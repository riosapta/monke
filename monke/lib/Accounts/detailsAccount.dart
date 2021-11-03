import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DetailsAccount extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _detailsAccountState();
}

class _detailsAccountState extends State<DetailsAccount>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Account Details",
              style: TextStyle(
                //fontFamily: 'Quicksand',
                //fontWeight: FontWeight.bold,
                fontSize: 20.0,
              )
          ),
          centerTitle: true,
        ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children:[
                CircleAvatar(radius: 30,),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bank',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )),
                    Row(
                      children:[
                        Text('Balance:'),
                        Text('Rp4,790,000.00')
                      ]
                    )
                  ],
                )
              ]
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overall',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 0.7,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
                                child: Text('Total Income',
                                    style: TextStyle(
                                      fontSize: 13,
                                    )
                                ),
                              )
                          ),
                          Text('RpXXX.XXX,XX',
                              style: TextStyle(
                                fontSize: 17,
                              )),
                        ]
                    ),
                    Divider(
                      color: Colors.green[400],
                      thickness: 0.7,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
                                child: Text('Total Expense',
                                    style: TextStyle(
                                      fontSize: 13,
                                    )
                                ),
                              )
                          ),
                          Text('RpXXX.XXX,XX',
                              style: TextStyle(
                                fontSize: 17,
                              )),
                        ]
                    ),
                    Divider(
                      color: Colors.redAccent[100],
                      thickness: 0.7,
                    ),
                  ]),
            ),
          ],
        )
      )
    );
  }
}

