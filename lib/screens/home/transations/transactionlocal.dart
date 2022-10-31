//import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/key.dart';
 //import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import '../../../models/transations/model_transations.dart';

class transatction extends StatelessWidget {
  final listT =List<transation_model>;
 // static const routname ='transation1';
 
   transatction({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    TransationDb.instance.refreshtransation();
    catagories_db.instance.refreshfuntion();
   
    return 
    
   
         ValueListenableBuilder(valueListenable:TransationDb.instance.transationlistnotifire ,
         
          builder: (BuildContext cnt, List<transation_model> newlist, Widget? _){
            
          return 
          
    
          
            
          
              
               ListView.separated(
                       padding: const EdgeInsets.only(top: 10,bottom: 10,),
                       // ignore: non_constant_identifier_names
                       itemBuilder:(context,Index){
                final vAlue =newlist[Index];
               final String purposename =vAlue.purpose;
                 return  Slidable(
                       key:Key( vAlue.id!),
                       startActionPane: ActionPane(motion: const ScrollMotion(),
                       
                 children:[
                       SlidableAction(onPressed: (cnt){
                //TransationDb.instance.deletetransations(vAlue.id!);
                showDialog(context: context, builder: (BuildContext context){
                       return   AlertDialog(
                         title:  Text('Delete',style: TextStyle(fontSize: 18),
                         ),
                         content:  Text('are you sure to delete $purposename transaction?',style: TextStyle(color: Color.fromARGB(255, 32, 28, 28)),),
                         actions: [
                TextButton(onPressed: (){
                             Navigator.of(context).pop();
                           }, child: const Text('cancel')),
               
                          TextButton(onPressed: (){
                            TransationDb.instance.deletetransations(vAlue.id!);
                            Navigator.of(context).pop();
                          },
                           child: const Text('delete')),
                          
                         ]
                    );
                  }
                
                  
                  );
                       },label:'delete' ,icon: Icons.delete,)
                       ]),
                       child: Card(
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
                // trailing: vAlue.type==catagories_type.income? Icon(CupertinoIcons.down_arrow,color: Colors.green,)
                // :Icon(CupertinoIcons.up_arrow,color: Colors.red,)
                ),
                ),
                       
                 );
                 }, separatorBuilder: (cont,index1){
                       return const SizedBox(height: 10,);
                 }, itemCount: newlist.length);
                
               
         
         }
          );
      
     }  
    }
      //----------------//parsedate//-------------------
String parsedate(DateTime date){
var _date= DateFormat.MMMd().format(date);
final splitedate=_date.split(' ');
 
  return '${splitedate.last}\n${splitedate.first}'; 
}

 

