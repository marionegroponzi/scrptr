import 'dart:io';

import 'package:flutter/material.dart';
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

  _onSelectionChanged(item) {
    setState(() {
      _selectedItem = item;
    });
  }

  _onRun(button) async {
    if (button?.item != null) {
      final item = button!.item!;
      debugPrint("Running ${item.command}");
      final cmds = item.command.split(" ");
      final exResult = await Process.run(cmds[0], cmds.sublist(1), runInShell: true);
      debugPrint(exResult.stdout.toString());
      debugPrint(exResult.stderr.toString());
    } else {
      debugPrint("Nothing to run");
    }
  }

  _onLoad(button) async {
    debugPrint("_onLoad");
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
            runButtonPressed: _onRun
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