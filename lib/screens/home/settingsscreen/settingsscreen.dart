import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';
import 'package:moneymanagement/funtions/transactionfn/transaction.dart';
import 'package:moneymanagement/screens/contactUs/Contact.dart';
import 'package:moneymanagement/screens/contactUs/providercontact.dart';
import 'package:moneymanagement/screens/splash_scrren.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../screenhome/screen_home.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: const Text(
                      "No",
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Yes"))
              ],
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: const Text(
            'MONEY MANAGER',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: WillPopScope(
          onWillPop: () => showexitdiloge(),
          child: Column(
            children: [
              ListTile(
                  title: const Text(
                    " App Reset",
                  ),
                  onTap: () => showDialog(
                      context: context,
                      builder: ((context) => AlertDialog(
                            title: const Text("Reset app"),
                            content: const Text(
                                'your app will be reset. all data will be lost.'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>  Homescreen()),
                                        (route) => false);
                                  },
                                  child: const Text('CANCEL',
                                      style: TextStyle(color: Colors.black))),
                              TextButton(
                                  onPressed: () {
                                    TransactionDb.instance
                                        .restartapptransaction();
                                    CategoriesDb.instance.restarcatocaryapp();
                                    //   <! second time-->
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) {
                                      return const SplashScreen();
                                    }), (route) => false);

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            margin: EdgeInsets.all(15),
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              'app Reseted',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )));
                                  },
                                  child: const Text(
                                    'ACCEPT',
                                    style: TextStyle(color: Colors.black),
                                  ))
                            ],
                          )))
                          ),
              ListTile(
                onTap: () {
               
                    Navigator.push(context, MaterialPageRoute(builder: (con) {
                  return  Contact();
                }));},
                title: const Text(
                  "Contact Us",
                ),
              ),
              ListTile(
                onTap: () => Share.share('link not fount'),
                title: const Text(
                  "Share App",
                ),
              )
            ],
          ),
        ));
  }
}
