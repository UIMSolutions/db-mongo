module dbs.mongo;

// Standard libraries
public import std.stdio;
public import std.string;
public import std.uuid;

// Dub libraries
public import vibe.d;

// UIM libraries
public import uim.core;
public import uim.oop;

// Local packages
public import dbs.mongo.commands;
public import dbs.mongo.classes;

public import dbs.mongo.bson;
public import dbs.mongo.filter;
public import dbs.mongo.update;

@safe Bson[] toBson(T)(T[] values) {
    Bson[] results; results.length = values.length;
    foreach(i, value; values) results[i] = Bson(value);
    return results;
}
unittest{

}

@safe Bson toBson(T)(T[string] values) {
    Bson result = Bson.emptyObject;
    foreach(field, value; values) result[field] = Bson(value);
    return result;
}
unittest{
    
}
