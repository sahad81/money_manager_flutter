import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
part 'model_transations.g.dart';
// ignore: camel_case_types
@HiveType(typeId: 3)
class TransactionModel{


@HiveField(0)
final String purpose;

@HiveField(1)
final double amount;

@HiveField(2)
late final DateTime date;

@HiveField(3)
 final CategoriesType type;

@HiveField(4)
final CategoriesModel catogoryT;

@HiveField(5)
String? id; 

@HiveField(6)
List? idlist;
  TransactionModel({
    required this.purpose,
 required  this.amount,
  required this.date,
  required this.type,
  required this.catogoryT
}){
  id=DateTime.now().microsecondsSinceEpoch.toString();
  idlist;
}


}