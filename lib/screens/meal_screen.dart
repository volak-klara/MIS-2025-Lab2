import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/api_service.dart';
import '../widgets/meal_card.dart';

class MealScreen extends StatefulWidget {
  final String category;

  MealScreen({required this.category});

  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  late Future<List<Meal>> futureMeals;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    futureMeals = ApiService().getMealsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category),
      backgroundColor: Colors.deepPurple[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: 'Пребарај јадења...'),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Meal>>(
              future: searchQuery.isEmpty ? futureMeals : ApiService().searchMeals(searchQuery),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final filtered = snapshot.data!
                      .where((meal) => meal.name.toLowerCase().contains(searchQuery))
                      .toList();
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return MealCard(meal: filtered[index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Грешка: ${snapshot.error}'));
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
