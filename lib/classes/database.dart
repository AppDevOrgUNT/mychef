import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  /// Authentication methods implementation
  static FirebaseAuth _firebaseAuth;
  static FirebaseFirestore database;

  /// Used for storing variables.
  static String uid;

  static bool working;

  static Future<void> init() async
  {
    await _firebaseInit();
    _firebaseAuth = FirebaseAuth.instance;
    database = FirebaseFirestore.instance;
    working = false;
    return null;
  }

  static Future<void> _firebaseInit() async
  {
    return Firebase.initializeApp();
  }

  static Future<bool> signInWithContinuedSession() async
  {
    User previousUser = _firebaseAuth.currentUser;
    if (previousUser != null)
    {
      print("Logged in with a continued session. UID: " + uid);
      uid = previousUser.uid;
      return true;
    }
    else
    {
      return false;
    }
  }

  static Future<void> anonymousSignIn() async
  {
    UserCredential user = await _firebaseAuth.signInAnonymously();
    uid = user.user.uid;
    print("Logged in with an anonymous session. UID: " + uid);
    return null;
  }

  static Future<void> signIn(String email, String password) async {
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    uid = user.user.uid;
    return null;
  }

  static Future<void> signUp(String email, String password) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    uid = user.user.uid;
    return null;
  }

  static Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  static Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  static Future<void> sendEmailVerification() async {
    User user = _firebaseAuth.currentUser;
    user.sendEmailVerification();
  }

  static Future<bool> isEmailVerified() async {
    User user = _firebaseAuth.currentUser;
    return user.emailVerified;
  }

  static Future<void> changeEmail(String email) async {
    User user = _firebaseAuth.currentUser;
    user.updateEmail(email).then((_) {
      print("Successfully changed email");
    }).catchError((error) {
      print("Email can't be changed" + error.toString());
    });
    return null;
  }

  static Future<void> changePassword(String password) async {
    User user = _firebaseAuth.currentUser;
    user.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
    return null;
  }

  static Future<void> deleteUser() async {
    User user = _firebaseAuth.currentUser;
    user.delete().then((_) {
      print("User deleted successfully");
    }).catchError((error) {
      print("User cannot be deleted" + error.toString());
    });
    return null;
  }

  static Future<void> sendPasswordResetMail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return null;
  }

  static void addIngredient(String ingr) async
  {
    _adjustIngredient(ingr, true);
  }

  static void removeIngredient(String ingr) async
  {
    _adjustIngredient(ingr, false);
  }

  static void _adjustIngredient(String ingr, bool add) async
  {
    // Start this once working is done.
    while (working) { await Future.delayed(new Duration(milliseconds: 1000)); }

    working = true;

    List<dynamic> pantry;
    pantry = await _retrieveData("User Data", uid, "Pantry");

    if (pantry == null) {
      pantry = new List<dynamic>();
      print("PANTRY WAS NULL!");
    }

    if (add)
    {
      pantry.add(ingr);
    }
    else
    {
      // Find ingr in pantry
      for (int index = 0; index < pantry.length; index++)
      {
        if (pantry[index] == ingr)
        {
          pantry.removeAt(index);
          break;
        }
      }
    }

    await _writeData("User Data", uid, "Pantry", pantry);

    working = false;
  }

  /// Writes the given data to the database.
  static Future<void> _writeData(
      String collection, String document, dynamic name, dynamic data) async {
    return await database
        .collection(collection.toString())
        .doc(document.toString())
        .set({name.toString(): data});
  }

  /// Retrieves all data at the location.
  static Future<Map<String, dynamic>> _retrieveDataMap(
      String collection, String document) async {
    DocumentSnapshot snapshot =
        await database.collection(collection).doc(document).get();

    return Map.from(snapshot.data());
  }

  /// Retrieves a specific value at the location.
  static Future<T> _retrieveData<T>(
      String collection, String document, String name) async {
    // Retrieve each of the data items in a document.
    Map<String, dynamic> dataSet = await _retrieveDataMap(collection, document);

    // Find the key which matches name.
    dynamic result;
    for (MapEntry<String, dynamic> item in dataSet.entries) {
      if (item.key == name) {
        result = item.value;
        break;
      }
    }

    if (result == null) {
      print("Value at " +
          collection +
          "/" +
          document +
          "/" +
          name +
          " does not exist.");
      return null;
    } else if (result is T) {
      return result;
    } else {
      print("Value found is not of type " + T.toString() + ".");
      return null;
    }
  }
}
