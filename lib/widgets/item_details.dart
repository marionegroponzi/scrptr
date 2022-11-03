// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// import 'package:path_provider/path_provider.dart';
import 'package:scrptr/models/item.dart';
import 'package:scrptr/app_widgets/app_button.dart';
import 'package:scrptr/app_widgets/app_textarea.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key,
    required this.isInTabletLayout,
    required this.item,
    required this.runButtonPressed,
    required this.stdoutController,
    required this.stderrController,})
      : super(key: key);

  final bool isInTabletLayout;
  final Item? item;
  final Function(BuildContext context) runButtonPressed;
  final TextEditingController stdoutController;
  final TextEditingController stderrController;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  String getParameter(int index) {
    final item = widget.item;
    if (item != null && item.parameters != null && index < item.parameters!.length) {
      return item.parameters![index];
    }
    return "";
  }

  getLength() {
    final item = widget.item;
    if (item != null && item.parameters != null) {
      return item.parameters!.length;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
      final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.item?.command ??
                            'Please select one command on the left.',
                        style: const TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              itemCount: getLength(),
              prototypeItem: const ListTile(
                title: Text(""),
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("${getParameter(index)}: "),
                  title: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      print('First text field: $text');
                    },
                  )
                );
              },
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    const Flexible(
                      flex: 1,
                      child: Text("Standard Output"),
                    ),
                    Flexible(
                      flex: 10,
                      child: AppTextArea(
                                borderColor: Colors.grey,
                                controller: widget.stdoutController,
                            ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    const Flexible(
                      flex: 1,
                      child: Text("Standard Error"),
                    ),
                    Flexible(
                      flex: 10,
                      child: AppTextArea(
                        borderColor: Colors.red,
                        controller: widget.stderrController,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppButton(
              buttonPressed: widget.runButtonPressed,
              buttonTitle: "Run",
              disabled: widget.item == null),
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
