import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  const CustomCard(
      {Key key,
      this.title,
      this.width,
      this.height,
      this.bgGradient,
      this.children})
      : super(key: key);

  final String title;
  final double width;
  final double height;
  final LinearGradient bgGradient;
  final List<Widget> children;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            gradient: widget.bgGradient,
            color: Color.fromRGBO(242, 250, 250, 1),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(2, 1))
            ]),
        constraints: BoxConstraints(minHeight: 200, minWidth: 200),
        child: Center(
            child: Column(children: <Widget>[
          Row(children: [
            Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(widget.title,
                    style: TextStyle(color: Colors.white, fontSize: 20))),
          ]),
          Row(
            children: widget.children ??
                [
                  Text(
                    'No content',
                    style: TextStyle(color: Colors.black38),
                  )
                ],
          )
        ])));
  }
}
