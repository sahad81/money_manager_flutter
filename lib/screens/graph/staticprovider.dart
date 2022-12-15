
import 'package:flutter/cupertino.dart';

class Staticprovider extends ChangeNotifier{

 var dropdownvalue;

onchange(value){
  dropdownvalue=value;
  notifyListeners();
  
}
oninit(BuildContext context){
dropdownvalue=1;
notifyListeners()
;}

}