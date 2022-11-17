import 'package:flutter/material.dart';

import 'package:charts_flutter_new/flutter.dart' as chartp;
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';

class Chart2 extends StatefulWidget {
  const Chart2({super.key});

  @override
  State<Chart2> createState() => _Chart2State();
}

class _Chart2State extends State<Chart2> {
  List<CategoriesModel> incomecategorylist =
      CategoriesDb.instance.incomecategorieslistlistner.value;

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
              title: const Center(child: Text('MONEY MANAGER')),
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.grey.shade200,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: TransactionDb
                            .instance.transactionlistnotifire.value.isEmpty
                        ? Column(
                          children: const [
                            Expanded(
                                child: Center(
                                    child: Text(
                                'Not enough Data to display',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ))),
                          ],
                        )
                        : chartp.BarChart(
                            series,
                            animate: true,
                          )),
              ),
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
