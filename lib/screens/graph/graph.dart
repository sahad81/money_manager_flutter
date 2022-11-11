
import 'package:flutter/material.dart';

import 'package:pie_chart/pie_chart.dart';

import '../../funtions/catagories_fn_db/transation.dart';
import '../../models/transations/model_transations.dart';

class Graph extends StatefulWidget {
const Graph({super.key});

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
    TransactionDb.instance.refreshtransaction();
    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionlistnotifire,
        builder: (BuildContext cnt, List<TransactionModel> newlist, Widget? _) {

 
 
             
               
                    Map<String, double> datamab = {
                  'Income': TransactionDb.instance.allincomeamount(),
                  //catagories_type.income,
                  'Expense': TransactionDb.instance.allexpenseamount(),
                  
                  // catagories_type.income
                };
      
          return Scaffold(
            backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Center(child: Text('CHART')),
                backgroundColor: Colors.black,
              ),
              body:
          
              Column(
                children: [
                  const SizedBox(height: 100),
                  PieChart(
                    
                     dataMap: datamab,
                      initialAngleInDegree: 0,
                      animationDuration: const Duration(milliseconds: 2000),
                      chartType: ChartType.ring,
                      chartRadius: MediaQuery.of(context).size.width / 1.4,
                      ringStrokeWidth: 69,
                      colorList: colorList,
                      chartLegendSpacing: 30,
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
              ) 
              
             
              );
                  
          //f
        });
  }



}
