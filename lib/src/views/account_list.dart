import 'package:flutter/material.dart';
import 'package:money_assistant/src/views/account_list_item.dart';
import '../models/account.dart';
import '../blocs/account_bloc.dart';
import 'custom_app_bar.dart';

class AccountList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllAccounts();
    return Scaffold(
      appBar: CustomAppBar(
        Text(
          'YOUR ACCOUNTS',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: StreamBuilder(
        stream: bloc.allAccounts,
        builder: (context, AsyncSnapshot<List<Account>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  double calculateTotalBalance(List<Account> accounts) {
    Set<Account> balances = Set.from(accounts);
    double totalBalance = 0;
    balances.forEach((element) {
      totalBalance += element.balance;
    });
    return totalBalance;
  }

  Widget buildList(AsyncSnapshot<List<Account>> snapshot) {
    double totalBalance = calculateTotalBalance(snapshot.data);
    Color totalBalanceColor = Colors.black;
    if (totalBalance > 0) {
      totalBalanceColor = Color.fromRGBO(0, 201, 30, 1);
    } else if (totalBalance < 0) {
      totalBalanceColor = Colors.redAccent;
    }

    return Column(
      children: <Widget>[
        Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
            child: Row(children: [
              Text(
                "ACCOUNTS",
                style: TextStyle(color: Colors.black45),
              ),
              Text(
                totalBalance.toStringAsPrecision(2),
                style: TextStyle(
                    color: totalBalanceColor, fontWeight: FontWeight.bold),
              )
            ], mainAxisAlignment: MainAxisAlignment.spaceBetween)),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return AccountListItem(snapshot.data[index]);
          },
          itemCount: snapshot.data.length,
        )),
      ],
    );
  }
}
