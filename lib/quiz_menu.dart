// new_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);
  final int numberOfQuizzes = 20;

  List<Widget> _buildQuizContainers(int count) {
    return List<Widget>.generate(
      count,
      (index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        height: 150,
        width: 150,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorOrange,
      appBar: AppBar(
        title: const Text(
          'Quiz Menu',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30, // Adjust the font size as needed
            fontWeight: FontWeight.bold,
            fontFamily: 'News Gothic', // Use the same font family as MyApp
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset("assets/bg_pawn_orange.png"),
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: _buildQuizContainers(numberOfQuizzes),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
