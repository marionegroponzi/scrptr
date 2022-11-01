import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.buttonPressed,
    required this.buttonTitle,
    required this.disabled,
  }) : super(key: key);

  final Function(BuildContext context) buttonPressed;
  final String buttonTitle;
  final bool disabled;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(10.0)),
          onPressed: disabled ? null : () { buttonPressed(context); },
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
