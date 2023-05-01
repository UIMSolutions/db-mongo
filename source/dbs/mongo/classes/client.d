module dbs.mongo.classes.client;

import dbs.mongo;

class DMGOClient {
  this() {}

  mixin(OProperty!("MongoClient", "client"));

  /// Disconnects all currently unused connections to the server.
  O cleanupConnections(this O)() {
    _client.cleanupConnections(); return cast(O)this;
  }	

  /// Connect
  auto connect (string adr) {
    return _client = connectMongoDB(adr);
  }

  /// Accesses a collection using an absolute path.
  auto collection (string path) {
    return _client.getCollection(path);
  }

  /// Returns an object representing the specified database.
  auto database(string dbName) {
    return _client.getDatabase(dbName);	
  }	

  /// Return a handle to all databases of the server.
  auto databases() {
    return _client.getDatabases();
  }
}
auto MGOClient() { return new DMGOClient; }

unittest{
  auto client = connectMongoDB("127.0.0.1");
  writeln("Databases");  
  foreach(db; client.getDatabases) {
    writeln("Database");
    writeln(db);  
    writeln(mgListCollections(db, false, true));
    writeln(mgListCollections(db, false, true)["cursor"]);
    foreach(b; mgListCollections(db, false, true)["cursor"]["firstBatch"]) writeln(b["name"]);
  }
  
  /*auto users = client.getCollection("users");
  users.insert(Bson("peter"));
  // connecting using the URL form with custom settings
  auto client = connectMongoDB("mongodb://localhost/?slaveOk=true");
  // connecting with SSL encryption enabled and verification off
  auto client = connectMongoDB("mongodb://localhost/?ssl=true&sslverifycertificate=false");*/
}