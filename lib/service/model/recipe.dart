class Recipe {
  final int id;
  final String name;
  final List<String> ingredients;
  final String description;
  final String url;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.description,
    required this.url,
  });
}
