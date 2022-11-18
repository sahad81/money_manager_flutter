

import 'package:flutter/material.dart';

import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';
import 'package:moneymanagement/screens/home/catagories/category_add_popup.dart';
import 'package:moneymanagement/screens/home/catagories/expenselist.dart';
import 'package:moneymanagement/screens/home/catagories/incomlist.dart';


class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> with SingleTickerProviderStateMixin{
  late TabController _tabController;
@override
  void initState() {
    _tabController=TabController(length: 2, vsync: this);
    CategoriesDb().refreshfuntion();
  
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
              children: const [ 
              
           Incomelist(),
           Expenselist(),
                 ] ),
          )
        ],
      ),
    );
  }
}