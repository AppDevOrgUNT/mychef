import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

final database = Firestore.instance;

class Database {
  /// Writes the given data to the database.
  ///
  /// NOTE: Type "K" must be able to be cast to a String. If "K" is an int,
  /// String, etc., then you're fine; otherwise, implement a toString() method.
  static Future<bool> writeData(
      String collection,
      String document,
      dynamic name,
      dynamic data)
      async
  {
    await database.collection(collection.toString())
      .document(document.toString())
      .setData({name.toString(): data});

    return true;
  }

  /// Retrieves all data at the location.
  static Future<Map<String, dynamic>> retrieveDataMap(
      String collection,
      String document)
      async
  {
    DocumentSnapshot snapshot = await database.collection(collection)
      .document(document)
      .get();

    return Map.from(snapshot.data);
  }

  /// Retrieves a specific value at the location.
  static Future<T> retrieveData<T>(
      String collection,
      String document,
      String name)
      async
  {
    // Retrieve each of the data items in a document.
    Map<String, dynamic> dataSet = await retrieveDataMap(collection, document);

    // Find the key which matches name.
    dynamic result;
    for (MapEntry<String, dynamic> item in dataSet.entries)
    {
      if (item.key == name)
      {
        result = item.value;
        break;
      }
    }

    if (result == null)
    {
      print("Value at " + collection + "/" + document + "/" + name +
          " does not exist.");
      return null;
    }
    else if (result is T)
    {
      return result;
    }
    else
    {
      print("Value found is not of type " + T.toString() + ".");
      return null;
    }
  }
}