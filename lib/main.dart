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

//App colors
const interfaceColor = const Color.fromARGB(0xff, 0x79, 0xA5, 0x4E);
const fruitsColor = const Color.fromARGB(0xff, 0xA1, 0x79, 0xBC);
const vegetablesColor = const Color.fromARGB(0xff, 0x79, 0xA5, 0x4E);
const grainsColor = const Color.fromARGB(0xff, 0xE6, 0x8A, 0x00);
const proteinColor = const Color.fromARGB(0xff, 0xC6, 0x5D, 0x3E);
const dairyColor = const Color.fromARGB(0xff, 0x7B, 0xA4, 0xDD);
const condimentsColor = const Color.fromARGB(0xff, 0xEB, 0xB0, 0x00);

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
      //the title is the app bars text
      home: MyHomePageWidget(),
    );
  } //Widget build
} //MyApp Class

//Creating a statefulwidget for "_MyHomePageState"
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title; //this is the title from above
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// } //MyHomePage Class

//CREATING STATEFUL FOR SEARCHTEXTFIELD
// class SearchTextFieldWidget extends StatefulWidget {
//   SearchTextFieldWidget({Key key}) : super(key: key);
//
//   @override
//   _SearchTextFieldWidgetState createState() => _SearchTextFieldWidgetState();
// }

//RECREATING STATEFUL WIDGET FOR MYHOMEPAGESTATE
class MyHomePageWidget extends StatefulWidget {
  MyHomePageWidget({Key key}) : super(key: key);

  @override
  _MyHomePageWidgetState createState() => _MyHomePageWidgetState();
}

//RECREATING CLASS FOR MYHOMEPAGE CLASS
class _MyHomePageWidgetState extends State<MyHomePageWidget> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(
      //Text Style
      fontSize: 30,
      fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    //Contains widgets to display for each tab; Stored in center widget
    Center(
      //SCROLLING CHECKLIST OF INGREDIENTS
      child: ListOfIngredientsWidget(), //Calls list of ingredients widget class
    ),
    // Text(
    //   'Index 1: Recipe Output', //TODO: Find widget for multiple lines of text
    //   style: optionStyle,
    // ),
    Center(
      child: RecipesWidget(),
    ),
    ListView(
      padding: const EdgeInsets.all(5),
      children: <Widget>[
        SearchTextFieldWidget(),
        Text('Proteins'),
        HorizontalChecklistWidget(), //Need to find a way to create an instance of this class for each category
        Text('Grains'),
        HorizontalChecklistWidget(),
        Text('Vegetables'),
        HorizontalChecklistWidget(),
        Text('Fruits'),
        HorizontalChecklistWidget(),
        Text('Dairy'),
        HorizontalChecklistWidget(),
      ],
    ),
    Text(
      'Not sure what to put here',
      style: optionStyle,
    ),
    Text(
      'Settings for User login',
      style: optionStyle,
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
      // appBar: AppBar(
      //   title: const Text(
      //       'Testing Navigator Bar'), //TODO: How to change text of app bar to match bottom tab
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey[700],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Shopping Cart',
            //backgroundColor: Colors.blue[200],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_headline_sharp),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[900],
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

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Ingredient',
            ),
            validator: (value) {
              //If user doesn't enter anything on the text field
              if (value.isEmpty) {
                return 'Please enter an ingredient'; //Alerts user
              }
              return null;
            },
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
              child: Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}

//Class to display list of ingredients that are appended to the list
class ListOfIngredientsWidget extends StatefulWidget {
  ListOfIngredientsWidget({Key key}) : super(key: key);

  @override
  _ListOfIngredientsWidgetState createState() =>
      _ListOfIngredientsWidgetState();
}

class _ListOfIngredientsWidgetState extends State<ListOfIngredientsWidget> {
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

