import 'package:flutter/material.dart';
import 'Ingredient.dart';
import 'Recipe.dart';
import 'dart:collection';

void main() {
  var recipe1 = new Recipe();
  var ingredient1 = new Ingredient();

  // recipe1.showCalInfo();
  // recipe1.showInfo();
  // ingredient1.showIngrInfo();

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test Program'),
          backgroundColor: Colors.pinkAccent[400],
        ),
        body: Center(
          child: Text('${recipe1.calories}'),
        ),
        backgroundColor: Colors.pink[300],
      ),
    ),
  );

  // var recipe1 = new Recipe();
  // var ingredient1 = new Ingredient();
  //
  // recipe1.showCalInfo();
  // recipe1.showInfo();
  // ingredient1.showIngrInfo();
}
