import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../models/account.dart';

class AccountListItem extends StatelessWidget {
  final Account account;

  AccountListItem(
    this.account, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color amountColor = Colors.black;
    if (account.balance > 0) {
      amountColor = Color.fromRGBO(0, 201, 30, 1);
    } else if (account.balance < 0) {
      amountColor = Colors.redAccent;
    }

    return Container(
      height: 60,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(71, 50, 150, 0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3))
      ]),
      child: Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            Container(
              width: 50,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.black12, //Color.fromRGBO(71, 50, 150, 1),
                borderRadius: BorderRadius.circular(5),
                // boxShadow: [
                //   BoxShadow(
                //       color: Color.fromRGBO(71, 50, 150, 0.2),
                //       spreadRadius: 2,
                //       blurRadius: 4,
                //       offset: Offset(0, 3))
                // ]
              ),
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Icon(
                Icons.add_circle,
                size: 25,
                color: Colors.grey,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Text(account.name),
                    Text(
                      account.balance.toString() + "zł",
                      style: TextStyle(
                          color: amountColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ))
          ])),
    );
  }
}
