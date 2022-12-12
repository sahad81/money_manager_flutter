import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';
import 'package:moneymanagement/funtions/transactionfn/transaction.dart';
import 'package:moneymanagement/screens/graph/d_chart.dart';

import '../../../models/catogaries/modelcatogaries.dart';

class Expenselist extends StatelessWidget {
  const Expenselist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoriesDb().expensecategorieslistlistner,
        builder:
            (BuildContext conxt, List<CategoriesModel> newlist, Widget? _) {
          return 
          TransactionDb.instance.incomecategorylist.isEmpty?
          Column(
            children: const [
              Expanded(
                child: Center(child: Text("No expense category added"  ,  style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),),),
              )
            ],
          )
          
          
          :
          ListView.separated(
              itemBuilder: ((context, index) {
                final category = newlist[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Card(
                    child: ListTile(
                        title: Text(
                          category.name,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            final nameofordlete = category.name;
                            //---------deleting expense category------------------//
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: const Text(
                                        'Delete',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      content: Text(
                                          'are you sure to delete the $nameofordlete expense category?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('cancel',
                                                style: TextStyle(
                                                    color: Colors.black))),
                                        TextButton(
                                            onPressed: () {
                                              CategoriesDb.instance
                                                  .deletecategories(
                                                      category.id);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('delete',
                                                style: TextStyle(
                                                    color: Colors.black))),
                                      ]);
                                });
                          },
                        )
                        // Icon(Icons.delete,color: Colors.black,),
                        ),
                  ),
                );
              }),
              separatorBuilder: (context, index) => const SizedBox(),
              itemCount: newlist.length);
        });
  }
}
