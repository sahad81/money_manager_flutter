import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';

import 'package:moneymanagement/screens/home/transations/add_Transation/add_transation_screen.dart';
import 'package:moneymanagement/screens/screenhome/screen_home.dart';

import 'package:overlay_support/overlay_support.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(catagoriestypeAdapter().typeId)) {
    Hive.registerAdapter(catagoriestypeAdapter());
  }


  if (!Hive.isAdapterRegistered(catogariesmodelAdapter().typeId)) {
    Hive.registerAdapter(catogariesmodelAdapter());
  }
  
  if (!Hive.isAdapterRegistered(transationmodelAdapter().typeId)) {
    Hive.registerAdapter(transationmodelAdapter());
  }
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
       Builder(
         builder: (context) =>OverlaySupport.global(child:
            MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home:
            //Graph(),
             homescreen(),
            // contactUs(),
            //  homescreen(),
            routes: {
              add_transations.routname: (con) => add_transations(),
              // transatction.routname:(context) => transatction(),
           })
         )   
       );
  }
}
