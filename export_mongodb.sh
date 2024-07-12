# Define variables
CONTAINER_NAME=jobportal-mongo-1
DATABASE_NAME=jobportal
DUMP_DIR=.
DUMP_FILE=dump.archive

# Run MongoDB container (if not already running)
# docker run -d --name $CONTAINER_NAME -p 27017:27017 -v mongo_data:/data/db mongo:latest

# Wait for MongoDB to start (adjust time as needed)
sleep 10

# Create dump directory and dump file inside the container
docker exec -it $CONTAINER_NAME bash -c "mkdir -p /dump && mongodump --uri mongodb://localhost:27017/$DATABASE_NAME --archive=/dump/$DUMP_FILE"

# Copy dump file to host
docker cp $CONTAINER_NAME:/dump/$DUMP_FILE $DUMP_DIR/$DUMP_FILE

# Optional: Stop and remove the MongoDB container
# docker stop $CONTAINER_NAME
# docker rm $CONTAINER_NAME
