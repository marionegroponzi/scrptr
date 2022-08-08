import 'package:flutter/material.dart';
import 'package:scrptr/widgets/master_details_container.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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