import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/recipe_screen.dart';

class MealCard extends StatelessWidget {
  final Meal meal;

  MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
   return Card(
     color: Colors.white70,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(16),
       side: BorderSide( color: Colors.deepPurple[100] ?? Colors.deepPurple, width: 2),
     ),
      elevation: 8,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeScreen(mealId: meal.id),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(meal.image, height: 100, width: 100),
            SizedBox(height: 10),
            Text(
              meal.name,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

  }
}
