import 'dart:convert';

class IncomeCategory {
  IncomeCategory();

  int id;
  String name;
  String description;
  int subCategoryId;
  IncomeCategory subCategory;

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
    IncomeCategory account = new IncomeCategory();
    account.id = map["Id"];
    account.name = map["Name"];
    account.description = map["Description"];
    account.subCategoryId = map["SubCategoryId"];

    return account;
  }
}
