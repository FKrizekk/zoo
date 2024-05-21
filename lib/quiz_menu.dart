// new_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zoo/main.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);
  final Color colorOrangeLight = const Color.fromARGB(255, 255, 199, 159);
  final int numberOfQuizzes = 20;
  final String animalPictureName = "animal_images/winton.jpg";

  List<Widget> _buildQuizContainers(int count) {
    return List<Widget>.generate(
      count,
      (index) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(animalPictureName), fit: BoxFit.cover)),
        height: 175,
        width: 175,
        child: Stack(children: [
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: colorOrangeLight),
              height: 75,
              width: 175,
            ),
          )
        ]),
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
              const Stack(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Positioned(
                    left: 0,
                    child: BackButtonWidget(),
                  )
                ],
              ),
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
