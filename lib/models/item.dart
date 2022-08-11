
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
  Item(
    title: 'Script 3',
    command: 'This is the third script.',
  ),
];