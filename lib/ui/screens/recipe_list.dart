import 'package:flutter/material.dart';
import 'package:recipes/service/model/recipe.dart';
import 'package:recipes/ui/screens/recipe_details.dart';

class RecipeList extends StatelessWidget {
  RecipeList({Key? key}) : super(key: key);

  final List<Recipe> recipes = [
    Recipe(
      id: 1,
      name: 'Spaghetti Bolognese',
      ingredients: [
        'Spaghetti',
        'Ground beef',
        'Tomato sauce',
        'Onion',
        'Garlic'
      ],
      description: 'Classic Italian dish with savory meat sauce.',
      url: 'https://example.com/spaghetti',
    ),
    // Add more recipes as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Plate Craft"),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          Recipe recipe = recipes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailsScreen(recipe: recipe),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    recipe.url,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      recipe.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
