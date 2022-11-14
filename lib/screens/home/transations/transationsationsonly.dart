
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/screens/filtrisation/expenseonly/expenseonly.dart';
import 'package:moneymanagement/screens/filtrisation/today/today.dart';
import 'package:moneymanagement/screens/filtrisation/transationWithInAmonth/month.dart';
import 'package:moneymanagement/screens/home/transations/transactionlocal.dart';

import '../../../funtions/catagories_fn_db/transation.dart';
import '../../../models/transations/model_transations.dart';
import '../../filtrisation/incomeonly/incomeonly.dart';

class Viewall extends StatefulWidget {
  const Viewall({super.key});

  @override
  State<Viewall> createState() => _ViewallState();
}

class _ViewallState extends State<Viewall> {
  // ignore: prefer_typing_uninitialized_variables
  var  dropdownvalues;
   List<dynamic> items=["Today","Income","Expense","Month","All"];


List<TransactionModel> filter=[
  
];
void updatelist(String value){
  
}
ValueNotifier<List<TransactionModel>> transactions =
    TransactionDb.instance.transactionlistnotifire;


void searchfuntion(String keywords){
 
if(keywords.isEmpty){
  filter=transactions as List<TransactionModel>;
}

}

TextEditingController? seachcontroloer=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionlistnotifire,
        builder: (BuildContext cnt, List<TransactionModel> newlist, Widget? _) {
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
  Padding(
   padding: const EdgeInsets.all(8.0),
   child: TextField(
    controller: seachcontroloer,
    onChanged: (value)=>searchfuntion(value),
    style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
    filled: true,
    fillColor: Colors.grey,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none
    ),
    hintText: "Search.....",hintStyle:const TextStyle(color: Colors.black),
    prefixIcon: const Icon(Icons.search,color: Colors.black,)
),


   ),
 ),
              dropdownvalues==null? 
                  Expanded(
                    
                    child: ListView.separated(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                     
                        itemBuilder: (context, index) {
                          final vAlue = newlist[index];
                          final String purposename = vAlue.purpose;
                          return Slidable(
                            key: Key(vAlue.id!),
                            startActionPane:
                                ActionPane(motion: const ScrollMotion(), children: [
                              SlidableAction(
                                onPressed: (cnt) {
                                 
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
                                                  child: const Text('cancel',style: TextStyle(color: Colors.black),)),
                                              TextButton(
                                                  onPressed: () {
                                                    TransactionDb.instance
                                                        .deletetransactions(vAlue.id!);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('delete',style: TextStyle(color: Colors.black))),
                                            ]);
                                      });
                                },
                                label: 'delete',
                                icon: Icons.delete,
                              )
                            ]),
                            child: 
                             
                          ListTile(
                            onTap: (){
                              {
                                showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return SimpleDialog(
                                        contentPadding:
                                            const EdgeInsets.all(18),
                                        title: const Text('Details'),
                                        children: [
                                          Text(
                                              'Purpose : ${vAlue.purpose}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Amount   : ${vAlue.amount}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Category : ${vAlue.catogoryT.name}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Date      : ${parsedateforpopup(vAlue.date)}'),
                                        ]);
                                  }),
                                );
                              }
                            },
                                leading: CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        vAlue.type == CategoriesType.income
                                            ? Colors.green
                                            : Colors.red,
                                    child: Text(
                                      parsedate(vAlue.date),
                                      textAlign: TextAlign.center,
                                    )),
                                title: Text("Name: ${vAlue.purpose}"),
                                subtitle:
                                    Text("Category: ${vAlue.catogoryT.name}"),
                                trailing: vAlue.type == CategoriesType.income
                                    ? Text(
                                        "+ ₹ ${vAlue.amount}",
                                        style: const TextStyle(
                                            color: Colors.green),
                                      )
                                    : Text(
                                        "- ₹ ${vAlue.amount}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ))
                        
                            
                          );
                        },
                        separatorBuilder: (cont, index1) {
                          return const Divider(
                            thickness: 2,
                          );
                        },
                        itemCount: newlist.length),
                  ):
            dropdownvalues=="Month"?
            const Expanded(child:Month() 
            )
          //
            :dropdownvalues=="Today"? const Expanded(
              child: Today()) 
                  :dropdownvalues=="Income"?
                    const Expanded(child:  Incomeonly())
                    :dropdownvalues== "Expense"?
                       const Expanded(child: ExpenseOnly())
                       :dropdownvalues=="All"? Expanded(child: 
                       ListView.separated(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                       
                        itemBuilder: (context, index) {
                          final vAlue = newlist[index];
                          final String purposename = vAlue.purpose;
                          return Slidable(
                            key: Key(vAlue.id!),
                            startActionPane:
                                ActionPane(motion: const ScrollMotion(), children: [
                              SlidableAction(
                                onPressed: (cnt) {
                                  
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
                                                    TransactionDb.instance
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
                             onTap: (){
                              {
                                showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return SimpleDialog(
                                        contentPadding:
                                            const EdgeInsets.all(18),
                                        title: const Text('Details'),
                                        children: [
                                          Text(
                                              'Purpose  : ${vAlue.purpose}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Amount   : ${vAlue.amount}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Category : ${vAlue.catogoryT.name}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Date         : ${parsedateforpopup(vAlue.date)}'),
                                        ]);
                                  }),
                                );
                              }
                            },
                                leading: CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        vAlue.type == CategoriesType.income
                                            ? Colors.green
                                            : Colors.red,
                                    child: Text(
                                      parsedate(vAlue.date),
                                      textAlign: TextAlign.center,
                                    )),
                                title: Text("Name: ${vAlue.purpose}"),
                                subtitle:
                                    Text("Category: ${vAlue.catogoryT.name}"),
                                trailing: vAlue.type == CategoriesType.income
                                    ? Text(
                                        "+ ₹ ${vAlue.amount}",
                                        style: const TextStyle(
                                            color: Colors.green),
                                      )
                                    : Text(
                                        "- ₹ ${vAlue.amount}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ))

                        
                            
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

  String parsedateforpopup(DateTime date) {
    var datelocal = DateFormat.yMMMMEEEEd().format(date);
    return datelocal;
  }
