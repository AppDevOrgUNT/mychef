import 'package:flutter/material.dart';
import 'package:direct_select/direct_select.dart';
import 'Ingredient.dart';
import 'Recipe.dart';
import 'Allergy.dart';
import 'MealType.dart';
import 'Diet.dart';
import 'dart:collection';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'myChef Functionality Test'),
    );
  } //Widget build
} //MyApp Class

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  var recipe1 = new Recipe();
  var ingredient1 = new Ingredient();

  final elements1 = [
    MealType.breakfast,
    MealType.lunch,
    MealType.dinner,
    MealType.dessert,
    MealType.snack,
  ];
  final elements2 = [
    Allergy.crustacean,
    Allergy.eggs,
    Allergy.fish,
    Allergy.milk,
    Allergy.peanuts,
    Allergy.soybeans,
    Allergy.wheat,
    Allergy.treenuts,
    "None",
  ];
  final elements3 = [
    Diet.GlutenFree,
    Diet.Ketogenic,
    Diet.Vegetarian,
    Diet.LactoVegetarian,
    Diet.OvoVegetarian,
    Diet.Vegan,
    Diet.Pescetarian,
    Diet.Paleo,
    Diet.Primal,
    Diet.Whole30,
    "None",
  ];
  final elements4 = [
    "open01",
    "open02",
  ];
  int selectedIndex1 = 0, selectedIndex2 = 0, selectedIndex3 = 0, selectedIndex4 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
        title: ('${val}') //text of menu options
    ))

        .toList();
  }

  List<Widget> _buildItems2() {
    return elements2
        .map((val) => MySelectionItem(
        title: ('${val}')
    ))
        .toList();
  }

  List<Widget> _buildItems3() {
    return elements3
        .map((val) => MySelectionItem(
        title: ('${val}')
    ))
        .toList();
  }

  List<Widget> _buildItems4() {
    return elements4
        .map((val) => MySelectionItem(
        title: ('${val}')
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Select Type of Meal",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndex1,
                    child: MySelectionItem(
                        isForList: false,
                        title: ('${elements1[selectedIndex1]}') //Text on box/row
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex1 = index;
                      });
                    },
                    //mode: DirectSelectMode.tap, //.tap will require you to tap the menu then tap again to scroll through options
                    items: _buildItems1()),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "Select Food Allergies",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndex2,
                    child: MySelectionItem(
                        isForList: false,
                        title: ('${elements2[selectedIndex2]}')
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex2 = index;
                      });
                    },
                    items: _buildItems2()),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "Select Diets",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndex3,
                    child: MySelectionItem(
                        isForList: false,
                        title: ('${elements3[selectedIndex3]}')
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex3 = index;
                      });
                    },
                    items: _buildItems3()),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "Recipies",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndex4,
                    child: MySelectionItem(
                        isForList: false,
                        title: ('${elements4[selectedIndex4]}')
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex4 = index;
                      });
                    },
                    items: _buildItems4()),
                Text('Click button to move to search'),
          RaisedButton(
            textColor: Colors.white,
            color: Colors.blue,
            child: Text('Go to search results'),
            onPressed: () {
              navigateToSubPage(context);
            },
          )

        ])),
      ),

    );
  }
  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
  }
}

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
        child: _buildItem(context),
        padding: EdgeInsets.all(10.0),
      )
          : Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: <Widget>[
            _buildItem(context),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      ),
    );
  } //Widget build

  Widget _buildItem (BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: FittedBox(
          child: Text(
            title,
          )),
    );
  } //Widget _buildItem
} //MySelectionItem

class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('Click button to back to Main Page'),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Back to Main Page'),
              onPressed: () {
                backToMainPage(context);
              },
            )
          ],
        ),
      ),
    );
  }
  void backToMainPage(context) {
    Navigator.pop(context);
  }
}
