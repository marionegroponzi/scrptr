
class Item {
  Item({
    required this.title,
    required this.command,
  });

  @override
  String toString() {
    return "$title - $command";
  }

  final String title;
  final String command;
}