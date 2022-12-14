// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// import 'package:path_provider/path_provider.dart';
import 'package:scrptr/models/item.dart';
import 'package:scrptr/app_widgets/app_button.dart';
import 'package:scrptr/app_widgets/app_textarea.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({
    Key? key,
    required this.isInTabletLayout,
    required this.item,
    required this.runButtonPressed,
    required this.stdoutController,
    required this.stderrController,
  }) : super(key: key);

  final bool isInTabletLayout;
  final Item? item;
  final Function(BuildContext context) runButtonPressed;
  final TextEditingController stdoutController;
  final TextEditingController stderrController;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  Arg? getArg(int index) {
    final item = widget.item;
    if (item != null && item.args != null && index < item.args!.length) {
      return item.args![index];
    }
    return null;
  }

  getLength() {
    final item = widget.item;
    if (item != null && item.args != null) {
      return item.args!.length;
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
                        widget.item?.command ?? 'Load a file and select one command.',
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
          child: ListView.builder(
            itemCount: getLength(),
            itemBuilder: (context, index) {
              final Arg arg = getArg(index)!;
              final TextEditingController textController = TextEditingController();
              textController.text = arg.value;

              return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TextFormField(
                      controller: textController,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        helperText: arg.title,
                      ),
                      onChanged: (text) {
                        arg.value = text;
                      },
                    ),
                  ));
            },
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
