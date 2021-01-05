import 'package:flutter/material.dart';

class CardWithHeader extends StatelessWidget {
  final List<Widget> children;
  final String headerText;

  CardWithHeader({this.children, this.headerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[200],
          ),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        children: [
          Container(
            height: 50,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              this.headerText,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
            ),
            decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
              child: Column(
                children: [
              ...children
                ],
              )),
        ],
      ),
    );
  }
}
