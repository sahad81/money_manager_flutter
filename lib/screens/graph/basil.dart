
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';


class Graph2 extends StatefulWidget {
  const Graph2({super.key});

  @override
  State<Graph2> createState() => _Graph2State();
}

class _Graph2State extends State<Graph2> {
List<MaterialColor> colorList =[
  Colors.red,
  Colors.green,
  Colors.grey
  
];
List<String>items=[
 'Expense',
 'Income'
 'Balance'

];
List<transation_model>transation=TransationDb.instance.transationlistnotifire.value;
List<catogaries_model>expenselist=catagories_db.instance.expense_catogarieslistlistner.value;
List<catogaries_model>inccotogary=catagories_db.instance.income_catogarieslistlistner.value;

String ?selecteditems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
     Column(
      children: [
       PieChart(
        PieChartData(
          centerSpaceRadius: 70
,
sectionsSpace: 5,
sections: []
// sections: [
// for(var i=0; i<inccotogary.length;i++)
// // PieChartSectionData(
// //   title: TransationDb.instance.()[i].
// // )
// ]
        )
       )
      ],
     )
      ],
    );
  }
}