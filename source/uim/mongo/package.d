module uim.mongo;

public import uim.core;
public import uim.oop;

public import uim.mongo.bson;
public import uim.mongo.filter;

Bson[] toBson(T)(T[] values) {
    Bson[] results; results.length = values.length;
    foreach(i, value; values) results[i] = Bson(value);
    return results;
}
unittest{

}

Bson toBson(T)(T[string] values) {
    Bson result = Bson.emptyObject;
    foreach(field, value; values) result[field] = Bson(value);
    return result;
}
unittest{
    
}
