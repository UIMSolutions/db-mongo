module uim.mongo.commands.rolemanagement;

import uim.mongo;

@safe:
Bson rolesInfo(MongoDatabase db) {
  struct Cmd { int rolesInfo = 1; }
  return db.runCommand(Cmd().serializeToBson());
}

Bson rolesInfo(MongoDatabase db, string roleName) {
  struct Cmd { string rolesInfo; }
  return db.runCommand(Cmd(roleName).serializeToBson());
}