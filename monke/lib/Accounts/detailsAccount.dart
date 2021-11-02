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
            )
          ],
        )
      )
    );
  }
}

