## TT
#### Description
- A tree maintenance system fot the world

## TODO
#### MongoDB
- Initial Options for storing images included firebase, MongoDB, and local storage
- Therefore, MongoDB was chosen for its speed and ease to integrate with the project
- The 3 ways of storing on mongoDB are: GridFS, Base64, and URL
[GridFS](https://docs.mongodb.com/manual/core/gridfs/)
- GridFS is a specification for storing and retrieving files that exceed the BSON-document size limit of 16 MB
- Instead of storing a file in a single document, GridFS divides a file into parts, or chunks, and stores each of those chunks as a separate document
[More Info](https://www.baeldung.com/spring-boot-mongodb-upload-file)

#### Documentation