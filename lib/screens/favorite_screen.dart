import 'package:flutter/material.dart';
import '../services/favorite_service.dart';
import '../widgets/meal_card.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    final favorites = favoritesService.favorites;
    return Scaffold(
      appBar: AppBar(
        title: Text('Омилени рецепти'),
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? Center(child: Text('Нема омилени рецепти уште.'))
          : GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return MealCard(meal: favorites[index]);
        },
      ),
    );
  }
}
