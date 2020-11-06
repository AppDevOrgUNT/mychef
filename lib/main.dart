import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'enums/Ingredient.dart';
import 'classes/Recipe.dart';
import 'enums/Allergy.dart';
import 'enums/MealType.dart';
import 'enums/Diet.dart';
import 'dart:collection';
import 'classes/SearchButton.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

var _currentIndex = 0; //Global Variable for page index
const TextStyle style =
    TextStyle(fontFamily: 'Montserrat'); //global text format

//App colors
const interfaceColor = const Color.fromARGB(0xff, 0x86, 0xB3, 0x2C);
const purpleColor = const Color.fromARGB(0xff, 0xA1, 0x79, 0xBC);
const greenColor = const Color.fromARGB(0xff, 0x79, 0xA5, 0x4E);
const orangeColor = const Color.fromARGB(0xff, 0xE6, 0x8A, 0x00);
const redColor = const Color.fromARGB(0xff, 0xC6, 0x5D, 0x3E);
const blueColor = const Color.fromARGB(0xff, 0x7B, 0xA4, 0xDD);
const yellowColor = const Color.fromARGB(0xff, 0xEB, 0xB0, 0x00);

Recipe chickenRecipe = new Recipe(
    directions:
        "Step 1\nPreheat oven to 350 degrees F (175 degrees C).\n\nStep 2\nPlace chicken in a roasting pan, and season generously inside and out with salt and pepper. Sprinkle inside and out with onion powder. Place 3 tablespoons margarine in the chicken cavity. Arrange dollops of the remaining margarine around the chicken's exterior. Cut the celery into 3 or 4 pieces, and place in the chicken cavity.\n\nStep 3\nBake uncovered 1 hour and 15 minutes in the preheated oven, to a minimum internal temperature of 180 degrees F (82 degrees C). Remove from heat, and baste with melted margarine and drippings. Cover with aluminum foil, and allow to rest about 30 minutes before serving.\n\n",
    calories: 240,
    servings: 6,
    prepTime: 10,
    totalCookTime: 100,
    thisMealType: MealType.mainCourse); //chickenRecipe

Recipe pastaRecipe = new Recipe(
  directions:
      "Step :First, make a nest with the flour on a clean work surface \nAdd the remaining ingredients to the center and use a fork to gently break up the eggs.\nTry to keep the flour walls intact as best as you can! \nStep 2 :Next, use your hands to gently mix in the flour. Continue working the dough to bring it together into a shaggy ball.",
  calories: 349,
  servings: 2,
  prepTime: 10,
  totalCookTime: 26,
  thisMealType: MealType.mainCourse,
); //pastaRecipe

void main() => runApp(MyApp()); // main lol

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePageWidget(),
    );
  } //Widget build
} //MyApp Class

//RECREATING STATEFUL WIDGET FOR MYHOMEPAGESTATE
class MyHomePageWidget extends StatefulWidget {
  MyHomePageWidget({Key key}) : super(key: key);

  @override
  _MyHomePageWidgetState createState() => _MyHomePageWidgetState();
}

//RECREATING CLASS FOR MYHOMEPAGE CLASS
class _MyHomePageWidgetState extends State<MyHomePageWidget> {
  int _selectedIndex =
      2; //2 - Index for homepage; Makes home as default page @start up

  static const TextStyle optionStyle = TextStyle(
      //Text Style
      fontSize: 30,
      fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    //Contains widgets to display for each tab; Stored in center widget
    Center(
      //SHOPPING CART TAB
      child: ShoppingCartWidget(),
    ),
    Center(
      //RECIPES TAB
      child: RecipesTabWidget(),
    ),
    Center(
      //HOME TAB
      child: HomeTabWidget(),
    ),
    Text(
      //FAVORITES TAB
      'Not sure what to put here',
      style: optionStyle,
    ),
    Center(
      //SETTINGS TAB
      child: SettingTabWidget(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    //Constructs how the page look
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: interfaceColor,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Shopping Cart',
            backgroundColor: interfaceColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'Recipes',
            backgroundColor: interfaceColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: interfaceColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
            backgroundColor: interfaceColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_headline_sharp),
            label: 'Settings',
            backgroundColor: interfaceColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(0xff, 0x4E, 0x6E, 0x0F),
        onTap: _onItemTapped,
      ),
    );
  }
}

//Class for search text field
class SearchTextFieldWidget extends StatefulWidget {
  SearchTextFieldWidget({Key key}) : super(key: key);

