import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
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
                const Image(
                  image: AssetImage("assets/bg_pawn_orange.png"
                  )
                ),
                Positioned(
                  top: 50,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Color.fromARGB(255, 255, 199, 159),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/bg_pawn_orange_light.png")
                      )
                    ),
                    width: 300,
                    height: 500
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