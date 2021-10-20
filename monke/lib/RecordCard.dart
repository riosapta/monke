import 'package:flutter/material.dart';
import 'record.dart';

class RecordCard extends StatelessWidget {

  final Record? record;
  RecordCard({ this.record });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "${record?.recordDate?.toLocal()}".split(' ')[0],
                  style: TextStyle(
                    fontSize: 12,
                  ),),
                SizedBox(height: 6.0),
                Divider(
                  color: Colors.black,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:<Widget>[
                      CircleAvatar(
                        radius: 15,
                        child: Text(
                            'AR',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            )
                        ),
                        backgroundColor: Colors.grey,
                      ),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:<Widget>[
                                    Text(record!.category,
                                        style: TextStyle(
                                          fontSize: 13,)),
                                    Text(record!.account,
                                        style: TextStyle(
                                          fontSize: 10,)),
                                  ]
                              )
                          )
                      ),
                      Text('Rp${record!.amount}',
                          style:TextStyle(
                            fontSize: 20,
                          )),
                    ]
                )
              ]
          ),
        )
    );
  }
}
