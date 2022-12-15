import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';


import 'package:moneymanagement/screens/contactUs/providercontact.dart';
import 'package:moneymanagement/screens/graph/staticprovider.dart';
import 'package:moneymanagement/screens/home/transactions/add_Transation/add_transation_screen.dart';
import 'package:moneymanagement/screens/home/transactions/add_Transation/provider_add_transaction.dart';
import 'package:moneymanagement/screens/home/transactions/all_transactions/all_transaction_provider.dart';

import 'package:moneymanagement/screens/splash_scrren.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

 // WidgetsFlutterBinding.ensureInitialized();
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

  runApp(
MultiProvider(providers: [
ChangeNotifierProvider(create: (_)=>Addtrasactionprovider(),
),
ChangeNotifierProvider(create: (_)=> Contactprovider()),
ChangeNotifierProvider(create: (_)=> ProviderAllTransaction()),
ChangeNotifierProvider(create: (_)=> Staticprovider())
],
child: const MyApp(),
)

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => OverlaySupport.global(
                child: MaterialApp(
                    theme: ThemeData(primarySwatch: Colors.grey),
                    debugShowCheckedModeBanner: false,
                    home: 
                  
                     const SplashScreen(),
                    routes: {
                  AddTransactions.routname: (con) =>  AddTransactions(),
                })));
  }
}
