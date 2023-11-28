import 'package:recipes/service/model/recipe.dart';

// Dummy RecipeService class, replace this with your actual service.
class RecipeService {
  Future<List<Recipe>> fetchAllRecipes() async {
    // Simulate fetching all recipes from a backend service.
    // In a real application, you would make an HTTP request or use another method.
    await Future.delayed(Duration(seconds: 2));
    return [
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
        url:
            'https://supervalu.ie/thumbnail/800x600/var/files/real-food/recipes/Uploaded-2020/spaghetti-bolognese-recipe.jpg',
      ),
      Recipe(
        id: 2,
        name: 'Apple',
        ingredients: [
          'Spaghetti',
          'Ground beef',
          'Tomato sauce',
          'Onion',
          'Garlic'
        ],
        description: 'Classic Italian dish with savory meat sauce.',
        url:
            'https://supervalu.ie/thumbnail/800x600/var/files/real-food/recipes/Uploaded-2020/spaghetti-bolognese-recipe.jpg',
      ),
      Recipe(
        id: 3,
        name: 'Something',
        ingredients: [
          'Spaghetti',
          'Ground beef',
          'Tomato sauce',
          'Onion',
          'Garlic'
        ],
        description: 'Classic Italian dish with savory meat sauce.',
        url:
            'https://supervalu.ie/thumbnail/800x600/var/files/real-food/recipes/Uploaded-2020/spaghetti-bolognese-recipe.jpg',
      ),
      Recipe(
        id: 4,
        name: 'Brownie',
        ingredients: [
          'Spaghetti',
          'Ground beef',
          'Tomato sauce',
          'Onion',
          'Garlic'
        ],
        description: 'Classic Italian dish with savory meat sauce.',
        url:
            'https://supervalu.ie/thumbnail/800x600/var/files/real-food/recipes/Uploaded-2020/spaghetti-bolognese-recipe.jpg',
      ),
      Recipe(
        id: 5,
        name: 'Spaghetti Lala',
        ingredients: [
          'Spaghetti',
          'Ground beef',
          'Tomato sauce',
          'Onion',
          'Garlic'
        ],
        description: 'Classic Italian dish with savory meat sauce.',
        url:
            'https://supervalu.ie/thumbnail/800x600/var/files/real-food/recipes/Uploaded-2020/spaghetti-bolognese-recipe.jpg',
      ),
      Recipe(
        id: 6,
        name: 'Spaghetti Bolognese',
        ingredients: [
          'Spaghetti',
          'Ground beef',
          'Tomato sauce',
          'Onion',
          'Garlic'
        ],
        description: 'Classic Italian dish with savory meat sauce.',
        url:
            'https://supervalu.ie/thumbnail/800x600/var/files/real-food/recipes/Uploaded-2020/spaghetti-bolognese-recipe.jpg',
      ),
    ];
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    // Simulate searching for recipes based on a query.
    // In a real application, you would make an HTTP request or use another method.
    await Future.delayed(Duration(seconds: 1));
    return [
      // Return matching recipes based on the query.
    ];
  }
}
