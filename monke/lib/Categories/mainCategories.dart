import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/recordsData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class mainCategories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _mainCategoriesState();
}

class _mainCategoriesState extends State<mainCategories> {
  int secondaryIndex = 0;
  List<String> lst = ['Expense', 'Income'];

  List<Widget> itemsData = [];
  List<Widget> itemsData2 = [];

  void getPostsData() {
    List<dynamic> responseList = CATEGORY_DATA;
    List<Widget> listItems = [];
    FirebaseFirestore.instance
        .collection('category')
        .where('tipe_cat', isEqualTo: 'expense')
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
                    child: Icon(Icons.money_off_csred_outlined,
                        color: Colors.white),
                    backgroundColor: Colors.redAccent,
                  ),
                  title: Text(doc.id),
                  onTap: () => (''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          {
                            Navigator.pushNamed(context, '/editcategory');
                          }
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                      ),
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

  void getPostsData2() {
    List<dynamic> responseList = CATEGORY2_DATA;
    List<Widget> listItems = [];
    FirebaseFirestore.instance
        .collection('category')
        .where('tipe_cat', isEqualTo: 'income')
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
                    child:
                        Icon(Icons.attach_money_outlined, color: Colors.white),
                    backgroundColor: Colors.greenAccent,
                  ),
                  title: Text(doc.id),
                  onTap: () => (''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          {
                            Navigator.pushNamed(context, '/editaccount');
                          }
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                      ),
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
      itemsData2 = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    getPostsData2();
  }

  void changeSecondaryIndex(int index) {
    setState(() {
      secondaryIndex = index;
    });
  }

  Widget customRadio(String txt, int index) {
    return ElevatedButton(
      onPressed: () => changeSecondaryIndex(index),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(170, 40.0),
        primary: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        side: BorderSide(
            color: secondaryIndex == index ? Colors.teal : Colors.grey,
            width: 2),
      ),
      child: Text(
        txt,
        style: TextStyle(
            color: secondaryIndex == index ? Colors.teal : Colors.grey),
      ),
    );
  }

  Widget getCategories(int idx) {
    Widget child;
    if (idx == 0) {
      return Expanded(
          child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('category')
            .where('tipe_cat', isEqualTo: 'expense')
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
      ));
    } else if (idx == 1) {
      return Expanded(
          child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('category')
            .where('tipe_cat', isEqualTo: 'income')
            .snapshots(),
        builder: (context, snapshot) {
          // if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
            itemCount: itemsData2.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return itemsData2[index];
            },
          );
        },
      ));
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  customRadio(lst[0], 0),
                  customRadio(lst[1], 1),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
            getCategories(secondaryIndex)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/addcategory'),
        icon: Icon(Icons.add_circle_outline, color: Colors.black),
        label: Text('Add New Category',
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
