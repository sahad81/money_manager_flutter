
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/screens/appbaraction/expenseonly/expenseonly.dart';
import 'package:moneymanagement/screens/appbaraction/today/today.dart';

import '../../../funtions/catagories_fn_db/transation.dart';
import '../../../models/transations/model_transations.dart';
import '../../appbaraction/incomeonly/incomeonly.dart';

class Viewall extends StatefulWidget {
  const Viewall({super.key});

  @override
  State<Viewall> createState() => _ViewallState();
}

class _ViewallState extends State<Viewall> {
  var dropdownvalues;
   List<dynamic> items=["Today","Income","Expense","Month","All"];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TransationDb.instance.transationlistnotifire,
        builder: (BuildContext cnt, List<transation_model> newlist, Widget? _) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                 mainAxisSize: MainAxisSize.max,
                children: [
 Align(
  alignment: Alignment.center,
   child: DropdownButton(
    elevation: 10,
    value: dropdownvalues,
    
      hint: const Text(
                              'All Transactions',
                              style: TextStyle(color: Colors.black),
                            ),
    dropdownColor: Colors.white,
    items:items.map((dynamic vAlue) =>DropdownMenuItem(
    value: vAlue,
   
    child: Text(vAlue,style: const TextStyle(color: Colors.black),),
   )).toList()
   
    , onChanged: (newL){
      setState(() {
        dropdownvalues=newL!.toString();
      });
    },
 
    ),
 ),
              dropdownvalues==null? 
                  Expanded(
                    
                    child: ListView.separated(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        // ignore: non_constant_identifier_names
                        itemBuilder: (context, Index) {
                          final vAlue = newlist[Index];
                          final String purposename = vAlue.purpose;
                          return Slidable(
                            key: Key(vAlue.id!),
                            startActionPane:
                                ActionPane(motion: const ScrollMotion(), children: [
                              SlidableAction(
                                onPressed: (cnt) {
                                  //TransationDb.instance.deletetransations(vAlue.id!);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: const Text(
                                              'Delete',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            content: Text(
                                              'are you sure to delete $purposename transaction?',
                                              style: const TextStyle(
                                                  color:
                                                      Color.fromARGB(255, 32, 28, 28)),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('cancel')),
                                              TextButton(
                                                  onPressed: () {
                                                    TransationDb.instance
                                                        .deletetransactions(vAlue.id!);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('delete')),
                                            ]);
                                      });
                                },
                                label: 'delete',
                                icon: Icons.delete,
                              )
                            ]),
                            child: 
                             
                            ListTile(
                              leading: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: vAlue.type == catagories_type.income
                                      ? Colors.green
                                      : Colors.red,
                                  child: Text(
                                    parsedate(vAlue.date),
                                    textAlign: TextAlign.center,
                                  )),
                              title: Text("Name: ${vAlue.purpose}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text('Rs ${(vAlue.ammount)}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5, top: 3),
                                    child: Text("Category: ${vAlue.catogoryT.name}"),
                                  ),
                                ],
                              ),
                              // trailing: vAlue.type==catagories_type.income? Icon(CupertinoIcons.down_arrow,color: Colors.green,)
                              // :Icon(CupertinoIcons.up_arrow,color: Colors.red,)
                            )

                        
                            
                          );
                        },
                        separatorBuilder: (cont, index1) {
                          return const Divider(
                            thickness: 2,
                          );
                        },
                        itemCount: newlist.length),
                  )
            
          //
            :dropdownvalues=="Today"? const Expanded(
              child: Today()) 
                  :dropdownvalues=="Income"?
                    Expanded(child:  incomeonly())
                    :dropdownvalues== "Expense"?
                       const Expanded(child: ExpenseOnly())
                       :dropdownvalues=="All"? Expanded(child: 
                       ListView.separated(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        // ignore: non_constant_identifier_names
                        itemBuilder: (context, Index) {
                          final vAlue = newlist[Index];
                          final String purposename = vAlue.purpose;
                          return Slidable(
                            key: Key(vAlue.id!),
                            startActionPane:
                                ActionPane(motion: const ScrollMotion(), children: [
                              SlidableAction(
                                onPressed: (cnt) {
                                  //TransationDb.instance.deletetransations(vAlue.id!);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: const Text(
                                              'Delete',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            content: Text(
                                              'are you sure to delete $purposename transaction?',
                                              style: const TextStyle(
                                                  color:
                                                      Color.fromARGB(255, 32, 28, 28)),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('cancel')),
                                              TextButton(
                                                  onPressed: () {
                                                    TransationDb.instance
                                                        .deletetransactions(vAlue.id!);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('delete')),
                                            ]);
                                      });
                                },
                                label: 'delete',
                                icon: Icons.delete,
                              )
                            ]),
                            child: 
                             
                            ListTile(
                              leading: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: vAlue.type == catagories_type.income
                                      ? Colors.green
                                      : Colors.red,
                                  child: Text(
                                    parsedate(vAlue.date),
                                    textAlign: TextAlign.center,
                                  )),
                              title: Text("Name: ${vAlue.purpose}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text('Rs ${(vAlue.ammount)}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5, top: 3),
                                    child: Text("Category: ${vAlue.catogoryT.name}"),
                                  ),
                                ],
                              ),
                              // trailing: vAlue.type==catagories_type.income? Icon(CupertinoIcons.down_arrow,color: Colors.green,)
                              // :Icon(CupertinoIcons.up_arrow,color: Colors.red,)
                            )

                        
                            
                          );
                        },
                        separatorBuilder: (cont, index1) {
                          return const Divider(
                            thickness: 2,
                          );
                        },
                        itemCount: newlist.length),
                       ):const SizedBox()]


              ),
            ),
          );
        });
  }
}
 

Widget incomeandexpenseAmount(
  double amount,
  Color color,
  String incomeorexpense,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        incomeorexpense,
        style:
            TextStyle(fontSize: 22, color: color, fontWeight: FontWeight.w700),
      ),
      // child: Text("Rs 2000",style: TextStyle(fontSize: 20,color: Colors.white),),
      const SizedBox(
        height: 5,
      ),

      Text(
        "Rs $amount",
        style:
            TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.w700),
      ),
    ],
  );
}

//----------------//parsedate//-------------------
String parsedate(DateTime date) {
  var dateo = DateFormat.MMMd().format(date);
  final splitedate = dateo.split(' ');

  return '${splitedate.last}\n${splitedate.first}';
}
