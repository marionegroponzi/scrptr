import 'package:flutter/material.dart';
import 'package:scrptr/models/item.dart';

class DataModel extends InheritedWidget {
  final List<Item> items;

  const DataModel({required this.items, required Key key, required child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(DataModel oldWidget) {
    return items != oldWidget.items;
  }

  static DataModel? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<DataModel>());
  }
  
}