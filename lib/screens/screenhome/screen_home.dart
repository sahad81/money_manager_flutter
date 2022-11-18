
import 'package:flutter/material.dart';
import 'package:moneymanagement/screens/graph/total_chart.dart';
import 'package:moneymanagement/screens/home/catagories/screencategories.dart';



import 'package:moneymanagement/screens/home/transactions/transactionlocal.dart';
import 'package:moneymanagement/screens/screenhome/settingsscreen/settingsscreen.dart';
import 'package:moneymanagement/screens/screenhome/widgets/bottomnavigation.dart';

import '../../funtions/categories_fn_db/transaction.dart';

class Homescreen extends StatelessWidget {
  Homescreen({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedvaluenotifier = ValueNotifier(0);

  final _page = [
    // Today(),
     const Transaction(),
    const ScreenCategory(),
   
    //const Chart2(),
    //  Graph(),
    const 
    Chart2(),
    // Dchart(),
   //Piechart()    
 const  SettingsScreen()
  ];

  get context => null;

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.allincomeamount;
    return Scaffold( 
      backgroundColor: Colors.black,
      bottomNavigationBar: const bottimnavigationbar(),
      body: WillPopScope(
        onWillPop: showexitdiloge,
        child: ValueListenableBuilder(
            valueListenable: selectedvaluenotifier,
            builder: (BuildContext cnt, int updateintex, Widget? _) {
              return _page[updateintex];
            }),
      ),
    );
  }

  Future<bool> showexitdiloge() async {
    return await showDialog(
        context: context,
        builder: (co) {
          return AlertDialog(
            title: const Text("Exit app"),
            content: const Text("Do you want to exit this app?"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text("No",)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }
}
