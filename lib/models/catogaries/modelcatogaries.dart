
import 'package:hive_flutter/hive_flutter.dart';
part 'modelcatogaries.g.dart';

@HiveType(typeId: 2)
enum catagories_type {
  @HiveField(0)
  expense,
  @HiveField(1)
  income,
}
@HiveType(typeId: 1)
class catogaries_model{
   @HiveField(0)
   final String id;
   @HiveField(1)
  final String name;
  @HiveField(2)
  final bool is_deleted;
  @HiveField(3)
  final catagories_type type;
  

  // ignore: non_constant_identifier_names
  catogaries_model({required this.id,  required this.name, this.is_deleted =false,required this.type});

 @override
  String toString() {
    
    return '{$name $type}';
  }
}