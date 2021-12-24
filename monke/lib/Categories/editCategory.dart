import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import '../globals.dart' as globals;

class EditCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _editCategoryState();
}

class _editCategoryState extends State<EditCategory> {
  int secondaryIndex = 0;
  List<String> lstTwo = ['Income', 'Expense'];
  String selectedType = globals.initType;
  final nameController = TextEditingController(text: globals.initName);
  String currency =
      'Rp'; ///////////////////////////////////////////////////////////////////////////////// CURRENCY

  void changeSecondaryIndex(int index) {
    setState(() {
      secondaryIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (selectedType == 'income') {
      secondaryIndex = 0;
    }
    if (selectedType == 'expense') {
      secondaryIndex = 1;
    }
  }

  Widget customRadio2(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeSecondaryIndex(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(
          color: secondaryIndex == index ? Colors.teal : Colors.grey),
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

    Future<void> editCat(nameCat) {
      // Call the user's CollectionReference to add a new user
      return trxs
          .doc(globals.globDocID)
          .update({
            'nama_cat': nameCat, // John Doe
            'tipe_cat': selectedType
          })
          .then((value) => print("Cat Edited"))
          .catchError((error) => print("Failed to edit cat: $error"));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Category",
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
                    // hintText: 'Category Name',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  //maxLines: null,
                )),
            ElevatedButton.icon(
              onPressed: () {
                editCat(nameController.text);
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: Icon(Icons.edit),
              label: Text('Edit',
                  style: TextStyle(
                    fontSize: 16,
                  )),
            )
          ],
        ))));
  }
}
