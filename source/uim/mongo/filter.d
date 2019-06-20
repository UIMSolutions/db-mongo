module uim.mongo.filter;

import uim.mongo;

class DBsonFilter {
    this() {
        _bson = Bson.emptyObject;
    }

    Bson _bson;
    /*
    all() - creates an all filter for an array field. 
    */
    O All(this O, T)(string field, T[] values) {
        Bson[] bsons; bsons.length = values.length;
        foreach(i, value; values) bsons[i] = Bson(value);
        if (_bson[field].type != Bson.Type.null_) {
            auto condition = _bson[field];
            condition["$all"] = Bson(bsons);
            _bson[field] = condition; 
        }
        else {
            auto condition = Bson.emptyObject;
            condition["$all"] = Bson(bsons);
            _bson[field] = condition; 
        }
        return cast(O)this;    }
    unittest{
        writeln(BsonFilter.All("fruits", ["apple", "melone"]));
    }

    /*
    and() - creates an and field. 
    */
    O and(this O, T)(string field, T value) {
        _bson[field] = value;
        return cast(O)this;
    }
    O and(this O, T)(T[string] values) {
        foreach(field, value; values) _bson[field] = value;
        return cast(O)this;
    }
    unittest{
        assert(BsonFilter.and(["a":"b"]) == `{"a":"b"}`);
        assert(BsonFilter.and(["a":"b", "c": "d"]) == `{"c":"d","a":"b"}`);
    }

    /*
    anyEq() - Creates an equality filter for an array field. 
    */
    O anyEq(this O)() {
        // TODO
        return cast(O)this;
    }
    unittest{

    }

    /*
    anyGt() - Creates an greater than filter for an array field. 
    */
    @safe O Gt(this O, T)(string field, T value) {
        if (_bson[field].type != Bson.Type.null_) {
            auto condition = _bson[field];
            condition["$gt"] = Bson(value);
            _bson[field] = condition; 
        }
        else {
            auto condition = Bson.emptyObject;
            condition["$gt"] = Bson(value);
            _bson[field] = condition; 
        }
        return cast(O)this;
    }
    unittest{
        writeln(BsonFilter.Gt("age", 20));
        assert(BsonFilter.Gt("age", 20) == `{"age":{"$gt":20}}`);
        assert(BsonFilter.Gt("age", 20).Gt("age", 40) == `{"age":{"$gt":40}}`);
    }

    /*
    anyGe() - Creates an greater than or equal filter for an array field. 
    */
    O anyGe(this O, T)(string field, string value) {
        // TODO
        return cast(O)this;
    }
    unittest{

    }

    /*
    anyIn() - Creates an in filter for an array field. 
    */
    O In(this O, T)(string field, T[] values) {
        Bson[] selects; selects.length = values.length;
        foreach(i, v; values) selects[i] = Bson(v);

        auto condition = Bson.emptyObject;
        condition["$in"] = selects;

        if (_bson.type == Bson.Type.undefined) _bson = Bson.emptyObject;
        _bson[field] = condition;

        return cast(O)this;
    }
    unittest{
        // In SQL: SELECT * FROM inventory WHERE status in ("A", "D")
        assert(BsonFilter.In("status", ["A","D"]) == `{"status":{"$in":["A","D"]}}`);
    }

    /*
        LT(this O)(string field, string value)
        Adds an "less than" filter for field
    */
    O Lt(this O, T)(string field, T value) {
        if (_bson[field].type != Bson.Type.null_) {
            auto condition = _bson[field];
            condition["$lt"] = Bson(value);
            _bson[field] = condition; 
        }
        else {
            auto condition = Bson.emptyObject;
            condition["$lt"] = Bson(value);
            _bson[field] = condition; 
        }
        return cast(O)this;
    }
    unittest{
        writeln(BsonFilter.Lt("age", 20));
        assert(BsonFilter.Lt("age", 20) == `{"age":{"$lt":20}}`);
        writeln(
            BsonFilter
            .Lt("age", 20).Gt("age", 40)
            .Lt("name", "Tomb").Gt("name", "Raider"));
    }

    /*
    anyLe() - Creates an less than or equal filter for an array field. 
    */
    O Le(this O, T)(string field, string value) {
        // TODO
        return cast(O)this;
    }
    unittest{

    }

    /*
    anyNe() - Creates a not equal filter for an array field. 
    */
    O Ne(this O, T)(string field, string value) {
        // TODO
        return cast(O)this;
    }
    unittest{

    }

    /*
    or() - creates an or field. 
    */
    O or(this O)() {
        // TODO
        return cast(O)this;
    }
    unittest{

    }

    /*
        Size to return documents in the collection where the array size of field is value
    */
    O Size(this O, T)(string field, T value) if (isIntegral!T) {
        if (_bson[field].type != Bson.Type.null_) {
            auto condition = _bson[field];
            condition["$size"] = Bson(value);
            _bson[field] = condition; 
        }
        else {
            auto condition = Bson.emptyObject;
            condition["$size"] = Bson(value);
            _bson[field] = condition; 
        }
        return cast(O)this;
    }
    unittest{
        writeln(BsonFilter.Size("personen", 20));
        assert(BsonFilter.Size("personen", 20) == `{"personen":{"$size":20}}`);
    }

    bool opEquals(string txt) { return (toString == txt); }
    Bson toBson() {
        return _bson;
    }
    override string toString() {
        return _bson.toString;
    }
}
auto BsonFilter() { return new DBsonFilter(); }

unittest{
/*    writeln(
        BsonFilter
        .and(["field1":"b", "field2":"d"])
        .or(["x":"y"]));*/
}