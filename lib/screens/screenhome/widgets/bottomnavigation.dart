import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:moneymanagement/screens/screenhome/screen_home.dart';

// ignore: camel_case_types
class bottimnavigationbar extends StatelessWidget {
   bottimnavigationbar({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      
      valueListenable: homescreen.selectedvaluenotifier,
      builder: (BuildContext context , int updateintex, Widget?_){
 return  
   Container(
    color: Colors.black,
     child: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
       child: GNav(
        
  tabBackgroundColor: Colors.grey.shade800,
                   
                   
                        backgroundColor: Colors.black,
                       

                     gap: 8
                     ,
                    activeColor: Colors.white,
                    iconSize: 24,
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    tabs: const [
                      GButton(
                        icon: Icons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon:Icons.category ,
                        text: 'Category',
                      ),
                        GButton(
                        icon:Icons.bar_chart ,
                        text: 'Chart',
                      ),
                          GButton(
                        icon:Icons.settings_outlined ,
                        text: 'Settings',
                      ),
                    ],
                    selectedIndex: updateintex,
                    onTabChange: (newindex) {
                    
                      homescreen.selectedvaluenotifier.value=newindex;
                      }
 ),
     ),
   );
              },
            );
  }}
// BottomNavigationBar(
//   backgroundColor: Colors.black,  selectedItemColor: Colors.black,
//   showSelectedLabels: true,
//   selectedIconTheme: ,
//         currentIndex: updateintex,
//         onTap: (newindex){
//           homescreen.selectedvaluenotifier.value=newindex;
//         }   ,
//         items: const [
//       BottomNavigationBarItem(icon:Icon(Icons.home,color: Colors.white,) ,
//       label:'transactions'),
//       BottomNavigationBarItem(icon: Icon(Icons.category,color: Colors.white,),
//       label: 'categories'),
//        ] );

 