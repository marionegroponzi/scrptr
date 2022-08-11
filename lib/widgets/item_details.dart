// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:scrptr/models/item.dart';
import 'package:scrptr/app_widgets/app_button.dart';
import 'package:scrptr/app_widgets/app_textarea.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({Key? key, required this.isInTabletLayout, required this.item, required this.runButtonPressed})
      : super(key: key);

  final bool isInTabletLayout;
  final Item? item;
  final Function(AppButton? button) runButtonPressed;

  // _onRun() async {
  //   debugPrint("_onRun");
  // debugPrint("Running ${item?.subtitle ?? '...nope'}");
  // final directory = (await getApplicationDocumentsDirectory()).path;
  // debugPrint(directory);
  // FilePickerResult? result = await FilePicker.platform.pickFiles();
  //
  // if (result != null) {
  //   // File file = File(result.files.single.path!);
  //   debugPrint(result.files.single.path!);
  //   final exResult = await Process.run('cat', [result.files.single.path!]);
  //   debugPrint(exResult.stdout.toString());
  //
  //
  //
  // } else {
  //   // User canceled the picker
  // }
  //   // setState(() {
  //   //   file = io.Directory("$directory/resume/").listSync();  //use your folder name instead of resume.
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          item?.command ?? 'Please select one script on the left.',
          style: textTheme.subtitle1,
        ),
        const Spacer(flex: 1),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(child: AppTextArea(borderColor: Colors.grey,)),
              Flexible(child: AppTextArea(borderColor: Colors.red,)),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppButton(buttonPressed: runButtonPressed, buttonTitle: "Run", item: item),
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
