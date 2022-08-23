import 'package:flutter/material.dart';
import 'package:scrptr/models/item.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.buttonPressed,
    required this.buttonTitle,
    required this.canBeDisabled,
    this.item,
  }) : super(key: key);

  final Function(BuildContext context, AppButton? button) buttonPressed;
  final Item? item;
  final String buttonTitle;
  final bool canBeDisabled;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Theme.of(context).colorScheme.onPrimary,
            primary: Theme.of(context).colorScheme.primary,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(10.0)),
          onPressed: (item == null && canBeDisabled) ? null : () { buttonPressed(context, this); },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              buttonTitle,
              textScaleFactor: 1.4,
              // style: textTheme.headline5,
            ),
          ),
        ),
      ),
    );
  }
}
