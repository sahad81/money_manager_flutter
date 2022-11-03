import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';

const trnasactionDbName_ = 'transation__db';

 //late List<transation_model> list;


abstract class TransationDbFn {
  Future<List<transation_model>> gettransaction();
  Future<void> addtransaction(transation_model object);
  Future<void> deletetransactions(String id);
  Future<void> restartapptransaction();
  // int allexpenseamount();
   
  //  Future<void>check(transation_model date);

}

//  late List<transation_model> catogary;
//fi Listd =list;
class TransationDb implements TransationDbFn {
  TransationDb._internal();
  static TransationDb instance = TransationDb._internal();

  factory TransationDb() {
    return instance;
  }
  ValueNotifier<List<transation_model>> transationlistnotifire =
      ValueNotifier([]);
  ValueNotifier<List<transation_model>> transationIncomeonlyNotifire =
      ValueNotifier([]);
  ValueNotifier<List<transation_model>> transationExpnsenotifire =
      ValueNotifier([]);
  ValueNotifier<List<transation_model>> transationtodayonlynotifire =
      ValueNotifier([]);
  ValueNotifier<List<transation_model>> transationwithinAMonthNotifire =
      ValueNotifier([]);
  ValueNotifier<List<transation_model>> graapNotifire = ValueNotifier([]);

  @override
  Future<void> addtransaction(transation_model object) async {
    final db = await Hive.openBox<transation_model>(trnasactionDbName_);

    await db.put(object.id, object);
  }

  @override
  Future<List<transation_model>> gettransaction() async {
    final db = await Hive.openBox<transation_model>(trnasactionDbName_);

    return db.values.toList();
  }

  @override
  Future<void> deletetransactions(String id) async {
    final transatinDb =
        await Hive.openBox<transation_model>(trnasactionDbName_);
    transatinDb.delete(id);
    refreshtransaction();
    //  transationIncomeonlyNotifire.notifyListeners();
  }

  @override
  Future<void> restartapptransaction() async {
    final transationDb =
        await Hive.openBox<transation_model>(trnasactionDbName_);
    // transationDb_.deleteAll(iddeleteall);

    transationlistnotifire.value.clear();
    transationIncomeonlyNotifire.value.clear();
    transationExpnsenotifire.value.clear();
    transationtodayonlynotifire.value.clear();
    transationwithinAMonthNotifire.value.clear();
    graapNotifire.value.clear();
    await transationDb.clear();
     
    refreshtransaction();
    //  print('reset');
  }

  Future<void> refreshtransaction() async {
    final list = await gettransaction();
   allincomeamount();
    allexpenseamount();
    transationExpnsenotifire.addListener(() {allincomeamount(); });
    transationwithinAMonthNotifire.value.clear();
    transationIncomeonlyNotifire.value.clear();
    transationExpnsenotifire.value.clear();
    transationtodayonlynotifire.value.clear();
    graapNotifire.value.clear();
    list.sort((first, second) => second.date.day.compareTo(first.date.day));
    transationlistnotifire.value.clear();

    transationlistnotifire.value.addAll(list);
    transationlistnotifire.notifyListeners();
    
 
    await Future.forEach(list, (transation_model catogary) {
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

    await Future.forEach(list, (transation_model catogary) {
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
    await Future.forEach(list, (transation_model today) {
      // hii =catogary;
      if (today.date ==
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
        transationtodayonlynotifire.value.add(today);
        transationtodayonlynotifire.notifyListeners();
      } else {
        return;
      }
    });
    await Future.forEach(list, (transation_model month) {
      // hii =catogary;
      if (month.date == DateTime(DateTime.now().year, DateTime.now().month)) {
        transationwithinAMonthNotifire.value.add(month);
        transationwithinAMonthNotifire.notifyListeners();
      } else {
        return;
      }
    });
  }


  double allincomeamount() {
    //  var length=listO.length;

    var sumincomeAmount = 0;
    for (var value in transationlistnotifire.value) {
      if (value.type == catagories_type.income) {
        sumincomeAmount = sumincomeAmount + value.ammount.toInt();
      }
    }
    return sumincomeAmount.toDouble();
  }

 // @override
  double allexpenseamount() {
    var sumexpenseAmount = 0;
    for (var value in transationtodayonlynotifire.value) {
      if (value.type == catagories_type.expense) {
        sumexpenseAmount = sumexpenseAmount + value.ammount.toInt();
      }
    }
    return sumexpenseAmount.toDouble();
  }
  double balance(){
    var balance1 =0;
     var sumincomeAmount = 0;
        var sumexpenseAmount = 0;
    for (var value in transationtodayonlynotifire.value) {
      if (value.type == catagories_type.expense) {
        sumexpenseAmount = sumexpenseAmount + value.ammount.toInt();
      }
    }
   
    for (var value in transationlistnotifire.value) {
      if (value.type == catagories_type.income) {
        sumincomeAmount = sumincomeAmount + value.ammount.toInt();
      }
    }

    balance1=sumincomeAmount-sumexpenseAmount;
    return balance1.toDouble();
  }
}
