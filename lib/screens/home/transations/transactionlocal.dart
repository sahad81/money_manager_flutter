

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/screens/home/transations/transationsationsonly.dart';

import '../../../models/transations/model_transations.dart';
import 'add_Transation/add_transation_screen.dart';

class transatction extends StatefulWidget {
  transatction({Key? key}) : super(key: key);

  @override
  State<transatction> createState() => _transatctionState();
}

class _transatctionState extends State<transatction> {

  late double amountbalance = 0;
 late  double  amountincome=0;
 late   double amountexpense=0;
  // ignore: unused_element


@override
  void initState() {
       catagories_db().refreshfuntion();
  
      
  
    super.initState();
  }
// ignore: prefer_typinguninitialized_variables
  @override
  Widget build(BuildContext context) {
    TransationDb.instance.refreshtransaction();
    catagories_db.instance.refreshfuntion();
    

    return ValueListenableBuilder(
      
    valueListenable: TransationDb.instance.transationlistnotifire,
    builder: (BuildContext cnt, List<transation_model> newlist, Widget? _) {
     
      amountincome =  TransationDb.instance.allincomeamount();
      amountexpense=TransationDb.instance.allexpenseamount();
      amountbalance=TransationDb.instance.balance();
      return Scaffold(
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title:  const Text(
            'MONEY MANAGER',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(onPressed: (){}, icon:Icon(Icons.search))
          ],
          
        ),
        
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            
              Navigator.of(context).pushNamed(add_transations.routname);
            
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          
        ),
        body: Column(
          
          //  mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 09,
              margin: EdgeInsets.only(left: 12,right: 12,top: 12),
                decoration: const BoxDecoration(
                    color:Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      'Total Balance',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22.00,fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 12,),
                    Text(
                      'Rs  $amountbalance',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 26.00,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
              Padding(
                padding: const EdgeInsets.only(left: 35,bottom: 30),
                child: incomeandexpenseAmount(amountincome, Colors.green, "Income"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30,right: 40),
                child:  incomeandexpenseAmount(amountexpense, Colors.red, "Expense"),
              ),
              
                        ]
                    ),
                    
                  ],
                )
                ),
                newlist.isEmpty?
                
const SizedBox():
                Align(
                  alignment:Alignment.centerRight,
                  child: TextButton(onPressed: (){
                    
Navigator.push(context,MaterialPageRoute(builder: (context){
  return Viewall(); 
}));
                  }, child:const Text('view all',style: TextStyle(color: Colors.black),))),
//Divider(),
        
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.only(
        
                    bottom: 10,
                  ),
                  // ignore: non_constant_identifier_names
                  itemBuilder: (context, Index) {
                   final  vAlue = newlist[Index];
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
                                            color: Color.fromARGB(
                                                255, 32, 28, 28)),
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
                                                  .deletetransactions(
                                                      vAlue.id!);
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
                      child: ListTile(
                        
                        leading: CircleAvatar(
                            radius: 40,
                            backgroundColor:
                                vAlue.type == catagories_type.income
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
                              padding:
                                  const EdgeInsets.only(bottom: 5, top: 3),
                              child:
                                  Text("Category: ${vAlue.catogoryT.name}"),
                            ),
                          ],
                        ),
                        // trailing: vAlue.type==catagories_type.income? Icon(CupertinoIcons.down_arrow,color: Colors.green,)
                        // :Icon(CupertinoIcons.up_arrow,color: Colors.red,)
                      ),
                    );
                  },
                                    separatorBuilder: (cont, index1) {
                    return Divider(thickness: 2,);                  },
                  
                  itemCount: newlist.length<5?newlist.length:5 ),
            ),
          ],
        ),
      );
    });
  }


  Widget incomeandexpenseAmount(
   double amount,
   Color color,
   String incomeorexpense,
  ){
    return     Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
        
             Text(
              incomeorexpense,
              style: TextStyle(
                  fontSize: 22, color:color, fontWeight: FontWeight.w700),
            ),
            // child: Text("Rs 2000",style: TextStyle(fontSize: 20,color: Colors.white),),
            const SizedBox(
              height: 5,
            ),

            Text(
             "Rs $amount",
              style:  TextStyle(
                  fontSize: 20, color:color, fontWeight: FontWeight.w700),
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
}
