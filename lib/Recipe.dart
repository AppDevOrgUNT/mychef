import 'Cuisine.dart';
import 'Diet.dart';
import 'Ingredient.dart';
import 'Allergy.dart';
import 'MealType.dart';

class Recipe
{
  List<Ingredient> ingredients;
  String directions;

  int calories;
  double servings;
  int prepTime, totalCookTime;
  MealType mealType;
  List<Allergy> allergies;
  List<Cuisine> cuisines;
  List<Diet> diets;

  Recipe()
  {

  }

  main()
  {

  }
}