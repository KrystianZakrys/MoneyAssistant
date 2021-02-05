import 'package:flutter/material.dart';
import 'views/account_list.dart';

class App extends StatelessWidget {
  Color bgColor = Color.fromRGBO(227, 227, 227, 1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        backgroundColor: bgColor,
        body: AccountList(),
      ),
    );
  }
}
