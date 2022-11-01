import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:scrptr/models/data_model.dart';
import 'package:scrptr/models/item.dart';
import 'package:scrptr/widgets/item_details.dart';
import 'package:scrptr/widgets/item_listing.dart';

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

  _onRun(context) async {
    final selectedItem = _selectedItem;
    if (selectedItem != null) {
      debugPrint("Running ${selectedItem.command}");
      final cmds = selectedItem.command.split(" ");
      final exResult = await Process.run(cmds[0], cmds.sublist(1), runInShell: true);
      // debugPrint(exResult.stdout.toString());
      // debugPrint(exResult.stderr.toString());
      setState(() {
        _stdoutController.text = exResult.stdout.toString();
        _stderrController.text = exResult.stderr.toString();
      });
    } else {
      debugPrint("Nothing to run");
    }
  }

  _onLoad(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final fileName = result.files.single.path!;
      await DataModel.of(context)?.loadFile(fileName);
      setState(() {
        _stdoutController.text = "";
        _stderrController.text = "";
        _selectedItem = null;
      });
    } else {
      debugPrint("No new file selected");
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
              onSelectionChanged: _onSelectionChanged,
              onLoadButtonPressed: _onLoad,
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