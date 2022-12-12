import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';

import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';

const trnasactionDbName_ = 'transation__db';

abstract class TransactionDbFn {
  Future<List<TransactionModel>> gettransaction();
  Future<void> addtransaction(TransactionModel object);
  Future<void> deletetransactions(String id);
  Future<void> restartapptransaction();
}

class TransactionDb implements TransactionDbFn {
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();

  factory TransactionDb() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionlistnotifire =
      ValueNotifier([]);
  //=========notifire for filtrisation===========================\\
  ValueNotifier<List<TransactionModel>> transactionIncomeonlyNotifire =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> transactionExpnsenotifire =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> transactiontodayonlynotifire =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> transactionwithinAMonthNotifire =
      ValueNotifier([]);

  @override
  Future<void> addtransaction(TransactionModel object) async {
    final db = await Hive.openBox<TransactionModel>(trnasactionDbName_);

    await db.put(object.id, object);
  }

  @override
  Future<List<TransactionModel>> gettransaction() async {
    final db = await Hive.openBox<TransactionModel>(trnasactionDbName_);

    return db.values.toList();
  }

  @override
  Future<void> deletetransactions(String id) async {
    final transatinDb =
        await Hive.openBox<TransactionModel>(trnasactionDbName_);
    transatinDb.delete(id);
    refreshtransaction();
  }

  @override
  Future<void> restartapptransaction() async {
    final transationDb =
        await Hive.openBox<TransactionModel>(trnasactionDbName_);

    transactionlistnotifire.value.clear();
    transactionIncomeonlyNotifire.value.clear();
    transactionExpnsenotifire.value.clear();
    transactiontodayonlynotifire.value.clear();
    transactionwithinAMonthNotifire.value.clear();

    await transationDb.clear();

    refreshtransaction();
    //  print('reset');
  }

  Future<void> refreshtransaction() async {
    final list = await gettransaction();
    allincomeamount();
    allexpenseamount();
    todayexpensetotalamout();
    todayallincomeTransactionAmount();
    transactionExpnsenotifire.addListener(() {
      allincomeamount();
    });

    list.sort((first, second) => second.date.compareTo(first.date));
    transactionlistnotifire.value.clear();
    transactionwithinAMonthNotifire.value.clear();
    transactionIncomeonlyNotifire.value.clear();
    transactionExpnsenotifire.value.clear();
    transactiontodayonlynotifire.value.clear();

    transactionlistnotifire.value.addAll(list);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    transactionlistnotifire.notifyListeners();

    await Future.forEach(list, (TransactionModel data) {
      //==filtrisaction for todaytransaction============================================
      if (data.date ==
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
        transactiontodayonlynotifire.value.add(data);
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        transactiontodayonlynotifire.notifyListeners();
      }
      //===============filtrisation for monthly transactions==============================
      if (data.date.month == DateTime.now().month) {
        transactionwithinAMonthNotifire.value.add(data);
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        transactionwithinAMonthNotifire.notifyListeners();
      }

//===========total income=================
      if (data.type == CategoriesType.income) {
        transactionIncomeonlyNotifire.value.add(data);

        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        transactionIncomeonlyNotifire.notifyListeners();
      }
      //================total expense======================
      else {
        transactionExpnsenotifire.value.add(data);
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        transactionExpnsenotifire.notifyListeners();
      }
    });
  }

//   ===============all income total amount==================
  double allincomeamount() {
    var sumincomeAmount = 0;
    for (var value in transactionlistnotifire.value) {
      if (value.type == CategoriesType.income) {
        sumincomeAmount = sumincomeAmount + value.amount.toInt();
      }
    }
    return sumincomeAmount.toDouble();
  }

//  ===============all expense total amount==================
  double allexpenseamount() {
    var sumexpenseAmount = 0;
    for (var value in transactionlistnotifire.value) {
      if (value.type == CategoriesType.expense) {
        sumexpenseAmount = sumexpenseAmount + value.amount.toInt();
      }
    }
    return sumexpenseAmount.toDouble();
  }

  double balance() {
    var balance1 = 0;
    var sumincomeAmount = 0;
    var sumexpenseAmount = 0;
    for (var value in transactionlistnotifire.value) {
      if (value.type == CategoriesType.expense) {
        sumexpenseAmount = sumexpenseAmount + value.amount.toInt();
      }
    }

    for (var value in transactionlistnotifire.value) {
      if (value.type == CategoriesType.income) {
        sumincomeAmount = sumincomeAmount + value.amount.toInt();
      }
    }

    balance1 = sumincomeAmount - sumexpenseAmount;
    return balance1.toDouble();
  }

  double todayallincomeTransactionAmount() {
    double sumincometodaytransaction = 0;
    for (var value in transactiontodayonlynotifire.value) {
      if (value.type == CategoriesType.income) {
        sumincometodaytransaction =
            sumincometodaytransaction + value.amount.toInt();
      }
    }

    return sumincometodaytransaction;
  }

  double todayexpensetotalamout() {
    double sumexpensetoday = 0;
    for (var value in transactiontodayonlynotifire.value) {
      if (value.type == CategoriesType.expense) {
        sumexpensetoday = sumexpensetoday + value.amount.toInt();
      }
    }

    return sumexpensetoday;
  }

  double monthlyexpenseamount() {
    double sumexpensetoday = 0;
    for (var value in transactionwithinAMonthNotifire.value) {
      if (value.type == CategoriesType.expense) {
        sumexpensetoday = sumexpensetoday + value.amount.toInt();
      }
    }

    return sumexpensetoday;
  }

  double monthlyincomeamount() {
    double sumexpensetoday = 0;
    for (var value in transactionwithinAMonthNotifire.value) {
      if (value.type == CategoriesType.income) {
        sumexpensetoday = sumexpensetoday + value.amount.toInt();
      }
    }

    return sumexpensetoday;
  }



//=====================lists==============
List<CategoriesModel> incomecategorylist =
    CategoriesDb.instance.incomecategorieslistlistner.value;

    List<CategoriesModel> expensecategorylist =
    CategoriesDb.instance.expensecategorieslistlistner.value;
}