  Widget build(BuildContext context) {
    return ListView.separated(
      //Creates dynamic list of ingredients from the list
      padding: const EdgeInsets.all(8),
      itemCount: ingredients.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 30,
          //color: Colors.indigo[colorCodes[index]],
          child: Center(
            child: Text('${ingredients[index]}'),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
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
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

//Class that implements horizontal scrolling checklist
class HorizontalChecklistWidget extends StatefulWidget {
  HorizontalChecklistWidget({Key key}) : super(key: key);

  @override
  _HorizontalChecklistWidgetState createState() =>
      _HorizontalChecklistWidgetState();
}

/* NOTES:
    -Need a way to create a new instance/(object?) of HorizontalChecklistWidget class for each category
*/

class _HorizontalChecklistWidgetState extends State<HorizontalChecklistWidget> {
  final List<String> ingredients = <String>[
    'Eggs',
    'Bacon',
    'Rice',
    'Lettuce'
  ]; //List of ingredients can be appended here; NOT USED IN THIS CLASS YET

  bool _isSelected = false;
  final _width = 130.0; //sets consistent width for checkboxes

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal, //makes scrolling go left and right
        children: <Widget>[
          /* MORE NOTES
              -Need a way to create instance/(object?) of each container for the ingredient checkboxes
              -Need to fix checkboxes to not all be checked when one is selected
              -Need a way for label(text) to dynamically change size when it doesn't fit in the checkbox container
              OR maybe make checkbox container bigger to where majority of words(ingredients) fit
           */
          Container(
            width: _width,
            color: Colors.grey[300],
            child: LabeledCheckbox(
              label: 'Egg',
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value:
                  _isSelected, //<== Accessed and changed throughout the whole class
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected = newValue;
                });
              },
            ),
          ),
          Container(
            width: _width,
            color: Colors.grey[200],
            child: LabeledCheckbox(
              label: 'Bacon',
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value: _isSelected,
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected = newValue;
                });
              },
            ),
          ),
          Container(
            width: _width,
            color: Colors.grey[300],
            child: LabeledCheckbox(
              label: 'Lettuce',
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value: _isSelected,
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected = newValue;
                });
              },
            ),
          ),
          Container(
            width: _width,
            color: Colors.grey[200],
            child: LabeledCheckbox(
              label: 'Rice',
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value: _isSelected,
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected = newValue;
                });
              },
            ),
          ),
          Container(
            width: _width,
            color: Colors.grey[300],
            child: LabeledCheckbox(
              label: 'Banana',
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value: _isSelected,
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected = newValue;
                });
              },
            ),
          ),
          Container(
            width: _width,
            color: Colors.grey[200],
            child: LabeledCheckbox(
              label: 'Chicken',
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value: _isSelected,
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected = newValue;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipesWidget extends StatefulWidget {
  RecipesWidget({Key key}) : super(key: key);

  @override
  _RecipesWidgetState createState() => _RecipesWidgetState();
}

class _RecipesWidgetState extends State<RecipesWidget> {
  //Create a list of ingredients for the list view widget
  final List<String> recipeName = <String>['Chicken', 'Pasta'];
  final List<String> recipeImage = <String>[
    'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2012/11/2/0/DV1510H_fried-chicken-recipe-10_s4x3.jpg.rend.hgtvcom.616.462.suffix/1568222255998.jpeg',
    'https://lilluna.com/wp-content/uploads/2017/10/penne-pasta-resize-3-500x500.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        backgroundColor: interfaceColor,
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(10.0),
          itemCount: recipeImage.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: condimentsColor,
              margin: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.check),
                    color: Colors.white,
                    onPressed: () {
                      navigateToRecipePage(context);
                    },
                  ),
                  Image.network('${recipeImage[index]}',
                      height: 100, fit: BoxFit.fill),
                  Text(
                    '${recipeName[index]}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
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

//This is the class that is now "stateful" from "MyHomePage" class
// class _MyHomePageState extends State<MyHomePage> {
//   var recipe1 = new Recipe();
//   var ingredient1 = new Ingredient();
//
//   @override //This is now building a widget / homepage
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         //AppBar and the Text is the title from above
//         title: Text(widget.title),
//       ),
//       body: Padding(
//         //Just formatting
//         padding: const EdgeInsets.all(15.0),
//         child: Center(
//             //This is the "child" which has another "child" below it
//             child: Column(
//                 //More formatting
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//               //The child "Column" has a list of widgets
//               /*
//                   ListView.builder(itemBuilder:
//                   itemCount: list.length,
//                 ),
//                 */
//               Text('Click button to move to search'),
//               RaisedButton(
//                 textColor: Colors.white,
//                 color: Colors.blue,
//                 child: Text('Go to search results'),
//                 onPressed: () {
//                   //When the RaisedButton widget is pressed
//                   navigateToSubPage(context); //It will navigateTo"SubPage"
//                 },
//               )
//             ])),
//       ),
//       //This is the widget that is on the bottom as the name implies
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: (index) {
//           //When a user taps the icons the index will become that icon
//           setState(() {
//             _currentIndex = index; //
//           });
//           if (index == 0) {
//             //These are common if else statements with conditions for
//             navigateTo_MyHomePageState(context);
//           } //When the index is "0, 1,.."
//           else if (index == 1) {
//             //It will navigateTo"_Second_Page"
//             navigateTo_Second_Page(context);
//           } //Which is a class below
//           else if (index == 2) {
//             navigateTo_Third_Page(context);
//           } else if (index == 3) {
//             navigateTo_Forth_Page(context);
//           } else if (index == 4) {
//             navigateToSubPage(context);
//           }
//         },
//         currentIndex: _currentIndex,
//         //Create the variable "_currentIndex" which is used above for the onTap function
//         type: BottomNavigationBarType.shifting,
//         //Formatting for when one of the items are pressed
//         backgroundColor: Colors.lightBlue,
//         iconSize: 25,
//         items: [
//           //This begins a list of items for the bottomNavigationBAr
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             //You can change the Icon that the item will show by deleting "add_shopping_cart"
//             title: Text('#1'),
//             //This is the text that will show below the icon / its name
//             backgroundColor: Colors.lightBlue,
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.dashboard),
//               title: Text('#2'),
//               backgroundColor: Colors.lightBlue),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               title: Text('#3'),
//               backgroundColor: Colors.lightBlue),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.favorite),
//               title: Text('#4'),
//               backgroundColor: Colors.lightBlue),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.search),
//               title: Text('#5'),
//               backgroundColor: Colors.lightBlue),
//         ],
//       ),
//     );
//   }
// //
//   Future navigateToSubPage(context) async {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
//   } //Future
// //
//   Future navigateTo_MyHomePageState(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => MyHomePage()));
//   } //Future
//
//   Future navigateTo_Second_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Second_Page()));
//   } //Future
//
//   Future navigateTo_Third_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Third_Page()));
//   } //Future
//
//   Future navigateTo_Forth_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Forth_Page()));
//   } //Future
//
// } //class _MyHomePageState
//
// class MySelectionItem extends StatelessWidget {
//   final String title;
//   final bool isForList;
//
//   const MySelectionItem({Key key, this.title, this.isForList = true})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60.0,
//       child: isForList
//           ? Padding(
//               child: _buildItem(context),
//               padding: EdgeInsets.all(10.0),
//             )
//           : Card(
//               margin: EdgeInsets.symmetric(horizontal: 10.0),
//               child: Stack(
//                 children: <Widget>[
//                   _buildItem(context),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Icon(Icons.arrow_drop_down),
//                   )
//                 ],
//               ),
//             ),
//     );
//   } //Widget build
//
//   Widget _buildItem(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       alignment: Alignment.center,
//       child: FittedBox(
//           child: Text(
//         title,
//       )),
//     );
//   } //Widget _buildItem
// } //MySelectionItem
//
// class SubPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sub Page | search'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             //row for 2 buttons
//             Expanded(
//               child: new Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         //recipe 1 //TODO: RECIPE Classes
//                         IconButton(
//                           icon: Icon(Icons.home),
//                           tooltip: 'look at chicken recipe',
//                           onPressed: () {
//                             navigateToSubPageChicken(context);
//                           },
//                         ),
//                         Text('Chicken Recipe'),
//
//                         //recipe 2
//                         IconButton(
//                           icon: Icon(Icons.volume_up),
//                           tooltip: 'look at pasta recipe',
//                           onPressed: () {
//                             navigateToSubPagePasta(context);
//                           },
//                         ),
//                         Text('Pasta Recipe'),
//                       ])),
//             ),
//
//             Text('Click button to back to Main Page'),
//             RaisedButton(
//               textColor: Colors.white,
//               color: Colors.blue,
//               child: Text('Back to Main Page'),
//               onPressed: () {
//                 backToMainPage(context);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void backToMainPage(context) {
//     Navigator.pop(context);
//   }
//
//   Future navigateToSecond_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Second_Page()));
//   }
//
//   Future navigateToThird_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Third_Page()));
//   }
//
//   Future navigateToForth_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Forth_Page()));
//   }
//
//   Future navigateToSubPageChicken(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => SubPageChicken()));
//   }
//
//   Future navigateToSubPagePasta(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => SubPagePasta()));
//   }
//} //SubPage
//
// //The class without the prefixed _ is creating the stateful widget
// //For the class that is prefixed with _
// class Second_Page extends StatefulWidget {
//   Second_Page({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _Second_Page createState() => _Second_Page();
// } //Second_Page Class
//
// //This class's state extends the class with the prefixed _
// class _Second_Page extends State<Second_Page> {
//   int _selectedIndex = 0;
//   void _onItemTapped(int index) {
//     //Calculate the index of bottom navigation bar??
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('2nd Page'),
//           backgroundColor: Colors.blue,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Text('This is the 2nd page'),
//                 RaisedButton(
//                   textColor: Colors.white,
//                   color: Colors.blue,
//                   child: Text('Go back?'),
//                   onPressed: () {
//                     // navigateToMyHomePage(context);
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.add_shopping_cart),
//               title: Text('Shopping Cart'),
//               backgroundColor: Colors.blue,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.dashboard),
//               title: Text('Dashboard'),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               title: Text('Home'),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.favorite),
//               title: Text('Favorite'),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.search),
//               title: Text('Search'),
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.pink[200],
//           onTap: _onItemTapped,
//
//           // onTap: (index) {
//           //   setState(() {
//           //     _currentIndex = index;
//           //   }); //TODO: Fix if (index == 0) routing, this will crash the app and not route to "_MyHomePageState"
//           //   if (index == 0) {
//           //     navigateTo_MyHomePageState(context); //PROBLEM!
//           //   } else if (index == 1) {
//           //     navigateTo_Second_Page(context); //when second icon is clicked
//           //   } else if (index == 2) {
//           //     navigateTo_Third_Page(context); //when second
//           //   } else if (index == 3) {
//           //     navigateTo_Forth_Page(context);
//           //   } else if (index == 4) {
//           //     navigateToSubPage(context);
//           //   }
//           // },
//           // currentIndex: _currentIndex,
//           // type: BottomNavigationBarType.shifting,
//           // backgroundColor: Colors.lightBlue,
//           // iconSize: 25,
//           // items: [
//           //   BottomNavigationBarItem(
//           //     icon: Icon(Icons.add_shopping_cart),
//           //     title: Text('#1'),
//           //     backgroundColor: Colors.lightBlue,
//           //   ),
//           //   BottomNavigationBarItem(
//           //       icon: Icon(Icons.dashboard),
//           //       title: Text('#2'),
//           //       backgroundColor: Colors.lightBlue),
//           //   BottomNavigationBarItem(
//           //       icon: Icon(Icons.home),
//           //       title: Text('#3'),
//           //       backgroundColor: Colors.lightBlue),
//           //   BottomNavigationBarItem(
//           //       icon: Icon(Icons.favorite),
//           //       title: Text('#4'),
//           //       backgroundColor: Colors.lightBlue),
//           //   BottomNavigationBarItem(
//           //       icon: Icon(Icons.search),
//           //       title: Text('#5'),
//           //       backgroundColor: Colors.lightBlue),
//           // ],
//         ));
//   }
//
//   Future navigateToSubPage(context) async {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
//   } //Future
//
//   Future navigateTo_MyHomePageState(context) async {
//     //PROBLEM!
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => MyHomePage()));
//   } //Future
//
//   Future navigateTo_Second_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Second_Page()));
//   } //Future
//
//   Future navigateTo_Third_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Third_Page()));
//   } //Future
//
//   Future navigateTo_Forth_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Forth_Page()));
//   } //Future
// } //_Second_Page Class
//
// //The class without the prefixed _ is creating the stateful widget
// //For the class that is prefixed with _
// class Third_Page extends StatefulWidget {
//   Third_Page({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _Third_Page createState() => _Third_Page();
// } //Third_Page Class
//
// //This class's state extends the class with the prefixed _
// class _Third_Page extends State<Third_Page> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('3rd Page'),
//           backgroundColor: Colors.blue,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Text('This is the 3rd page'),
//                 RaisedButton(
//                   textColor: Colors.white,
//                   color: Colors.blue,
//                   child: Text('Go back?'),
//                   onPressed: () {
//                     // navigateToMyHomePage(context);
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//             if (index == 1) {
//               navigateTo_Second_Page(context);
//             } else if (index == 2) {
//               navigateTo_Third_Page(context);
//             } else if (index == 3) {
//               navigateTo_Forth_Page(context);
//             } else if (index == 4) {
//               navigateToSubPage(context);
//             }
//           },
//           currentIndex: _currentIndex,
//           type: BottomNavigationBarType.shifting,
//           backgroundColor: Colors.lightBlue,
//           iconSize: 25,
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.add_shopping_cart),
//               title: Text('#1'),
//               backgroundColor: Colors.lightBlue,
//             ),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.dashboard),
//                 title: Text('#2'),
//                 backgroundColor: Colors.lightBlue),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 title: Text('#3'),
//                 backgroundColor: Colors.lightBlue),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.favorite),
//                 title: Text('#4'),
//                 backgroundColor: Colors.lightBlue),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.search),
//                 title: Text('#5'),
//                 backgroundColor: Colors.lightBlue),
//           ],
//         ));
//   }
//
//   Future navigateToSubPage(context) async {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
//   } //Future
//
//   Future navigateTo_Second_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Second_Page()));
//   } //Future
//
//   Future navigateTo_Third_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Third_Page()));
//   }
//
//   Future navigateTo_Forth_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Forth_Page()));
//   }
// } //_Third_Page Class
//
// //So on
// class Forth_Page extends StatefulWidget {
//   Forth_Page({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _Forth_Page createState() => _Forth_Page();
// } //Forth_Page Class
//
// //And so on
// class _Forth_Page extends State<Forth_Page> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('4th Page'),
//           backgroundColor: Colors.blue,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Text('This is the 4th page'),
//                 RaisedButton(
//                   textColor: Colors.white,
//                   color: Colors.blue,
//                   child: Text('Go back?'),
//                   onPressed: () {
//                     // navigateToMyHomePage(context);
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//             if (index == 1) {
//               navigateTo_Second_Page(context);
//             } else if (index == 2) {
//               navigateTo_Third_Page(context);
//             } else if (index == 3) {
//               navigateTo_Forth_Page(context);
//             } else if (index == 4) {
//               navigateToSubPage(context);
//             }
//           },
//           currentIndex: _currentIndex,
//           type: BottomNavigationBarType.shifting,
//           backgroundColor: Colors.lightBlue,
//           iconSize: 25,
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.add_shopping_cart),
//               title: Text('#1'),
//               backgroundColor: Colors.lightBlue,
//             ),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.dashboard),
//                 title: Text('#2'),
//                 backgroundColor: Colors.lightBlue),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 title: Text('#3'),
//                 backgroundColor: Colors.lightBlue),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.favorite),
//                 title: Text('#4'),
//                 backgroundColor: Colors.lightBlue),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.search),
//                 title: Text('#5'),
//                 backgroundColor: Colors.lightBlue),
//           ],
//         ));
//   }
//
//   Future navigateToSubPage(context) async {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
//   } //Future
//
//   Future navigateTo_Second_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Second_Page()));
//   } //Future
//
//   Future navigateTo_Third_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Third_Page()));
//   }
//
//   Future navigateTo_Forth_Page(context) async {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Forth_Page()));
//   }
// } //_Forth_Page Class
//

