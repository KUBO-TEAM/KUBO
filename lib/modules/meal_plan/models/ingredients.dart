class Ingredients {
  //TODO: Ingredients model should have date...
  Ingredients({
    required this.id,
    // required this.date,
    required this.ingredients,
    this.isExpanded = false,
  });

  String id;
  List<String> ingredients;
  // DateTime date;
  bool isExpanded;
}
