// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:scrptr/models/item.dart';
import 'package:scrptr/app_widgets/app_button.dart';
import 'package:scrptr/app_widgets/app_textarea.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails(
      {Key? key,
      required this.isInTabletLayout,
      required this.item,
      required this.runButtonPressed,
      required this.stdoutController,
      required this.stderrController})
      : super(key: key);

  final bool isInTabletLayout;
  final Item? item;
  final Function(BuildContext context, AppButton? button) runButtonPressed;
  final TextEditingController stdoutController;
  final TextEditingController stderrController;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          // child: Flex(
          //   children: [Text("test")],
          //   direction: Axis.vertical,
          // ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      widget.item?.command ?? 'Please select one command on the left.',
                      style: const TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: AppTextArea(borderColor: Colors.grey, controller: widget.stdoutController)),
              Flexible(
                  child: AppTextArea(
                borderColor: Colors.red,
                controller: widget.stderrController,
              )),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppButton(buttonPressed: widget.runButtonPressed, buttonTitle: "Run", disabled: widget.item == null),
        ])
      ],
    );

    if (widget.isInTabletLayout) {
      return Center(child: content);
    }

    return Scaffold(
      body: Center(child: content),
    );
  }
}
