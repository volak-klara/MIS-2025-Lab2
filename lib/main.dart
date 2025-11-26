import 'package:flutter/material.dart';
import 'screens/category_screen.dart';
import 'services/api_service.dart';
import 'models/recipe.dart';
import 'screens/recipe_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Рецепти',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryScreen(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          icon: Icon(Icons.fastfood_sharp),
          label: Text('Прикажи рандом рецепт'),
          onPressed: () async {
            final recipe = await ApiService().getRandomRecipe();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeScreen(mealId: recipe.id),
              ),
            );
          },
        ),
      ),
    );
  }
}

