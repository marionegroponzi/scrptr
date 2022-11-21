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

  List<Parameter> parseParameters(params) {
    var res = List<Parameter>.empty(growable: true);
    for (var p in params) {
      var parameter = Parameter(p["title"], p["default"], p["default"]);
      res.add(parameter);
    }
    return res;
  }

  loadFile(String fileName) async {
    File file = File(fileName);
    final data = await file.readAsString();
    final mapData = loadYaml(data) as Map;
    final l = mapData["commands"] as List;

    final itemList = l.map((e) {
      final params = e["parameters"];
      if (params != null) {
        return Item(title: e["title"],
            command: e["command"],
            args: parseParameters(params),
        );
      } else {
        return Item(title: e["title"],
            command: e["command"],
            args: null);
      }
    }).toList();

    items.clear();
    items.addAll(itemList);
  }

  runItem(Item selectedItem) async {
    debugPrint("Running ${selectedItem.command}");
    final cmds = selectedItem.command.split(" ");
    return await Process.run(cmds[0], cmds.sublist(1), runInShell: true);
  }
  
}