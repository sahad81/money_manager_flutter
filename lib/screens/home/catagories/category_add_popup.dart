

import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';

 
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart'; 

ValueNotifier<CategoriesType>selectedCategoriesNotifire=ValueNotifier(CategoriesType.expense);
final nameEditingControler=TextEditingController();

Future<void>showpopupADD(BuildContext context)async{

  showDialog(context: context, builder: (cntx){
return SimpleDialog(
  title: const Text('ADD CATEGORY'),
  children: [
  
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   TextFormField(
    textCapitalization: TextCapitalization.sentences,
  controller: nameEditingControler ,
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
        RadioButton(titile: 'INCOME', type: CategoriesType.income),
         RadioButton(titile: 'EXPENSE',type: CategoriesType.expense),
      
      ],
    ),
    ),
    
Padding(
  padding: const EdgeInsets.all(8),
  child:   ElevatedButton
  
  
  
  (
    
     onPressed: (){
CategoriesDb.instance.refreshfuntion();
final name=nameEditingControler.text;
if(name.isEmpty)
{
return;
} 
  final typ=selectedCategoriesNotifire.value;
  final catagory= CategoriesModel(id: DateTime.now().microsecondsSinceEpoch.toString(),name: name,type:typ);
  CategoriesDb() .incertCategories(catagory);
  CategoriesDb.instance.expensecategorieslistlistner;
   CategoriesDb.instance.incomecategorieslistlistner;
  Navigator.of(cntx).pop();
  nameEditingControler.clear;
 CategoriesDb().refreshfuntion();
 
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
final  CategoriesType type;



  const RadioButton({Key? key, required this.titile, required this.type}) : super(key: key);


  
  @override
  Widget build(BuildContext context) {
   return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
     children: [
       ValueListenableBuilder(valueListenable: selectedCategoriesNotifire, builder: (BuildContext context,
       CategoriesType newcatagory,Widget? _){
      return  Radio<CategoriesType>(value:type ,
        fillColor:
        MaterialStateColor.resolveWith((states) => Colors.black),
      groupValue:newcatagory,
         onChanged: (value){
          if(value==null){
            return;
          } 
  
          selectedCategoriesNotifire.value=value;
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          selectedCategoriesNotifire.notifyListeners();
         }
         );
       })
       ,
        Text(titile) 
     ],
   ); 
  }
}