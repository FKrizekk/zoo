// new_page.dart
import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Page',
          style: TextStyle(
            fontSize: 30, // Adjust the font size as needed
            fontWeight: FontWeight.bold,
            fontFamily: 'News Gothic', // Use the same font family as MyApp
          ),
        ),
        backgroundColor: colorOrange,
      ),
      body: Container(
        color: colorOrange,
        padding: EdgeInsets.all(20), // Add some padding for better readability
        child: Center(
          child: Text(
            'You have navigated to the new page!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24, // Adjust the font size as needed
              color: Colors.white,
              fontFamily: 'News Gothic', // Use the same font family as MyApp
            ),
          ),
        ),
      ),
    );
  }
}