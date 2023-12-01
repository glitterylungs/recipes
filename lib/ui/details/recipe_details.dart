import 'package:flutter/material.dart';
import 'package:recipes/service/model/recipe.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(recipe.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(16),
                //   child: Image.network(
                //     recipe.url,
                //     height: 200,
                //     width: double.infinity,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                SizedBox(height: 16),
                Text(
                  'Description:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(recipe.description),
                SizedBox(height: 16),
                Text(
                  'Ingredients:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: recipe.ingredients
                      .map((ingredient) => Text('- $ingredient'))
                      .toList(),
                ),
                SizedBox(height: 16),
                Text(
                  'Method:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      recipe.method.map((method) => Text('- $method')).toList(),
                ),
              ],
            ),
          ),
        ));
  }
}
