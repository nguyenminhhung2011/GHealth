class Meal {
  final String id;
  final String name;
  final String asset;
  final int time; // 1: breakfast 2: lunch 3: dinner
  final String description;

  final List<String> steps;
  Meal({
    required this.id,
    required this.name,
    required this.asset,
    required this.time,
    required this.description,
    required this.steps,
  });
}
