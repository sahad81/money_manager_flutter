
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';  
import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';




class incomeonly extends StatelessWidget {
   incomeonly({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    TransationDb.instance.refreshtransaction();
    catagories_db.instance.refreshfuntion();
   
    return 
   
     ValueListenableBuilder(valueListenable:TransationDb.instance.transationIncomeonlyNotifire ,
      builder: (BuildContext cnt, List<transation_model> newlist, Widget? _){
      return  
       Scaffold(
  
         body: ListView.separated(
          padding: EdgeInsets.only(top: 10,bottom: 10,),
          itemBuilder:(context,index){
            final v_alue =newlist[index];
             
            return  
           ListTile(
                
               leading: CircleAvatar(child: Text(parsedate(v_alue.date),
               textAlign: TextAlign.center,),
               radius:40,
               backgroundColor: v_alue.type==catagories_type.income? Colors.green : Colors.red
               ),
               title:  Text( "Name: " + v_alue.purpose),
               subtitle:
                   Column(
                    
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                Text('Rs ${(v_alue.ammount)}'),
                       
                       Padding(
                         padding: const EdgeInsets.only(  top: 6),
                         child: Text("Category: ${v_alue.catogoryT.name}"),
                       ),
                     ],
                   ),
               
               );
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