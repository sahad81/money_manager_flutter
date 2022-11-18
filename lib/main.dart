import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';
import 'package:moneymanagement/screens/home/transactions/add_Transation/add_transation_screen.dart';



import 'package:moneymanagement/screens/splash_scrren.dart';

import 'package:overlay_support/overlay_support.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoriesTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoriesTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoriesModelAdapter().typeId)) {
    Hive.registerAdapter(CategoriesModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
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
                  
                    theme: ThemeData(primaryColor: Colors.black),
                    debugShowCheckedModeBanner: false,
                    home: 
                  //  Chart2(),
                  //
                 const SplashScreen(),
                //Chart2(),
                    routes: { 
                  AddTransactions.routname: (con) => const AddTransactions(),
                })));
  }
}
