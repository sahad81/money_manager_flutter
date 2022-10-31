

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/screens/home/catagories/expenselist.dart';
import 'package:moneymanagement/screens/home/catagories/incom.dart';

class screen_catogaries extends StatefulWidget {
   screen_catogaries({Key? key}) : super(key: key);
 


  @override
  State<screen_catogaries> createState() => _screen_catogariesState();
}

class _screen_catogariesState extends State<screen_catogaries> with SingleTickerProviderStateMixin {
 
 late TabController _tabController;
@override
  void initState() {
    _tabController=TabController(length: 2, vsync: this);
    catagories_db().refreshfuntion();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
                 
          labelColor: Colors.black,
           unselectedLabelColor: Colors.grey,

          controller: _tabController,
          tabs: 
        
        [
          Tab(text: 'INCOME',),
          Tab( text: 'EXPENSE',),
        ]
        ),
        Expanded (
          child: TabBarView(
            controller: _tabController ,
            children:[ 
            
         incomelist(),
         expenselist(),
               ] ),
        )
      ],
    );
  }
}