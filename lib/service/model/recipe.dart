class Recipe {
  final int id;
  final String name;
  final List<String> ingredients;
  final String description;
  final String url;
  final List<String> method;

  Recipe(
      {required this.id,
      required this.name,
      required this.ingredients,
      required this.description,
      required this.url,
      required this.method});

  static Recipe fromJSON(int id, Map<String, dynamic> json) {
    return Recipe(
      id: id,
      name: json['Name'] ?? '',
      ingredients:
          (json['Ingredients'] as List<dynamic>?)?.cast<String>() ?? [],
      description: json['Description'] ?? '',
      url: json['url'] ?? '',
      method: (json['Method'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }
}
