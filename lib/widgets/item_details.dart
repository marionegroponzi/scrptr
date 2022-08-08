import 'package:flutter/material.dart';
import 'package:scrptr/models/item.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({
    Key? key,
    required this.isInTabletLayout,
    required this.item,
  }) : super(key: key);

  final bool isInTabletLayout;
  final Item? item;

  _onPressed() {
    debugPrint("log");
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   item?.title ?? '',
        //   style: textTheme.headline3,
        // ),
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
                // style: TextButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: _onPressed,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
