
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moneymanagement/screens/graph/total_chart.dart';
import 'package:moneymanagement/screens/home/category_screens/screencategories.dart';

import 'package:moneymanagement/screens/home/transactions/home_balance_card_page.dart';
import 'package:moneymanagement/screens/home/settingsscreen/settingsscreen.dart';
import 'package:moneymanagement/screens/screenhome/widgets/bottomnavigation.dart';

 
class Homescreen extends StatelessWidget {
   Homescreen({super.key});
 static ValueNotifier<int> selectedvaluenotifier = ValueNotifier(0);
   final _page = [
     Transaction(),
    const ScreenCategory(),
     Chart2(),
    const SettingsScreen()
  ];

  var onpresscount = 0;
var presscount = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.black,
          bottomNavigationBar: const bottimnavigationbar(),
          body: ValueListenableBuilder(
              valueListenable: Homescreen.selectedvaluenotifier,
              builder: (BuildContext cnt, int updateintex, Widget? _) {
                return _page[updateintex];
              }),
        ),
        onWillPop:
  () async {
        presscount++;

        if (presscount == 2) {
          exit(0);
        } else {
          var snackBar =
              const SnackBar(content: Text('press another time to exit from app'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        }
  }
  );
  }
}