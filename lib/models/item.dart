
class Item {
  final String title;
  final String command;
  final List<Parameter>? args;

  Item({
    required this.title,
    required this.command,
    required this.args,
  });

  @override
  String toString() {
    return "$title - $command - $args";
  }


}

class Parameter {
  final String title;
  final String defaultValue;
  String value;

  Parameter(this.title, this.defaultValue, this.value);

  @override
  String toString() {
    return "$title - $defaultValue - $value";
  }

}