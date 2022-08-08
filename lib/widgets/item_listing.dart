import 'package:flutter/material.dart';
import 'package:scrptr/models/item.dart';

class ItemListing extends StatelessWidget {
  const ItemListing({Key? key,
    required this.itemSelectedCallback,
    this.selectedItem,
  }) : super(key: key);

  final ValueChanged<Item> itemSelectedCallback;
  final Item? selectedItem;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: items.map((item) {
        return ListTile(
          title: Text(item.title),
          onTap: () => itemSelectedCallback(item),
          selected: selectedItem == item,
        );
      }).toList(),
    );
  }
}