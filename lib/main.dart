// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'quiz_menu.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(const MaterialApp(
    home: NewPage(),
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

Future<List<int>> loadAnswers() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data/answers.json');

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      List<dynamic> quizzes = jsonData['quizzes'];
      if (quizzes.isNotEmpty) {
        List<dynamic> answers = quizzes[0]['answers'];
        return List<int>.from(answers);
      }
    }
  } catch (e) {
    print('Error loading answers: $e');
  }

  return [];
}

Future<void> storeAnswers(List<int> answers) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/data/answers.json');

  // Create the quizzes structure
  final Map<String, dynamic> quizzesData = {
    "quizzes": [
      {"answers": answers}
    ]
  };

  // Encode the data to JSON
  String jsonString = jsonEncode(quizzesData);

  // Ensure the directory exists
  await file.create(recursive: true);

  // Write the JSON string to the file
  await file.writeAsString(jsonString);

  print('Answers stored at ${file.path}');
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _launchUrl("https://www.goarmy.com/");
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange, // Background color
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        padding: const EdgeInsets.all(16.0), // Padding inside the button
      ),
      child: const Icon(
        Icons.arrow_back,
        color: Colors.white, // Icon color
      ),
    );
  }
}

class ListButtonWidget extends StatelessWidget {
  const ListButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange, // Background color
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        padding: const EdgeInsets.all(16.0), // Padding inside the button
      ),
      child: const Icon(
        Icons.arrow_back,
        color: Colors.white, // Icon color
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final Widget target;

  const ButtonWidget({
    super.key,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => target),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange, // Background color
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        padding: const EdgeInsets.all(16.0), // Padding inside the button
      ),
      child: const Icon(
        Icons.arrow_back,
        color: Colors.white, // Icon color
      ),
    );
  }
}



class QuizPage extends StatelessWidget {
  const QuizPage({super.key, required this.data});

  final dynamic data;

  final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);
  final Color colorOrangeLight = const Color.fromARGB(255, 255, 199, 159);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: colorOrange,
        body: ListView(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  'animal_images/${data["Image"]}',
                  width: 500,
                  height: 500,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/top_thingy.png',
                      width: 500,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      height: 60,
                      color: colorOrange,
                    )
                  ],
                ),
                Positioned(
                    left: 25,
                    bottom: 0,
                    width: 400,
                    child: Text(
                      data["Name"].replaceAll(' ', '\n'),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 55,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                const Positioned(
                    top: 25, left: 0, child: ButtonWidget(target: NewPage())),
                Positioned(
                    top: -15,
                    right: -25,
                    child: Image.asset(
                      'assets/logo.png',
                      width: 150,
                      height: 150,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.map_outlined,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(
                      data["Pavilon"],
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipRect(
                  child: Align(
                    heightFactor: 0.3,
                    child: Image.asset(
                        'assets/bg_pawn_orange.png',
                        fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 25,
                  right: 25,
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Color.fromARGB(255, 255, 199, 159),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/bg_pawn_orange_light.png"),
                          ),
                        ),
                        child: Quiz(data: data),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(colorOrange),
                            overlayColor: MaterialStateProperty.all<Color>(colorOrangeLight),
                          ),
                          onPressed: () async {
                            int correctAnswers = 0;
                            List<int> correctIndices = _QuizState.correctAnswerIndices;

                            for (int i = 0; i < _QuizState.selectedAnswers.length; i++) {
                              if (_QuizState.selectedAnswers[i] == correctIndices[i]) {
                                correctAnswers++;
                              }
                            }
                            double percentage = (correctAnswers / _QuizState.selectedAnswers.length) * 100;

                            // Store the percentage of correct answers
                            await writePercentage(data["Name"], percentage);

                            print("Submitted\nPercentage of correct answers: $percentage%");
                            Map<String, dynamic> percentages = await readPercentages();
                            print(percentages[data["Name"]]);

                            await _showResultDialog(context, percentage);
                          },
                          child: const Text("Submit"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showResultDialog(BuildContext context, double percentage) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to dismiss dialog
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Congratulations!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Good job! You got $percentage% correctly.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              foregroundColor : MaterialStateProperty.all<Color>(const Color.fromARGB(255, 235, 118, 34)),
              overlayColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 255, 199, 159))
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewPage()),
              );
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

class Quiz extends StatefulWidget {
  const Quiz({super.key, required this.data});

  final dynamic data;

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  static List<int> selectedAnswers = [0, 0, 0, 0, 0];
  static List<int> correctAnswerIndices = [];

  final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);
  final Color colorOrangeLight = const Color.fromARGB(255, 255, 199, 159);

  late List<Question> questions;

  @override
  void initState() {
    super.initState();

    dynamic data = widget.data;

    questions = [
      Question(
        text: "Jak je ${data["Name"]} velký?",
        answers: [data["SizeR"], data["Size1F"], data["Size2F"]],
        correctAnswerIndex: 0,
      ),
      Question(
        text: "Jakou má ${data["Name"]} dietu?",
        answers: [data["DietR"], data["Diet1F"], data["Diet2F"]],
        correctAnswerIndex: 0,
      ),
      Question(
        text: "Kde se ${data["Name"]} vyskytuje?",
        answers: [data["OccurrenceR"], data["Occurrence1F"], data["Occurrence2F"]],
        correctAnswerIndex: 0,
      ),
      Question(
        text: "Kolik ${data["Name"]} váží?",
        answers: [data["WeightR"], data["Weight1F"], data["Weight2F"]],
        correctAnswerIndex: 0,
      ),
      Question(
        text: "Jaké má rád ${data["Name"]} prostředí?",
        answers: [data["HabitatR"], data["Habitat1F"], data["Habitat2F"]],
        correctAnswerIndex: 0,
      ),
    ];

    // Shuffle the questions and answers, and update correct answer indices accordingly
    for (var question in questions) {
      int correctIndex = question.correctAnswerIndex;
      List<int> answerIndices = List.generate(question.answers.length, (index) => index);
      answerIndices.shuffle(Random());

      question.answers = answerIndices.map((index) => question.answers[index]).toList();
      question.correctAnswerIndex = answerIndices.indexOf(correctIndex);
    }
    questions.shuffle(Random());

    // Store correct answer indices
    correctAnswerIndices = questions.map((q) => q.correctAnswerIndex).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: PageView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return Card(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            questions[index].text,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ...questions[index].answers.asMap().entries.map((entry) {
                            int answerIndex = entry.key;
                            String answerText = entry.value;
                            return RadioListTile(
                              title: Text(answerText),
                              value: answerIndex,
                              groupValue: selectedAnswers[index],
                              activeColor: colorOrange,
                              onChanged: (value) {
                                setState(() {
                                  selectedAnswers[index] = value!;
                                });
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_left),Icon(Icons.arrow_right)
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Question {
  String text;
  List<String> answers;
  int correctAnswerIndex;

  Question({
    required this.text,
    required this.answers,
    required this.correctAnswerIndex,
  });
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/animal_percentages.json');
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

Future<void> writePercentage(String animalName, double percentage) async {
  final file = await _localFile;
  Map<String, dynamic> data = await readPercentages();
  
  data[animalName] = percentage;

  final jsonString = jsonEncode(data);
  await file.writeAsString(jsonString);
}