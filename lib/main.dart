import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("my balls"),
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
        ),
        drawer: Drawer(
          backgroundColor: Colors.black87,
          child: Container(
            margin: const EdgeInsets.all(50),
            child: const Column(
              children: [
                Text(
                  "hello",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                Image(
                  image: AssetImage("assets/bazinga.jpg"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}