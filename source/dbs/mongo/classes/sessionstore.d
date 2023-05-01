module dbs.mongo.classes.sessionstore;

import dbs.mongo;

class DMGOSessionStore {
  this() {}
  this(string url, string collection = "sessions") {}

  // mixin(OProperty!("MongoSessionStore", "_sessionStore"));


}
auto MGOSessionStore() { return new DMGOSessionStore; }