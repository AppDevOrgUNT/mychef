import 'Allergy.dart';

class Ingredient {
  //IngredientType type;
  Allergy allergy;
  String name;
  bool animalProduct;

  showIngrInfo() {
    print(
        "The ingredient function contents are: $name, $allergy, $animalProduct");
  }

  Ingredient(
      {Allergy allergy,
      String name = "Default ingredient",
      bool animalProduct = false});
}
