import 'package:flutter/material.dart';
import 'package:scrptr/models/item.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.buttonPressed,
    required this.buttonTitle,
    this.item,
  }) : super(key: key);

  final Function(AppButton? button) buttonPressed;
  final Item? item;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // Foreground color
            onPrimary: Theme.of(context).colorScheme.onPrimary,
            // Background color
            primary: Theme.of(context).colorScheme.primary,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(10.0)),
          onPressed: () => buttonPressed(this),
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
