import 'package:flutter/material.dart';
import 'card.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter login demo',
      theme: new ThemeData(
        primaryColor: Colors.red,
      ),
      home: new CardPage() 
    );
  }

}