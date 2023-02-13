import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';
import 'package:moneymanagement/funtions/transactionfn/transaction.dart';
import 'package:moneymanagement/screens/contactUs/Contact.dart';
import 'package:moneymanagement/screens/contactUs/providercontact.dart';
import 'package:moneymanagement/screens/splash_scrren.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../const/const.dart';
import '../../BottomNavigation/screen_home.dart';

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
            appname,
            style: TextStyle(color: Colors.white,letterSpacing: 2),
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
              ),
                  ListTile(
                onTap: () {
              showDialog(
  context: context,
  builder: (_) => AlertDialog(
  shape: const RoundedRectangleBorder(
    borderRadius:
      BorderRadius.all(
        Radius.circular(10.0))),
    content: Builder(
      builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.                              
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return SizedBox(
          height: height*0.2,
          width: width*0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("About App"),
            SizedBox(height: height*0.05,),
            Row(
              children: [

                Container(
                  width: 50,
                  height: 50,
                  child: Image(
                    
                    image: AssetImage("assets/images/splash/Frame.png")),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(appname,style: TextStyle(letterSpacing: 2,fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Text("V.1.0.2",style: TextStyle(color: Colors.grey),),
                    ),

                  ],),
                  
                )
              ],
              
            ),
            SizedBox(height: height*0.03,),
            Center(child: Text("Developed by sahad k",style: GoogleFonts.poppins(),)),
          ]),
        );
      },
    ),
  )
);
                },
                        
                title: const Text(
                  "About  App",
                ),
              ),
              
            ],
          ),
        ));
  }
}
