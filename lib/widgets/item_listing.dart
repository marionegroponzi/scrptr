import 'package:flutter/material.dart';
import 'package:scrptr/models/data_model.dart';
import 'package:scrptr/models/item.dart';
import 'package:scrptr/app_widgets/app_button.dart';


class ItemListing extends StatelessWidget {
  const ItemListing({
    Key? key,
    required this.onSelectionChanged,
    required this.onLoadButtonPressed,
    this.selectedItem,
  }) : super(key: key);

  final ValueChanged<Item> onSelectionChanged;
  final Function(BuildContext context, AppButton? button) onLoadButtonPressed;
  final Item? selectedItem;

  @override
  Widget build(BuildContext context) {
    var items = DataModel.of(context)!.items;
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: items.map((item) {
              return ListTile(
                title: Text(item.title),
                onTap: () => onSelectionChanged(item),
                selected: selectedItem == item,
              );
            }).toList(),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppButton(buttonPressed: onLoadButtonPressed, buttonTitle: "Load", disabled: false,),
        ])
      ],
    );
  }
}
