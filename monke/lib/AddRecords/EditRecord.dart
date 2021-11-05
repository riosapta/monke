import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../MainFunctions/Balance.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:monke/globals.dart' as globals;

class EditRecord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _editRecordState();
}

class _editRecordState extends State<EditRecord> {
  String selectedCategory = 'Select Category';
  String selectedAccount = 'Select Account';
  int secondaryIndex = 0;
  List<String> lstTwo = ['Income', 'Expense', 'Transfer'];
  DateTime selectedDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  String selectedJenis = '';
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  int inputAmount = 0;

  String currency =
      'Rp'; ///////////////////////////////////////////////////////////////////////////////// CURRENCY

  String getText() {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  Future _selectTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (newTime == null) return;
    setState(() {
      time = newTime;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2035));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void changeSecondaryIndex(int index) {
    setState(() {
      secondaryIndex = index;
      if (secondaryIndex == 0) {
        selectedJenis = 'Income';
      }
      if (secondaryIndex == 1) {
        selectedJenis = 'Expense';
      }
      if (secondaryIndex == 2) {
        selectedJenis = 'Transfer';
      }
    });
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

  void categoryButtonPressed() {
    showModalBottomSheet<dynamic>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: const Icon(Icons.cancel_outlined),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Center(
                        child: Text('Select a Category'),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(''),
                    ),
                  ]),
              Divider(
                color: Colors.black,
                height: 0,
              ),
              Expanded(
                child: SizedBox(
                  height: 700,
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Category S'),
                        onTap: () => selectCategory('Category S'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Category T'),
                        onTap: () => selectCategory('Category T'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Category U'),
                        onTap: () => selectCategory('Category U'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Category V'),
                        onTap: () => selectCategory('Category V'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Category W'),
                        onTap: () => selectCategory('Category W'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Category X'),
                        onTap: () => selectCategory('Category X'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Category Y'),
                        onTap: () => selectCategory('Category Y'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Category Z'),
                        onTap: () => selectCategory('Category Z'),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                height: 0,
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.edit, color: Colors.black),
                label: Text('Edit Records',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    )),
                style: TextButton.styleFrom(minimumSize: Size(500, 0)),
              ),
            ]),
          );
        });
  }

  void selectCategory(String name) {
    Navigator.pop(context);
    setState(() {
      selectedCategory = name;
    });
  }

  void accountButtonPressed() {
    showModalBottomSheet<dynamic>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: const Icon(Icons.cancel_outlined),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Center(
                        child: Text('Select an Account'),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(''),
                    ),
                  ]),
              Divider(
                color: Colors.black,
                height: 0,
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Cash'),
                        onTap: () => selectAccount('Cash'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Bank'),
                        onTap: () => selectAccount('Bank'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Saving'),
                        onTap: () => selectAccount('Saving'),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                height: 0,
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.edit, color: Colors.black),
                label: Text('Edit Records',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    )),
                style: TextButton.styleFrom(minimumSize: Size(500, 0)),
              ),
            ]),
          );
        });
  }

  void selectAccount(String name) {
    Navigator.pop(context);
    setState(() {
      selectedAccount = name;
    });
  }

  ///////////////////////////////////////////////////// BUILD STARTS HERE ///////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    CollectionReference trxs =
        FirebaseFirestore.instance.collection('transactions');

    Future<void> addTrx(int amount, note) {
      // Call the user's CollectionReference to add a new user
      return trxs
          .doc(globals.globDocID)
          .update({
            'akun_trx': selectedAccount, // John Doe
            'catatan_trx': note,
            'jenis_trx': selectedJenis, // Stokes and Sons
            'jumlah_trx': amount, // 42
            'kategori_trx': selectedCategory,
            'tanggal_trx': selectedDate
          })
          .then((value) => print("Trx Updated"))
          .catchError((error) => print("Failed to update trx: $error"));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Record",
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
            Balance(), /////////////////////////////////////////////////////////////////////////// BALANCE IS HERE
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  customRadio2(lstTwo[0], 0),
                  customRadio2(lstTwo[1], 1),
                  customRadio2(lstTwo[2], 2),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Date:'),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text("${selectedDate.toLocal()}".split(' ')[0]),
                ),
                Text('Time:'),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text(getText()),
                ),
              ],
            ),
            Container(
              //margin: EdgeInsets.only(top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      //Text('Category:'),
                      TextButton(
                        onPressed: () => setState(() {
                          categoryButtonPressed();
                        }),
                        child: Text('$selectedCategory'),
                        style: ButtonStyle(),
                      ),
                    ]),
                    Column(children: [
                      //Text('Account:'),
                      TextButton(
                        onPressed: () => setState(() {
                          accountButtonPressed();
                        }),
                        child: Text('$selectedAccount'),
                        style: ButtonStyle(),
                      ),
                    ]),
                  ]),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Amount',
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
                  decoration: InputDecoration(
                    hintText: 'Notes',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  //maxLines: null,
                )),
            ElevatedButton.icon(
              onPressed: () {
                addTrx(
                    int.parse(amountController.text
                        .replaceAll('Rp', '')
                        .replaceAll(',', '')
                        .replaceAll('.00', '')),
                    noteController.text);
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
