module dbs.mongo.commands.usermanagement;

import dbs.mongo;

@safe:
struct UserInfo{ string user; string db; }

Bson usersInfo(MongoDatabase db) {
  struct Cmd { int usersInfo = 1; }
  return db.runCommand(Cmd().serializeToBson());
}

Bson usersInfo(MongoDatabase db, string username) {
  struct Cmd { string usersInfo; }
  return db.runCommand(Cmd(username).serializeToBson());
}

Bson usersInfo(MongoDatabase db, string userName, string dbName) {
  struct Cmd { UserInfo usersInfo; }
  return db.runCommand(Cmd(UserInfo(userName, dbName)).serializeToBson());
}

Bson usersInfo(MongoDatabase db, string[string] users) {
  struct Cmd { UserInfo[] usersInfo; }
  UserInfo[] userInfos;
  foreach (k, v; users) { userInfos ~= UserInfo(k, v); }
  return db.runCommand(Cmd(userInfos).serializeToBson());
}

Bson usersInfo(MongoDatabase db, string[] users) {
  struct Cmd { string[] usersInfo; }
  return db.runCommand(Cmd(users).serializeToBson());
}