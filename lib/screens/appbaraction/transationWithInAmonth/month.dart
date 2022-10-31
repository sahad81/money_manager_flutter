
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';

import '../../../funtions/catagories_fn_db/transation.dart';
import '../../../models/transations/model_transations.dart';

class Month extends StatelessWidget {
   const Month({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    TransationDb.instance.refreshtransation();
    catagories_db.instance.refreshfuntion();
   
    return 
   
     ValueListenableBuilder(valueListenable:TransationDb.instance.transationwithinAMonthNotifire ,
      builder: (BuildContext cnt, List<transation_model> newlist, Widget? _){
      return  
       Scaffold(
     appBar: AppBar(
  title:const Text( "Transactions within a month",style: TextStyle(
    color: Colors.black
  ),),
  centerTitle: true ,
  
  
) ,
         body: ListView.separated(
          padding: EdgeInsets.only(top: 10,bottom: 10,),
          itemBuilder:(context,index){
            final vAlue =newlist[index];
             
            return  
         
           Card(
            elevation: 0,
            child: ListTile(
                 
                leading: CircleAvatar(child: Text(parsedate(vAlue.date),
                textAlign: TextAlign.center,),
                radius:40,
                backgroundColor: vAlue.type==catagories_type.income? Colors.green : Colors.red
                ),
                title:  Padding(
                  padding: const EdgeInsets.only(bottom: 5,top: 4),
                  child: Text( "Name: " + vAlue.purpose),
                ),
                subtitle:
                    Column(
                     
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                 Text('Rs ${(vAlue.ammount)}'),
                        
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5,top: 6),
                          child: Text("Category: "+ vAlue.catogoryT.name),
                        ),
                      ],
                    ),
                
                ),
           );
            
            }, separatorBuilder: (cont,index1){
          return const SizedBox(height: 10,);
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