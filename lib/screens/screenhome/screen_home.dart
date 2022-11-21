
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moneymanagement/screens/graph/total_chart.dart';
import 'package:moneymanagement/screens/home/category_screens/screencategories.dart';

import 'package:moneymanagement/screens/home/transactions/Home_balanceCard.dart';
import 'package:moneymanagement/screens/screenhome/settingsscreen/settingsscreen.dart';
import 'package:moneymanagement/screens/screenhome/widgets/bottomnavigation.dart';


class Homescreen extends StatefulWidget {
 const Homescreen({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedvaluenotifier = ValueNotifier(0);

  @override
  State<Homescreen> createState() => _HomescreenState();
}
var presscount = 0;
class _HomescreenState extends State<Homescreen> {
  final _page = [
    const Transaction(),
    const ScreenCategory(),
    const Chart2(),
    const SettingsScreen()
  ];

  var onpresscount = 0;

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