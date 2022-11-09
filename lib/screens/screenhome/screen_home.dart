

import 'package:flutter/material.dart';
import 'package:moneymanagement/screens/graph/chart2.dart';
import 'package:moneymanagement/screens/graph/graph.dart';
import 'package:moneymanagement/screens/home/catagories/screencatogaries.dart';
import 'package:moneymanagement/screens/home/transations/transactionlocal.dart';
import 'package:moneymanagement/screens/screenhome/settingsscreen/settingsscreen.dart';
import 'package:moneymanagement/screens/screenhome/widgets/bottomnavigation.dart';

import '../../funtions/catagories_fn_db/transation.dart';

class homescreen extends StatelessWidget {
  homescreen({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedvaluenotifier = ValueNotifier(0);

  final _page = [
 // Today(),
    transatction(),
    screen_catogaries(),
    Chart2(),
  //  Graph(),
    SettingsScreen() 
  ];

  @override
  Widget build(BuildContext context) {
    TransationDb.instance.allincomeamount;
    return Scaffold(
        backgroundColor: Colors.black,
        
        
          
        
 
        bottomNavigationBar: bottimnavigationbar(),
        body: SafeArea(
          child: ValueListenableBuilder(
                
              valueListenable: selectedvaluenotifier,
              builder: (BuildContext cnt, int updateintex, Widget? _) {
                return _page[updateintex];
              }),
        ),);
    }}



