import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:scrptr/models/data_model.dart';
import 'package:scrptr/models/item.dart';
import 'package:scrptr/widgets/item_details.dart';
import 'package:scrptr/widgets/item_listing.dart';
import 'package:yaml/yaml.dart';

class MasterDetailContainer extends StatefulWidget {
  const MasterDetailContainer({Key? key}) : super(key: key);

  @override
  State createState() => _ItemMasterDetailContainerState();
}


class _ItemMasterDetailContainerState extends State<MasterDetailContainer> {
  static const int kTabletBreakpoint = 600;

  Item? _selectedItem;
  final TextEditingController _stdoutController = TextEditingController();
  final TextEditingController _stderrController = TextEditingController();

  _onSelectionChanged(item) {
    setState(() {
      _stdoutController.text = "";
      _stderrController.text = "";
      _selectedItem = item;
    });
  }

  _onRun(context, button) async {
    if (button?.item != null) {
      final item = button!.item!;
      debugPrint("Running ${item.command}");
      final cmds = item.command.split(" ");
      final exResult = await Process.run(cmds[0], cmds.sublist(1), runInShell: true);
      debugPrint(exResult.stdout.toString());
      debugPrint(exResult.stderr.toString());
      setState(() {
        _stdoutController.text = exResult.stdout.toString();
        _stderrController.text = exResult.stderr.toString();
      });
    } else {
      debugPrint("Nothing to run");
    }
  }

  _onLoad(context, button) async {
    _stdoutController.text = "";
    _stderrController.text = "";
    debugPrint("_onLoad");
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final str = result.files.single.path!;
      debugPrint(str);
      File file = File(str);
      final data = await file.readAsString();
      final mapData = loadYaml(data) as Map;
      // debugPrint(mapData.toString());
      final l = mapData["commands"] as List;
      final itemList = l.map((e) => Item(title: e["title"], command: e["command"])).toList();
      debugPrint(itemList.toString());
      DataModel.of(context)?.items.clear();
      DataModel.of(context)?.items.addAll(itemList);
      setState(() {
        _stdoutController.text = "";
        _stderrController.text = "";
        _selectedItem = null;
      });
    } else {
      // User canceled the picker, nothing to do
    }
  }

  Widget _buildWideLayout() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Material(
            elevation: 4.0,
            child: ItemListing(
              itemSelectedCallback: _onSelectionChanged,
              loadButtonPressed: _onLoad,
              selectedItem: _selectedItem,
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: ItemDetails(
            isInTabletLayout: true,
            item: _selectedItem,
            runButtonPressed: _onRun,
            stdoutController: _stdoutController,
            stderrController: _stderrController,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyLayout() {
    return const Center(
      child: Text("Too small..."),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var windowWidth = MediaQuery.of(context).size.width;
    var windowHeight = MediaQuery.of(context).size.height;

    if (windowWidth < kTabletBreakpoint || windowHeight < kTabletBreakpoint/2) {
      content = _buildEmptyLayout();
    } else {
      content = _buildWideLayout();
    }
    return Scaffold(
      body: content,
    );
  }


}