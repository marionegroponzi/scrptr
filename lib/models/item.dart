
class Item {
  final String title;
  final String command;
  final List<Arg>? args;

  Item({
    required this.title,
    required this.command,
    required this.args,
  });

  fullCommand() {
    var fullCommand = command;
    args?.forEach((arg) {
      fullCommand = fullCommand.replaceAll("\$${arg.title}", arg.value);
    });
    return fullCommand;
  }

  @override
  String toString() {
    return "$title - $command - $args";
  }


}

class Arg {
  final String title;
  final String defaultValue;
  String value;

  Arg(this.title, this.defaultValue, this.value);

  @override
  String toString() {
    return "$title - $defaultValue - $value";
  }

}