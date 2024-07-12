const mongoose = require('mongoose');
const path = require("path")
const fs = require("fs")
mongoose.connect('mongodb://localhost:27017/jobportal', {
    useNewUrlParser: true,
    useUnifiedTopology: true
});

const db = mongoose.connection;
async function exportCollection(collectionName, outputPath) {
    if (!fs.existsSync(outputPath)) {
        fs.mkdirSync(outputPath);
    }
    const collection = mongoose.connection.db.collection(collectionName);
    const cursor = collection.find({});
    const data = await cursor.toArray();
    const filePath = path.join(outputPath, `${collectionName}.json`);
    fs.writeFileSync(filePath, JSON.stringify(data, null, 2));
    console.log(`Exported collection ${collectionName} to ${filePath}`);
}
db.on('error', console.error.bind(console, 'Connection error:'));
db.once('open', async () => {
    console.log('Connected to MongoDB');

    // Proceed with operations here, such as listing collections
    try {
        const collections = await mongoose.connection.db.listCollections().toArray();
        for (let collection of collections) {
            await exportCollection(collection.name, "output");
        }
        console.log('Collections:', collections);
    } catch (err) {
        console.error('Error listing collections:', err);
    } finally {
        mongoose.connection.close();
    }
});
