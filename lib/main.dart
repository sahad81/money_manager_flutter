import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';

import 'package:moneymanagement/screens/home/transations/add_Transation/add_transation_screen.dart';


import 'package:moneymanagement/screens/splash_scrren.dart';

import 'package:overlay_support/overlay_support.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoriestypeAdapter().typeId)) {
    Hive.registerAdapter(CategoriestypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategriesmodelAdapter().typeId)) {
    Hive.registerAdapter(CategriesmodelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionmodelAdapter().typeId)) {
    Hive.registerAdapter(TransactionmodelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => OverlaySupport.global(
                child: MaterialApp(
                    theme: ThemeData(),
                    debugShowCheckedModeBanner: false,
                    home: const
                  //  Chart2(),
                     SplashScreen(),
                    routes: {
                  AddTransactions.routname: (con) => const AddTransactions(),
                })));
  }
}
