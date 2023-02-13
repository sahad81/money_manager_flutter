// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';
import 'package:moneymanagement/funtions/transactionfn/transaction.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';

import 'package:moneymanagement/screens/home/category_screens/category_add_popup.dart';
import 'package:moneymanagement/screens/home/transactions/add_Transation/provider_add_transaction.dart';
import 'package:provider/provider.dart';

class AddTransactions extends StatelessWidget {
  AddTransactions({super.key});
  static const routname = 'add_transaction';

  CategoriesModel? _selectedcategorymodel;

  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  final _purposetexteditingControler = TextEditingController();
  final _amounttexteditingControler = TextEditingController();

  late final String purpose;

  // ignore: prefer_typing_uninitialized_variables
  late final _parsedAmount;

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;

    final sizeh = MediaQuery.of(context).size.height;
    Widget size20 = SizedBox(height: sizeh * 0.025);

    // Future.delayed(Duration.zero, () {
   
    //   // context.read<Addtrasactionprovider>().initstate();
    // }
    // )
    // ;
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(children: [
                size20,
                size20,
                size20,
                Center(
                  child: Text(
                    'ADD TRANSACTION',
                    style: GoogleFonts.lateef(
                        textStyle: TextStyle(
                      decorationColor: Colors.black,
                      decorationThickness: 4,
                      decorationStyle: TextDecorationStyle.dashed,
                      fontSize: sizew * 0.09,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    )),
                  ),
                ),
                 SizedBox(
                  height: sizeh*0.033
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(children: [
//---------amounttextfiled------------------//

                    TextFormField(
                        maxLength: 8,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter Amount';
                          }
                          return null;
                        },
                        controller: _amounttexteditingControler,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: "Enter Amount")),

                    size20,

                    Consumer<Addtrasactionprovider>(
                      builder: (context, value, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Radio(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.black),
                                  value: CategoriesType.income,
                                  groupValue: value.selectedcategory,
                                  onChanged: (newvalue) {
                                    value.selectedincometype();
                                    value.catogariesID = null;
                                  }),
                              const Text('Income')
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.black),
                                  value: CategoriesType.expense,
                                  groupValue: value.selectedcategory,
                                  onChanged: (newvalue) {
                                    value.selectexpensetype();
                                    value.catogariesID = null;
                                  }),
                              const Text('Expense'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    size20,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //---------selection category  field------------------//
                        Consumer<Addtrasactionprovider>(
                          builder: (context, value, child) =>
                              DropdownButton<String>(
                                  underline: const SizedBox(),
                                  onTap: () =>
                                      CategoriesDb.instance.refreshfuntion(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: sizew * 0.045),
                                  hint: const Text(
                                    'Select category',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: value.catogariesID,
                                  focusColor: Colors.black,
                                  borderRadius: BorderRadius.circular(16),
                                  items: (value.selectedcategory ==
                                              CategoriesType.income
                                          ? CategoriesDb()
                                              .incomecategorieslistlistner
                                          : CategoriesDb()
                                              .expensecategorieslistlistner)
                                      .value
                                      .map((e) {
                                    return DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        e.name,
                                        selectionColor: Colors.black,
                                      ),
                                      onTap: () {
                                        value.refreshtransacRefreshcateg();

                                        _selectedcategorymodel = e;
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (selectedvalue) {
                                    value.refreshtransacRefreshcateg();
                                    value.categoryidchange(
                                        selectedvalue.toString());
                                  }),
                        ),
                        IconButton(
                            onPressed: () {
                              //------------add new category---------------/
                              addcategory(context);
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),

                    size20,

//---------select date of transaction------------------//

                    Consumer<Addtrasactionprovider>(
                      builder: (context, value, child) => TextButton.icon(
                          onPressed: () {
                            value.calendar(context);
                          },
                          icon: const Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                          ),
                          label: Text(
                            value.selecteddate == null
                                ? '  Select date'
                                : parsedate(
                                    value.selecteddate!,
                                  ).toString(),
                            style: const TextStyle(color: Colors.black),
                          )),
                    ),

//================notes================//

                    TextFormField(
                        maxLength: 15,
                        controller: _purposetexteditingControler,
                        decoration: const InputDecoration(
                          labelText: 'Note...',
                        )),
                    size20,

                    //  size20,

                    size20,
                    ElevatedButton(
                        onPressed: () {
//----------------validation spot------------------//

                          final isvalid = formKey.currentState!.validate();
                          if (!isvalid) {
                            return;
                          }
                          if (Provider.of<Addtrasactionprovider>(context,
                                      listen: false)
                                  .catogariesID ==
                              null) {
                            showpopoep("Select category", Colors.red, context);
                            return;
                          }
                          if (Provider.of<Addtrasactionprovider>(context,
                                      listen: false)
                                  .selecteddate ==
                              null) {
                            showpopoep("Date is required", Colors.red, context);
                            return;
                          }
                          if (_selectedcategorymodel == null) {
                            return;
                          }
                          addTransationfuntion(context);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(350, 50),
                            maximumSize: const Size(350, 50),
                            backgroundColor: Colors.black),
                        child: Text(
                          'Submit'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        )),
                    size20,
                  ]),
                )
              ]),
            ),
          ],
        ),
      )),
    );
  }

  //---------add new category funtion------------------//
  addcategory(BuildContext context) {
    showDialog(
      context: context,
      builder: (cntx) {
        return SimpleDialog(
          title: const Text('ADD CATEGORY'),
          children: [
            Form(
              key: formKey2,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      maxLength: 12,
                      textCapitalization: TextCapitalization.sentences,
                      controller: nameEditingControler,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter category name";
                        } else {
                          for (var i = 0;
                              i <
                                  TransactionDb
                                      .instance.incomecategorylist.length;
                              i++) {
                            if (value.toLowerCase() ==
                                TransactionDb
                                    .instance.incomecategorylist[i].name
                                    .toLowerCase()) {
                              return 'Alredy exit';
                            }
                            for (var i = 0;
                                i <
                                    TransactionDb
                                        .instance.expensecategorylist.length;
                                i++) {
                              if (value.toLowerCase() ==
                                  TransactionDb
                                      .instance.expensecategorylist[i].name
                                      .toLowerCase()) {
                                return 'Alredy exit';
                              }
                            }
                          }
                        }
                        const InputDecoration(
                          hintText: 'Add category',
                          focusColor: Colors.black,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(8),
                        );
                        return null;
                      })),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: const [
                  RadioButton(titile: 'INCOME', type: CategoriesType.income),
                  RadioButton(titile: 'EXPENSE', type: CategoriesType.expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                  onPressed: () {
                    final isvald = formKey2.currentState!.validate();

                    if (!isvald) {
                      return;
                    } else {
                      final name = nameEditingControler.text;

                      final typ = selectedCategoriesNotifire.value;
                      final catagory = CategoriesModel(
                          id: DateTime.now().microsecondsSinceEpoch.toString(),
                          name: name,
                          type: typ);

                      CategoriesDb().incertCategories(catagory);

                      Provider.of<Addtrasactionprovider>(context, listen: false)
                          .refreshtransacRefreshcateg();
                      CategoriesDb.instance.expensecategorieslistlistner;
                      CategoriesDb.instance.incomecategorieslistlistner;
                      Navigator.of(cntx).pop();
                      nameEditingControler.clear;
                      CategoriesDb().refreshfuntion();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'ADD',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        );
      },
    );
  }

//--------- add to hive database------------------//
  Future<void> addTransationfuntion(BuildContext context) async {
    purpose = _purposetexteditingControler.text;
    final ammount = _amounttexteditingControler.text;

    _parsedAmount = double.tryParse(ammount);

    final model = TransactionModel(
        purpose: purpose,
        amount: _parsedAmount,
        date: Provider.of<Addtrasactionprovider>(context, listen: false)
            .selecteddate!,
        type: Provider.of<Addtrasactionprovider>(context, listen: false)
            .selectedcategory!,
        catogoryT: _selectedcategorymodel!);

    TransactionDb.instance.addtransaction(model);

    Navigator.of(context).pop();

    TransactionDb.instance.refreshtransaction();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        content: Text(' Transaction added'),
        margin: EdgeInsets.all(15),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(10),
        ))));
  }
  //--------- showing the errers in snackbar------------------//

  void showpopoep(String popname, Color color, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(popname),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(15),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(10),
        ))));
  }
  //---------parse date------------------//

  String parsedate(DateTime date) {
    var datelocal = DateFormat.yMMMMEEEEd().format(date);
    return datelocal;
  }
}
