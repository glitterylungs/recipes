import 'package:recipes/service/model/recipe.dart';
import 'package:recipes/service/RecipeService.dart';

class RecipeViewModel {
  final RecipeService _recipeService = RecipeService();

  List<Recipe> _recipes = [];

  Future<List<Recipe>> getAllRecipes() async {
    _recipes = await _recipeService.fetchAllRecipes();
    return _recipes;
  }

  Future<List<Recipe>> getRecipesByQuery(String query) async {
    return _recipeService.searchRecipes(query);
  }
}
