import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Balance extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _balanceState();
}


class _balanceState extends State<Balance>{
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15.0),
        color: Colors.teal[400],
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(children: <Widget>[
                Text('INCOME',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    )),
                Text('Rp5.000.000,00',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
              ]),
              Column(children: <Widget>[
                Text('EXPENSE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    )),
                Text('Rp210.000,00',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
              ]),
              Column(children: <Widget>[
                Text('TOTAL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    )),
                Text('Rp4.790.000,00',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
              ]),
            ]));
  }

}