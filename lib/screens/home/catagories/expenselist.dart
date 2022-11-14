
import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';

import '../../../models/catogaries/modelcatogaries.dart';


class Expenselist extends StatelessWidget {
const  Expenselist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return 
     ValueListenableBuilder(valueListenable:CategoriesDb().expensecategorieslistlistner ,
      builder: (BuildContext conxt, List<CategoriesModel>newlist , Widget?_) {
      return  ListView.separated(itemBuilder: ((context, index) {
        final category =newlist[index];
      return 
       ListTile(title:Text(category.name ,) ,
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
                 }, child: const Text('cancel',style: TextStyle(color: Colors.black))),

                TextButton(onPressed: (){
                  CategoriesDb.instance.deletecategories(category.id);
                  Navigator.of(context).pop();
                },
                 child: const Text('delete',style: TextStyle(color: Colors.black))),
                
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