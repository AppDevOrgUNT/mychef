import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'entities/note.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var index = 0;
  List<Note> recipes = List<Note>(); // creates the List of Notes object that will store the recipe info
  var test = Note.ifFails("ops", "guess it didn't work");


  Future<List<Note>> fetchNotes() async {
    //for the URL, we are going to add the club API key, its using mine for now
    //and for any searches you can consult the spoonacular document to see the syntax,
    //you should be able to replace that middle with a variable
    var url = 'https://api.spoonacular.com/recipes/findByIngredients?ingredients=beef,+broth,&number=30&apiKey=ed6d31ebce104a339672fc4babd4e536';
    //This is a feature unique to Future asyncronous functions, it waits for the server to respond to your request
    var response = await http.get(url);
    var recipe = List<Note>();
    //Asserts that the server response was successful
    if (response.statusCode == 200)
      {
      //This is a call from the flutter json library.
      //It transforms the json string into a map. You can run the API url above on a browser to see what the keys for each element are
      var notesJson = json.decode(response.body);
      //If there is more than one result, the outtermost layer of the map will contain the number of finds
      //and a sub-map with all the results
      for (var noteJson in notesJson){
        recipe.add(Note.fromJson(noteJson)); // populates recipes object
      }
      return recipe; // returns a List with all the recipes
    }
    else{ // this will run if the server fails
      recipe.add(Note.ifFails("This Failed", "Didn't work"));
      return recipe;
    }
  }

  @override
  // initState is what runs where the program first starts up, this is an overload of that function
  void initState() {
    super.initState();
    // This is weird syntax for calling future functions, didn't really understand it but it works
    fetchNotes().then((value) {
      setState(() {
        //stores all the recipes in an object
        recipes.addAll(value);
      });
    });
  }
  String printIngr(List<String> ingredients)
  {
    String ingresList = ingredients.join(", ");
    return ingresList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //placeholder title for app
        title: Text('My Chef Recipes'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      //'Title',
                      recipes[index].title,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                      )
                  ),
                  Text(
                      //'sub title',
                      "Recipe ID: " + recipes[index].text,
                      style: TextStyle(
                        color: Colors.grey.shade500
                      )

                  ),
                  Text(
                      "Missing Ingredients: " + printIngr(recipes[index].missIngredients),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal
                      )
                  ),
                  Image.network(
                    recipes[index].imageUrl,
                    width: 200,
                    height: 100,
                  )
              ]
             )
            ),
          );
        },
        itemCount: recipes.length,
      )
    );
    index++;
  }
}
