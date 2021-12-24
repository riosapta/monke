import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/recordsData.dart';
import 'detailsAccount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../globals.dart' as globals;

class mainAccounts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _mainAccountsState();
}

class _mainAccountsState extends State<mainAccounts> {
  List<Widget> itemsData = [];

  final Stream _inexStream =
      FirebaseFirestore.instance.collection('inexData').doc('inex').snapshots();

  CollectionReference deleteAcc =
      FirebaseFirestore.instance.collection('accounts');

  Future<void> deleteField(docID) {
    return deleteAcc
        .doc(docID)
        .delete()
        .then((value) => print("Acc Deleted"))
        .catchError((error) => print("Failed to delete Acc: $error"));
  }

  void onSelected(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.pushNamed(context, '/detailsaccount');
        break;
      case 1:
        Navigator.pushNamed(context, '/editaccount');
        break;
      case 2:
        print('Delete function insert here');
        deleteField(globals.globDocIDDel);
        getPostsData();
        setState(() {
          build(context);
        });
        break;
    }
  }

  void getPostsData() {
    // List<dynamic> responseList = RECORDS_DATA;
    List<Widget> listItems = [];
    FirebaseFirestore.instance
        .collection('accounts')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        listItems.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    radius: 15,
                    child: Icon(Icons.monetization_on_outlined,
                        color: Colors.black),
                    backgroundColor: Colors.tealAccent,
                  ),
                  title: Text(doc['nama_akun']),
                  onTap: () =>
                      {Navigator.pushNamed(context, '/detailsaccount')},
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Rp${doc["jumlah_akun"]}',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      PopupMenuButton<int>(
                        onSelected: (item) => {
                          onSelected(context, item),
                          globals.globDocIDDel = doc.id,
                          globals.globDocID = doc.id,
                          globals.initName = doc["nama_akun"],
                          globals.initJumlah = doc["jumlah_akun"],
                          print(globals.globDocIDDel),
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(value: 0, child: Text('Details')),
                          PopupMenuItem<int>(value: 1, child: Text('Edit')),
                          PopupMenuItem<int>(value: 2, child: Text('Delete')),
                        ],
                      ),
                      // IconButton(onPressed: (){{Navigator.pushNamed(context, '/editaccount');}}, icon: Icon(Icons.more_vert),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Divider(
                    height: 0,
                    thickness: 0.7,
                  ),
                ),
              ]),
        ));
      });
    });
    setState(() {
      itemsData = listItems;
    });
  }

  void updateAllData() {
    num jumlah = 0;
    num totAkun = 0;

    FirebaseFirestore.instance
        .collection('accounts')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        FirebaseFirestore.instance
            .collection('transactions')
            .where('akun_trx', isEqualTo: doc['nama_akun'])
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc1) {
            jumlah = jumlah + doc1['jumlah_trx'];

            FirebaseFirestore.instance
                .collection('accounts')
                .doc(doc.id)
                .update({'jumlah_akun': jumlah})
                .then((value) => print("Income Updated"))
                .catchError(
                    (error) => print("Failed to update Income: $error"));
          });
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    updateAllData();
  }

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
          return Scaffold(
            body: Column(children: <Widget>[
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                  child: Column(children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                        color: Colors.tealAccent[400],
                      ),
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      //define the background color
                      child: Center(
                        child: Text(
                          'Overall',
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
                              onTap: () {
                                print('tapped');
                              },
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
                                      child: Text('Total Balance',
                                          style: TextStyle(
                                            fontSize: 13,
                                          )),
                                    )),
                                    Text('Rp${data['total_account']}',
                                        style: TextStyle(
                                          fontSize: 17,
                                        )),
                                  ]),
                            ),
                            Divider(
                              color: Colors.grey[400],
                              thickness: 0.7,
                            ),
                            InkWell(
                              onTap: () {
                                print('tapped');
                              },
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
                                      child: Text('Total Income',
                                          style: TextStyle(
                                            fontSize: 13,
                                          )),
                                    )),
                                    Text('Rp${data['jumlah_in']}',
                                        style: TextStyle(
                                          fontSize: 17,
                                        )),
                                  ]),
                            ),
                            Divider(
                              color: Colors.lightGreenAccent[400],
                              thickness: 0.7,
                            ),
                            InkWell(
                              onTap: () {
                                print('tapped');
                              },
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
                                      child: Text('Total Expense',
                                          style: TextStyle(
                                            fontSize: 13,
                                          )),
                                    )),
                                    Text('Rp${data['jumlah_ex']}',
                                        style: TextStyle(
                                          fontSize: 17,
                                        )),
                                  ]),
                            ),
                            Divider(
                              color: Colors.redAccent[100],
                              thickness: 0.7,
                            ),
                          ]),
                    ),
                  ])),

              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Accounts',
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
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('accounts')
                    .snapshots(),
                builder: (context, snapshot) {
                  // if (!snapshot.hasData) return const Text('Loading...');
                  return ListView.builder(
                    itemCount: itemsData.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return itemsData[index];
                    },
                  );
                },
              )),
              // Expanded(
              //   child:
              //     Card(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15.0),
              //         ),
              //         margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30),
              //         child:
              //         Column(
              //             children: <Widget>[
              //               Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.only(
              //                     topRight: Radius.circular(15),
              //                     topLeft: Radius.circular(15),
              //                   ),
              //                   color: Colors.tealAccent[400],
              //                 ),
              //                 width: double.maxFinite,
              //                 padding: EdgeInsets.symmetric(vertical:5),
              //                 //define the background color
              //                 child: Center(
              //                   child: Text('Accounts',
              //                     style: TextStyle(
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               Expanded(
              //                 child: ListView.builder(
              //                   itemCount: itemsData.length,
              //                   itemBuilder: (context, index) {
              //                     return itemsData[index];
              //                   },
              //                 ),
              //               ),
              //             ])
              //     ),
              // ),
            ]),
            floatingActionButton: FloatingActionButton.extended(
              heroTag: "btn2",
              onPressed: () => Navigator.pushNamed(context, '/addaccount'),
              icon: Icon(Icons.add_circle_outline, color: Colors.black),
              label: Text('Add New Account',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  )),
              backgroundColor: Colors.amber[200],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        });
  }
}
