  import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';



const catagories_db_name='catogaries_datanase';

abstract class catagories_db_fn{

Future<List <Catogariesmodel>> getcatogaries();

Future<void> incertCatagories(Catogariesmodel value);
 Future <void> deletecatagories (String catagoriesid);
 Future<void> deleteallcatogories(List deleteall);
  }
class catagories_db implements catagories_db_fn{
  catagories_db.intenal();
  static catagories_db instance =catagories_db.intenal();
  factory catagories_db(){
    return instance; 
  }

 ValueNotifier<List<Catogariesmodel>>income_catogarieslistlistner=ValueNotifier([]);
 ValueNotifier<List<Catogariesmodel>>expense_catogarieslistlistner=ValueNotifier([]);
  @override
  Future<void> incertCatagories(Catogariesmodel value)async {
    final categoriesDB= await Hive.openBox<Catogariesmodel>(catagories_db_name);
await categoriesDB.put(value.id,value);
refreshfuntion();
  }
  
  @override
  Future<List<Catogariesmodel>> getcatogaries() async {
   final categoriesDB= await Hive.openBox<Catogariesmodel>(catagories_db_name);
   return categoriesDB.values.toList();
  }
Future<void> refreshfuntion()async{
 final allcatogaries=await getcatogaries();
 income_catogarieslistlistner.value.clear();
 expense_catogarieslistlistner.value.clear();
 await Future.forEach(allcatogaries, (Catogariesmodel category) {
if(category.type==catagories_type.income){
  income_catogarieslistlistner.value.add(category);
}else{
   expense_catogarieslistlistner.value.add(category);
}

 });
 // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
 income_catogarieslistlistner.notifyListeners();
 // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
 expense_catogarieslistlistner.notifyListeners();
}

  @override
  Future<void> deletecatagories(String catagoriesid)async {
    final _catagories_db =await Hive.openBox<Catogariesmodel>(catagories_db_name);
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
   final catocaryrestart_=await Hive.openBox<Catogariesmodel>(catagories_db_name);
  // transationDb_.deleteAll(iddeleteall);
    income_catogarieslistlistner.value.clear();
    expense_catogarieslistlistner.value.clear();
   await catocaryrestart_.clear();

   refreshfuntion();
//print('restart');
  }
  
}