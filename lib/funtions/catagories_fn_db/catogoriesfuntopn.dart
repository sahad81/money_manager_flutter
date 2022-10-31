  import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';



const catagories_db_name='catogaries_datanase';

abstract class catagories_db_fn{

Future<List <catogaries_model>> getcatogaries();

Future<void> incertCatagories(catogaries_model value);
 Future <void> deletecatagories (String catagoriesid);
 Future<void> deleteallcatogories(List deleteall);
  }
class catagories_db implements catagories_db_fn{
  catagories_db.intenal();
  static catagories_db instance =catagories_db.intenal();
  factory catagories_db(){
    return instance; 
  }

 ValueNotifier<List<catogaries_model>>income_catogarieslistlistner=ValueNotifier([]);
 ValueNotifier<List<catogaries_model>>expense_catogarieslistlistner=ValueNotifier([]);
  @override
  Future<void> incertCatagories(catogaries_model value)async {
    final categoriesDB= await Hive.openBox<catogaries_model>(catagories_db_name);
await categoriesDB.put(value.id,value);
refreshfuntion();
  }
  
  @override
  Future<List<catogaries_model>> getcatogaries() async {
   final categoriesDB= await Hive.openBox<catogaries_model>(catagories_db_name);
   return categoriesDB.values.toList();
  }
Future<void> refreshfuntion()async{
 final allcatogaries=await getcatogaries();
 income_catogarieslistlistner.value.clear();
 expense_catogarieslistlistner.value.clear();
 await Future.forEach(allcatogaries, (catogaries_model category) {
if(category.type==catagories_type.income){
  income_catogarieslistlistner.value.add(category);
}else{
   expense_catogarieslistlistner.value.add(category);
}

 });
 income_catogarieslistlistner.notifyListeners();
 expense_catogarieslistlistner.notifyListeners();
}

  @override
  Future<void> deletecatagories(String catagoriesid)async {
    final _catagories_db =await Hive.openBox<catogaries_model>(catagories_db_name);
    _catagories_db.delete(catagoriesid);
    refreshfuntion();
    
  }
  
  @override
  Future<void> deleteallcatogories(List deleteall) async{
   
   final catogoriesdeleteall_= await Hive.openBox(catagories_db_name);
   catogoriesdeleteall_.deleteAll(deleteall);
    income_catogarieslistlistner.value.clear();
 expense_catogarieslistlistner.value.clear();
refreshfuntion();
  }
   Future<void>
   restarcatocaryapp() async {
   final catocaryrestart_=await Hive.openBox<catogaries_model>(catagories_db_name);
  // transationDb_.deleteAll(iddeleteall);
    income_catogarieslistlistner.value.clear();
    expense_catogarieslistlistner.value.clear();
   await catocaryrestart_.clear();

   refreshfuntion();
   print('restart');
  }
  
}