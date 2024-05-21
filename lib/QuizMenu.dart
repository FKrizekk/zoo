// new_page.dart
import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Menu',
          style: TextStyle(
            fontSize: 30, // Adjust the font size as needed
            fontWeight: FontWeight.bold,
            fontFamily: 'News Gothic', // Use the same font family as MyApp
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body:  ListView(
          children: [
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                Container(
                  color: const Color.fromARGB(255, 255, 0, 0),
                  height: 40,
                  width: 40,
                ),
              ],
            ),
          ],
        ),
    );
  }
}