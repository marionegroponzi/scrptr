import 'package:flutter/material.dart';
import 'package:scrptr/models/item.dart';

class ItemListing extends StatelessWidget {
  const ItemListing({
    Key? key,
    required this.itemSelectedCallback,
    this.selectedItem,
  }) : super(key: key);

  final ValueChanged<Item> itemSelectedCallback;
  final Item? selectedItem;

  _onLoad() async {
    debugPrint("_onLoad");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: items.map((item) {
              return ListTile(
                title: Text(item.title),
                onTap: () => itemSelectedCallback(item),
                selected: selectedItem == item,
              );
            }).toList(),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // Foreground color
                  onPrimary: Theme.of(context).colorScheme.onPrimary,
                  // Background color
                  primary: Theme.of(context).colorScheme.primary,
                ).copyWith(elevation: ButtonStyleButton.allOrNull(10.0)),
                onPressed: _onLoad,
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Load",
                    textScaleFactor: 1.4,
                    // style: textTheme.headline5,
                  ),
                ),
              ),
            ),
          ),
        ])
      ],
    );
  }
}
