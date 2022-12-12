import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';
import 'package:moneymanagement/funtions/transactionfn/transaction.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/screens/graph/d_chart.dart';
import 'package:moneymanagement/screens/home/transactions/home_balance_card_page.dart';

class Incomelist extends StatelessWidget {
  const Incomelist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoriesDb().incomecategorieslistlistner,
        builder:
            (BuildContext conxt, List<CategoriesModel> newlist, Widget? _) {
          return TransactionDb.instance.incomecategorylist.isEmpty
              ? Column(
                  children: const [
                    Expanded(
                        child: Center(
                            child: Text(
                      "No income categories added",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ))),
                  ],
                )
                //---------showing income category list------------------//
              : ListView.separated(
                  itemBuilder: ((context, index) {
                    final category = newlist[index];
                    return
             
                        Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Card(
                        child: ListTile(
                            title: Text(category.name),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                final nameofordlete = category.name;
                                //--------- deleting category------------------//
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: const Text(
                                            'Delete',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          content: Text(
                                              'are you sure to delete the $nameofordlete income category?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'cancel',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  CategoriesDb.instance
                                                      .deletecategories(
                                                          category.id);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'delete',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )),
                                          ]);
                                    });
                              },
                            )),
                      ),
                    );
                  }),
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemCount: newlist.length);
        });
  }

}
