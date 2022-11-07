
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
class Catogariesmodel{
   @HiveField(0)
   final String id;
   @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isdeleted;
  @HiveField(3)
  final catagories_type type;
  

  // ignore: non_constant_identifier_names
  Catogariesmodel({required this.id,  required this.name, this.isdeleted =false,required this.type});

 @override
  String toString() {
    
    return '{$name $type}';
  }
}