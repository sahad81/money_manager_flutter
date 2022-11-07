import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/catogoriesfuntopn.dart';
import 'package:moneymanagement/funtions/catagories_fn_db/transation.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';
import 'package:moneymanagement/models/transations/model_transations.dart';
import 'package:moneymanagement/screens/home/catagories/category_add_popup.dart';

class add_transations extends StatefulWidget {
  static const routname = 'add_transaction';

  add_transations({super.key});
  @override
  State<add_transations> createState() => _add_transationsState();
}

class _add_transationsState extends State<add_transations> {
  Widget sizedb = const SizedBox(
    height: 20,
  );
  DateTime? selecteddate;
  catagories_type? _selectedcatagory;
  Catogariesmodel? _selected_catory_model;
  String? _catogariesID;
  var formKey = GlobalKey<FormState>();
  final _purposetexteditingControler = TextEditingController();
  final _AmounttexteditingControler = TextEditingController();

  late final String purpose;
  DateTime? datefirst;
  late final _parsedAmount;
  //  add_transations({
  //   this.selecteddate,
  //  });

  @override
  void initState() {
    _selectedcatagory = catagories_type.income;

    super.initState();
  }

  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
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

                  TextFormField(
                      controller: _purposetexteditingControler,
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'enter purpose of transaction';
                        }
                        return null;
                      }),
                      decoration: const InputDecoration(
                        labelText: 'Purpose',
                        labelStyle: TextStyle(),
                      )),
                  sizedb,
                  const SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter Amount';
                      }
                      return null;
                    },
                    controller: _AmounttexteditingControler,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
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
                              value: catagories_type.income,
                              groupValue: _selectedcatagory,
                              onChanged: (newvalue) {
                                setState(() {
                                  _selectedcatagory = catagories_type.income;
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
                              value: catagories_type.expense,
                              groupValue: _selectedcatagory,
                              onChanged: (newvalue) {
                                setState(() {
                                  _selectedcatagory = catagories_type.expense;
                                  _catogariesID = null;
                                });
                              }),
                          const Text('EXPENSE'),
                        ],
                      ),
                    ],
                  ),
                  //  sizedb,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                          style: const TextStyle(
                              color: Colors.black, fontSize: 17),
                          hint: const Text(
                            'select category',
                            style: TextStyle(color: Colors.black),
                          ),
                          value: _catogariesID,
                          focusColor: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                          items: (_selectedcatagory == catagories_type.income
                                  ? catagories_db().income_catogarieslistlistner
                                  : catagories_db()
                                      .expense_catogarieslistlistner)
                              .value
                              .map((e) {
                            return DropdownMenuItem(
                              value: e.id,
                              child: Text(
                                e.name,
                                selectionColor: Colors.black,
                              ),
                              onTap: () {
                                _selected_catory_model = e;
                              },
                            );
                          }).toList(),
                          onChanged: (selectedvalue) {
                            setState(() {
                              catagories_db.instance.refreshfuntion();
                              _catogariesID = selectedvalue as String?;
                            });
                          }),
                      IconButton(
                          onPressed: () {
                            showpopupADD(context);
                          },
                          icon: Icon(Icons.add))
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
                        if (_selected_catory_model == null) {
                          return;
                        }
                        addTransationfuntion();

                        //  addtransationtntd();
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
              primary: Colors.black, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Color.fromARGB(255, 66, 125, 145),
            )),
            child: child!);
      },
    );
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
    final ammount = _AmounttexteditingControler.text;

    _parsedAmount = double.tryParse(ammount);

    final model = transation_model(
        purpose: purpose,
        ammount: _parsedAmount,
        date: selecteddate!,
        type: _selectedcatagory!,
        catogoryT: _selected_catory_model!);

    TransationDb.instance.addtransaction(model);
  
    Navigator.of(context).pop();

    TransationDb.instance.refreshtransaction();
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