  @override
  _SearchTextFieldWidgetState createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  final _formKey = GlobalKey<FormState>();

  //Might be a good resource: https://dev.to/luizeduardotj/search-bar-in-flutter-33e1

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // TextFormField(
          //   decoration: const InputDecoration(
          //     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          //     hintText: 'Enter Ingredient',
          //   ),
          //   validator: (value) {
          //     //If user doesn't enter anything on the text field
          //     if (value.isEmpty) {
          //       return 'Please enter an ingredient'; //Alerts user
          //     }
          //     return null;
          //   },
          // ),
          TextField(
            obscureText: false,
            style: style,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                hintText: "Enter ingredient",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ElevatedButton(
              //Creates add button
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  //PROCESS DATA HERE AFTER USER PRESSES THE BUTTON
                }
              },
              child: Text(
                'Add',
                style: style,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Class to display list of ingredients that are appended to the list
class ShoppingCartWidget extends StatefulWidget {
  ShoppingCartWidget({Key key}) : super(key: key);

  @override
  _ShoppingCartWidgetState createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
  final List<String> ingredients = <String>[
    'Eggs',
    'Bacon',
    'Rice',
    'Lettuce',
    'Banana',
    'Chicken',
    'Wheat Bread',
    'Soy Sauce',
    'Baking Soda',
    'Butter',
    'Beef',
    'Pork',
    'Cream Cheese',
    'Broccoli',
    'Ham',
    'Whipping Cream',
    'Garlic',
    'Tomato'
  ]; //List of ingredients can be appended here
  //final List<int> colorCodes = <int>[600, 500, 400, 300];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: style,
        ),
        backgroundColor: interfaceColor,
      ),
      body: Center(
        child: ListView.separated(
          //Creates dynamic list of ingredients from the list
          padding: const EdgeInsets.all(8),
          itemCount: ingredients.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 30,
              //color: Colors.indigo[colorCodes[index]],
              child: Center(
                child: Text('${ingredients[index]}', style: style),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}

//checkboxes and search is stored here
class HomeTabWidget extends StatefulWidget {
  HomeTabWidget({Key key}) : super(key: key);

  @override
  _HomeTabWidgetState createState() => _HomeTabWidgetState();
}

class _HomeTabWidgetState extends State<HomeTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          //TODO: Format app bar based on group 4's design
          title: Text(
            'Let\'s Cook!',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  SearchTextFieldWidget(); //TODO: Search bar should pop up after pressing this
                }),
          ],
          backgroundColor: interfaceColor,
        ),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          children: <Widget>[
            //SearchTextFieldWidget(),
            SizedBox(height: 30.0),
            Text('Proteins', style: style),
            ProteinsChecklistWidget(), //Need to find a way to create an instance of this class for each category
            SizedBox(height: 30.0),
            Text('Grains', style: style),
            GrainsChecklistWidget(),
            SizedBox(height: 30.0),
            Text('Vegetables', style: style),
            VegetablesChecklistWidget(),
            SizedBox(height: 30.0),
            Text('Fruits', style: style),
            FruitsChecklistWidget(),
            SizedBox(height: 30.0),
            Text('Dairy', style: style),
            DairyChecklistWidget(),
            SizedBox(height: 30.0),
            Text('Sauces & Condiments', style: style),
            SauceChecklistWidget(),
          ],
        ),
      ),
    );
  }
}

