import 'package:flutter/services.dart';
import 'package:recipes/service/model/recipe.dart';
import 'dart:convert';
import 'dart:io';

// Dummy RecipeService class, replace this with your actual service.
class RecipeService {
  List<Recipe> _recipes = [];

  RecipeService() {
    _init();
  }

  Future<void> _init() async {
    String data = await rootBundle.loadString('recipes.json');
    final jsonResult = json.decode(data);
    List<Recipe> recipes = [];
    var id = 0;
    for (var recipe in jsonResult) {
      _recipes.add(Recipe.fromJSON(id, recipe));
      id++;
      if (id >= 200) {
        break;
      }
    }
  }

  Future<List<Recipe>> fetchAllRecipes({int number = 200}) async {
    var recipes = _recipes.sublist(0, number);
    return recipes;
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    var recipes = _recipes.where((recipe) {
      return recipe.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return recipes;
  }
}
