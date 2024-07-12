# Define variables
CONTAINER_NAME=jobportal-mongo-1
DUMP_DIR=.
DUMP_FILE=dump.archive

# Run MongoDB container (if not already running)
# docker run -d --name $CONTAINER_NAME -p 27017:27017 -v mongo_data:/data/db mongo:latest

# Wait for MongoDB to start (adjust time as needed)
sleep 10

# Copy dump file to the container
docker cp $DUMP_DIR/$DUMP_FILE $CONTAINER_NAME:/dump/$DUMP_FILE

# Restore the dump file inside the container
docker exec -it $CONTAINER_NAME mongorestore --uri mongodb://localhost:27017 --archive=/dump/$DUMP_FILE

# Optional: Stop the MongoDB container
# docker stop $CONTAINER_NAME
# docker rm $CONTAINER_NAME
