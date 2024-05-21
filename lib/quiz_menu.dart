// new_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zoo/main.dart';

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
      body: Stack(
        children: [
          Image.asset("assets/bg_pawn_orange.png"),
          ListView( 
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            children: [
              Stack(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  const Positioned(
                    left: 0,
                    child: BackButtonWidget(),
                  ),
                  const Positioned(
                    left: 0,
                    right: 0,
                    top: -10,
                    height: 75,
                    child: Center(
                        child: Text('Quiz Menu',
                        textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "News Gothic"
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -30,
                    top: -50,
                    child: Image.asset(
                    'assets/logo.png',
                    width: 150,
                    height: 150,


                  )
                  ),
                ],
              ),
              Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    for (var i = 0; i < numberOfQuizzes; i++)
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        height: 150,
                        width: 150,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
