
class Item {
  Item({
    required this.title,
    required this.command,
  });

  final String title;
  final String command;
}

final List<Item> items = <Item>[
  Item(
    title: 'Java version',
    command: 'java -version',
  ),
  Item(
    title: 'ADB version',
    command: 'adb --version',
  ),
];