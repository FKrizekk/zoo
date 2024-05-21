// new_page.dart
import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);

    return Scaffold(
      backgroundColor: colorOrange,
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
      body:  Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
            children: [
              Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    for (var i = 0; i < 15; i++) Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                      ),
                      height: 150,
                      width: 150,
                    ),
                    
        
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}