/*
    This can be the skeleton code for the recipe class.
 */

class SubPageChicken extends StatefulWidget {
  SubPageChicken({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SubPageChicken createState() => _SubPageChicken();
} //Forth_Page Class

class _SubPageChicken extends State<SubPageChicken> {
  final List<String> recipeImage = <String>[
    'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2012/11/2/0/DV1510H_fried-chicken-recipe-10_s4x3.jpg.rend.hgtvcom.616.462.suffix/1568222255998.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Here is your Recipe!'),
        backgroundColor: interfaceColor,
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: recipeImage.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Image.network('${recipeImage[index]}',
                        //height: 500,
                        fit: BoxFit.fill),
                    Text(chickenRecipe.directions),
                    Text("calories: " + chickenRecipe.calories.toString()),
                    Text("servings: " + chickenRecipe.servings.toString()),
                    Text("prepTime: " + chickenRecipe.prepTime.toString()),
                    Text("totalCookTime:  " +
                        chickenRecipe.totalCookTime.toString()),
                    Text(
                        "meal type:  " + chickenRecipe.thisMealType.toString()),
                  ],
                ),
              );
            }),
      ),
    );
  }

  // Future navigateToSubPage(context) async {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
  // } //Future
  //
  // Future navigateTo_Second_Page(context) async {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => Second_Page()));
  // } //Future
  //
  // Future navigateTo_Third_Page(context) async {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => Third_Page()));
  // }
  //
  // Future navigateTo_Forth_Page(context) async {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => Forth_Page()));
  // }

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
