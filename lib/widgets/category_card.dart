import 'package:flutter/material.dart';
import '../models/category.dart';
import '../screens/meal_screen.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category});

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
              builder: (context) => MealScreen(category: category.name),
            ),
          );
        },
        child: Column(
          children: [
            Image.network(category.image, height: 100, width: 100),
            Text(category.name),
            Text(category.description, maxLines: 2, overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
