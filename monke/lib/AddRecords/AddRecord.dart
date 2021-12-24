import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../MainFunctions/Balance.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class AddRecord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addRecordState();
}

class _addRecordState extends State<AddRecord> {
  String selectedCategory = 'Select Category';
  String selectedAccount = 'Select Account';
  String selectedAccount2 = 'Select Account';
  int secondaryIndex = 0;
  List<String> lstTwo = ['Income', 'Expense', 'Transfer'];
  DateTime selectedDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  String selectedJenis = 'Income';
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  int inputAmount = 0;
  List<Widget> accData = [];
  List<Widget> catData = [];
  int accIndex = 0;

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
    return OutlinedButton(
      onPressed: () {
        changeSecondaryIndex(index);
        categoryList();
        selectedCategory = 'Select Category';
      },
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

  Widget getCategories(int idx) {
    Widget child;
    if (idx == 0) {
      return Expanded(
          child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('category')
            .where('tipe_cat', isEqualTo: 'income')
            .snapshots(),
        builder: (context, snapshot) {
          // if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
            itemCount: catData.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, idx3) {
              return catData[idx3];
            },
          );
        },
      ));
    } else if (idx == 1) {
      return Expanded(
          child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('category')
            .where('tipe_cat', isEqualTo: 'expense')
            .snapshots(),
        builder: (context, snapshot) {
          // if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
            itemCount: catData.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, idx3) {
              return catData[idx3];
            },
          );
        },
      ));
    }
    return SizedBox.shrink();
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
              getCategories(secondaryIndex),
              Divider(
                color: Colors.black,
                height: 0,
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add_circle_outline, color: Colors.black),
                label: Text('Add New Records',
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

  void categoryList() {
    List<Widget> listCat = [];
    if (secondaryIndex == 0) {
      FirebaseFirestore.instance
          .collection('category')
          .where('tipe_cat', isEqualTo: 'income')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          listCat.add(ListTile(
            leading: Icon(Icons.circle),
            title: Text(doc.id),
            onTap: () => selectCategory(doc.id),
          ));
        });
      });
    } else if (secondaryIndex == 1) {
      FirebaseFirestore.instance
          .collection('category')
          .where('tipe_cat', isEqualTo: 'expense')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          listCat.add(ListTile(
            leading: Icon(Icons.circle),
            title: Text(doc.id),
            onTap: () => selectCategory(doc.id),
          ));
        });
      });
    }

    setState(() {
      catData = listCat;
    });
  }

  void accountList() {
    List<Widget> listItems = [];
    FirebaseFirestore.instance
        .collection('accounts')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        listItems.add(ListTile(
          leading: Icon(Icons.circle),
          title: Text(doc['nama_akun']),
          onTap: () => selectAccount(doc['nama_akun']),
        ));
      });
    });
    setState(() {
      accData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    accountList();
    categoryList();
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
                  child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('accounts')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Loading...');
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: accData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, idx2) {
                        return accData[idx2];
                      },
                    );
                  } else
                    return const Text('Error');
                },
              )
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.75,
                  //   child:
                  // ),
                  ),
              Divider(
                color: Colors.black,
                height: 0,
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add_circle_outline, color: Colors.black),
                label: Text('Add New Records',
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
      if (accIndex == 1) {
        selectedAccount = name;
      } else if (accIndex == 2) {
        selectedAccount2 = name;
      }
    });
  }

  Widget transferOpt(int idx) {
    if (idx == 2) {
      return Container(
        //margin: EdgeInsets.only(top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('from:'),
              Column(children: [
                //Text('Category:'),
                TextButton(
                  onPressed: () => setState(() {
                    accountButtonPressed();
                    accIndex = 1;
                  }),
                  child: Text('$selectedAccount'),
                  style: ButtonStyle(),
                ),
              ]),
              Text('to:'),
              Column(children: [
                //Text('Account:'),
                TextButton(
                  onPressed: () => setState(() {
                    accountButtonPressed();
                    accIndex = 2;
                  }),
                  child: Text('$selectedAccount2'),
                  style: ButtonStyle(),
                ),
              ]),
            ]),
      );
    } else {
      return Container(
        //margin: EdgeInsets.only(top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
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
                    accIndex = 1;
                  }),
                  child: Text('$selectedAccount'),
                  style: ButtonStyle(),
                ),
              ]),
            ]),
      );
    }
  }
  // void setAmount(String amount) {
  //   int intAmount = int.parse(amount);
  //   setState(() {
  //     inputAmount = intAmount;
  //   });
  // }

  ///////////////////////////////////////////////////// BUILD STARTS HERE ///////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    CollectionReference trxs =
        FirebaseFirestore.instance.collection('transactions');

    Future<void> addTrx(int amount, note) {
      // Call the user's CollectionReference to add a new user
      return trxs
          .add({
            'akun_trx': selectedAccount, // John Doe
            'catatan_trx': note,
            'jenis_trx': selectedJenis, // Stokes and Sons
            'jumlah_trx': amount, // 42
            'kategori_trx': selectedCategory,
            'tanggal_trx': selectedDate
          })
          .then((value) => print("Trx Added"))
          .catchError((error) => print("Failed to add trx: $error"));
    }

    void alertDialogCategory(BuildContext context) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Text('You have to select category or account!',
                    style: TextStyle(
                      color: Colors.red,
                    )),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              );
            });
          });
    }

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Record",
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
            transferOpt(secondaryIndex),
            Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter record amount';
                            }
                            return null;
                          },
                          controller: amountController,
                          decoration: InputDecoration(
                            hintText: 'Amount',
                            border: OutlineInputBorder(),
                          ),
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyTextInputFormatter(
                              symbol: '$currency',
                              decimalDigits: 0,
                            ),
                          ])),
                  // https://stackoverflow.com/questions/50395032/flutter-textfield-with-currency-format
                  // https://www.youtube.com/watch?v=eWa6iGncZ5Q
                  // https://stackoverflow.com/questions/50736571/when-i-select-a-textfield-the-keyboard-moves-over-it
                  Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: noteController,
                        decoration: InputDecoration(
                          hintText: 'Notes',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                        //maxLines: null,
                      )),
                ])),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  if (selectedCategory == 'Select Category' ||
                      selectedCategory == 'Select Account') {
                    alertDialogCategory(context);
                  } else {
                    addTrx(
                        int.parse(amountController.text
                            .replaceAll('Rp', '')
                            .replaceAll(',', '')
                            .replaceAll('.00', '')),
                        noteController.text);
                    Navigator.pushReplacementNamed(context, '/');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                }
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
