module dbs.mongo.classes.database;

import dbs.mongo;

class DMGODatabase {
  this() {}
  this(string aName) { this(); this.name(aName); }
  this(MongoDatabase aMongoDb) { this(); this.db(aMongoDb); }

  ///  Connector to vibe's MongoDB library
  mixin(OProperty!("MongoDatabase", "db"));

  ///  Name of database
  mixin(OProperty!("string", "name"));
  // collections
  auto collections() {
    auto bsonResults = mgListCollections(_db);
    DMGOCollection[] results;
    // foreach (bson; bsonResults) results ~= MGOCollection(_db, bson);

    return results;
  }

  auto collections(string name) {
    DMGOCollection result;
    return result;
  }
}