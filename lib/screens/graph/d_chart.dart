import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';

class Dchart extends StatefulWidget {
  const Dchart({super.key});
  @override
  State<Dchart> createState() => _DchartState();
}

List<CategoriesModel> incomecategorylist =
    CategoriesDb.instance.incomecategorieslistlistner.value;

    List<CategoriesModel> expensecategorylist =
    CategoriesDb.instance.expensecategorieslistlistner.value;
    
List<TransactionModel> incometransaction =
    TransactionDb.instance.transactionIncomeonlyNotifire.value;

class _DchartState extends State<Dchart> {
  var sum = 0;
  var sum2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
      
          child: ListView(
            children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: AspectRatio(
                    aspectRatio: 19 / 18,
                    child: DChartPie(
                      data: [
                        for (var i = 0; i < incometransaction.length; i++)

                          {
                            'domain': incometransaction[i].catogoryT.name,
                            'measure': sum + incometransaction[i].amount,
                          }

                 
                      
                      ],
                      fillColor: (pieData, index) => Colors.green.shade300,
                      labelColor: Colors.black,
                      labelPosition: PieLabelPosition.inside,
                      pieLabel: (Map<dynamic, dynamic> pidata, int? index) {
                        return pidata['domain'] +
                            ':' +
                             "\n" +
                            pidata['measure'].toString();
                      },
                      donutWidth: 100,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
