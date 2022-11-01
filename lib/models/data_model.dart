import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scrptr/models/item.dart';
import 'package:yaml/yaml.dart';

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

  Future<void> loadFile(String fileName) async {
    File file = File(fileName);
    final data = await file.readAsString();
    final mapData = loadYaml(data) as Map;
    final l = mapData["commands"] as List;
    final itemList = l.map((e) => Item(title: e["title"], command: e["command"])).toList();
    items.clear();
    items.addAll(itemList);
  }
  
}