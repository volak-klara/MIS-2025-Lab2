import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/recipe_screen.dart';
import '../services/favorite_service.dart';

class MealCard extends StatefulWidget {
  final Meal meal;

  MealCard({required this.meal});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  final favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    final isFav = favoritesService.isFavorite(widget.meal);

    return Card(
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.deepPurple[100] ?? Colors.deepPurple,
          width: 2,
        ),
      ),
      elevation: 8,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeScreen(mealId: widget.meal.id),
            ),
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Image.network(
                      widget.meal.image,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          favoritesService.toggleFavorite(widget.meal);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                widget.meal.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
