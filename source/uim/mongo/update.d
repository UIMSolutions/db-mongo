module uim.mongo.update;

import uim.mongo;

class DBsonUpdate { 
    this() {
        _bson = Bson.emptyObject;
    }
    this(T)(string field, T value) {
        this();
        _bson[field] = Bson(value);
    }
    this(T)(T[string] values) {
        this();
        _bson = value.toBson;
    }
    
    private Bson _bson;

@safe:    
bool opEquals(string txt) { return (toString == txt); }
    Bson toBson() {
        return _bson;
    }
    override string toString() {
        return _bson.toString;
    }
}
auto BsonFilter() { return new DBsonUpdate(); }
auto BsonFilter(T)(string field, T value) { return new DBsonUpdate(field, value); }
auto BsonFilter(T)(T[string] values) { return new DBsonUpdate(values); }

unittest{

}