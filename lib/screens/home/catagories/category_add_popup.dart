

import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';

 
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart'; 

ValueNotifier<catagories_type>selected_catagoriesNotifire=ValueNotifier(catagories_type.expense);
final name_editing_controler=TextEditingController();

Future<void>showpopupADD(BuildContext context)async{

  showDialog(context: context, builder: (cntx){
return SimpleDialog(
  title: const Text('ADD CATEGORY'),
  children: [
  
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   TextFormField(
  controller: name_editing_controler ,
    decoration: const InputDecoration(
      hintText: 'Add category',
   
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.black),

    ),
      contentPadding:EdgeInsets.all(8) ,
  
     
  
    ),
  
  
  
  ),
),
  Padding(padding: const EdgeInsets.all(8),
    child: Row(
      children:  const [
        RadioButton(titile: 'INCOME', type: catagories_type.income),
         RadioButton(titile: 'EXPENSE',type: catagories_type.expense),
      
      ],
    ),
    ),
    
Padding(
  padding: const EdgeInsets.all(8),
  child:   ElevatedButton
  
  
  
  (
    
     onPressed: (){

final _name=name_editing_controler.text;
if(_name.isEmpty)
{
return;
} 
  final typ=selected_catagoriesNotifire.value;
  final catagory= Catogariesmodel(id: DateTime.now().microsecondsSinceEpoch.toString(),name: _name,type:typ);
  catagories_db() .incertCatagories(catagory);
  catagories_db.instance.expense_catogarieslistlistner;
   catagories_db.instance.income_catogarieslistlistner;
  Navigator.of(cntx).pop();
  name_editing_controler.clear;
 catagories_db().refreshfuntion();
 
 },style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,), child: const Text('ADD')
  
  ),
)
  ],
);
  },
  );
 }


 
 class RadioButton extends StatelessWidget {
final String titile;
final  catagories_type type;



  const RadioButton({Key? key, required this.titile, required this.type}) : super(key: key);


  
  @override
  Widget build(BuildContext context) {
   return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
     children: [
       ValueListenableBuilder(valueListenable: selected_catagoriesNotifire, builder: (BuildContext context,
       catagories_type newcatagory,Widget? _){
      return  Radio<catagories_type>(value:type ,
        fillColor:
        MaterialStateColor.resolveWith((states) => Colors.black),
      groupValue:newcatagory,
         onChanged: (value){
          if(value==null){
            return;
          } 
  
          selected_catagoriesNotifire.value=value;
          selected_catagoriesNotifire.notifyListeners();
         }
         );
       })
       ,
        Text(titile) 
     ],
   ); 
  }
}