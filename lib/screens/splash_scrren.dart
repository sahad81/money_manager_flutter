import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';

import 'package:moneymanagement/screens/screenhome/screen_home.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: SingleChildScrollView(
          child: Column(
            children:[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:Image.asset("assets/images/splash/Frame.png",height: 150,width: 150,),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "M O N E Y  M A N A G E R",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cormorant"
                      ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        splashIconSize: 300,
        nextScreen:  Homescreen());
  }
}
