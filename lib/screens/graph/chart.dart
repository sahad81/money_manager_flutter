// import 'package:flutter/material.dart';

// import 'package:charts_flutter_new/flutter.dart' as chartpie;
// import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
// import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
// import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
// import 'package:moneymanagement/models/transations/model_transations.dart';


// class Piechart extends StatefulWidget {
//   const Piechart({super.key});

//   @override
//   State<Piechart> createState() => _PiechartState();
// }

// class _PiechartState extends State<Piechart> {
  
  
//  @override
//   Widget build(BuildContext context) {
// final bool animate;
//   final List<pie> data = [
//     pie("income",TransactionDb.instance.allincomeamount(), Colors.green),
//     pie("expense", TransactionDb.instance.allexpenseamount(), const Color.fromRGBO(244, 67, 54, 1))
//   ];
//     TransactionDb.instance.refreshtransaction;
// return
//  ValueListenableBuilder(
      
//         valueListenable: TransactionDb.instance.transactionlistnotifire,
//         builder: (BuildContext cnt, List<TransactionModel> newlist, Widget? _) {
//       List<chartpie.Series<pie, String>> series = [
//       chartpie.Series(
//           data: data,
//           id: "graph",
       
//           labelAccessorFn: (pie row,_)=>"${row.text}",
//          domainFn: (pie h, _) => h.text.toString(),
//           measureFn: (pie h, _) => h.value,
        
            
//               )
              
//     ];

    
      
// return 

//  Scaffold(
  
//               appBar: AppBar(
//                 automaticallyImplyLeading: false,
//                 title: const Center(child: Text('MONEY MANAGER')),
//                 backgroundColor: Colors.black,
//               ),
//       backgroundColor: Colors.grey.shade200,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 2,
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(10)),
//               child: chartpie.PieChart(series,
//               animate: true ,
//               animationDuration: const Duration(seconds: 6),

//               )
//         //       defaultRenderer: new chartpie.ArcRendererConfig(arcRendererDecorators: 
//         //       [
//         //   new chartpie.ArcLabelDecorator(
//         //       labelPosition: chartpie.ArcLabelPosition.outside)
//         // ])
//   //             behaviors: [
//   //               chartpie.DatumLegend(
//   //  showMeasures: true,
//   //  measureFormatter:(var value){
//   //   return value==null?"-":"${value}k";
//   //  }
//   //               )
//   //             ],
//   )),
              
//         ),
//  );
//         }
//         );}
// }
//  class pie {
//   String text;
//   double value;
//   Color colors;

// pie(this.text, this.value, this.colors);
  
// }
 