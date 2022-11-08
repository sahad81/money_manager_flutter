

import 'package:flutter/material.dart';

import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/screens/home/catagories/category_add_popup.dart';
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
       
              showpopupADD(context);
            }
      ,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
 appBar:  AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title:  const Center(
            child: Text(
              'MONEY MANAGER',
              style: TextStyle(color: Colors.white),
            ),
          )),
      body: Column(
        children: [
          TabBar(
                   
            labelColor: Colors.black,
             unselectedLabelColor: Colors.grey,
    
            controller: _tabController,
            tabs: 
          
          const [
            Tab(text: 'INCOME',),
            Tab( text: 'EXPENSE',),
          ]
          ),
          Expanded (
            child: TabBarView(
              controller: _tabController ,
              children: [ 
              
           const Incomelist(),
           Expenselist(),
                 ] ),
          )
        ],
      ),
    );
  }
}