
//=================stateless==========================

// import 'package:flutter/material.dart';
// import 'package:moneymanagement/screens/home/category_screens/expenselist.dart';
// import 'package:moneymanagement/screens/home/category_screens/incomlist.dart';

// class ScreenCategory extends StatelessWidget {
//   const ScreenCategory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           bottom: const TabBar(
//             indicatorColor: Colors.white,
//             labelColor: Colors.white,
//             tabs: [
             
//               Tab(text: "INCOME"),
//               Tab(text: "EXPENSE"),
//             ],
//           ),
//           title:  Container(
//             width: MediaQuery.of(context).size.width,
//             color: Colors.yellow,
//               child: Text(
//             'MONEY MANAGER',
//             style: TextStyle(color: Colors.white),
//           )),
//         ),
//         body: const TabBarView(
//           children: [Incomelist(), Expenselist()],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:moneymanagement/const/const.dart';
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';
import 'package:moneymanagement/screens/home/category_screens/category_add_popup.dart';
import 'package:moneymanagement/screens/home/category_screens/expenselist.dart';
import 'package:moneymanagement/screens/home/category_screens/incomlist.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              appname,
              style: TextStyle(color: Colors.white,letterSpacing: 2),
            ),
          )),
      body: Column(
        children: [
          TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'INCOME',
                ),
                Tab(
                  text: 'EXPENSE',
                ),
              ]),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              Incomelist(),
              Expenselist(),
            ]),
          )
        ],
      ),
    );
  }
  
}