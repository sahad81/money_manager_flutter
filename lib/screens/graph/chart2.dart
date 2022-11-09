import 'package:flutter/material.dart';

import 'package:charts_flutter_new/flutter.dart' as Chartp;
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';

class Chart2 extends StatefulWidget {
  const Chart2({super.key});

  @override
  State<Chart2> createState() => _Chart2State();
}

class _Chart2State extends State<Chart2> {
 
  @override
  Widget build(BuildContext context) {

  final List<Graphhh> data = [
    Graphhh("income",TransationDb.instance.allincomeamount(), Colors.green),
    Graphhh("expense", TransationDb.instance.allexpenseamount(), Color.fromRGBO(244, 67, 54, 1))
  ];

    TransationDb.instance.refreshtransaction;
return
 ValueListenableBuilder(
      
        valueListenable: TransationDb.instance.transationlistnotifire,
        builder: (BuildContext cnt, List<transation_model> newlist, Widget? _) {
      List<Chartp.Series<Graphhh, String>> series = [
      Chartp.Series(
          data: data,
          id: "graph",
          domainFn: (Graphhh h, _) => h.text,
          measureFn: (Graphhh h, _) => h.value,
          colorFn: (Graphhh h, _) =>
              Chartp.ColorUtil.fromDartColor(h.colors))
    ];

    
      
return 

 Scaffold(
  
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Center(child: Text('CHART')),
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
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Chartp.BarChart(series)),
        ),
      ),
    );
        }
        );}
}
 class Graphhh {
  String text;
  double value;
  Color colors;

  Graphhh(this.text, this.value, this.colors);
  
}
