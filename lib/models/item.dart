
class Item {
  final String title;
  final String command;
  final List<String>? parameters;

  Item({
    required this.title,
    required this.command,
    required this.parameters,
  });

  @override
  String toString() {
    return "$title - $command - $parameters";
  }


}