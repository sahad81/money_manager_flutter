  

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';



class add_transations extends StatefulWidget {
  static const routname ='add_transaction';


   add_transations({super.key});
  @override
  State<add_transations> createState() => _add_transationsState();
  
}

class _add_transationsState extends State<add_transations> {
  Widget sizedb=SizedBox(height: 20,);
   DateTime? selecteddate;
   catagories_type?_selectedcatagory;
   catogaries_model? _selected_catory_model;
   String? _catogariesID;
    var formKey = GlobalKey<FormState>();
   final _purposetexteditingControler =TextEditingController();
   final _AmounttexteditingControler =TextEditingController();

   late final  ammount;
   late final String purpose;
   late final datefirst;
  late final _parsedAmount;
  //  add_transations({
  //   this.selecteddate,
  //  });

   @override
  void initState() {
  _selectedcatagory =catagories_type.income;
  
    super.initState();
  }
//    String parsedate(DateTime date){
// var dateformated1= DateFormat.MMMd().format(date);
// final splitedate=dateformated1.split(' ');
 
//   return '${splitedate.last}\n${splitedate.first}'; 
  
// }

 bool _isValid = false;

  @override
  Widget build(BuildContext context) {
  

   
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      body: SafeArea(child: 
     Padding(
       padding: const EdgeInsets.all(15.0),
       child: Form(
        key: formKey,
        onChanged:(){
           final isValid = formKey.currentState!.validate();
           if(_isValid =isValid){
            setState(() {
              _isValid=isValid;
            });
           }
        } ,
         child: ListView(
          shrinkWrap: true,
       
          children: [
            sizedb,
            sizedb,
            sizedb,
            Center(
              child: Text('ADD TRANSACTIONS',style: GoogleFonts.lateef(textStyle: const TextStyle(decoration: TextDecoration.underline,
              decorationColor: Colors.black,
                  decorationThickness: 4,
                  decorationStyle:
                  TextDecorationStyle.dashed,
                fontSize: 35,color: Colors.black,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic
       
              )),
              ),
              
            ),
            sizedb,
            
          TextFormField(
            controller: _purposetexteditingControler,
            validator: ((value) {
              if(value!.isEmpty){
                return 'enter purpose of transaction';
              }
              return null;
            }),
              decoration: InputDecoration(
                fillColor: Colors.lightBlue[50],
                filled: true,
                labelText:'Purpose' ,labelStyle: const TextStyle(
                  
                ),
               
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(7),)
              ),
            ),
            sizedb,
            const SizedBox(height: 10,),
            TextFormField(
              validator: (value){
                 if (value!.isEmpty){
                 return 'enter Amount';
               }
                 return null; },
              controller: _AmounttexteditingControler,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: Colors.lightBlue[50],
                filled: true,
                labelText:'Amount' ,labelStyle: const TextStyle(
                  
                ),
               
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(7),)
              ),
            ),
             sizedb,
             
         TextButton.icon(onPressed: () {
          calender(context);
          
         }, icon: const Icon(Icons.calendar_today), label:  Text(selecteddate==null? 'select date'
         :parsedate(selecteddate!,).toString(),style: const TextStyle( color: Colors.blue ),)),
             
            
             
         Row(
          mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Row(
              children: [
                Radio(value:catagories_type.income, groupValue: _selectedcatagory, onChanged: (newvalue){
                  setState(() {
                    _selectedcatagory =catagories_type.income;  
                    _catogariesID=null; 
                  });
                }),
                const Text('INCOME')
              ],
             ),
             Row(
              children: [
                Radio(value:catagories_type.expense, groupValue: _selectedcatagory, onChanged: (newvalue){
                  setState(() {
                      _selectedcatagory=catagories_type.expense;
                      _catogariesID=null;
                  });
                 
                }),
              const Text('EXPENSE'),
       
       
              ],
             ),
            
           ],
         ),
       
         
         
         Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
       
             DropdownButton(
              style: const TextStyle(color: Colors.blue,fontSize: 17),
         hint: const Text('select category',style: TextStyle(color: Colors.blue),),
         value: _catogariesID,
         items: (_selectedcatagory==catagories_type.income?catagories_db().income_catogarieslistlistner
         : catagories_db().expense_catogarieslistlistner).value .map((e){
         return DropdownMenuItem(
           value: e.id,
           child:
          Text(e.name),
          onTap: (){
          _selected_catory_model=e;  
          },
          );
          
       }).toList(),
        onChanged: (selectedvalue){
         setState(() {
            _catogariesID = selectedvalue as String?; 
           
         });
        }),
       
           
            
           ],
         ),
           sizedb,
           
           
           ElevatedButton(onPressed: (){
           
           final isvalid =formKey.currentState!.validate();
           if(!isvalid){
            return;
           }
            addTransationfuntion (); 
      
           //  addtransationtntd();
           }, style:ElevatedButton.styleFrom(
             minimumSize: const Size(350, 50),
           maximumSize: const Size(350, 50),
           )
           , child: const Text('SUBMIT',style: TextStyle(
             fontSize: 20
           ),))
       
          ]),
       ),
     )
      ),
    );
  }



calender(BuildContext context)async{
    datefirst = await showDatePicker(
    
     context: context,
    initialDate:DateTime.now() , firstDate:DateTime.now().subtract(const Duration(days: 60)) ,
   lastDate:DateTime.now(),
   builder: (context, child) {
    return Theme(data: Theme.of(context).copyWith(
      colorScheme: const ColorScheme.light(
         primary: Colors.amberAccent, // <-- SEE HERE
      onPrimary: Color(0xffF02E65), // <-- SEE HERE
      onSurface: Color.fromARGB(255, 66, 125, 145),
      )  
    ), child: child!);
   } ,
   );
   if (datefirst==null){
    return;

   }else{
  //  print(datefirst.toString());

    setState(() {
      selecteddate= datefirst;
    });
   }

}

   Future<void>addTransationfuntion()async{
 
 purpose=_purposetexteditingControler.text;
 ammount =_AmounttexteditingControler.text;
if(purpose.isEmpty||ammount.isEmpty){
  return;
}if(_catogariesID==null){
  return;
}if(selecteddate==null){
  return;

}
 if(_selected_catory_model==null){
  return;
 }

  _parsedAmount =double.tryParse(ammount);
if(_parsedAmount==null){
  return;
}

 final model=  transation_model(
  purpose: purpose,
 ammount: _parsedAmount,
  date:selecteddate!,
   type: _selectedcatagory!,
    catogoryT: _selected_catory_model!);

//texttext(selecteddate!);
      TransationDb.instance.addtransation(model);
   //  print(purpose);
Navigator.of(context).pop();
TransationDb.instance.refreshtransation(); 



   }




   String parsedate(DateTime date){

 var datelocal=
  DateFormat. yMMMMEEEEd().format(date);
//final splitedate=_date.split(' ');
 return datelocal;
//  return '${splitedate.last}\n${splitedate.first}'; 
}


}
