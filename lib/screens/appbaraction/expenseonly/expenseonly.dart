



import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import '../../../funtions/catagories_fn_db/transation.dart';
import '../../home/transations/transationsationsonly.dart';

class ExpenseOnly extends StatelessWidget {
  const ExpenseOnly({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    TransationDb.instance.refreshtransaction();
    catagories_db.instance.refreshfuntion();
  
    return 
   
     ValueListenableBuilder(valueListenable:TransationDb.instance.transationExpnsenotifire ,
      builder: (BuildContext cnt, List<transation_model> newlist, Widget? _){
      return  
       Scaffold(
    
         body: ListView.separated(
          padding: const EdgeInsets.only(top: 10,bottom: 10,),
          itemBuilder:(context,index){
            final v_alue =newlist[index];
             
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
                                              'Purpose : ${v_alue.purpose}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Amount   : ${v_alue.ammount}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Category : ${v_alue.catogoryT.name}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Date      : ${parsedateforpopup(v_alue.date)}'),
                                        ]);
                                  }),
                                );
                              }
                            },
                                leading: CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        v_alue.type == catagories_type.income
                                            ? Colors.green
                                            : Colors.red,
                                    child: Text(
                                      parsedate(v_alue.date),
                                      textAlign: TextAlign.center,
                                    )),
                                title: Text("Name: ${v_alue.purpose}"),
                                subtitle:
                                    Text("Category: ${v_alue.catogoryT.name}"),
                                trailing: v_alue.type == catagories_type.income
                                    ? Text(
                                        "+ ₹ ${v_alue.ammount}",
                                        style: const TextStyle(
                                            color: Colors.green),
                                      )
                                    : Text(
                                        "- ₹ ${v_alue.ammount}",
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
var _date= DateFormat.MMMd().format(date);
final splitedate=_date.split(' ');
 
  return '${splitedate.last}\n${splitedate.first}'; 
}

 

}