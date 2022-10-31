import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/screens/home/catagories/incom.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../funtions/catagories_fn_db/transation.dart';
import '../../models/transations/model_transations.dart';

class Graph extends StatefulWidget {
  Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  late final double hii;

  int key = 0;

  List<MaterialColor> ColorList = [
    Colors.red,
    Colors.green,
  ];
 
          @override
  void initState() {
  
    super.initState();
  }       
             

  @override
  Widget build(BuildContext context) {
    TransationDb.instance.refreshtransation();
    return ValueListenableBuilder(
        valueListenable: TransationDb.instance.transationlistnotifire,
        builder: (BuildContext cnt, List<transation_model> newlist, Widget? _) {

 
   const double income1 =0 ;
    const double expense=0;
    
                 Future.forEach(newlist, ( transation_model income) {
                  if(income.type==catagories_type.income){
                  setState(() {
                      income1.toDouble() + 1;
                  });
                 
                  }
                 });
                    Future.forEach(newlist, ( transation_model expense1) {
                  if(expense1.type==catagories_type.expense){
                  
                   expense.toDouble() + 1;
                  }
                 });
                    Map<String, double> datamab = {
                  'income': income1,
                  //catagories_type.income,
                  'expense': expense
                  // catagories_type.income
                };
      
          return Scaffold(
              appBar: AppBar(
                title: Center(child: Text('pieChart ')),
                backgroundColor: Colors.black,
              ),
              body:
              //  ListView.builder(itemBuilder: (context, index)
              //  {
              
               //  final vale = newlist[index];

                 
                
                // // var lengthofindex= vale.type;
                // // lengthofindex=catagories_type.expense;

              //  return
              PieChart(
                 dataMap: datamab,
                  initialAngleInDegree: 0,
                  animationDuration: const Duration(milliseconds: 999),
                  chartType: ChartType.disc,
                  chartRadius: MediaQuery.of(context).size.width / 1.4,
                  ringStrokeWidth: 69,
                  colorList: ColorList,
                  chartLegendSpacing: 30,
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesOutside: false,
                    showChartValueBackground: false,
                    showChartValues: true,
                  ),
                  centerText: "spending",
                  legendOptions: const LegendOptions(
                      showLegends: true,
                      showLegendsInRow: false,
                      legendShape: BoxShape.circle,
                      legendPosition: LegendPosition.bottom,
                      legendTextStyle: TextStyle(color: Colors.white)),
                ) 
              
             
              );
                  
          //f
        });
  }



}
