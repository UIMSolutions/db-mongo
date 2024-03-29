﻿module dbs.mongo.classes.bson;

import dbs.mongo;

@safe:
	class DBSON {
		this() {}
		this(string[string] values) {
			_bson = Bson.emptyObject;
			foreach(k, v; values) { _bson[k] = v; }
		}

		private Bson _bson;

		bool isEmpty() { return (_bson.type == Bson.Type.undefined); }
		bool isUndefined() { return (_bson.type == Bson.Type.undefined); }
		bool isArray() { return (_bson.type == Bson.Type.array); }
		bool isBinData() { return (_bson.type == Bson.Type.binData); }
		bool isBool() { return (_bson.type == Bson.Type.bool_); }
		// TODO

		O and(this O)(string[string] values) { 
			if (isEmpty) _bson = Bson.emptyObject;
			foreach(k, v; values) _bson[k] = v; 
			return cast(O)this;
		}
		unittest {	
			assert(BSON.and(["a":"b", "c":"d"]) == `{"c":"d","a":"b"}`);			
		}

		O or(this O)(string[string][] values) {
			DBSON[] bsons; bsons.length = values.length;
			foreach(i, v; values) bsons[i] = BSON(v);
			this.or(bsons); 
			return cast(O)this;
		}
		O or(this O)(DBSON[] values) { 
			Bson[] bsons; bsons.length = values.length;
			size_t pre = 0;
			if (!isEmpty) {
				bsons.length = values.length+1;
				bsons[0] = _bson;
				pre = 1;
			}
			foreach(i, v; values) bsons[i+pre] = v.toBson;
			_bson = Bson(["$or": Bson(bsons)]); 
			return cast(O)this; }
		unittest {	
			assert(BSON.or([["a":"b"], ["c":"d"]]) == `{"$or":[{"a":"b"},{"c":"d"}]}`);
			assert(BSON(["a":"b"]).or([["c":"d"]]) == `{"$or":[{"a":"b"},{"c":"d"}]}`);
		}

		bool opEquals(string txt) { return (toString == txt); }
		Bson toBson() {
			return _bson;
		}
		override string toString() {
			return _bson.toString;
		}
	}
	auto BSON() { return new DBSON(); }
	auto BSON(string[string] values) { return new DBSON(values); }

// Create Bson Object 
auto BsonArray() { return Bson.emptyArray; }

// Create Bson Object 
auto BsonObj() { return Bson.emptyObject; }

// Create Bson Object of Associative Array
auto toBSON(V)(V[string] vals) {
	auto result = BsonObj;
	foreach(k, v; vals) result[k] = v;
	return result;
}
unittest {
	assert(["a":"b", "c":"d"].toBSON.toString == `{"c":"d","a":"b"}`, "Error in toBSON");
}

// AND operator 	
Bson bAND(V)(V[string] conditions) {	
	return bObject(conditions);
}
Bson and(V)(Bson obj, V[string] conditions) {
	foreach(k, v; conditions) obj[k] = v;
	return obj;
}
unittest {	
	assert(["a":"b", "c":"d"].toBSON.and(["x":"y"]).toString == `{"c":"d","a":"b","x":"y"}`, "Error in and");
}

// OR Operator
Bson or(string[string][] values) {
	Bson[] conditions;
	foreach(val; values) conditions~=val.toBSON;
	return or(conditions);
}
Bson or(Bson[] conditions) { return Bson(["$or": Bson(conditions)]); }

unittest {
/*	writeln(or([["a":"b"].toBSON, ["c":"d"].toBSON]));
	writeln(or[["a":"b"].toBSON, ["c":"d", "x":"y"].toBSON]));
	writeln(BSON.or([["a":"b"], ["c":"d"]]));
	writeln(BSON.or([["a":"b"], ["c":"d"]]).and(["x":"y"]));
	writeln(BSON.or([["a":"b"], ["c":"d"]]).and(["x":"y"]));*/
}

// EQ Equal operator
Bson bEQ(V)(string field, V value) { return Bson([field: Bson(["$eq":Bson(V)])]); }

// GT Greater Equal operator
Bson bGT(V)(string field, V value) { return Bson([field: Bson(["$gt":Bson(V)])]); }

// GT Greater then operator
Bson bGE(V)(string field, V value) { return Bson([field: Bson(["$gte":Bson(V)])]); }

// LT Less then operator
Bson bLT(V)(string field, V value) { return Bson([field: Bson(["$lt":Bson(V)])]); }

// LE Less equal operator
Bson bLE(V)(string field, V value) { return Bson([field: Bson(["$lte":Bson(V)])]); }

// NE NOT Equal operator
Bson bNE(V)(string field, V value) { return Bson([field: Bson(["$ne":Bson(V)])]); }

Bson bArray(V)(V[] values) {
	Bson[] results;
	foreach(v; values) results ~= Bson(v);
	return Bson(results);
}
Bson mIN(V)(string field, V[] values) { return Bson([field: Bson(["$in":_array(values)])]); }
Bson mNI(V)(string field, V[] values) { return Bson([field: Bson(["$nin":_array(values)])]); }

Bson bSET(Bson[string] values) { 
	auto obj = Bson.emptyObject;
	foreach(k, v; values) obj[k] = v;
	return bSET(obj);
}
Bson bSET(Bson obj) { return Bson(["$set": obj]); }

Bson bUNSET(string[] fields) {
	auto obj = Bson.emptyObject;
	foreach(field; fields) obj[field] = "";
	return bUNSET(obj);
}
Bson bUNSET( Bson obj) { return Bson(["$unset": obj]);}

Bson bINC(size_t[string] values) { 
	auto obj = Bson.emptyObject;
	foreach(k, v; values) obj[k] = v;
	return _inc(obj);
}
Bson _inc(Bson obj) { return Bson(["$set": obj]); }

Bson _mul(double[string] values) { 
	auto obj = Bson.emptyObject;
	foreach(k, v; values) obj[k] = v;
	return _mul(obj);
}
Bson _mul(Bson obj) { return Bson(["$mul": obj]); }

unittest {

}