import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
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

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

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
class NewPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final Color colorOrange = const Color.fromARGB(255, 235, 118, 34);
    return Scaffold(
       
      appBar: AppBar(
        title: Text('Quiz Menu',
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 30,
        fontWeight: FontWeight.w600,
        color: colorOrange,
        fontFamily: 'News Gothic'
        
        ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: colorOrange,
        child:Center(
        child: Text(
          'You have navigated to the new page!',
          textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,


          ),
        ),
      ),
      ),
    );
  }
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
                const Positioned(
                  top: 25,
                  left: 0,
                  child: BackButtonWidget(),
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
                const Image(
                  image: AssetImage("assets/bg_pawn_orange.png"
                  )
                ),
                Positioned(
                  top: 50,
                  left: 25,
                  right: 25,
                  child: Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Color.fromARGB(255, 255, 199, 159),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/bg_pawn_orange_light.png")
                      )
                    ),
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