//Creates custom labeled checkbox class used in the HorizontalChecklistWidget class
class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    //to keep a consistent layout
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });
  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  final checkboxSize = 10.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          //creates a "custom" checkbox instead of using CheckboxListTile Widget
          children: <Widget>[
            Container(
              //For the checkbox (circle)
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), //rounds off corners
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5), //TODO: Make check mark bigger
                child: value
                    ? Icon(Icons.check_sharp,
                        size: checkboxSize, color: Colors.black)
                    : Icon(Icons.check_box_outline_blank,
                        size: checkboxSize, color: Colors.white),
              ),
            ),
            Expanded(
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TODO: Find a way to create generalized class for each checklist widget
class ProteinsChecklistWidget extends StatefulWidget {
  ProteinsChecklistWidget({Key key}) : super(key: key);

  @override
  _ProteinsChecklistWidgetState createState() =>
      _ProteinsChecklistWidgetState();
}

class _ProteinsChecklistWidgetState extends State<ProteinsChecklistWidget> {
  final List<String> ingredients = <String>[
    'Beef',
    'Bacon',
    'Pork',
    'Chicken',
    'Egg'
  ]; //List of ingredients can be appended here for each category:

  final List<bool> isSelected = <bool>[
    false,
    false,
    false,
    false,
    false
  ]; //makes individual checkboxes selected

  final categoryColor = redColor;
  final _width = 150.0; //sets consistent width for checkboxes

  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal, //makes scrolling go left and right
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: categoryColor,
            ),
            width: _width,
            child: LabeledCheckbox(
              label: '${ingredients[index]}',
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value: isSelected[index],
              onChanged: (bool newValue) {
                setState(() {
                  isSelected[index] = newValue;
                });
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }
}

class GrainsChecklistWidget extends StatefulWidget {
  GrainsChecklistWidget({Key key}) : super(key: key);

  @override
  _GrainsChecklistWidgetState createState() => _GrainsChecklistWidgetState();
}

class _GrainsChecklistWidgetState extends State<GrainsChecklistWidget> {
  final List<String> ingredients = <String>[
    'White Rice',
    'Brown Rice',
    'Tortilla',
    'Popcorn',
    'Bread'
  ]; //List of ingredients can be appended here for each category:

  final List<bool> isSelected = <bool>[
    false,
    false,
    false,
    false,
    false
  ]; //makes individual checkboxes selected

  final categoryColor = orangeColor;
  final _width = 150.0; //sets consistent width for checkboxes

  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal, //makes scrolling go left and right
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: categoryColor,
            ),
            width: _width,
            child: LabeledCheckbox(
              label: '${ingredients[index]}',
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value: isSelected[index],
              onChanged: (bool newValue) {
                setState(() {
                  isSelected[index] = newValue;
                });
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }
}

class VegetablesChecklistWidget extends StatefulWidget {
  VegetablesChecklistWidget({Key key}) : super(key: key);

  @override
  _VegetablesChecklistWidgetState createState() =>
      _VegetablesChecklistWidgetState();
}

class _VegetablesChecklistWidgetState extends State<VegetablesChecklistWidget> {
  final List<String> ingredients = <String>[
    'Romaine Lettuce',
    'Broccoli',
    'Carrot',
    'Spinach',
    'Squash'
  ]; //List of ingredients can be appended here for each category:

  final List<bool> isSelected = <bool>[
    false,
    false,
    false,
    false,
    false
  ]; //makes individual checkboxes selected

  final categoryColor = greenColor;
  final _width = 150.0; //sets consistent width for checkboxes

  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal, //makes scrolling go left and right
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: categoryColor,
            ),
            width: _width,
            child: LabeledCheckbox(
              label: '${ingredients[index]}',
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value: isSelected[index],
              onChanged: (bool newValue) {
                setState(() {
                  isSelected[index] = newValue;
                });
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }
}

class FruitsChecklistWidget extends StatefulWidget {
  FruitsChecklistWidget({Key key}) : super(key: key);

  @override
  _FruitsChecklistWidgetState createState() => _FruitsChecklistWidgetState();
}

class _FruitsChecklistWidgetState extends State<FruitsChecklistWidget> {
  final List<String> ingredients = <String>[
    'Mango',
    'Banana',
    'Grapes',
    'Orange',
    'Strawberry'
  ]; //List of ingredients can be appended here for each category:

  final List<bool> isSelected = <bool>[
    false,
    false,
    false,
    false,
    false
  ]; //makes individual checkboxes selected

  final categoryColor = purpleColor;
  final _width = 150.0; //sets consistent width for checkboxes

  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal, //makes scrolling go left and right
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: categoryColor,
            ),
            width: _width,
            child: LabeledCheckbox(
              label: '${ingredients[index]}',
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value: isSelected[index],
              onChanged: (bool newValue) {
                setState(() {
                  isSelected[index] = newValue;
                });
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }
}

class DairyChecklistWidget extends StatefulWidget {
  DairyChecklistWidget({Key key}) : super(key: key);

  @override
  _DairyChecklistWidgetState createState() => _DairyChecklistWidgetState();
}

class _DairyChecklistWidgetState extends State<DairyChecklistWidget> {
  final List<String> ingredients = <String>[
    'Goat Cheese',
    'Butter',
    'Greek Yogurt',
    'Whipped Cream',
    'Cream Cheese'
  ]; //List of ingredients can be appended here for each category:

  final List<bool> isSelected = <bool>[
    false,
    false,
    false,
    false,
    false
  ]; //makes individual checkboxes selected

  final categoryColor = blueColor;
  final _width = 150.0; //sets consistent width for checkboxes

  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal, //makes scrolling go left and right
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: categoryColor,
            ),
            width: _width,
            child: LabeledCheckbox(
              label: '${ingredients[index]}',
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value: isSelected[index],
              onChanged: (bool newValue) {
                setState(() {
                  isSelected[index] = newValue;
                });
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }
}

class SauceChecklistWidget extends StatefulWidget {
  SauceChecklistWidget({Key key}) : super(key: key);

  @override
  _SauceChecklistWidgetState createState() => _SauceChecklistWidgetState();
}

class _SauceChecklistWidgetState extends State<SauceChecklistWidget> {
  final List<String> ingredients = <String>[
    'Ketchup',
    'Mayonnaise',
    'Mustard',
    'Relish',
    'Soy Sauce'
  ]; //List of ingredients can be appended here for each category:

  final List<bool> isSelected = <bool>[
    false,
    false,
    false,
    false,
    false
  ]; //makes individual checkboxes selected

  final categoryColor = yellowColor;
  final _width = 150.0; //sets consistent width for checkboxes

  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal, //makes scrolling go left and right
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: categoryColor,
            ),
            width: _width,
            child: LabeledCheckbox(
              label: '${ingredients[index]}',
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value: isSelected[index],
              onChanged: (bool newValue) {
                setState(() {
                  isSelected[index] = newValue;
                });
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }
}

//Information from Recipe class can be stored here
class RecipesTabWidget extends StatefulWidget {
  RecipesTabWidget({Key key}) : super(key: key);

  @override
  _RecipesTabWidgetState createState() => _RecipesTabWidgetState();
}

class _RecipesTabWidgetState extends State<RecipesTabWidget> {
  //Create a list of ingredients for the list view widget
  final List<String> recipeName = <String>[
    'Chicken',
    'Pasta',
    'Recipe Name',
    'Recipe Name',
    'Recipe Name',
    'Recipe Name',
    'Recipe Name'
  ];
  final List<String> recipeMealType = <String>[
    'Breakfast',
    'Lunch',
    'Meal',
    'Meal',
    'Meal',
    'Meal',
    'Meal'
  ];
  final List<String> recipeCuisine = <String>[
    'Cuisine',
    'Cuisine',
    'Cuisine',
    'Cuisine',
    'Cuisine',
    'Cuisine',
    'Cuisine'
  ];
  final List<String> recipeTime = <String>[
    '45 minutes',
    'Time',
    'Time',
    'Time',
    'Time',
    'Time',
    'Time'
  ];
  final List<String> recipeDifficulty = <String>[
    'Medium',
    'Difficulty',
    'Difficulty',
    'Difficulty',
    'Difficulty',
    'Difficulty',
    'Difficulty'
  ];
  final List<String> recipeImage = <String>[
    'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2012/11/2/0/DV1510H_fried-chicken-recipe-10_s4x3.jpg.rend.hgtvcom.616.462.suffix/1568222255998.jpeg',
    'https://lilluna.com/wp-content/uploads/2017/10/penne-pasta-resize-3-500x500.jpg',
    'https://countrylakesdental.com/wp-content/uploads/2016/10/orionthemes-placeholder-image.jpg',
    'https://countrylakesdental.com/wp-content/uploads/2016/10/orionthemes-placeholder-image.jpg',
    'https://countrylakesdental.com/wp-content/uploads/2016/10/orionthemes-placeholder-image.jpg',
    'https://countrylakesdental.com/wp-content/uploads/2016/10/orionthemes-placeholder-image.jpg',
    'https://countrylakesdental.com/wp-content/uploads/2016/10/orionthemes-placeholder-image.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          //TODO: Format app bar based on group 4's design
          title: Text(
            'Recipes (${recipeName.length})',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  SearchTextFieldWidget(); //TODO: Search bar should pop up after pressing this
                }),
          ],
          backgroundColor: interfaceColor,
        ),
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          itemCount: recipeName.length,
          itemBuilder: (BuildContext context, int index) {
            return FlatButton(
              onPressed: () {
                navigateToRecipePage(
                    context); //when button pressed, navigate to subpage
              },
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), //rounds off corners
                  color: yellowColor,
                ),
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      //Makes corner of image rounded
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      child: Image.network('${recipeImage[index]}',
                          height: 100, width: 120, fit: BoxFit.fill),
                    ),
                    // Image.network('${recipeImage[index]}',
                    //     height: 100, fit: BoxFit.fill),
                    Expanded(
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Column(
                            children: <Widget>[
                              Text(
                                '${recipeName[index]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Text(
                                '${recipeMealType[index]}, ${recipeCuisine[index]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  Text(
                                    ' ${recipeTime[index]}, ${recipeDifficulty[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 1.0,
          ),
        ),
      ),
    );
  }

  Future navigateToRecipePage(context) async {
    //Make it go to generalized subpage class for all recipes
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SubPageChicken()));
  }
}

