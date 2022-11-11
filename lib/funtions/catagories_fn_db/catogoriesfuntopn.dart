import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/catogaries/modelcatogaries.dart';

const categoriesDbName = 'categories_database';

abstract class CatagoriesDbFn {
  Future<List<CategoriesModel>> getcatogaries();

  Future<void> incertCategories(CategoriesModel value);
  Future<void> deletecategories(String catagoriesid);
  Future<void> deleteallctogories(List deleteall);
}

class CategoriesDb implements CatagoriesDbFn {
  CategoriesDb.intenal();
  static CategoriesDb instance = CategoriesDb.intenal();
  factory CategoriesDb() {
    return instance;
  }

  ValueNotifier<List<CategoriesModel>> incomecategorieslistlistner =
      ValueNotifier([]);
  ValueNotifier<List<CategoriesModel>> expensecategorieslistlistner =
      ValueNotifier([]);
  @override
  Future<void> incertCategories(CategoriesModel value) async {
    final categoriesDB = await Hive.openBox<CategoriesModel>(categoriesDbName);
    await categoriesDB.put(value.id, value);
    refreshfuntion();
  }

  @override
  Future<List<CategoriesModel>> getcatogaries() async {
    final categoriesDB = await Hive.openBox<CategoriesModel>(categoriesDbName);
    return categoriesDB.values.toList();
  }

//for refreshing ui--------------------
  Future<void> refreshfuntion() async {
    final allcategories = await getcatogaries();
    incomecategorieslistlistner.value.clear();
    expensecategorieslistlistner.value.clear();
    await Future.forEach(allcategories, (CategoriesModel category) {
      if (category.type == CategoriesType.income) {
        incomecategorieslistlistner.value.add(category);
      } else {
        expensecategorieslistlistner.value.add(category);
      }
    });
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    incomecategorieslistlistner.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    expensecategorieslistlistner.notifyListeners();
  }

  @override
  Future<void> deletecategories(String catagoriesid) async {
    final categoriesdb_ = await Hive.openBox<CategoriesModel>(categoriesDbName);
    categoriesdb_.delete(catagoriesid);
    refreshfuntion();
  }

  @override
  Future<void> deleteallctogories(List deleteall) async {
    final catogoriesdeleteall_ = await Hive.openBox(categoriesDbName);
    catogoriesdeleteall_.deleteAll(deleteall);
    incomecategorieslistlistner.value.clear();
    expensecategorieslistlistner.value.clear();
    refreshfuntion();
  }

  Future<void> restarcatocaryapp() async {
    final categoyReset_ = await Hive.openBox<CategoriesModel>(categoriesDbName);

    incomecategorieslistlistner.value.clear();
    expensecategorieslistlistner.value.clear();
    await categoyReset_.clear();

    refreshfuntion();
  }
}
