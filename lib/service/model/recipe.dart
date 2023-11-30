class Recipe {
  final int id;
  final String name;
  final List<String> ingredients;
  final String description;
  final String url;

  static fromJSON(id, Map<String, dynamic> json) {
    return Recipe(
      id: id,
      name: json['Name'],
      ingredients: json['Ingredients'].cast<String>(),
      description: json['Description'],
      url: json['url'],
    );
  }

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.description,
    required this.url,
  });
}
