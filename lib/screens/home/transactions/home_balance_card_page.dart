import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';
import 'package:moneymanagement/funtions/transactionfn/transaction.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';

import 'package:moneymanagement/screens/home/transactions/add_Transation/add_transation_screen.dart';
import 'package:moneymanagement/screens/home/transactions/add_Transation/provider_add_transaction.dart';
import 'package:moneymanagement/screens/home/transactions/all_transactions/all_transaction_provider.dart';
import 'package:moneymanagement/screens/home/transactions/all_transactions/transaction_all.dart';
import 'package:provider/provider.dart';

import '../../../const/const.dart';
import '../../../models/transations/model_transations.dart';

// ignore: must_be_immutable
class Transaction extends StatelessWidget {
   Transaction({super.key});
  late double amountbalance = 0;
  late double amountincome = 0;
  late double amountexpense = 0;

 @override
  Widget build(BuildContext context) {
  final  sizew =MediaQuery.of(context).size.width;
  final sizeh =MediaQuery.of(context).size.height;
    TransactionDb.instance.refreshtransaction();
    CategoriesDb.instance.refreshfuntion();

    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionlistnotifire,
        builder: (BuildContext cnt, List<TransactionModel> newlist, Widget? _) {
          amountincome = TransactionDb.instance.allincomeamount();
          amountexpense = TransactionDb.instance.allexpenseamount();
          amountbalance = TransactionDb.instance.balance();
          return Scaffold(
          
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title:  Text(
                appname,
                style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
  Provider.of<Addtrasactionprovider>(context,listen: false).initstate();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (con) {
            //  
                    return AddTransactions();
                  }),
                );
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    width: sizew * 09,
                    margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
                    decoration: const BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: Column(
                      children: [
                         SizedBox(
                          height:sizeh*0.02,
                        ),
                         Text(
                          'Total Balance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: sizeh*0.025,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Text(
                          '₹  $amountbalance',
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                              fontSize: sizeh*0.029,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                         SizedBox(height: sizeh*0.013),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, bottom: 20),
                                child: incomeandexpenseAmount(context,amountincome,
                                    Colors.white, Colors.green, "Income"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, right: 30),
                                child: incomeandexpenseAmount(context,amountexpense,
                                    Colors.white, Colors.red, "Expense"),
                              ),
                            ]),
                      ],
                    )),
                newlist.isEmpty
                    ? const SizedBox()
                  
                   :
                       Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                               
                   Provider.of<ProviderAllTransaction>(context,listen: false).initstate();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return  Viewall();
                                }));
                              },
                              child: const Text(
                                'View all',
                                style: TextStyle(color: Colors.black),
                              ))),
                  
//Divider(),
                if (newlist.isEmpty)
                  const Expanded(
                      child: Center(
                          child: Text(
                    "NO DATA TO SHOW",
                    style: TextStyle(color: Colors.grey),
                  )))
                else
                  Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        itemBuilder: (context, index) {
                          final vAlue = newlist[index];
                          final String categoryname = vAlue.catogoryT.name;
                          return Slidable(
                              key: Key(vAlue.id!),
                              startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (cnt) {
                                        //-------for delete transacttions--------
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title: const Text(
                                                    'Delete',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  content: Text(
                                                    'are you sure to delete $categoryname transaction?',
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 32, 28, 28)),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                          'cancel',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          TransactionDb.instance
                                                              .deletetransactions(
                                                                  vAlue.id!);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            'delete',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black))),
                                                  ]);
                                            });
                                      },
                                      label: 'delete',
                                      icon: Icons.delete,
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 5),
                                child: Card(
                                  child: ListTile(
                                      onTap: () {
                                        {
                                          //--------------- show details-----------------------
                                          showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return SimpleDialog(
                                                  contentPadding:
                                                      const EdgeInsets.all(18),
                                                  title: const Text('Details'),
                                                  children: [
                                                    Text(
                                                        'Notes      : ${vAlue.purpose}'),
                                                     SizedBox(
                                                      height: sizeh*0.013,
                                                    ),
                                                    Text(
                                                        'Amount   : ${vAlue.amount}'),
                                                     SizedBox(
                                                      height: sizeh*0.013,
                                                    ),
                                                    Text(
                                                        'Category : ${vAlue.catogoryT.name}'),
                                                     SizedBox(
                                                      height: sizeh*0.013,
                                                    ),
                                                    Text(
                                                        'Date         : ${parsedateforpopup(vAlue.date)}'),
                                                  ]);
                                            }),
                                          );
                                        }
                                      },
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child:
                                            Text(parsedateforpopup(vAlue.date)),
                                      ),
                                      title: Text(
                                          vAlue.catogoryT.name),
                                      trailing:
                                          vAlue.type == CategoriesType.income
                                              ? Text(
                                                  "+ Rs ${vAlue.amount}",
                                                  style: const TextStyle(
                                                      color: Colors.green),
                                                )
                                              : Text(
                                                  "- Rs ${vAlue.amount}",
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                )),
                                ),
                              ));
                        },
                        separatorBuilder: (cont, index1) {
                          return const SizedBox();
                        },
                        itemCount: newlist.length < 5 ? newlist.length : 5),
                  ),
              ],
            ),
          );
        });
  }

//----------------car show income and expense-------------------
  Widget incomeandexpenseAmount(
    BuildContext context,
    double amount,
    Color color2,
    Color color,
    String incomeorexpense,
  ) 

  {
    final sizeh=MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          incomeorexpense,
          style: TextStyle(
            fontSize: sizeh*0.025,
            color: color,
          ),
        ),
         SizedBox(
          height:  sizeh*0.005,
        ),
        Text(
          "₹ $amount",
          style: TextStyle(
            fontSize:sizeh*0.0225,
            color: color2,
          ),
        ),
      ],
    );
  }

  //----------------//parsedate//-------------------
  String parsedate(DateTime date) {
    var datelocal = DateFormat.yMMMMEEEEd().format(date);
    return datelocal;
  }
}
