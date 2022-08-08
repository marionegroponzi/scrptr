import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scrptr/models/item.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({
    Key? key,
    required this.isInTabletLayout,
    required this.item,
  }) : super(key: key);

  final bool isInTabletLayout;
  final Item? item;

  _onPressed() async {
    debugPrint("Running ${item?.subtitle ?? '...nope'}");
    final directory = (await getApplicationDocumentsDirectory()).path;
    debugPrint(directory);
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // File file = File(result.files.single.path!);
      debugPrint(result.files.single.path!);
      final exResult = await Process.run('cat', [result.files.single.path!]);
      debugPrint(exResult.stdout.toString());



    } else {
      // User canceled the picker
    }
      // setState(() {
      //   file = io.Directory("$directory/resume/").listSync();  //use your folder name instead of resume.
      // });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(),
        ),
        Text(
          item?.subtitle ?? 'Please select one on the left.',
          style: textTheme.subtitle1,
        ),
        Expanded(
          child: Container(),
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
                onPressed: _onPressed,
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Run",
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

    if (isInTabletLayout) {
      return Center(child: content);
    }

    return Scaffold(
      body: Center(child: content),
    );
  }
}
