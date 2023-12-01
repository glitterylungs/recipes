import 'package:flutter/material.dart';
import 'package:recipes/service/model/recipe.dart';
import 'package:recipes/ui/details/recipe_details.dart';
import 'package:recipes/ui/list/recipe_list_view_model.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  late RecipeViewModel _recipeViewModel;
  late Future<List<Recipe>> _recipeListFuture;
  List<Recipe> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _recipeViewModel = RecipeViewModel();
    _recipeListFuture = _recipeViewModel.getAllRecipes();
  }

  void filterRecipes(String query) async {
    if (query.isEmpty) {
      List<Recipe> allRecipes = await _recipeViewModel.getAllRecipes();
      setState(() {
        _filteredRecipes = allRecipes;
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
            icon: const Icon(Icons.search),
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No recipes found.'),
            );
          } else {
            _filteredRecipes = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.only(top: 10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Set the number of columns here
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
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
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        // Positioned.fill(
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(16),
                        //     child: Image.network(
                        //       recipe.url,
                        //       width: double.infinity,
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                topRight: Radius.circular(50),
                              ),
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.9),
                            ),
                            child: Text(
                              recipe.name,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
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
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No recipes found.'),
          );
        } else {
          final List<Recipe> searchResults = snapshot.data!;

          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              Recipe recipe = searchResults[index];
              return ListTile(
                title: Text(recipe.name),
                onTap: () {
                  close(context, recipe.name);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailsScreen(recipe: recipe),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
