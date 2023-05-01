module uim.mongo.classes.sessionstore;

import uim.mongo;

class DMGOSessionStore {
  this() {}
  this(string url, string collection = "sessions") {}

  // mixin(OProperty!("MongoSessionStore", "_sessionStore"));


}
auto MGOSessionStore() { return new DMGOSessionStore; }