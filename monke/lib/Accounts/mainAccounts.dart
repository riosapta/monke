import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/recordsData.dart';

class mainAccounts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _mainAccountsState();
}
class _mainAccountsState extends State<mainAccounts> {
  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = RECORDS_DATA;
    List<Widget> listItems = [];
    // FirebaseFirestore.instance
    //     .collection('transactions')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    responseList.forEach((post) {
        listItems.add(new InkWell(
                onTap: () {print('tapped');},
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 15,
                                child: Text('AR',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    )),
                                backgroundColor: Colors.grey,
                              ),
                              Expanded(
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      child:
                                        Text(post["account"],
                                            style: TextStyle(
                                              fontSize: 13,
                                            )),
                                        )),
                              Text("${post["amount"]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                              Icon(Icons.more_vert)
                            ]),
                        Padding(
                            padding: const EdgeInsets.only(top:5.0),
                            child:
                              Divider(
                                height: 0,
                                thickness: 0.7,
                              ),
                        ),
                      ]),
                )
            )
        );
    });
    // }
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget> [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                child:
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                          color: Colors.tealAccent[400],
                      ),
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical:5),
                       //define the background color
                      child: Center(
                        child: Text('Overall',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            InkWell(
                              onTap: () {print('tapped');},
                              child:
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Expanded(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
                                            child: Text('Total Balance',
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
                            ),
                            Divider(
                              color: Colors.grey[400],
                              thickness: 0.7,
                            ),
                            InkWell(
                              onTap: () {print('tapped');},
                              child:
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
                            ),
                            Divider(
                              color: Colors.lightGreenAccent[400],
                              thickness: 0.7,
                            ),
                            InkWell(
                              onTap: () {print('tapped');},
                              child:
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
                            ),
                            Divider(
                              color: Colors.redAccent[100],
                              thickness: 0.7,
                            ),
                      ]),
                    ),
                ])
          ),

          Expanded(
            child:
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30),
                  child:
                  Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                            color: Colors.tealAccent[400],
                          ),
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(vertical:5),
                          //define the background color
                          child: Center(
                            child: Text('Accounts',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: itemsData.length,
                            itemBuilder: (context, index) {
                              return itemsData[index];
                            },
                          ),
                        ),
                      ])
              ),
          ),
        ]
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/addrecord'),
        icon: Icon(Icons.add_circle_outline, color: Colors.black),
        label: Text('Add New Account',
        style: TextStyle(
          fontSize: 12,
          color: Colors.black,
        )),
        backgroundColor: Colors.amber[200],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}