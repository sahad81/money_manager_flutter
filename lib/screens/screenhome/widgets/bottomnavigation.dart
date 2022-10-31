import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moneymanagement/screens/screenhome/screen_home.dart';

// ignore: camel_case_types
class bottimnavigationbar extends StatelessWidget {
   bottimnavigationbar({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      
      valueListenable: homescreen.selectedvaluenotifier,
      builder: (BuildContext context , int updateintex, Widget?_){
return  BottomNavigationBar(
  selectedItemColor: Colors.black,
  
        currentIndex: updateintex,
        onTap: (newindex){
          homescreen.selectedvaluenotifier.value=newindex;
        }   ,
        items: const [
      BottomNavigationBarItem(icon:Icon(Icons.home) ,
      label:'transactions'),
      BottomNavigationBarItem(icon: Icon(Icons.category),
      label: 'categories'),
       ] );

      },
    );
  }
}