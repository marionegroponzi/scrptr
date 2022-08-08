import 'package:flutter/material.dart';
import 'package:scrptr/widgets/master_details_container.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScrPtr',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MasterDetailContainer(),
    );
  }
}