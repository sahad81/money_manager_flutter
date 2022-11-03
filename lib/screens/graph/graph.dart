
import 'package:flutter/material.dart';

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

  List<MaterialColor> colorList = [
    
    Colors.green,
    Colors.red,
      Colors.grey
  ];
 
          @override
  void initState() {
  
    super.initState();
  }       
             

  @override
  Widget build(BuildContext context) {
    TransationDb.instance.refreshtransaction();
    return ValueListenableBuilder(
        valueListenable: TransationDb.instance.transationlistnotifire,
        builder: (BuildContext cnt, List<transation_model> newlist, Widget? _) {

 
 
             
               
                    Map<String, double> datamab = {
                  'Income': TransationDb.instance.allincomeamount(),
                  //catagories_type.income,
                  'Expense': TransationDb.instance.allexpenseamount(),
                  "Balance": TransationDb.instance.balance()
                  // catagories_type.income
                };
      
          return Scaffold(
              appBar: AppBar(
                title: const Center(child: Text('Chart')),
                backgroundColor: Colors.black,
              ),
              body:
          
              PieChart(
                 dataMap: datamab,
                  initialAngleInDegree: 0,
                  animationDuration: const Duration(milliseconds: 999),
                  chartType: ChartType.disc,
                  chartRadius: MediaQuery.of(context).size.width / 1.4,
                  ringStrokeWidth: 69,
                  colorList: colorList,
                  chartLegendSpacing: 30,
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesOutside: true,
                    showChartValueBackground: true,
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