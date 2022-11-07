
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:share_plus/share_plus.dart';

import '../../appbaraction/contactus/contactUs.dart';
import '../screen_home.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ListTile(
              title: Text(
                " App Reset",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  CupertinoIcons.arrow_counterclockwise_circle,
                  color: Colors.black,
                ),
              ),
              onTap: () =>  showDialog(
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
                                                .restartapptransaction();
                                         catagories_db.instance.restarcatocaryapp();
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
                                  )))
            ),
            const Divider(),
             ListTile(
              onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (con) {
                              return contactUs();
                            })) ,
              title: const Text(
                "Contact Us",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon( Icons.contacts,
                  color: Colors.black,
                ),
              ),
            ),
            const Divider(),
            const ListTile(
              title: Text("About",
               style: TextStyle(fontWeight: FontWeight.w600),
            ),
              trailing: Padding(
                padding: EdgeInsets.all(8.0),
                // child: Iconify( FlatColorIcons.about,
                 
                // ),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () => Share.share('link not fount'),
              title: const Text("Share App",style: TextStyle(fontWeight: FontWeight.w600),),
                trailing: const Padding(
                padding: EdgeInsets.all(8.0),
                child:Icon(Icons.share,color: Colors.black,),
                 
                ),
              ),
            
            const Divider(),
          ],
        ));
  }
}
