
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';

import '../../home/transations/transationsationsonly.dart';




class Incomeonly extends StatelessWidget {
const   Incomeonly({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refreshtransaction();
    CategoriesDb.instance.refreshfuntion();
   
    return 
   
     ValueListenableBuilder(valueListenable:TransactionDb.instance.transactionIncomeonlyNotifire ,
      builder: (BuildContext cnt, List<TransactionModel> newlist, Widget? _){
      return  
       Scaffold(
  
         body: ListView.separated(
          padding: const EdgeInsets.only(top: 10,bottom: 10,),
          itemBuilder:(context,index){
           
            // ignore: no_leading_underscores_for_local_identifiers, unused_local_variable
            final _value =newlist[index];
             
            return  
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
                                              'Purpose : ${_value.purpose}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Amount   : ${_value.amount}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Category : ${_value.catogoryT.name}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Date      : ${parsedateforpopup(_value.date)}'),
                                        ]);
                                  }),
                                );
                              }
                            },
          
                                leading: CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        _value.type == CategoriesType.income
                                            ? Colors.green
                                            : Colors.red,
                                    child: Text(
                                      parsedate(_value.date),
                                      textAlign: TextAlign.center,
                                    )),
                                title: Text("Name: ${_value.purpose}"),
                                subtitle:
                                    Text("Category: ${_value.catogoryT.name}"),
                                trailing: _value.type == CategoriesType.income
                                    ? Text(
                                        "+ ₹ ${_value.amount}",
                                        style: const TextStyle(
                                            color: Colors.green),
                                      )
                                    : Text(
                                        "- ₹ ${_value.amount}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ));
            }, separatorBuilder: (cont,index1){
          return const Divider(thickness: 2,);
            }, itemCount: newlist.length),
       );
      
     });
    }
      //----------------//parsedate//-------------------
String parsedate(DateTime date){
var date_= DateFormat.MMMd().format(date);
final splitedate=date_.split(' ');
 
  return '${splitedate.last}\n${splitedate.first}';
}

 

}