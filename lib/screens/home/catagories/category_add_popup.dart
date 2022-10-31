

import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';

 
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart'; 

ValueNotifier<catagories_type>selected_catagoriesNotifire=ValueNotifier(catagories_type.expense);
final name_editing_controler=TextEditingController();

Future<void>showpopupADD(BuildContext context)async{

  showDialog(context: context, builder: (cntx){
return SimpleDialog(
  title: Text('ADD CATEGORY'),
  children: [
  
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   TextFormField(
  controller: name_editing_controler ,
    decoration: const InputDecoration(
      hintText: 'Add your category',
  
      contentPadding:EdgeInsets.all(8) ,
  
      border: OutlineInputBorder()
  
    ),
  
  
  
  ),
),
  Padding(padding: const EdgeInsets.all(8),
    child: Row(
      children:  const [
        radioButton(titile: 'INCOME', type: catagories_type.income),
         radioButton(titile: 'EXPENSE',type: catagories_type.expense),
      
      ],
    ),
    ),
    
Padding(
  padding: const EdgeInsets.all(8),
  child:   ElevatedButton
  
  
  
  ( onPressed: (){

final _name=name_editing_controler.text;
if(_name.isEmpty)
{
return;
} 
  final _typ=selected_catagoriesNotifire.value;
  final _catagory= catogaries_model(id: DateTime.now().microsecondsSinceEpoch.toString(),name: _name,type:_typ);
  catagories_db() .incertCatagories(_catagory);
  Navigator.of(cntx).pop();

 }, child: Text('ADD')
  
  ),
)
  ],
);
  },
  );
 }


 
 class radioButton extends StatelessWidget {
final String titile;
final  catagories_type type;



  const radioButton({Key? key, required this.titile, required this.type}) : super(key: key);


  
  @override
  Widget build(BuildContext context) {
   return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
     children: [
       ValueListenableBuilder(valueListenable: selected_catagoriesNotifire, builder: (BuildContext context,
       catagories_type newcatagory,Widget? _){
      return  Radio<catagories_type>(value:type ,
      groupValue:newcatagory,
         onChanged: (value){
          if(value==null){
            return;
          } 
          print(value);
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