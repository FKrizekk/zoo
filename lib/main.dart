import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'fart.dart';
import 'quiz_menu.dart';
import 'dart:convert';
import 'dart:io';



void main() {
  runApp(MaterialApp(
    home: NewPage(),
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
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
      {
        "answers": answers
      }
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
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange, // Background color
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomRight: Radius.circular(25))
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

class ListButtonWidget extends StatelessWidget {
  const ListButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange, // Background color
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomRight: Radius.circular(25))
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
  QuizPage({super.key});

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
                Transform.flip(
                  flipX: true,
                  child: Image.asset( //------------Animal image---------------
                    'animal_images/winton.jpg',
                    width: 500,
                    height: 500,
                    fit: BoxFit.fitHeight,
                  )
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
                const Positioned( //----------------Animal name---------------
                  left: 25,
                  bottom: 0,
                  child: Text(
                    'GORILA\nNÍŽINNÁ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "News Gothic"
                    ),
                  )
                ),
                Positioned(
                  top: 25,
                  left: 0,
                  child: ButtonWidget(target: NewPage())
                ),
                Positioned(
                  top: -15,
                  right: -25,
                  child: Image.asset(
                    'assets/logo.png',
                    width: 150,
                    height: 150,


                  )
                )
              ],
            ),
            const Padding( //----------Animal Location--------------
              padding: EdgeInsets.only(left: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      'Rezervace Dja',
                      textAlign: TextAlign.left,
                      style: TextStyle(
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
                const Image( //-----------------Background paws--------------------
                  image: AssetImage("assets/bg_pawn_orange.png"
                  )
                ),
                Positioned( //-------------------Quiz Container-----------------------------
                  top: 50,
                  left: 25,
                  right: 25,
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Color.fromARGB(255, 255, 199, 159),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/bg_pawn_orange_light.png")
                          )
                        ),
                        child: Quiz()
                      ),
                      Center(
                        child: ElevatedButton(
                          child: Text("Submit"),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(colorOrange),
                            overlayColor: MaterialStateProperty.all<Color>(colorOrangeLight)
                          ),
                          onPressed: () async {
                            //Write answers to json
                            storeAnswers(_QuizState.selectedAnswers);

                            print("Submitted\n${_QuizState.selectedAnswers}");

                            print(await loadAnswers());
                          },
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

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Question> questions = [
    Question(
      text: "Which monkey is the best?",
      answers: ["Monkey 1", "Monkey 2", "Monkey 3"],
    ),
    Question(
      text: "Which planet is known as the Red Planet?",
      answers: ["Earth", "Mars", "Jupiter"],
    ),
    Question(
      text: "What is the largest ocean on Earth?",
      answers: ["Atlantic Ocean", "Indian Ocean", "Pacific Ocean"],
    ),
    Question(
      text: "Who wrote 'To be, or not to be'?",
      answers: ["Mark Twain", "Charles Dickens", "William Shakespeare"],
    ),
    Question(
      text: "What is the chemical symbol for water?",
      answers: ["H2O", "O2", "CO2"],
    ),
  ];

  static List<int> selectedAnswers = [0,0,0,0,0];

  final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);
  final Color colorOrangeLight = const Color.fromARGB(255, 255, 199, 159);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: PageView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return Card(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( //--------------------Question-----------------------
                      questions[index].text,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...questions[index].answers.asMap().entries.map((entry) { //----------------Answers------------------
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

  Question({required this.text, required this.answers});
}