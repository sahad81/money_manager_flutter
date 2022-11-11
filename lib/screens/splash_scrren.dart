import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';

import 'package:moneymanagement/screens/screenhome/screen_home.dart';
import 'package:iconsax/iconsax.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: SingleChildScrollView(
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Iconsax.wallet_money,
                  size: 60,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
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
        nextScreen: Homescreen());
  }
}
