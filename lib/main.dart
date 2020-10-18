import 'package:flutter/material.dart';
import 'package:direct_select/direct_select.dart';
import 'enums/Ingredient.dart';
import 'classes/Recipe.dart';
import 'enums/Allergy.dart';
import 'enums/MealType.dart';
import 'enums/Diet.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

// FIREBASE TEST //
final databaseReference = Firestore.instance;
// END FIREBASE TEST //

Recipe chickenRecipe = new Recipe(
    directions:
        "Step 1\nPreheat oven to 350 degrees F (175 degrees C).\n\nStep 2\nPlace chicken in a roasting pan, and season generously inside and out with salt and pepper. Sprinkle inside and out with onion powder. Place 3 tablespoons margarine in the chicken cavity. Arrange dollops of the remaining margarine around the chicken's exterior. Cut the celery into 3 or 4 pieces, and place in the chicken cavity.\n\nStep 3\nBake uncovered 1 hour and 15 minutes in the preheated oven, to a minimum internal temperature of 180 degrees F (82 degrees C). Remove from heat, and baste with melted margarine and drippings. Cover with aluminum foil, and allow to rest about 30 minutes before serving.\n\n",
    calories: 240,
    servings: 6,
    prepTime: 10,
    totalCookTime: 100,
    thisMealType: MealType.mainCourse);

Recipe pastaRecipe = new Recipe(
  directions:
      "Step :First, make a nest with the flour on a clean work surface \nAdd the remaining ingredients to the center and use a fork to gently break up the eggs.\nTry to keep the flour walls intact as best as you can! \nStep 2 :Next, use your hands to gently mix in the flour. Continue working the dough to bring it together into a shaggy ball.",
  calories: 349,
  servings: 2,
  prepTime: 10,
  totalCookTime: 26,
  thisMealType: MealType.mainCourse,
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // FIREBASE TEST //
    createTest();
    print("TESTING COMPLETE");
    // END FIREBASE TEST //

    return MaterialApp(
      home: MyHomePage(title: 'myChef Functionality Test'),
    );
  } //Widget build
} //MyApp Class

// FIREBASE TEST //
void createTest() async {
  await databaseReference.collection("TestCollection")
    .document("TestDocument")
    .setData({
      'dataItem1': "Hello",
      'dataItem2': "World"
  });
}
// END FIREBASE TEST //

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var recipe1 = new Recipe();
  var ingredient1 = new Ingredient();

  final elements1 = [
    MealType.breakfast,
    MealType.appetizer,
    MealType.mainCourse,
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
  int selectedIndex1 = 0,
      selectedIndex2 = 0,
      selectedIndex3 = 0,
      selectedIndex4 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(title: ('${val}') //text of menu options
            ))
        .toList();
  }

  List<Widget> _buildItems2() {
    return elements2.map((val) => MySelectionItem(title: ('${val}'))).toList();
  }

  List<Widget> _buildItems3() {
    return elements3.map((val) => MySelectionItem(title: ('${val}'))).toList();
  }

  List<Widget> _buildItems4() {
    return elements4.map((val) => MySelectionItem(title: ('${val}'))).toList();
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
                      title: ('${elements2[selectedIndex2]}')),
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
                      title: ('${elements3[selectedIndex3]}')),
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
                      title: ('${elements4[selectedIndex4]}')),
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

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

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

  Widget _buildItem(BuildContext context) {
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
        title: Text('Sub Page | search'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            //row for 2 buttons
            Expanded(
              child: new Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        //recipe 1
                        IconButton(
                          icon: Icon(Icons.volume_up),
                          tooltip: 'look at chicken recipe',
                          onPressed: () {
                            navigateToSubPageChicken(context);
                          },
                        ),
                        Text('Chicken Recipe'),

                        //recipe 2
                        IconButton(
                          icon: Icon(Icons.volume_up),
                          tooltip: 'look at pasta recipe',
                          onPressed: () {
                            navigateToSubPagePasta(context);
                          },
                        ),
                        Text('Pasta Recipe'),
                      ])),
            ),

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

  Future navigateToSubPageChicken(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SubPageChicken()));
  }

  Future navigateToSubPagePasta(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SubPagePasta()));
  }
}

class SubPageChicken extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sub Page | Chicken'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: <
                Widget>[
          //display recipe info
          Expanded(
            child: new Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(chickenRecipe.directions),
                      Text("calories: " + chickenRecipe.calories.toString()),
                      Text("servings: " + chickenRecipe.servings.toString()),
                      Text("prepTime: " + chickenRecipe.prepTime.toString()),
                      Text("totalCookTime:  " +
                          chickenRecipe.totalCookTime.toString()),
                      Text("meal type:  " +
                          chickenRecipe.thisMealType.toString()),
                    ])),
          ),

          Text('Click button to back to Main Page'),
          RaisedButton(
            textColor: Colors.white,
            color: Colors.blue,
            child: Text('Back to Previous Page'),
            onPressed: () {
              backToMainPage(context);
            },
          )
        ])));
  }

  void backToMainPage(context) {
    Navigator.pop(context);
  }
}

class SubPagePasta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sub Page | Pasta'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
              //display recipe info
              Expanded(
                child: new Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(pastaRecipe.directions),
                          Text("calories: " + pastaRecipe.calories.toString()),
                          Text("servings: " + pastaRecipe.servings.toString()),
                          Text("prepTime: " + pastaRecipe.prepTime.toString()),
                          Text("totalCookTime:  " +
                              pastaRecipe.totalCookTime.toString()),
                          Text("meal type:  " +
                              pastaRecipe.thisMealType.toString()),
                        ])),
              ),

              Text('Click button to back to Main Page'),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Back to Previous Page'),
                onPressed: () {
                  backToMainPage(context);
                },
              )
            ])));
  }

  void backToMainPage(context) {
    Navigator.pop(context);
  }
}

