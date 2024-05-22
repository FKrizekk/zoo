// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zoo/main.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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
  return d;
}

Future<int> getNumberOfAnimals() async {
  final String response = await rootBundle.loadString('data/quiz.json');
  final data = await json.decode(response);
  
  return data.length;
}

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);
  final Color colorOrangeLight = const Color.fromARGB(255, 255, 199, 159);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorOrange,
      body: FutureBuilder<int>(
        future: getNumberOfAnimals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final numberOfQuizzes = snapshot.data!;
            return Stack(
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
                                fontFamily: "News Gothic",
                              ),
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
            );
          }
        },
      ),
    );
  }

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
              child: const Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200],
              ),
              height: 175,
              width: 175,
              child: const Center(child: Icon(Icons.error)),
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
                    fit: BoxFit.cover,
                  ),
                ),
                height: 175,
                width: 175,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/bg_pawn_orange_light.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: colorOrangeLight,
                        ),
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
                            FutureBuilder<double?>(
                              future: getPercentageForAnimal(data["Name"]),
                              builder: (context, percentageSnapshot) {
                                if (percentageSnapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (percentageSnapshot.hasError) {
                                  return const Icon(Icons.error);
                                } else {
                                  final percentage = percentageSnapshot.data ?? 0.0;
                                  return Text(
                                    "${percentage.toStringAsFixed(1)}%",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "News Gothic",
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<double?> getPercentageForAnimal(String animalName) async {
    final percentages = await readPercentages();
    return percentages[animalName];
  }
}

Future<Map<String, dynamic>> readPercentages() async {
  try {
    final file = await _localFile;
    if (await file.exists()) {
      final contents = await file.readAsString();
      return jsonDecode(contents);
    } else {
      return {};
    }
  } catch (e) {
    print("Error reading file: $e");
    return {};
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/animal_percentages.json');
}
