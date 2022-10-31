



import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';

import '../../../funtions/catagories_fn_db/transation.dart';

class Today extends StatelessWidget {
   const Today({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    TransationDb.instance.refreshtransation();
    catagories_db.instance.refreshfuntion();
   
    return 
   
     ValueListenableBuilder(valueListenable:TransationDb.instance.transationtodayonlynotifire ,
      builder: (BuildContext cnt, List<transation_model> newlist, Widget? _){
      return  
       Scaffold(
     appBar: AppBar(
  title:const Text( "Today's Transations",style: TextStyle(
    color: Colors.black
  ),),
  centerTitle: true ,
  
  
) ,
         body: ListView.separated(
          padding: EdgeInsets.only(top: 10,bottom: 10,),
          itemBuilder:(context,index){
            final v_alue =newlist[index];
             
            return 
           Card(
            elevation: 0,
            child:ListTile(
                 
                leading: CircleAvatar(child: Text(parsedate(v_alue.date),
                textAlign: TextAlign.center,),
                radius:40,
                backgroundColor: v_alue.type==catagories_type.income? Colors.green : Colors.red
                ),
                title:  Padding(
                  padding: const EdgeInsets.only(bottom: 5,top: 4),
                  child: Text( "Name: " + v_alue.purpose),
                ),
                subtitle:
                    Column(
                     
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                 Text('Rs ${(v_alue.ammount)}'),
                        
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5,top: 6),
                          child: Text("Category: "+ v_alue.catogoryT.name)
                        ),
                      ],
                    ),
                
                ),
           );
          
            }, separatorBuilder: (cont,index1){
          return const SizedBox(height: 10);
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