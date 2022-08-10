
class Item {
  Item({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
}

final List<Item> items = <Item>[
  Item(
    title: 'Script 1',
    subtitle: 'This is the first script.',
  ),
  Item(
    title: 'Script 2',
    subtitle: 'This is the second script.',
  ),
  Item(
    title: 'Script 3',
    subtitle: 'This is the third script.',
  ),
];