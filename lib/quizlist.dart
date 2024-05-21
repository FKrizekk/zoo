import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [],
        ),
      ),
    );
  }
}
