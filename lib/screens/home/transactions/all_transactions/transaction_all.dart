import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/screens/home/transactions/add_Transation/provider_add_transaction.dart';
import 'package:moneymanagement/screens/home/transactions/all_transactions/all_transaction_provider.dart';
import 'package:provider/provider.dart';
import '../../../../funtions/transactionfn/transaction.dart';
import '../../../../models/transations/model_transations.dart';

 


// ignore: must_be_immutable
class Viewall extends StatelessWidget {
   Viewall({super.key});
 TextEditingController? seachcontroloer = TextEditingController();
 

   @override
  Widget build(BuildContext context) {
final sizeh=MediaQuery.of(context).size.height;

    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionlistnotifire,
        builder: (BuildContext cnt, List<TransactionModel> newlist, Widget? _) {
          
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: const Text(
                'Transactions',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Align(
                  alignment: Alignment.center,
                  child: Consumer<ProviderAllTransaction>(
                    builder: (context, value, child) => 
                     DropdownButton(
                      underline:const SizedBox(),
                      elevation: 1,
                      value: value.dropdownvalues,
                      hint: const Text(
                        'All Transactions',
                        style: TextStyle(color: Colors.black),
                      ),
                      dropdownColor: Colors.white,
                      items: value.items
                          .map((dynamic vAlue) => DropdownMenuItem(
                                value: vAlue,
                                child: Text(
                                  vAlue,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ))
                          .toList(),
                      onChanged: (newL) {
                    value.filter(newL);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: seachcontroloer,
                    onChanged: (value) => searchfuntion(value,context),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none),
                        hintText: "Search.....",
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                  ),                                                                                        
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        itemBuilder: (context, index) {
                          final vAlue = Provider.of<ProviderAllTransaction>(context).dropdowntransaction[index];
                          final String purposename = vAlue.purpose;
                          return Slidable(
                              key: Key(vAlue.id!),
                              startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (cnt) {
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
                                                    'are you sure to delete $purposename transaction?',
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
                              child: Card(
                                child: ListTile(
                                    onTap: () {
                                      {
                                        showDialog(
                                          context: context,
                                          builder: ((context) {
                                            return SimpleDialog(
                                                contentPadding:
                                                    const EdgeInsets.all(18),
                                                title: const Text('Details'),
                                                children: [
                                                  Text(
                                                      'Amount   : ${vAlue.amount}'),
                                                   SizedBox(
                                                    height: sizeh*0.012
                                                  ),
                                                  Text(
                                                      'Category : ${vAlue.catogoryT.name}'),
                                                   SizedBox(
                                               height: sizeh*0.012
                                                  ),
                                                  Text(
                                                      'Date         : ${parsedateforpopup(vAlue.date)}'),
                                                   SizedBox(
                                                   height: sizeh*0.012
                                                  ),
                                                  Text(
                                                      'notes       : ${vAlue.purpose}'),
                                                ]);
                                          }),
                                        );
                                      }
                                    },
                                    leading: Text(parsedate(vAlue.date)),
                                    title: Text(
                                        "Category: ${vAlue.catogoryT.name}"),
                                    trailing:
                                        vAlue.type == CategoriesType.income
                                            ? Text(
                                                "+ ₹ ${vAlue.amount}",
                                                style: const TextStyle(
                                                    color: Colors.green),
                                              )
                                            : Text(
                                                "- ₹ ${vAlue.amount}",
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              )),
                              ));
                        },
                        separatorBuilder: (cont, index1) {
                          return const SizedBox();
                        },
                        itemCount: Provider.of<ProviderAllTransaction>(context).dropdowntransaction.length),
                  ),
                )
              ]),
            ),
          );
        });
  }

//================search===============\\
  void searchfuntion(String keywords ,BuildContext context) {
    final provider =Provider.of<ProviderAllTransaction>(context,listen: false);
    if (keywords.isEmpty) {
      provider.filterr = provider.transactions;
    } else {
      provider.filterr = provider.transactions
          .where((element) => element.catogoryT.name
              .trim()
              .toLowerCase()
              .contains(keywords.trim().toLowerCase()))
          .toList();
    }
provider.filternotify();

  }
}

//----------------//parsedate//-------------------
String parsedate(DateTime date) {
  var dateo = DateFormat.MMMd().format(date);
  final splitedate = dateo.split(' ');

  return '${splitedate.last}\n${splitedate.first}';
}

String parsedateforpopup(DateTime date) {
  var datelocal = DateFormat.yMMMMEEEEd().format(date);
  return datelocal;
}



 


 