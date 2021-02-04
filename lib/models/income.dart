import 'dart:convert';
import 'package:money_assistant/models/expense_category.dart';

import 'account.dart';

class Income {
  Income();

  int id;
  String name;
  String description;
  int categoryId;
  ExpenseCategory category;
  double amount;
  DateTime date;
  int accountId;
  Account account;

  static final columns = [
    "Id",
    "Name",
    "Description",
    "CategoryId",
    "Amount",
    "Date",
    "AccountId"
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "Name": name,
      "Description": description,
      "CategoryId": categoryId,
      "Amount": amount,
      "Date": date,
      "AccountId": accountId
    };

    if (id != null) {
      map["Id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    Income account = new Income();
    account.id = map["Id"];
    account.name = map["Name"];
    account.description = map["Description"];
    account.categoryId = map["CategoryId"];
    account.amount = map["Amount"];
    account.date = map["Date"];
    account.accountId = map["AccountId"];

    return account;
  }
}
