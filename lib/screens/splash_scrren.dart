import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:moneymanagement/const/const.dart';

import 'package:moneymanagement/screens/BottomNavigation/screen_home.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
 final sizem = MediaQuery.of(context).size.height;
  final sizemw = MediaQuery.of(context).size.width;
    return AnimatedSplashScreen(
        splash: SingleChildScrollView(
          child: Column(
            children:[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:Image.asset("assets/images/splash/Frame.png",height: sizem*0.20,width:  sizem*0.20,),
              ),
               SizedBox(
                height: sizem*0.013,
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                          Text(
                      appname,
                      style: TextStyle(
                        letterSpacing: 3,
                          fontSize: sizemw*0.1,
                          color: Colors.blue.shade900,
                         fontFamily: "Cormorant"
                       
                          ),
                    ),
                //    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Text(
                      "M O N E Y  M A N A G E R",
                      style: TextStyle(
                          fontSize: sizemw*0.03,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Cormorant"
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        splashIconSize: sizemw*1,
        nextScreen:  Homescreen());
  }
}
