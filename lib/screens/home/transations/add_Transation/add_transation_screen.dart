import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';
import 'package:moneymanagement/screens/home/catagories/category_add_popup.dart';

class AddTransactions extends StatefulWidget {
  const AddTransactions({super.key});
  static const routname = 'add_transaction';
  @override
  State<AddTransactions> createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions> {
  Widget sizedb = const SizedBox(
    height: 20,
  );
  DateTime? selecteddate;
  CategoriesType? _selectedcategory;
  CategoriesModel? _selectedcategorymodel;
  String? _catogariesID;
  var formKey = GlobalKey<FormState>();
  final _purposetexteditingControler = TextEditingController();
  final _amounttexteditingControler = TextEditingController();

  late final String purpose;
  DateTime? datefirst;
  // ignore: prefer_typing_uninitialized_variables
  late final _parsedAmount;

  @override
  void initState() {
    _selectedcategory = CategoriesType.income;

    super.initState();
  }

  // ignore: unused_field
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 40,right: 40,top: 70),
        child: Form(
          key: formKey,
          onChanged: () {
            final isValid = formKey.currentState!.validate();
            if (_isValid = isValid) {
              setState(() {
                _isValid = isValid;
              });
            }
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(children: [
                  sizedb,
                  sizedb,

                  Center(
                    child: Text(
                      'ADD TRANSACTIONS',
                      style: GoogleFonts.lateef(
                          textStyle: const TextStyle(
                              decorationColor: Colors.black,
                              decorationThickness: 4,
                              decorationStyle: TextDecorationStyle.dashed,
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic)),
                    ),
                    
                  ),
                    
                  const SizedBox(
                    height: 30,
                  ),

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
                    decoration:  const InputDecoration(
                      labelText: 'Amount',
                      labelStyle: TextStyle(),
                       
                    ),
                  ),
                  sizedb,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.black),
                              value: CategoriesType.income,
                              groupValue: _selectedcategory,
                              onChanged: (newvalue) {
                                setState(() {
                                  _selectedcategory = CategoriesType.income;
                                  _catogariesID = null;
                                });
                              }),
                          const Text('INCOME')
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.black),
                              value: CategoriesType.expense,
                              groupValue: _selectedcategory,
                              onChanged: (newvalue) {
                                setState(() {
                                  _selectedcategory = CategoriesType.expense;
                                  _catogariesID = null;
                                });
                              }),
                          const Text('EXPENSE'),
                        ],
                      ),
                    ],
                  ),
                  sizedb,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                         underline: const SizedBox(),
                          onTap: () => CategoriesDb.instance.refreshfuntion(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 17),
                          hint: const Text(
                            'select category',
                            style: TextStyle(color: Colors.black),
                          ),
                          value: _catogariesID,
                          focusColor: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                          items: (_selectedcategory == CategoriesType.income
                                  ? CategoriesDb().incomecategorieslistlistner
                                  : CategoriesDb().expensecategorieslistlistner)
                              .value
                              .map((e) {
                            return DropdownMenuItem(
                              value: e.id,
                              child: Text(
                                e.name,
                                selectionColor: Colors.black,
                              ),
                              onTap: () {
                                setState(() {
                                  TransactionDb.instance.refreshtransaction();
                                  CategoriesDb.instance.refreshfuntion();
                                });
                                _selectedcategorymodel = e;
                              },
                            );
                          }).toList(),
                          onChanged: (selectedvalue) {
                            setState(() {
                              CategoriesDb
                                  .instance.expensecategorieslistlistner;
                              TransactionDb.instance.refreshtransaction();
                              CategoriesDb.instance.refreshfuntion();
                              _catogariesID = selectedvalue as String?;
                            });
                          }),
                      IconButton(
                          onPressed: () {
                            showpopupADD(context);
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                  sizedb,
                  TextButton.icon(
                      onPressed: () {
                        calendar(context);
                      },
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                      label: Text(
                        selecteddate == null
                            ? '  Select date'
                            : parsedate(
                                selecteddate!,
                              ).toString(),
                        style: const TextStyle(color: Colors.black),
                      )),
                  TextFormField(
                      maxLength: 15,
                      controller: _purposetexteditingControler,
                      // validator: ((value) {
                      //   if (value!.isEmpty) {
                      //     return 'enter notes of transaction';
                      //   }
                      //   return null;
                      // }),
                      decoration: const InputDecoration(
                        labelText: 'Note...',
                        labelStyle: TextStyle(),
                      )),
                  sizedb,

                  //  sizedb,

                  sizedb,
                  ElevatedButton(
                      onPressed: () {
                        final isvalid = formKey.currentState!.validate();
                        if (!isvalid) {
                          return;
                        }
                        if (_catogariesID == null) {
                          showpopoep("Select category", Colors.red);
                        }
                        if (selecteddate == null) {
                          showpopoep("Date is required", Colors.red);
                        }
                        if (_selectedcategorymodel == null) {
                          return;
                        }
                        addTransationfuntion();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(350, 50),
                          maximumSize: const Size(350, 50),
                          backgroundColor: Colors.black),
                      child: const Text(
                        'ADD',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                  sizedb,
                ]),
              ),
            ],
          ),
        ),
      )),
    );
  }

  calendar(BuildContext context) async {
    datefirst = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 60)),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Color.fromARGB(255, 66, 125, 145),
            )),
            child: child!);
      },
    );
    // ignore: unnecessary_null_comparison
    if (datefirst! == null) {
      return;
    } else {
      setState(() {
        selecteddate = datefirst;
      });
    }
  }

  Future<void> addTransationfuntion() async {
    purpose = _purposetexteditingControler.text;
    final ammount = _amounttexteditingControler.text;

    _parsedAmount = double.tryParse(ammount);

    final model = TransactionModel(
        purpose: purpose,
        amount: _parsedAmount,
        date: selecteddate!,
        type: _selectedcategory!,
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

  showpopoep(String popname, Color color) {
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

  String parsedate(DateTime date) {
    var datelocal = DateFormat.yMMMMEEEEd().format(date);
    return datelocal;
  }
}
