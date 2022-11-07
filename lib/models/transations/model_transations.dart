import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
part 'model_transations.g.dart';
// ignore: camel_case_types
@HiveType(typeId: 3)
class transation_model{


@HiveField(0)
final String purpose;

@HiveField(1)
final double ammount;

@HiveField(2)
late final DateTime date;

@HiveField(3)
 final catagories_type type;

@HiveField(4)
final Catogariesmodel catogoryT;

@HiveField(5)
String? id; 

@HiveField(6)
List? idlist;
  transation_model({
    required this.purpose,
 required  this.ammount,
  required this.date,
  required this.type,
  required this.catogoryT
}){
  id=DateTime.now().microsecondsSinceEpoch.toString();
  idlist;
}


}