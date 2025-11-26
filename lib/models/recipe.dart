class Recipe {
  final String id;
  final String name;
  final String image;
  final String instructions;
  final List<String> ingredients;
  final String? youtube;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.instructions,
    required this.ingredients,
    this.youtube,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      String ingredient = json['strIngredient$i'];
      String measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add('$ingredient ($measure)');
      }
    }
    return Recipe(
      id: json['idMeal'],
      name: json['strMeal'],
      image: json['strMealThumb'],
      instructions: json['strInstructions'],
      ingredients: ingredients,
      youtube: json['strYoutube'],
    );
  }
}
