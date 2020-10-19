import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

final database = Firestore.instance;

class Database {
  /// TODO: Isha (ID of the current user.)
  static int userID;

  /// TODO: Isha (Logs in the user given the user's information.)
  ///
  /// Returns true if login was successful. Returns false otherwise.
  static bool logIn(String username, String password)
  {
    // If (username and password exist in the database and are correct) then:
    //    assign the userID field above to a unique ID based on it, return true.
    // Else, return false.
  }

  /// Writes the given data to the database.
  static void writeData(
      String collection,
      String document,
      dynamic name,
      dynamic data)
      async
  {
    await database.collection(collection.toString())
        .document(document.toString())
        .setData({name.toString(): data});
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