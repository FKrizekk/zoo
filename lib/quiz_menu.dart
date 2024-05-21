// new_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoo/main.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';


enum Stats {
  weight,
  habitat,
  size,
  diet,
  occurrence
}

Future<Map> readJson(int id) async {
  final String response = await rootBundle.loadString('data/quiz.json');
  final data = await json.decode(response);
  
  final d = data[id];
  
  // return [
  //   d["Name"],
  //   d["Image"],
  //   d["WeightR"],
  //   d["Weight1F"],
  //   d["Weight2F"],
  //   d["HabitatR"],
  //   d["Habitat1F"],
  //   d["Habitat2F"],
  //   d["SizeR"],
  //   d["Size1F"],
  //   d["Size2F"],
  //   d["DietR"],
  //   d["Diet1F"],
  //   d["Diet2F"],
  //   d["OccurrenceR"],
  //   d["Occurrence1F"],
  //   d["Occurrence2F"],
  // ];
  return d;
}

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);
  final Color colorOrangeLight = const Color.fromARGB(255, 255, 199, 159);
  final int numberOfQuizzes = 5;

  List<Widget> _buildQuizContainers(int count, BuildContext context) {
    return List<Widget>.generate(
      count,
      (index) => FutureBuilder(
        future: readJson(index),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200],
              ),
              height: 175,
              width: 175,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200],
              ),
              height: 175,
              width: 175,
              child: Center(child: Icon(Icons.error)),
            );
          } else {
            final data = snapshot.data as Map;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(data: data),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage("animal_images/${data["Image"]}"),
                        fit: BoxFit.cover)),
                height: 175,
                width: 175,
                child: Stack(children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/bg_pawn_orange_light.png"),
                          fit: BoxFit.cover
                          ),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: colorOrangeLight),
                      height: 75,
                      width: 175,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            data["Name"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            "userPercent%", // Replace with actual user percentage if available
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: "News Gothic"),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            );
          }
        },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BackButtonWidget(),
                      const Text(
                        '  Quiz List',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: "News Gothic"),
                      ),
                      Image.asset(
                        'assets/logo.png',
                        width: 100,
                        height: 100,
                      ),
                    ],
                  )
                ],
              ),
              Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: _buildQuizContainers(numberOfQuizzes, context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
