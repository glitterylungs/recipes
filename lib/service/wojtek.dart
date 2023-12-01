import 'package:flutter/services.dart';
import 'package:recipes/service/model/recipe.dart';
import 'dart:convert';
import 'dart:io';

class RecipeService {
  List<Recipe> _recipes = [];

  RecipeService() {
    _init();
  }

  Future<void> _init() async {
    String data = await rootBundle.loadString('assets/recipes.json');
    final jsonResult = json.decode(data);
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
    await _init();

    var recipes = _recipes.take(number).toList();
    print(recipes.first.url);
    return recipes;
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    await _init();

    var recipes = _recipes.where((recipe) {
      return recipe.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return recipes;
  }
}
