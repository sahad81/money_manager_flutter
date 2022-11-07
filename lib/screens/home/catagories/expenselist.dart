
import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';

import '../../../models/catogaries/modelcatogaries.dart';


class Expenselist extends StatelessWidget {
  Expenselist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return 
     ValueListenableBuilder(valueListenable:catagories_db().expense_catogarieslistlistner ,
      builder: (BuildContext conxt, List<Catogariesmodel>newlist , Widget?_) {
      return  ListView.separated(itemBuilder: ((context, index) {
        final category =newlist[index];
      return 
       ListTile(title:Text(category.name,style: const TextStyle(fontWeight: FontWeight.bold),) ,
       trailing:IconButton(icon:const Icon(Icons.delete),onPressed: () {
final nameofordlete=category.name;
        showDialog(context: context, builder: (BuildContext context){
      return   AlertDialog(
               title: const Text('Delete',style: TextStyle(fontSize: 18),
               ),
               content: Text('are you sure to delete the $nameofordlete expense category?'),
               actions: [
 TextButton(onPressed: (){
                   Navigator.of(context).pop();
                 }, child: const Text('cancel')),

                TextButton(onPressed: (){
                  catagories_db.instance.deletecatagories(category.id);
                  Navigator.of(context).pop();
                },
                 child: const Text('delete')),
                
               ]
          );
        }
        
        
        );
         
       },)
        // Icon(Icons.delete,color: Colors.black,),
       );
  }
       ), separatorBuilder:(context, index)

     =>

     
     Column(children:const [ 
     Padding(
       padding: EdgeInsets.only(left: 15,right: 15),
       child: Divider(thickness: 2,),
     ),
     ]
     
     )
      ,
       itemCount: newlist.length);
   
       
     });
  }
}