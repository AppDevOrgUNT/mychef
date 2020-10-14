import 'Cuisine.dart';
import 'Diet.dart';
import 'Ingredient.dart';
import 'Allergy.dart';
import 'MealType.dart';

class Recipe {
  List<Ingredient> ingredients;
  String directions;

  int calories;
  double servings;
  int prepTime, totalCookTime;
  MealType thisMealType;
  List<Allergy> allergies;
  List<Cuisine> cuisines;
  List<Diet> diets;

  //setters
  set setDirections(String A){this.directions = A;}
  set setCalories(int A){this.calories = A;}
  set setServings(double A){this.servings = A;}
  set setPrepTime(int A){this.prepTime = A;}
  set setTotalCookTime(int A){this.totalCookTime = A;}
  set setMealType(MealType A){this.thisMealType = A;}

  //getters automatic


  Recipe(
      {this.directions = "directions go brr",
      this.calories = 600,
      this.servings = 4,
      this.prepTime = 30,
      this.totalCookTime = 12,
      this.thisMealType = MealType.breakfast});

  showCalInfo() {
    print("Calories are : $calories");
  }

  showInfo() {
    print("Ingredients are :  $ingredients"); //list
    print("Directions are:  $directions");
    print("Calories are:  $calories");
    print("Servings are :  $servings");
    print("PrepTime is:  $prepTime");
    print("TotalCookTime is:  $totalCookTime");
    print("MealType is:  $thisMealType");
    print("Allergies are :  $allergies"); //list
    print("Cuisines is:  $cuisines"); //list
    print("Diets are : $diets"); //list
  }
}
