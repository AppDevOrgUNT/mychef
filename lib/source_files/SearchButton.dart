import 'Cuisine.dart';
import 'Diet.dart';
import 'Allergy.dart';
import 'MealType.dart';

class SearchButton {
  //
  List<String> ingredients;
  List<String> allergies;
  List<String> cuisines;
  List<String> diets;
  //Consider using Ingredient class
  //Call this function with the value you want and they will be added to the end of the ingredients list
  addIngredient(String ingredientA) {
    ingredients.add(ingredientA);
  }

  //Call this function with the value you want and it will be removed from the ingredients list
  removeIngredient(String ingredientA) {
    ingredients.remove(ingredientA);
  }

  addAllergy(String AllergyA) {
    allergies.add(AllergyA);
  }

  removeAllergy(String AllergyA) {
    allergies.remove(AllergyA);
  }

  addCuisine(String cuisineA) {
    cuisines.add(cuisineA);
  }

  removeCuisine(String cuisineA) {
    cuisines.remove(cuisineA);
  }

  addDiet(String dietA) {
    diets.add(dietA);
  }

  removeDiet(String dietA) {
    diets.remove(dietA);
  }
}
