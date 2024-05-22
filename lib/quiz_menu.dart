// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
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

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 118, 34),
      body: Stack(
        children: [
          Positioned(
            width: 500,
            child: Image.asset("assets/bg_pawn_orange.png", fit: BoxFit.cover)),
          ListView(
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
                          fontFamily: "News Gothic"
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by name...',
                    hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 199, 159)), // Customize hint text color
                    prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 255, 199, 159)), // Customize icon color
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 255, 199, 159)), // Customize border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 255, 199, 159)), // Customize border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 255, 199, 159)), // Customize border color
                    ),
                  ),
                  style: const TextStyle(color: Color.fromARGB(255, 255, 199, 159)), // Customize text color
                  cursorColor: const Color.fromARGB(255, 255, 199, 159), // Customize cursor color
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
              FutureBuilder<double>(
                future: getTotalPercentage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final totalPercentage = snapshot.data ?? 0.0;
                    return Column(
                      children: [
                        Center(
                          child: Text(
                            "${totalPercentage.toStringAsFixed(0)}%",
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              Center(
                child: Expanded(
                  child: FutureBuilder<int>(
                    future: getNumberOfAnimals(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final numberOfQuizzes = snapshot.data!;
                        return FutureBuilder<List<Widget>>(
                          future: _buildFilteredQuizContainers(numberOfQuizzes, context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return const Center(child: Text('Error loading data'));
                            } else {
                              return Wrap(
                                spacing: 20,
                                runSpacing: 20,
                                children: snapshot.data ?? [],
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<Widget>> _buildFilteredQuizContainers(int count, BuildContext context) async {
    final List<Widget> filteredContainers = [];

    for (int index = 0; index < count; index++) {
      final data = await readJson(index);
      final animalName = data['Name'].toString().toLowerCase();

      if (animalName.contains(_searchQuery)) {
        filteredContainers.add(
          FutureBuilder(
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
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/bg_pawn_orange_light.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              color: Color.fromARGB(255, 255, 199, 159),
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
                                        "${percentage.toStringAsFixed(0)}%",
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
    }

    return filteredContainers;
  }

  Future<double?> getPercentageForAnimal(String animalName) async {
    final percentages = await readPercentages();
    return percentages[animalName];
  }

}

Future<double> getTotalPercentage() async {
  final percentages = await readPercentages();
  if (percentages.isEmpty) {
    return 0.0;
  }

  double total = percentages.values.fold(0.0, (sum, item) => sum + (item ?? 0.0));
  total /= await getNumberOfAnimals();
  return total;
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