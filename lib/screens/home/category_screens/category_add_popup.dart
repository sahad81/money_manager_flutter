import 'package:flutter/material.dart';
import 'package:moneymanagement/funtions/categories_fn_db/categories.dart';

import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';

ValueNotifier<CategoriesType> selectedCategoriesNotifire =
    ValueNotifier(CategoriesType.expense);
final nameEditingControler = TextEditingController();
var formKey = GlobalKey<FormState>();
Future<void> showpopupADD(BuildContext context) async {
  List<CategoriesModel> incomecategorylist =
      CategoriesDb.instance.incomecategorieslistlistner.value;

  List<CategoriesModel> expenseategorylist =
      CategoriesDb.instance.expensecategorieslistlistner.value;

  showDialog(
    
    context: context,
    builder: (cntx) {
         nameEditingControler.clear();
      return SimpleDialog(
        title: const Text('ADD CATEGORY'),
        children: [
          Form(
            key: formKey,
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
                        for (var i = 0; i < incomecategorylist.length; i++) {
                          if (value.toLowerCase() ==
                              incomecategorylist[i].name.toLowerCase()) {
                            return 'Alredy exit';
                          }
                          for (var i = 0; i < expenseategorylist.length; i++) {
                            if (value.toLowerCase() ==
                                expenseategorylist[i].name.toLowerCase()) {
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
                  final isvald = formKey.currentState!.validate();

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
                  
                     CategoriesDb.instance.refreshfuntion();
                    CategoriesDb.instance.expensecategorieslistlistner;
                    CategoriesDb.instance.incomecategorieslistlistner;
                    Navigator.of(cntx).pop();
                    nameEditingControler.clear();
                    CategoriesDb().refreshfuntion();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text('ADD',style: TextStyle(color: Colors.white),)),
          )
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String titile;
  final CategoriesType type;

  const RadioButton({Key? key, required this.titile, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoriesNotifire,
            builder:
                (BuildContext context, CategoriesType newcatagory, Widget? _) {
              return Radio<CategoriesType>(
                  value: type,
                  fillColor:
                      MaterialStateColor.resolveWith((states) => Colors.black),
                  groupValue: newcatagory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    selectedCategoriesNotifire.value = value;
                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                    selectedCategoriesNotifire.notifyListeners();
                  });
            }),
        Text(titile)
      ],
    );
  }
}
