import 'package:flutter_iconify/flutter_iconify.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/si_glyph.dart';
import 'package:moneymanagement/screens/appbaraction/contactus/contactUs.dart';
import 'package:moneymanagement/screens/appbaraction/today/today.dart';
import 'package:moneymanagement/screens/appbaraction/transationWithInAmonth/month.dart';
import 'package:moneymanagement/screens/graph/graph.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:moneymanagement/screens/home/transations/add_Transation/add_transation_screen.dart';
import 'package:moneymanagement/screens/home/catagories/category_add_popup.dart';
import 'package:moneymanagement/screens/home/transations/transactionlocal.dart';
import 'package:moneymanagement/screens/screenhome/widgets/bottomnavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:moneymanagement/screens/home/catagories/screencatogaries.dart';
import '../appbaraction/expenseonly/expenseonly.dart';
import '../appbaraction/incomeonly/incomeonly.dart';

// ignore: camel_case_types
class homescreen extends StatelessWidget {
  homescreen({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedvaluenotifier = ValueNotifier(0);

  final _page = [
 // Today(),
    transatction(),
    screen_catogaries(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar:  selectedvaluenotifier.value == 0? AppBar(
          
          title:  Text(
            'MONEY MANAGER',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(onPressed: (){}, icon:Icon(Icons.search))
          ],
          
        )
        :AppBar(
          
          title:  Text(
            'MONEY MANAGER',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        
          
        ),
        drawer: Drawer(
            child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 110,
                  ),
                  Text(
                    'MoneyManager',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Roboto and San Fransisco'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,

                //color: Colors.grey,

                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    actionbar(
                        text: "Transaction Today",
                        icon: Icons.arrow_forward_rounded,
                        leading: Icons.today_sharp,
                        pressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Today();
                          }));
                        }),
                    actionbar(
                        text: "Transactions In A Month",
                        icon: Icons.arrow_forward_rounded,
                        leading: Icons.calendar_month,
                        pressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return  Graph();
                            //Month();
                          }));
                        }),

                    ListTile(
                      title: const Text('Income'),
                      leading: const Iconify(
                        SiGlyph.money_coin,
                        color: Colors.blue,
                      ),
                      trailing: const Icon(Icons.arrow_forward_rounded),
                      onTap: () => changetoincome(context),
                    ),
                    ListTile(
                      title: const Text('Expense'),
                      leading: const Icon(
                        IconifyLighter.man_with_money,
                        color: Colors.blue,
                      ),
                      trailing: const Icon(Icons.arrow_forward_rounded),
                      onTap: () => changetoexpenses(context),
                    ),

                    const Divider(
                      thickness: 1,
                    ),

                    actiionbarwithleading(
                        text: "App Reset",
                        icon: CupertinoIcons.arrow_counterclockwise_circle,
                        pressed: () {
                          showDialog(
                              context: context,
                              builder: ((context) => AlertDialog(
                                    title: const Text("Reset app"),
                                    content: const Text(
                                        'your app will be reset and all data will be lost.'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (con) {
                                              return homescreen();
                                            }));
                                          },
                                          child: const Text('CANCEL')),
                                      TextButton(
                                          onPressed: () {
                                            TransationDb.instance
                                                .restartapptransation();
                                            catagories_db.instance
                                                .restarcatocaryapp();
                                            //   <! second time-->
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (con) {
                                              return homescreen();
                                            }));
                                            //Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content:
                                                        Text('app Reseted')));
                                          },
                                          child: const Text('ACCEPT'))
                                    ],
                                  )));
                        }),

                 
                actiionbarwithleading(
                          text: "Contact Us",
                          icon: Icons.contacts,
                          pressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (con) {
                              return contactUs();
                            }));
                          
                          }),
                  
                    actiionbarwithleading(
                        text: 'Share App',
                        icon: Icons.share,
                        pressed: () {
                          Share.share('link not fount');
                        }),
                    //
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: const [
                          //s height: 30,
                          SizedBox(
                            height: 200,
                          ),
                          Text(
                            'Version 0.01',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
        bottomNavigationBar: bottimnavigationbar(),
        body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedvaluenotifier,
              builder: (BuildContext cnt, int updateintex, Widget? _) {
                return _page[updateintex];
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedvaluenotifier.value == 0) {
              Navigator.of(context).pushNamed(add_transations.routname);
            } else {
              showpopupADD(context);
            }
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ));
  }

  actionbar(
      {required IconData leading,
      required String text,
      required IconData icon,
      required Function() pressed}) {
    return Column(
      children: [
        ListTile(
            onTap: pressed,
            leading: Icon(
              leading,
              color: Colors.blue,
            ),
            title: Text(text),
            trailing: Icon(icon)),

        //  Divider(thickness: 1,)
      ],
    );
  }

  Column actiionbarwithleading(
      {required String text,
      required IconData icon,
      required Function() pressed}) {
    return Column(
      children: [
        ListTile(
            onTap: pressed,
            title: Text(text),
            leading: Icon(
              icon,
              color: Colors.blue,
            )),
      ],
    );
  }

  void changetoincome(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context1) {
      return incomeonly();
    }));
  }

  void changetoexpenses(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context1) {
      return const ExpenseOnly();
    }));
  }
}
