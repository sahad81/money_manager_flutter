
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';

import '../../../models/catogaries/modelcatogaries.dart';


class expenselist extends StatelessWidget {
  const expenselist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return 
     ValueListenableBuilder(valueListenable:catagories_db().expense_catogarieslistlistner ,
      builder: (BuildContext conxt, List<catogaries_model>newlist , Widget?_) {
      return  ListView.separated(itemBuilder: ((context, index) {
        final Category =newlist[index];
      return 
       Card(
         child: ListTile(title:Text(Category.name) ,
         trailing:IconButton(icon:Icon(Icons.delete),onPressed: () {
final nameofordlete=Category.name;
          showDialog(context: context, builder: (BuildContext context){
      return   AlertDialog(
                 title: Text('Delete',style: TextStyle(fontSize: 18),
                 ),
                 content: Text('are you sure to delete the $nameofordlete expense category?'),
                 actions: [
 TextButton(onPressed: (){
                     Navigator.of(context).pop();
                   }, child: Text('cancel')),

                  TextButton(onPressed: (){
                    catagories_db.instance.deletecatagories(Category.id);
                    Navigator.of(context).pop();
                  },
                   child: Text('delete')),
                  
                 ]
            );
          }
        
          
          );
           
         },)
          // Icon(Icons.delete,color: Colors.black,),
         ),
       );
  }
       ), separatorBuilder:(context, index)

     =>

     
     Column(children:[ SizedBox(height: 5,),
     Divider(),
     ]
     
     )
      ,
       itemCount: newlist.length);
   
       
     });
  }
}