import 'package:flutter/material.dart';

import 'package:charts_flutter_new/flutter.dart' as chartp;
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';
import 'package:moneymanagement/funtions/transactionfn/transaction.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';
import 'package:moneymanagement/screens/graph/staticprovider.dart';
import 'package:moneymanagement/screens/graph/todey_month_chart.dart';
import 'package:provider/provider.dart';

class Chart2 extends StatelessWidget {
  Chart2({super.key});

  // ignore: prefer_typing_uninitialized_variables

  // dropdownvalue = 1;

  @override
  Widget build(BuildContext context) {
    final List<Graphhh> data = [
      Graphhh("income", TransactionDb.instance.allincomeamount(), Colors.green),
      Graphhh("expense", TransactionDb.instance.allexpenseamount(),
          const Color.fromRGBO(244, 67, 54, 1))
    ];
    TransactionDb.instance.refreshtransaction;
    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionlistnotifire,
        builder: (BuildContext cnt, List<TransactionModel> newlist, Widget? _) {
          List<chartp.Series<Graphhh, String>> series = [
            chartp.Series(
                data: data,
                id: "graph",
                domainFn: (Graphhh h, _) => h.text,
                measureFn: (Graphhh h, _) => h.value,
                colorFn: (Graphhh h, _) =>
                    chartp.ColorUtil.fromDartColor(h.colors))
          ];

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Center(
                  child: Text(
                'MONEY MANAGER',
                style: TextStyle(color: Colors.white),
              )),
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.grey.shade200,
            body: Column(
              children: [
                Consumer<Staticprovider>(
                  builder: (context, value, child) => DropdownButton(
                      hint: const Text("Total "),
                      elevation: 5,
                      dropdownColor: Colors.grey,
                      underline: const SizedBox(),
                      value: value.dropdownvalue,
                      items: const [
                        DropdownMenuItem(value: 1, child: Text("Total")),
                        DropdownMenuItem(value: 2, child: Text("today")),
                        DropdownMenuItem(value: 3, child: Text("Monthly")),
                      ],
                      onChanged: (valuee) {
                        value.onchange(valuee);
                      }),
                ),
                Provider.of<Staticprovider>(context, listen: true)
                            .dropdownvalue ==
                        2
                    ? Expanded(
                        child: Graph(
                        expenseamount:
                            TransactionDb.instance.todayexpensetotalamout(),
                        incomeamount: TransactionDb.instance
                            .todayallincomeTransactionAmount(),
                      ))
                    : Provider.of<Staticprovider>(context, listen: true)
                                .dropdownvalue ==
                            3
                        ? Expanded(
                            child: Graph(
                                incomeamount: TransactionDb.instance
                                    .monthlyincomeamount(),
                                expenseamount: TransactionDb.instance
                                    .monthlyexpenseamount()))
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 60, right: 10, left: 10),
                                child: Center(
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TransactionDb
                                              .instance
                                              .transactionlistnotifire
                                              .value
                                              .isEmpty
                                          ? const Center(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 120),
                                                child: Center(
                                                    child: Text(
                                                  'Not enough Data to display',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                )),
                                              ),
                                            )
                                          : chartp.BarChart(
                                              series,
                                              animate: true,
                                            )),
                                ),
                              ),
                            ],
                          ),
              ],
            ),
          );
        });
  }
}

class Graphhh {
  String text;
  double value;
  Color colors;

  Graphhh(this.text, this.value, this.colors);
}
