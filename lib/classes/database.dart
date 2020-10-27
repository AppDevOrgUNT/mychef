import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

final database = Firestore.instance;

class Database {
  /// Authentication methods implementation
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user.uid;
  }

  Future<String> signUp(String email, String password) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.user.uid;
  }

  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    User user = _firebaseAuth.currentUser;
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User user = _firebaseAuth.currentUser;
    return user.emailVerified;
  }

  @override
  Future<void> changeEmail(String email) async {
    User user = _firebaseAuth.currentUser;
    user.updateEmail(email).then((_) {
      print("Successfully changed email");
    }).catchError((error) {
      print("Email can't be changed" + error.toString());
    });
    return null;
  }

  @override
  Future<void> changePassword(String password) async {
    User user = _firebaseAuth.currentUser;
    user.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
    return null;
  }

  @override
  Future<void> deleteUser() async {
    User user = _firebaseAuth.currentUser;
    user.delete().then((_) {
      print("User deleted successfully");
    }).catchError((error) {
      print("User cannot be deleted" + error.toString());
    });
    return null;
  }

  @override
  Future<void> sendPasswordResetMail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return null;
  }

  /// Writes the given data to the database.
  static void writeData(
      String collection, String document, dynamic name, dynamic data) async {
    await database
        .collection(collection.toString())
        .document(document.toString())
        .setData({name.toString(): data});
  }

  /// Retrieves all data at the location.
  static Future<Map<String, dynamic>> retrieveDataMap(
      String collection, String document) async {
    DocumentSnapshot snapshot =
        await database.collection(collection).document(document).get();

    return Map.from(snapshot.data);
  }

  /// Retrieves a specific value at the location.
  static Future<T> retrieveData<T>(
      String collection, String document, String name) async {
    // Retrieve each of the data items in a document.
    Map<String, dynamic> dataSet = await retrieveDataMap(collection, document);

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
