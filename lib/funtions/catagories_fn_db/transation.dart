import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';
import 'package:validators/validators.dart';

const trnasationDbName_ = 'transation__db';

abstract class TransationDbFn {
  Future<List<transation_model>> gettransation();
  Future<void> addtransation(transation_model object);
  Future<void> deletetransations(String id);
  Future<void> restartapptransation();
  //Future<Void> allincomeamount();
  //  Future<void>check(transation_model date);

}

late List<transation_model> listO;

//  late List<transation_model> catogary;
//fi Listd =list;
class TransationDb implements TransationDbFn {
  TransationDb._internal();
  static TransationDb instance = TransationDb._internal();

  factory TransationDb() {
    return instance;
  }
  ValueNotifier<List<transation_model>> transationlistnotifire =  ValueNotifier([]);
  ValueNotifier<List<transation_model>> transationIncomeonlyNotifire = ValueNotifier([]);
   ValueNotifier<List<transation_model>> transationExpnsenotifire = ValueNotifier([]);
     ValueNotifier<List<transation_model>> transationtodayonlynotifire = ValueNotifier([]);
     ValueNotifier<List<transation_model>> transationwithinAMonthNotifire = ValueNotifier([]);
         ValueNotifier<List<transation_model>> graapNotifire = ValueNotifier([]);
     
  @override
  Future<void> addtransation(transation_model object) async {
    final db = await Hive.openBox<transation_model>(trnasationDbName_);

    await db.put(object.id, object);
  }

  @override
  Future<List<transation_model>> gettransation() async {
    final db = await Hive.openBox<transation_model>(trnasationDbName_);

    return db.values.toList();
  }

  @override
  Future<void> deletetransations(String id) async {
    final transatinDb =
        await Hive.openBox<transation_model>(trnasationDbName_);
    transatinDb.delete(id);
    refreshtransation();
  //  transationIncomeonlyNotifire.notifyListeners();
  }

  @override
  Future<void> restartapptransation() async {
    final transationDb =
        await Hive.openBox<transation_model>(trnasationDbName_);
    // transationDb_.deleteAll(iddeleteall);
    transationlistnotifire.value.clear();
    transationIncomeonlyNotifire.value.clear();
    transationExpnsenotifire.value.clear();
    transationtodayonlynotifire.value.clear();
    transationwithinAMonthNotifire.value.clear();
    graapNotifire.value.clear();
    await transationDb.clear();

    refreshtransation();
  //  print('reset');
  }

  Future<void> refreshtransation() async {
    listO = await gettransation();
    transationwithinAMonthNotifire.value.clear();
    transationIncomeonlyNotifire.value.clear();
    transationExpnsenotifire.value.clear();    
    transationtodayonlynotifire.value.clear();
    graapNotifire.value.clear();
    listO.sort((first, second) => second.date.day.compareTo(first.date.day));
    transationlistnotifire.value.clear();

    transationlistnotifire.value.addAll(listO);
    transationlistnotifire.notifyListeners();

    await Future.forEach(listO, (transation_model catogary) {
      // hii =catogary;
      if (catogary.type == catagories_type.income) {
        //final List<Iterable> typee=catogary;
        // transationtext.value.clear();

        transationIncomeonlyNotifire.value.add(catogary);
       transationIncomeonlyNotifire.notifyListeners();
      } else {
        return;
      }
    });

    await Future.forEach(listO, (transation_model catogary) {
      // hii =catogary;
      if (catogary.type == catagories_type.expense) {
        //final List<Iterable> typee=catogary;
        // transationtext.value.clear();

        transationExpnsenotifire.value.add(catogary);
        transationExpnsenotifire.notifyListeners();
       
      } else {
        return;
      }
    });
        await Future.forEach(listO, (transation_model today) {
      // hii =catogary;
      if (today.date == DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ) {
        transationtodayonlynotifire.value.add(today);
         transationtodayonlynotifire.notifyListeners();
      } else {
        return;
      }
    });
     await Future.forEach(listO, (transation_model month) {
      // hii =catogary;
      if (month.date ==DateTime(DateTime.now().year,DateTime.now().month) ) {
        transationwithinAMonthNotifire.value.add(month);
         transationwithinAMonthNotifire.notifyListeners();
      } else {
        return;
      }
    });


    
  }
  
  // @override
  // Future<Void> allincomeamount() {
  
  // for

  // }
}
