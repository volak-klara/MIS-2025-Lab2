import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class RecipeScreen extends StatefulWidget {
  final String mealId;

  RecipeScreen({required this.mealId});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  late Future<Recipe> futureRecipe;

  @override
  void initState() {
    super.initState();
    futureRecipe = ApiService().getRecipeById(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Рецепт'), centerTitle: true),
      body: FutureBuilder<Recipe>(
        future: futureRecipe,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final recipe = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [

                    Material(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          recipe.image,
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      recipe.name,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 18),
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.deepPurple),
                        SizedBox(width: 8),
                        Text('Инструкции:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(recipe.instructions, style: TextStyle(fontSize: 16)),
                    SizedBox(height: 18),
                    Row(
                      children: [
                        Icon(Icons.list_alt, color: Colors.deepPurple),
                        SizedBox(width: 8),
                        Text('Состојки:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Card(
                      color: Colors.yellow[100],
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: recipe.ingredients
                              .map((ingredient) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text("• $ingredient", style: TextStyle(fontSize: 15)),
                          ))
                              .toList(),
                        ),
                      ),
                    ),
                    if (recipe.youtube != null && recipe.youtube!.isNotEmpty) ...[
                      SizedBox(height: 18),
                      Row(
                        children: [
                          Icon(Icons.video_library, color: Colors.red),
                          SizedBox(width: 8),
                          Text('YouTube:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        recipe.youtube!,
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],

                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Грешка: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }


}
