import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';

import '../../../../funtions/transactionfn/transaction.dart';



class Addtrasactionprovider with ChangeNotifier {
  CategoriesType? selectedcategory=CategoriesType.expense;
  String? catogariesID;
    DateTime? selecteddate;
     DateTime? datefirst;
  initstate() {
    selectedcategory = CategoriesType.income;
   selecteddate=null;
   catogariesID=null;
    notifyListeners();
  }

  void selectedincometype() {
    selectedcategory = CategoriesType.income;
    log("inc");
    notifyListeners();
  }

  void selectexpensetype() {
    selectedcategory = CategoriesType.expense;
    log("ex");
    notifyListeners();
  }

  void refreshtransacRefreshcateg() {
    CategoriesDb.instance.expensecategorieslistlistner;
    TransactionDb.instance.refreshtransaction();
    CategoriesDb.instance.refreshfuntion();
    notifyListeners();
  }

  void categoryidchange(String? value) {
    catogariesID = value;
    notifyListeners();
  }
    calendar(BuildContext context) async {
    datefirst = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 60)),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Color.fromARGB(255, 66, 125, 145),
            )),
            child: child!);
      },
    );

    // ignore: unnecessary_null_comparison
    if (datefirst! == null) {
      return;
    } else {
      
        selecteddate = datefirst;
notifyListeners();
    }
  }
}
