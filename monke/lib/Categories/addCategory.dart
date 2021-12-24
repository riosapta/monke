import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'listCategory.dart';

class AddCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => addCategoryState();
}

class addCategoryState extends State<AddCategory> {
  static int secondaryIndex = 0;
  List<String> lstTwo = ['Income', 'Expense'];
  String selectedType = "income";
  final nameController = TextEditingController();
  String currency =
      'Rp'; ///////////////////////////////////////////////////////////////////////////////// CURRENCY

  void changeSecondaryIndex(int index) {
    setState(() {
      secondaryIndex = index;
    });
    if (secondaryIndex == 0) {
      selectedType = "income";
    } else {
      selectedType = "expense";
    }
  }

  Widget customRadio2(String txt, int index) {
    return OutlinedButton(
      onPressed: () => changeSecondaryIndex(index),
      style: ElevatedButton.styleFrom(
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

  ///////////////////////////////////////////////////// BUILD STARTS HERE ///////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    CollectionReference trxs =
        FirebaseFirestore.instance.collection('category');

    Future<void> addCat(nameCat) {
      // Call the user's CollectionReference to add a new user
      return trxs
          .add({
            'nama_cat': nameCat, // John Doe
            'tipe_cat': selectedType
          })
          .then((value) => print("Cat Added"))
          .catchError((error) => print("Failed to add cat: $error"));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Category",
              style: TextStyle(
                //fontFamily: 'Quicksand',
                //fontWeight: FontWeight.bold,
                fontSize: 20.0,
              )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(children: [
                //Text('Account:'),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Category Type'),
                    customRadio2(lstTwo[0], 0),
                    customRadio2(lstTwo[1], 1),
                  ],
                ),
              ]),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Category Name',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  //maxLines: null,
                )),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: ListCategory(),
            ),
            ElevatedButton.icon(
              onPressed: () {
                addCat(nameController.text);
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: Icon(Icons.add_circle_outline),
              label: Text('Add',
                  style: TextStyle(
                    fontSize: 16,
                  )),
            )
          ],
        ))));
  }
}
