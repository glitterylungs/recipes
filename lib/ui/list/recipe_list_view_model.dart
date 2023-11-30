import 'package:recipes/service/model/recipe.dart';
import 'package:recipes/service/wojtek.dart';

class RecipeViewModel {
  // Assuming you have a service to fetch recipes, replace RecipeService with your actual service.
  // For the sake of example, I'm using a dummy service.
  final RecipeService _recipeService = RecipeService();

  List<Recipe> _cachedRecipes = [];

  Future<List<Recipe>> getAllRecipes() async {
    // Implement logic to fetch all recipes from your service.
    // For now, we'll return an empty list as a placeholder.
    _cachedRecipes = await _recipeService.fetchAllRecipes(number: 200);
    return _cachedRecipes;
  }

  Future<List<Recipe>> getRecipesByQuery(String query) async {
    // Implement logic to fetch recipes based on the query from your service.
    // For now, we'll return an empty list as a placeholder.
    return _recipeService.searchRecipes(query);
  }

  List<Recipe> getCachedRecipes() {
    // Return the cached recipes. This can be useful to show recipes immediately
    // while the async operation to fetch all recipes is still in progress.
    return _cachedRecipes;
  }
}
