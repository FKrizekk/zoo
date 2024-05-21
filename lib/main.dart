import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: colorOrange,
        body: ListView(
          addAutomaticKeepAlives: false,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Transform.flip(
                  flipX: true,
                  child: Image.asset( //Animal image
                    'animal_images/winton.jpg',
                    width: 500,
                    fit: BoxFit.fitWidth,
                  )
                ),
                Positioned( //Header thingy
                  bottom: 0,
                  child: Image.asset(
                    'assets/top_thingy.png',
                    width: 500,
                  ),
                ),
                const Positioned( //Animal name
                  left: 25,
                  bottom: -5,
                  child: Text(
                    'GORILA\nNÍŽINNÁ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "News Gothic"
                    ),
                  )
                ),
              ],
            ),
            const Image(image: AssetImage("assets/bg_pawn_orange.png"))
          ],
        ),
      ),
    );
  }
}