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
  final TextEditingController _stdoutController = TextEditingController();
  final TextEditingController _stderrController = TextEditingController();

  _onSelectionChanged(item) {
    setState(() {
      _stdoutController.text = "";
      _stderrController.text = "";
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
      setState(() {
        _stdoutController.text = exResult.stdout.toString();
        _stderrController.text = exResult.stderr.toString();
      });
    } else {
      debugPrint("Nothing to run");
    }
  }

  _onLoad(button) async {
    _stdoutController.text = "";
    _stderrController.text = "";
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