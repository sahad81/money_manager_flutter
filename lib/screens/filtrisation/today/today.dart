import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';
import 'package:moneymanagement/screens/home/transations/transationsationsonly.dart';
import '../../../funtions/catagories_fn_db/transation.dart';

class Today extends StatelessWidget {
  const Today({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refreshtransaction();
    CategoriesDb.instance.refreshfuntion();

    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactiontodayonlynotifire,
        builder: (BuildContext cnt, List<TransactionModel> newlist, Widget? _) {
          return ListView.separated(
              itemBuilder: (context, index) {
                // ignore: non_constant_identifier_names
                final v_alue = newlist[index];

                return  ListTile(
                     onTap: (){
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
                                              'Purpose : ${v_alue.purpose}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Amount   : ${v_alue.amount}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Category : ${v_alue.catogoryT.name}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Date      : ${parsedateforpopup(v_alue.date)}'),
                                        ]);
                                  }),
                                );
                              }
                            },
                                leading: CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        v_alue.type == CategoriesType.income
                                            ? Colors.green
                                            : Colors.red,
                                    child: Text(
                                      parsedate(v_alue.date),
                                      textAlign: TextAlign.center,
                                    )),
                                title: Text("Name: ${v_alue.purpose}"),
                                subtitle:
                                    Text("Category: ${v_alue.catogoryT.name}"),
                                trailing: v_alue.type == CategoriesType.income
                                    ? Text(
                                        "+ ₹ ${v_alue.amount}",
                                        style: const TextStyle(
                                            color: Colors.green),
                                      )
                                    : Text(
                                        "- ₹ ${v_alue.amount}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ));
              },
              separatorBuilder: (cont, index1) {
                return const Divider(thickness: 2);
              },
              itemCount: newlist.length);
        });
  }

  //----------------//parsedate//-------------------
  String parsedate(DateTime date) {
    // ignore: no_leading_underscores_for_local_identifiers
    var _date = DateFormat.MMMd().format(date);
    final splitedate = _date.split(' ');

    return '${splitedate.last}\n${splitedate.first}';
  }
}
