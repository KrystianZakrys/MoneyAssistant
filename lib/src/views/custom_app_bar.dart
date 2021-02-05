import 'package:flutter/material.dart';

@override
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Widget title;

  CustomAppBar(
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  static List<Color> appBarColors = <Color>[
    Color.fromRGBO(42, 125, 219, 1),
    Color.fromRGBO(0, 97, 158, 1)
  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: title,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: appBarColors)),
          child: Center(
            child: Column(
              children: [],
            ),
          ),
        ));
  }
}
