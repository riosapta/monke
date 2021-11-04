import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Balance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _balanceState();
}

class _balanceState extends State<Balance> {
  final Stream _inexStream =
      FirebaseFirestore.instance.collection('inexData').doc('inex').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _inexStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
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
                      Text('Rp${data['jumlah_in']}',
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
                      Text('Rp${data['jumlah_ex']}',
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
                      Text('Rp${data['total_inex']}',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),
                    ]),
                  ]));
        });
  }
}
