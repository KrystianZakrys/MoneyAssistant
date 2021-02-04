import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'context.dart';
import 'custom_card.dart';
import 'models/account.dart';

void main() {
  runApp(MyApp());
}

List<Color> appBarColors = <Color>[
  Color.fromRGBO(0, 138, 11, 1),
  Color.fromRGBO(136, 173, 0, 1)
];

Color bgColor = Color.fromRGBO(58, 64, 69, 1);

Color textColor = Colors.white;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoneyAssistant',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.grey,
          bottomAppBarColor: Colors.transparent),
      home: MyHomePage(title: 'Money Assistant'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final dbContext = Context.instance;

  @override
  _MyHomePageState createState() => _MyHomePageState();

  void _insert() async {
    Account account = new Account();
    account.name = 'Main';
    account.balance = 0;
    account.cardLimit = 1000;
    account.icon = "xD";
    account.isCountedInTotal = 0;
    account.type = 'Bank';

    final Account accountEntity = await dbContext.upsertAccount(account);
    print('inserted row id: $accountEntity.id');
  }

  void _query() async {
    final allRows = await dbContext.fetchAccounts(10);
    print('query all rows:');
    allRows.forEach((row) => print(row.name));
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: appBarColors)),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome',
                style: TextStyle(color: textColor, fontSize: 25),
              ),
              CustomCard(
                title: 'SiemaS',
                width: 310,
                height: 250,
                bgGradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.cyanAccent, Colors.blue],
                ),
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        ElevatedButton(
                          child: Text(
                            'insert',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            widget._insert();
                          },
                        ),
                        ElevatedButton(
                          child: Text(
                            'query',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            widget._query();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
