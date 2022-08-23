import 'package:flutter/material.dart';
import 'package:scrptr/models/item.dart';
import 'package:scrptr/app_widgets/app_button.dart';

class ItemListing extends StatelessWidget {
  const ItemListing({
    Key? key,
    required this.itemSelectedCallback,
    required this.loadButtonPressed,
    this.selectedItem,
  }) : super(key: key);

  final ValueChanged<Item> itemSelectedCallback;
  final Function(AppButton? button) loadButtonPressed;
  final Item? selectedItem;

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
          AppButton(buttonPressed: loadButtonPressed, buttonTitle: "Load", canBeDisabled: false,),
        ])
      ],
    );
  }
}
