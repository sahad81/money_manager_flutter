import 'package:flutter/cupertino.dart';
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';
import 'package:moneymanagement/funtions/transactionfn/transaction.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';

class ProviderAllTransaction extends ChangeNotifier {
  // ignore: prefer_typing_uninitialized_variables
  var dropdownvalues;
  List<dynamic> items = ["Today", "Income", "Expense", "Month", "All"];
  List<TransactionModel> dropdowntransaction = [];
  List<TransactionModel> filterr = [];

  //-----------filtered list----------------\\-------
  List<TransactionModel> transactions =
      TransactionDb.instance.transactionlistnotifire.value;
  List<TransactionModel> incometranscaction =
      TransactionDb.instance.transactionIncomeonlyNotifire.value;
  List<TransactionModel> expenseTransactionList =
      TransactionDb.instance.transactionExpnsenotifire.value;
  List<TransactionModel> todaytransactionList =
      TransactionDb.instance.transactiontodayonlynotifire.value;
  List<TransactionModel> monthTreansactionlist =
      TransactionDb.instance.transactionwithinAMonthNotifire.value;

  void filter(var newL) {
    dropdownvalues = newL!.toString();
    if (dropdownvalues == null) {
      dropdowntransaction = transactions;
    } else if (dropdownvalues == "Expense") {
      dropdowntransaction = expenseTransactionList;
    } else if (dropdownvalues == "Today") {
      dropdowntransaction = todaytransactionList;
    } else if (dropdownvalues == "Month") {
      dropdowntransaction = monthTreansactionlist;
    } else if (dropdownvalues == "All") {
      dropdowntransaction = transactions;
    }
    if (dropdownvalues == "Income") {
      dropdowntransaction = incometranscaction;
    }

    notifyListeners();
  }

  void filternotify() {
    dropdowntransaction = filterr;
    notifyListeners();
  }

  void initstate() {
    dropdownvalues = "All";
    dropdowntransaction = transactions;
    notifyListeners();
  }

  void refreshfn() {
    TransactionDb.instance.refreshtransaction();
    CategoriesDb.instance.refreshfuntion();
    notifyListeners();
  }
}
