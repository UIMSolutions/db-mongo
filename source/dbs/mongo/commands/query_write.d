module dbs.mongo.commands.query_write;

import dbs.mongo;

/// Delete all documents in the specified collection by specifying an empty query condition and a limit of 0.
/* Bson deleteDocuments(MongoDatabase db, string collectionName, Bson selector, bool ordered = true) {
  struct Cmd { string delete; Bson deletes; bool ordered; }
  return db.runCommand(Cmd(collectionName, selector, ordered).serializeToBson());
} */

/***
  colViewName -	The name of the collection or view to query.
*/
Bson mgFindAll(MongoDatabase db, string colViewName) {
  struct Cmd { string find; }
  return db.runCommand(Cmd(colViewName).serializeToBson());
}

/***
  colViewName -	The name of the collection or view to query.
*/
Bson mgFind(MongoDatabase db, string colViewName, Bson filter) {
  struct Cmd { string find; Bson filter; }
  return db.runCommand(Cmd(colViewName, filter).serializeToBson());
}
