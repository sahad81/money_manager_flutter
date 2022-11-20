import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';

import 'package:pie_chart/pie_chart.dart';

import '../../funtions/transactionfn/transaction.dart';
import '../../models/transations/model_transations.dart';

// ignore: must_be_immutable
class Graph extends StatefulWidget {
  Graph(
      {super.key,
      required this.incomeamount,
      required this.expenseamount,
      });

  final double incomeamount;
 
  final double expenseamount;

  List<CategoriesModel> incomecategorylist =
      CategoriesDb.instance.incomecategorieslistlistner.value;

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  int key = 0;

  List<MaterialColor> colorList = [Colors.green, Colors.red, Colors.grey];

  List<CategoriesModel> incomecategorylist =
      CategoriesDb.instance.incomecategorieslistlistner.value;

  @override
  Widget build(BuildContext context ) {
    TransactionDb.instance.refreshtransaction();
    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionlistnotifire,
        builder: (BuildContext cnt, List<TransactionModel> newlist, Widget? _) {
                    Map<String, double> datamab = {

           "income":widget.incomeamount,
                  'Expense':widget.expenseamount

                };

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  //   height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Card(
                    elevation: 6,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        PieChart(
                          dataMap: datamab,
                          initialAngleInDegree: 0,
                          animationDuration: const Duration(milliseconds: 2000),
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width / 1.7,
                          ringStrokeWidth: 69,
                          colorList: colorList,
                          chartLegendSpacing: 60,
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                          ),
                          legendOptions: const LegendOptions(
                              showLegends: true,
                              showLegendsInRow: false,
                              legendShape: BoxShape.circle,
                              legendPosition: LegendPosition.bottom,
                              legendTextStyle: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  //f

}