//Stores user login
class SettingTabWidget extends StatefulWidget {
  SettingTabWidget({Key key}) : super(key: key);

  @override
  _SettingTabWidgetState createState() => _SettingTabWidgetState();
}

class _SettingTabWidgetState extends State<SettingTabWidget> {
  //TextStyle style = TextStyle(fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: orangeColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          //Process data here
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              //fontWeight: FontWeight.bold
            )),
      ),
    );

    final guestButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: orangeColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Continue as Guest",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              //fontWeight: FontWeight.bold
            )),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Login',
          style: style,
        ),
        backgroundColor: interfaceColor,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0), //separate text fields
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
                SizedBox(
                  height: 15.0,
                ),
                guestButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
    This can be the skeleton code for the recipe class.
 */

class SubPageChicken extends StatefulWidget {
  SubPageChicken({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SubPageChicken createState() => _SubPageChicken();
}

class _SubPageChicken extends State<SubPageChicken> {
  final recipeImage =
      'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2012/11/2/0/DV1510H_fried-chicken-recipe-10_s4x3.jpg.rend.hgtvcom.616.462.suffix/1568222255998.jpeg';
  final recipeName = 'Chicken';
  final recipeMealType = 'Meal';
  final recipeCuisine = 'Cuisine';
  final recipeTime = 'Time';
  final recipeDifficulty = 'Difficulty';

  final List<String> ingredients = <String>[
    'Blah',
    'Blah',
    'Blah',
    'Blah',
    'Blah'
  ]; //List of ingredients can be appended here for each category:

  final List<bool> isSelected = <bool>[
    true,
    true,
    true,
    true,
    true
  ]; //makes individual checkboxes selected

  final categoryColor = Colors.grey;
  final _width = 100.0; //sets consistent width for checkboxes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //title: Text(recipeName),
        backgroundColor: Colors
            .transparent, //Makes app bar disappear but the back button will still appear
        elevation: 0,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Image.network(recipeImage,
                //height: 500,
                fit: BoxFit.fill),
            //Container for header bar
            Container(
              color: interfaceColor,
              height: 130,
              child: Expanded(
                child: Container(
                  //color: Colors.grey,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Column(
                      children: <Widget>[
                        Text(
                          recipeName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          '${recipeMealType}, ${recipeCuisine}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 5,
                            ),
                            Text(
                              recipeTime,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 5,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              ' • ${recipeDifficulty}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 5,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //Container for  ingredients and selected checklist
            Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Column(
                children: <Widget>[
                  Text(
                    'Ingredients',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black45),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 30,
                    child: ListView.separated(
                      scrollDirection:
                          Axis.horizontal, //makes scrolling go left and right
                      itemCount: ingredients.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: categoryColor,
                          ),
                          width: _width,
                          child: LabeledCheckbox(
                            label: '${ingredients[index]}',
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            value: isSelected[index],
                            onChanged: (bool newValue) {
                              setState(() {
                                isSelected[index] = newValue;
                              });
                            },
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        width: 10.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(chickenRecipe.directions),
            Text("calories: " + chickenRecipe.calories.toString()),
            Text("servings: " + chickenRecipe.servings.toString()),
            Text("prepTime: " + chickenRecipe.prepTime.toString()),
            Text("totalCookTime:  " + chickenRecipe.totalCookTime.toString()),
            Text("meal type: " + chickenRecipe.thisMealType.toString()),
          ],
        ),
      ),
    );
  }

  void backToMainPage(context) {
    Navigator.pop(context);
  }
} //SubPageChicken Class

//
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
          ],
        ),
      ),
    );
  }

  // void backToMainPage(context) {
  //   Navigator.pop(context);
  // }
} //SubPagePasta Class
// //testing
