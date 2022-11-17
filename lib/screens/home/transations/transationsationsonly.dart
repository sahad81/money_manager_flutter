import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';

import '../../../funtions/catagories_fn_db/transation.dart';
import '../../../models/transations/model_transations.dart';

class Viewall extends StatefulWidget {
  const Viewall({super.key});

  @override
  State<Viewall> createState() => _ViewallState();
}

class _ViewallState extends State<Viewall> {
  List<TransactionModel> dropdowntransaction = [];
  // ignore: prefer_typing_uninitialized_variables
  var dropdownvalues;
  List<dynamic> items = ["Today", "Income", "Expense", "Month", "All"];

  List<TransactionModel> filter = [];
  void updatelist(String value) {}
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

  @override
  void initState() {
    dropdowntransaction = transactions;
    super.initState();
  }

  TextEditingController? seachcontroloer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionlistnotifire,
        builder: (BuildContext cnt, List<TransactionModel> newlist, Widget? _) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: const Text(
                'Transactions',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Align(
                  alignment: Alignment.center,
                  child: DropdownButton(
                    elevation: 10,
                    value: dropdownvalues,
                    hint: const Text(
                      'All Transactions',
                      style: TextStyle(color: Colors.black),
                    ),
                    dropdownColor: Colors.white,
                    items: items
                        .map((dynamic vAlue) => DropdownMenuItem(
                              value: vAlue,
                              child: Text(
                                vAlue,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (newL) {
                      setState(() {
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
                      });
                    },
                    onTap: () {
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: seachcontroloer,
                    onChanged: (value) => searchfuntion(value),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none),
                        hintText: "Search.....",
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        itemBuilder: (context, index) {
                          final vAlue = dropdowntransaction[index];
                          final String purposename = vAlue.purpose;
                          return Slidable(
                              key: Key(vAlue.id!),
                              startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (cnt) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title: const Text(
                                                    'Delete',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  content: Text(
                                                    'are you sure to delete $purposename transaction?',
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 32, 28, 28)),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                          'cancel',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          TransactionDb.instance
                                                              .deletetransactions(
                                                                  vAlue.id!);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            'delete',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black))),
                                                  ]);
                                            });
                                      },
                                      label: 'delete',
                                      icon: Icons.delete,
                                    )
                                  ]),
                              child: Card(
                                child: ListTile(
                                    onTap: () {
                                      {
                                        showDialog(
                                          context: context,
                                          builder: ((context) {
                                            return SimpleDialog(
                                                contentPadding:
                                                    const EdgeInsets.all(18),
                                                title: const Text('Details'),
                                                children: [
                                                  Text(
                                                      'Amount   : ${vAlue.amount}'),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      'Category : ${vAlue.catogoryT.name}'),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      'Date         : ${parsedateforpopup(vAlue.date)}'),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      'notes       : ${vAlue.purpose}'),
                                                ]);
                                          }),
                                        );
                                      }
                                    },
                                    leading: Text(parsedate(vAlue.date)),
                                    title: Text(
                                        "Category: ${vAlue.catogoryT.name}"),
                                    trailing:
                                        vAlue.type == CategoriesType.income
                                            ? Text(
                                                "+ ₹ ${vAlue.amount}",
                                                style: const TextStyle(
                                                    color: Colors.green),
                                              )
                                            : Text(
                                                "- ₹ ${vAlue.amount}",
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              )),
                              ));
                        },
                        separatorBuilder: (cont, index1) {
                          return const SizedBox();
                        },
                        itemCount: dropdowntransaction.length),
                  ),
                )
              ]),
            ),
          );
        });
  }


//================search===============\\
  void searchfuntion(String keywords) {
    if (keywords.isEmpty) {
      filter = transactions;
    } else {
      filter = transactions
          .where((element) => element.catogoryT.name
              .trim()
              .toLowerCase()
              .contains(keywords.trim().toLowerCase()))
          .toList();
    }
    setState(() {
      dropdowntransaction = filter;
    });
  }
}

//----------------//parsedate//-------------------
String parsedate(DateTime date) {
  var dateo = DateFormat.MMMd().format(date);
  final splitedate = dateo.split(' ');

  return '${splitedate.last}\n${splitedate.first}';
}

String parsedateforpopup(DateTime date) {
  var datelocal = DateFormat.yMMMMEEEEd().format(date);
  return datelocal;
}
