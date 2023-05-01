module uim.mongo.commands.administration;

import uim.mongo; 

@safe:
/// The dropDatabase command drops the database, deleting the associated data files.
Bson mgDropDatabase(MongoDatabase db) {
  struct Cmd { int dropDatabase = 1; }
  return db.runCommand(Cmd().serializeToBson());
}

/// The dropIndexes command drops one or more indexes (except the index on the _id field) from the specified collection.
Bson mgDropIndexes(MongoDatabase db, string collection, string index = "*") {
  struct Cmd { string collection; string index; }
  return db.runCommand(Cmd(collection, index).serializeToBson());
}

Bson mgDropIndexes(MongoDatabase db, string collection, string[] indexes) {
  struct Cmd { string collection; string[] indexes; }
  return db.runCommand(Cmd(collection, indexes).serializeToBson());
}

/// Retrieve information, i.e. the name and options, about the collections and views in a database. 
/// Specifically, the command returns a document that contains information with which to create a cursor to the collection information.
Bson mgListCollections(MongoDatabase db) {
  struct Cmd { int listCollections = 1; }
  return db.runCommand(Cmd().serializeToBson());
}
Bson mgListCollections(MongoDatabase db, bool authorizedCollections, bool nameOnly) {
  struct Cmd { int listCollections = 1; bool authorizedCollections; bool nameOnly; }
  return db.runCommand(Cmd(authorizedCollections, nameOnly).serializeToBson());
}

Bson mgRenameCollection(MongoDatabase db, string fromCollection, string toCollection, bool dropTarget = false) {
  struct Cmd { string renameCollection; string to; bool dropTarget; }
  return db.runCommand(Cmd(fromCollection, toCollection, dropTarget).serializeToBson());
}