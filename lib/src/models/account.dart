import 'dart:convert';

class Account {
  Account();

  int id;
  String name;
  double balance;
  String type;
  String icon;
  double cardLimit;
  int isCountedInTotal;

  static final columns = [
    "Id",
    "Name",
    "Balance",
    "Type",
    "Icon",
    "CardLimit",
    "IsCountedInTotal"
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "Name": name,
      "Balance": balance,
      "Type": type,
      "Icon": icon,
      "CardLimit": cardLimit,
      "IsCountedInTotal": isCountedInTotal
    };

    if (id != null) {
      map["Id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    Account account = new Account();
    account.id = map["Id"];
    account.name = map["Name"];
    account.balance = map["Balance"];
    account.type = map["Type"];
    account.icon = map["Icon"];
    account.cardLimit = map["CardLimit"];
    account.isCountedInTotal = map["IsCountedInTotal"];

    return account;
  }
}
