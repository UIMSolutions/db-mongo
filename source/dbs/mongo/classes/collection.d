module uim.mongo.classes.collection;

import uim.mongo;

class DMGOCollection {
  this() {}
  this(string aName) { this(); this.name(aName); }
  this(MongoCollection aCollection) { this(); this.collection(aCollection); }

  mixin(OProperty!("string", "name"));
  mixin(OProperty!("MongoCollection", "collection"));

@safe:
  /// Calculates aggregate values for the data in a collection.
  Bson aggregate(ARGS...) (ARGS pipeline) {
    return _collection.aggregate(pipeline);
  }
  unittest {
/*    auto db = connectMongoDB("127.0.0.1").getDatabase("test");
  	auto results = db["coll"].aggregate(
		["$match": ["status": "A"]],
		["$group": ["_id": Bson("$cust_id"),
			"total": Bson(["$sum": Bson("$amount")])]],
		["$sort": ["total": -1]]); */
  }

  MongoCursor!R aggregate(R, S) (S[] pipeline, AggregateOptions options) {
    return _collection.aggregate(pipeline, options);
  }
  unittest {
    /*
   	auto db = connectMongoDB("127.0.0.1").getDatabase("test");

    Bson[] args;
    args ~= serializeToBson(["$match": ["status": "A"]]);
    args ~= serializeToBson(["$group": ["_id": Bson("$cust_id"),
        "total": Bson(["$sum": Bson("$amount")])]]);
    args ~= serializeToBson(["$sort": ["total": -1]]);

    AggregateOptions options;
    options.cursor.batchSize = 10; // prefetch the first 10 results
    auto results = db["coll"].aggregate(args, options);
  */ 
  }

  /// Counts the results of the specified query expression.
  ulong count(T) (T query) {
    return _collection.count(query);
  }

  /// Returns an input range of all unique values for a certain field for records matching the given query.
  auto distinct(R, Q) (string key, Q query) {
    return _collection.distinct(key, query);
  }	
  unittest {
  /*	auto db = connectMongoDB("127.0.0.1").getDatabase("test");
    auto coll = db["collection"];

    coll.drop();
    coll.insert(["a": "first", "b": "foo"]);
    coll.insert(["a": "first", "b": "bar"]);
    coll.insert(["a": "first", "b": "bar"]);
    coll.insert(["a": "second", "b": "baz"]);
    coll.insert(["a": "second", "b": "bam"]);

    auto result = coll.distinct!string("b", ["a": "first"]);

    assert(result.equal(["foo", "bar"]));*/
  }

  auto drop()	{
    _collection.drop();
    return null;
  }

  O dropIndex(this O)(string name) {
    _collection.dropIndex(name); return cast(O)this;
  } 

  /// Creates or updates an index.
  O ensureIndex(O)(scope const(std.typecons.Tuple!(string,int))[] field_orders, IndexFlags flags = cast(IndexFlags)0, core.time.Duration expire_time = dur(0L)) {
    _collection.ensureIndex(field_orders, flags, expire_time); return cast(O)this;
  }

  /// Queries the collection for existing documents.
  MongoCursor!R find(R, T, U) (T query, U returnFieldSelector, QueryFlags flags = QueryFlags.None, int num_skip = 0, int num_docs_per_chunk = 0) {
    return _collection.find(query, returnFieldSelector, flags, num_skip, num_docs_per_chunk);
  }

  MongoCursor!(T,R,typeof(null)) find(R, T) (T query) {
    return _collection.find(query);
  }

  MongoCursor!(Bson,R,typeof(null)) find(R)() {
    return _collection.find();
  }
  
  /// Combines a modify and find operation to a single atomic operation.
  Bson findAndModify(T, U, V) (T query, U update, V returnFieldSelector) {
    return _collection.findAndModify(query, update, returnFieldSelector);   
  }

  Bson findAndModify(T, U) (T query, U update) {
    return _collection.findAndModify(query, update);   
  }

  /// Combines a modify and find operation to a single atomic operation with generic options support.
  Bson findAndModifyExt(T, U, V) (T query, U update, V options) {
    return _collection.findAndModify(query, update, options);
  }

  /// Queries the collection for existing documents.
  auto findOne(R, T, U)(T query, U returnFieldSelector, QueryFlags flags = QueryFlags.None) {
    return _collection.findOne(query, returnFieldSelector, flags);
  }

  auto findOne(R, T) (T query) {
    return _collection.findOne(query, returnFieldSelector, flags);
  }

  /// Inserts new documents into the collection.
  O insert(this O, T)(T document_or_documents, InsertFlags flags = InsertFlags.None) {
    _collection.insert(document_or_documents, flags); return cast(O)this;
  }

  ///	Removes documents from the collection.
  O remove(this O, T) (T selector, DeleteFlags flags = DeleteFlags.None) {
    _collection.remove(selector, flags); return cast(O)this;
  }

  O remove(this O)() {
      _collection.remove(); return cast(O)this;
  }

  /// Performs an update operation on documents matching 'selector', updating them with 'update'.
  O update(this O, T, U) (T selector, U update, UpdateFlags flags = UpdateFlags.None) {
    _collection.update(selector, update, flags); return cast(O)this; 
  }
}
auto MGOCollection() { return new DMGOCollection(); }
auto MGOCollection(string aName) { return new DMGOCollection(aName); }
auto MGOCollection(MongoCollection aCollection) { return new DMGOCollection(aCollection); }
