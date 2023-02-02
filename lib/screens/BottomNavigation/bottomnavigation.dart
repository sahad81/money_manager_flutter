import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:moneymanagement/screens/BottomNavigation/screen_home.dart';

// ignore: camel_case_types
class bottimnavigationbar extends StatelessWidget {
  const bottimnavigationbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Homescreen.selectedvaluenotifier,
      builder: (BuildContext context, int updateintex, Widget? _) {
        return Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GNav(
                tabBackgroundColor: Colors.grey.shade800,
                backgroundColor: Colors.black,
                gap: 8,
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
                    icon: Icons.category,
                    text: 'Category',
                  ),
                  GButton(
                    icon: Icons.bar_chart,
                    text: 'Statics',
                  ),
                  GButton(
                    icon: Icons.settings_outlined,
                    text: 'Settings',
                  ),
                ],
                selectedIndex: updateintex,
                onTabChange: (newindex) {
                  Homescreen.selectedvaluenotifier.value = newindex;
                }),
          ),
        );
      },
    );
  }
}
