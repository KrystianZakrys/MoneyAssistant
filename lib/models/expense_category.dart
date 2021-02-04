import 'dart:convert';

class ExpenseCategory {
  ExpenseCategory();

  int id;
  String name;
  String description;
  int subCategoryId;
  ExpenseCategory subCategory;

  static final columns = ["Id", "Name", "Description", "SubCategoryId"];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "Name": name,
      "Description": description,
      "SubCategoryId": subCategoryId
    };

    if (id != null) {
      map["Id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    ExpenseCategory account = new ExpenseCategory();
    account.id = map["Id"];
    account.name = map["Name"];
    account.description = map["Description"];
    account.subCategoryId = map["SubCategoryId"];

    return account;
  }
}
