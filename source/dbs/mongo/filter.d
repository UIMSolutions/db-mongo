module dbs.mongo.filter;

import dbs.mongo;

class DBsonFilter {
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

    /*
    all() - creates an all filter for an array field. 
    */
    @safe O All(this O, T)(string field, T[] values) {
        if (_bson[field].type != Bson.Type.null_) {
            auto condition = _bson[field];
            condition["$all"] = values.toBson;
            _bson[field] = condition; 
        }
        else {
            auto condition = Bson.emptyObject;
            condition["$all"] = values.toBson;
            _bson[field] = condition; 
        }
        return cast(O)this;    }
    unittest{
        writeln(BsonFilter.All("fruits", ["apple", "melone"]));
    }

    /*
    And() - creates an and field. 
    */
    @safe O And(this O, T)(string field, T value) {
        _bson[field] = value;
        return cast(O)this;
    }
    @safe O And(this O, T)(T[string] values) {
        _bson = values.toBson;
        return cast(O)this;
    }
    unittest{
        assert(BsonFilter.And(["a":"b"]) == `{"a":"b"}`);
        assert(BsonFilter.And(["a":"b", "c": "d"]) == `{"c":"d","a":"b"}`);
    }

    /*
    anyEq() - Creates an equality filter for an array field. 
    */
    @safe O anyEq(this O)() {
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
    @safe O anyGe(this O, T)(string field, string value) {
        // TODO
        return cast(O)this;
    }
    unittest{

    }

    // $bitsAllClear 
    @safe O BitsAllClear(this O)(string field, BsonBinData data) {
        auto condition = Bson.emptyObject;
        condition["$bitsAllClear"] = data;
        _bson[field] = condition; 
        return cast(O)this;
    }
    @safe O BitsAllClear(this O)(string field, int[] positions) {
        auto condition = Bson.emptyObject;
        condition["$bitsAllClear"] = positions.toBson;
        _bson[field] = condition; 
        return cast(O)this;
    }
    @safe O BitsAllClear(this O)(string field, int mask) {
        auto condition = Bson.emptyObject;
        condition["$bitsAllClear"] = mask;
        _bson[field] = condition; 
        return cast(O)this;
    }
    unittest{
        assert(BsonFilter.BitsAllClear("a", [1, 5]) == `{"a":{"$bitsAllClear":[1,5]}}`);
        assert(BsonFilter.BitsAllClear("a", 35) == `{"a":{"$bitsAllClear":35}}`);
    }

    // $bitsAllSet  
   @safe  O BitsAllSet(this O)(string field, BsonBinData data) {
        auto condition = Bson.emptyObject;
        condition["$bitsAllSet"] = data;
        _bson[field] = condition; 
        return cast(O)this;
    }
    @safe O BitsAllSet(this O)(string field, int[] positions) {
        auto condition = Bson.emptyObject;
        condition["$bitsAllSet"] = positions.toBson;
        _bson[field] = condition; 
        return cast(O)this;
    }
    @safe O BitsAllSet(this O)(string field, int mask) {
        auto condition = Bson.emptyObject;
        condition["$bitsAllSet"] = mask;
        _bson[field] = condition; 
        return cast(O)this;
    }
    unittest{
        assert(BsonFilter.BitsAllSet("a", [1, 5]) == `{"a":{"$bitsAllSet":[1,5]}}`);
        assert(BsonFilter.BitsAllSet("a", 35) == `{"a":{"$bitsAllSet":35}}`);
    }

    // $bitsAnyClear 
    @safe O BitsAnyClear(this O)(string field, BsonBinData data) {
        auto condition = Bson.emptyObject;
        condition["$bitsAnyClear"] = data;
        _bson[field] = condition; 
        return cast(O)this;
    }
    @safe O BitsAnyClear(this O)(string field, int[] positions) {
        auto condition = Bson.emptyObject;
        condition["$bitsAnyClear"] = positions.toBson;
        _bson[field] = condition; 
        return cast(O)this;
    }
    @safe O BitsAnyClear(this O)(string field, int mask) {
        auto condition = Bson.emptyObject;
        condition["$bitsAnyClear"] = mask;
        _bson[field] = condition; 
        return cast(O)this;
    }
    unittest{
        assert(BsonFilter.BitsAnyClear("a", [1, 5]) == `{"a":{"$bitsAnyClear":[1,5]}}`);
        assert(BsonFilter.BitsAnyClear("a", 35) == `{"a":{"$bitsAnyClear":35}}`);
    }

    // $bitsAnySet  
    @safe O BitsAnySet(this O)(string field, BsonBinData data) {
        auto condition = Bson.emptyObject;
        condition["$bitsAnySet"] = data;
        _bson[field] = condition; 
        return cast(O)this;
    }
    @safe O BitsAnySet(this O)(string field, int[] positions) {
        auto condition = Bson.emptyObject;
        condition["$bitsAnySet"] = positions.toBson;
        _bson[field] = condition; 
        return cast(O)this;
    }
    @safe O BitsAnySet(this O)(string field, int mask) {
        auto condition = Bson.emptyObject;
        condition["$bitsAnySet"] = mask;
        _bson[field] = condition; 
        return cast(O)this;
    }
    unittest{
        assert(BsonFilter.BitsAnySet("a", [1, 5]) == `{"a":{"$bitsAnySet":[1,5]}}`);
        assert(BsonFilter.BitsAnySet("a", 35) == `{"a":{"$bitsAnySet":35}}`);
    }

    @safe O Comment(this O)(string text) {
        _bson["$comment"] = text; 
        return cast(O)this;
    }
    unittest{
        assert(BsonFilter.BitsAnySet("a", [1, 5]) == `{"a":{"$bitsAnySet":[1,5]}}`);
        assert(BsonFilter.BitsAnySet("a", 35) == `{"a":{"$bitsAnySet":35}}`);
    }

    @safe O ElemMatch(this O)(string field, Bson condition) {
        auto match = Bson.emptyObject;
        match["$elemMatch"] = condition;
        _bson[field] = match;
        return cast(O)this;
    }
    unittest{
        // students: { $elemMatch: { school: 102 } }
    }

    @safe O Meta(this O)(string field, string txt) {
        auto meta = Bson.emptyObject;
        meta["$meta"] = Bson(text);
        _bson[field] = meta;
        return cast(O)this;
    }
    unittest{
        // students: { $elemMatch: { school: 102 } }
    }

    @safe O Slice(this O)(string field, int amount) {
        auto slice = Bson.emptyObject;
        slice["$slice"] = Bson(amount);
        _bson[field] = slice;
        return cast(O)this;
    }
    @safe O Slice(this O)(string field, size_t skip, size_t limit) {
        auto slice = Bson.emptyObject;
        slice["$slice"] = [skip, limit].toBson;
        _bson[field] = slice;
        return cast(O)this;
    }
    unittest{
        // students: { $elemMatch: { school: 102 } }
    }

    /*
        In(this O, T)(string field, T[] values)
        Adds an "in" filter for an array field 
    */
    @safe O In(this O, T)(string field, T[] values) {
        auto condition = Bson.emptyObject;
        condition["$in"] = values.toBson;
        _bson[field] = condition;

        return cast(O)this;
    }
    unittest{
        // In SQL: SELECT * FROM inventory WHERE status in ("A", "D")
        assert(BsonFilter.In("status", ["A","D"]) == `{"status":{"$in":["A","D"]}}`);
    }

    /*
        Lt(this O)(string field, string value)
        Adds an "less than" filter for field
    */
    @safe O Lt(this O, T)(string field, T value) {
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
        assert(BsonFilter.Lt("age", 20) == `{"age":{"$lt":20}}`);
        assert(BsonFilter.Lt("age", 20).Gt("age", 40).Lt("name", "Tomb").Gt("name", "Raider") == `{"age":{"$lt":20,"$gt":40},"name":{"$lt":"Tomb","$gt":"Raider"}}`);
    }

    /*
    anyLe() - Creates an less than or equal filter for an array field. 
    */
    @safe O Le(this O, T)(string field, string value) {
        // TODO
        return cast(O)this;
    }
    unittest{

    }

    /*
    anyNe() - Creates a not equal filter for an array field. 
    */
    @safe O Ne(this O, T)(string field, string value) {
        // TODO
        return cast(O)this;
    }
    unittest{

    }

    /*
    or() - creates an or field. 
    */
    @safe O Or(this O)(DBsonFilter[] conditions) {
        Bson[] bsons; bsons.length = conditions.length;
        foreach(i, condition; conditions) bsons[i] = condition.toBson;
        return this.Or(bsons);
    }    
    @safe O Or(this O)(Bson[] conditions) {
        return this.Or(Bson(conditions));
    }
    @safe O Or(this O)(Bson conditions) {
        _bson["$or"] = conditions;
        return cast(O)this;
    }
    unittest{
        // { $or: [ { status: "A" }, { qty: { $lt: 30 } } ] }
        assert(BsonFilter.Or([BsonFilter("status", "A"), BsonFilter.Lt("qty", 30)]) == `{"$or":[{"status":"A"},{"qty":{"$lt":30}}]}`);
    }

    /*
        Size to return documents in the collection where the array size of field is value
    */
    @safe O Size(this O, T)(string field, T value) if (isIntegral!T) {
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
    @safe Bson toBson() {
        return _bson;
    }
    override string toString() {
        return _bson.toString;
    }
}
auto BsonFilter() { return new DBsonFilter(); }
auto BsonFilter(T)(string field, T value) { return new DBsonFilter(field, value); }
auto BsonFilter(T)(T[string] values) { return new DBsonFilter(values); }

unittest{
/*    writeln(
        BsonFilter
        .and(["field1":"b", "field2":"d"])
        .or(["x":"y"]));*/
}