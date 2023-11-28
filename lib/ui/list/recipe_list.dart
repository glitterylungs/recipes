import 'package:flutter/material.dart';
import 'package:recipes/service/model/recipe.dart';
import 'package:recipes/ui/details/recipe_details.dart';
import 'package:recipes/ui/list/recipe_list_view_model.dart';

class RecipeList extends StatefulWidget {
  RecipeList({Key? key}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  late RecipeViewModel _recipeViewModel; // Your view model instance
  late Future<List<Recipe>> _recipeListFuture;
  List<Recipe> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _recipeViewModel = RecipeViewModel(); // Initialize your view model
    _recipeListFuture = _recipeViewModel.getAllRecipes();
    _recipeListFuture.then((recipes) {
      setState(() {
        _filteredRecipes = recipes;
      });
    });
  }

  void filterRecipes(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredRecipes = _recipeViewModel.getCachedRecipes();
      });
    } else {
      _recipeViewModel.getRecipesByQuery(query).then((recipes) {
        setState(() {
          _filteredRecipes = recipes;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Plate Craft"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final String? query = await showSearch<String>(
                context: context,
                delegate: RecipeSearchDelegate(_recipeViewModel),
              );
              if (query != null && query.isNotEmpty) {
                filterRecipes(query);
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _recipeListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: _filteredRecipes.length,
              itemBuilder: (context, index) {
                Recipe recipe = _filteredRecipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipeDetailsScreen(recipe: recipe),
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
            );
          }
        },
      ),
    );
  }
}

class RecipeSearchDelegate extends SearchDelegate<String> {
  final RecipeViewModel _recipeViewModel;

  RecipeSearchDelegate(this._recipeViewModel);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchResults();
  }

  Widget buildSearchResults() {
    return FutureBuilder<List<Recipe>>(
      future: _recipeViewModel.getRecipesByQuery(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final List<Recipe> searchResults = snapshot.data ?? [];

          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              Recipe recipe = searchResults[index];
              return ListTile(
                title: Text(recipe.name),
                onTap: () {
                  close(context, recipe.name);
                },
              );
            },
          );
        }
      },
    );
  }
}
