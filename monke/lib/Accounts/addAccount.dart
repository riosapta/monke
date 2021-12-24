import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'listAccount.dart';

class AddAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addAccountState();
}

class _addAccountState extends State<AddAccount> {
  int secondaryIndex = 0;
  List<String> lstTwo = ['Income', 'Expense', 'Transfer'];
  final nameController = TextEditingController();
  final balanceController = TextEditingController();

  String currency =
      'Rp'; ///////////////////////////////////////////////////////////////////////////////// CURRENCY

  void changeSecondaryIndex(int index) {
    setState(() {
      secondaryIndex = index;
    });
  }

  Widget customRadio2(String txt, int index) {
    return ElevatedButton(
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
        FirebaseFirestore.instance.collection('accounts');

    Future<void> addAcc(nameCat, balance) {
      // Call the user's CollectionReference to add a new user
      return trxs
          .add({
            'nama_akun': nameCat, // John Doe
            'jumlah_akun': balance
          })
          .then((value) => print("Cat Added"))
          .catchError((error) => print("Failed to add cat: $error"));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Account",
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
            // Container(
            //   margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       customRadio2(lstTwo[0], 0),
            //       customRadio2(lstTwo[1], 1),
            //       customRadio2(lstTwo[2], 2),
            //     ],
            //   ),
            // ),

            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                    controller: balanceController,
                    decoration: InputDecoration(
                      hintText: 'Initial Balance',
                      border: OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyTextInputFormatter(symbol: '$currency'),
                    ])),
            // https://stackoverflow.com/questions/50395032/flutter-textfield-with-currency-format
            // https://www.youtube.com/watch?v=eWa6iGncZ5Q
            // https://stackoverflow.com/questions/50736571/when-i-select-a-textfield-the-keyboard-moves-over-it
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Account Name',
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
              child: ListAccount(),
            ),
            ElevatedButton.icon(
              onPressed: () {
                addAcc(
                    nameController.text,
                    int.parse(balanceController.text
                        .replaceAll('Rp', '')
                        .replaceAll(',', '')
                        .replaceAll('.00', '')));
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
