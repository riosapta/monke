import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:monke/RouteGenerator.dart';

/////////////// PAGES IMPORT
import 'MainFunctions/HamburgerDrawer.dart';
import 'MainFunctions/Balance.dart';
import 'Accounts/mainAccounts.dart';
import 'Analysis/mainAnalysis.dart';
import 'Categories/mainCategories.dart';
import 'globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

int testaja = 0;

/////////////////////////////////////////////////////////////////////////  Wrapper Classes
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MonkeGIGA',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String data;

  const MyHomePage({Key? key, required this.title, required this.data})
      : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final tabs = [
    mainPage(''),
    mainAccounts(),
    mainAnalysis(),
    mainCategories(),
  ];

  ///////////////////////////////////////////////////////////////////////////////////////////////// WIDGET BUILD MAINFRAME
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      ///////////////////////////////////////////////////////////////////////// AppBar
      drawer: HamburgerDrawer(),
      appBar: AppBar(
          title: Text('MONKE', //widget.data,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              )),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
          ]),

/////////////////////////////////////////////////////////////////////////  Body
      body: IndexedStack(
        index: _selectedIndex,
        children: tabs,
      ),

      //  tabs[_selectedIndex],
      /////////////////////////////////////////////////////////////////////////  BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.teal[400],
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber[200],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_sharp),
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_sharp),
            label: 'Categories',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class mainPage extends StatefulWidget {
  final arguments;
  const mainPage(this.arguments);

  @override
  State<StatefulWidget> createState() => _mainPageState();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////  MAINPAGE CLASS

class _mainPageState extends State<mainPage> {
  List<Widget> itemsData = [];
  List<Widget> tempItemsData = [];
  DateTime selectedDate = DateTime.now();
  CollectionReference deleteTrx =
      FirebaseFirestore.instance.collection('transactions');
  var _counter = ValueNotifier<int>(0);
  final Widget goodJob = const Text('Good job!');
/////////////////////////////////////////////////////////////////////////////////////////////////////////// DETAILS
  void showDetails(BuildContext context, DocumentSnapshot doc) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                    width: 500,
                    height: 320,
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
                        //padding: EdgeInsets.all(10),
                        //define the background color
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.cancel_outlined)),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                //margin: EdgeInsets.only(left:30),
                                child: Text(
                                  doc["jenis_trx"],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(children: [
                                IconButton(
                                    onPressed: () {
                                      selectedDocEdit(
                                          doc.id,
                                          doc["akun_trx"],
                                          doc["catatan_trx"],
                                          doc["jenis_trx"],
                                          doc["jumlah_trx"],
                                          doc["kategori_trx"],
                                          doc["tanggal_trx"]);
                                      Navigator.pushNamed(
                                          context, '/editrecord',
                                          arguments: {'docID': doc.id});
                                    },
                                    icon: Icon(Icons
                                        .edit)), /////////////////////////////////////////EDIT
                                IconButton(
                                    onPressed: () {
                                      deleteField(doc.id);
                                      updateAllData();
                                      getPostsData();
                                    },
                                    icon: Icon(Icons
                                        .delete)), /////////////////////////////////////DELETE
                              ])
                            ]),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Rp${doc["jumlah_trx"]}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              SizedBox(height: 5),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 45),
                                  child: Column(children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Category',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          SizedBox(width: 20),
                                          Text(doc["kategori_trx"])
                                        ]),
                                    SizedBox(height: 5),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Account',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          SizedBox(width: 20),
                                          Text(doc["akun_trx"])
                                        ]),
                                    SizedBox(height: 5),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Time',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text("${doc["tanggal_trx"].toDate()}"
                                              .split(' ')[0])
                                        ]),
                                  ])),
                              SizedBox(height: 20),
                              Text('Note',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Container(
                                  height: 100,
                                  margin: EdgeInsets.only(top: 5),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey,
                                  ),
                                  child: Flex(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text(doc["catatan_trx"]))
                                    ],
                                  ))
                            ],
                          )),
                    ])));
          });
        });
  }

  void selectedDocEdit(docID, initAccount, initNote, initJenis, initJumlah,
      initCategory, initDate) {
    globals.globDocID = docID;
    globals.initAccount = initAccount;
    globals.initNote = initNote;
    globals.initJenis = initJenis;
    globals.initJumlah = initJumlah;
    globals.initCategory = initCategory;
    globals.initDate = initDate.toDate();
    print(globals.globDocID);
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////// SELECTDATE
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
    getPostsData();
    startTheCounter();
  }

  Future<void> deleteField(docID) {
    return deleteTrx
        .doc(docID)
        .delete()
        .then((value) => print("Trx Deleted"))
        .catchError((error) => print("Failed to delete Trx: $error"));
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////// GETPOSTDATA
  void getPostsData() {
    //List<dynamic> responseList = RECORDS_DATA;
    List<Widget> listItems = [];
    DateTime _start =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 0, 0);
    DateTime _end = DateTime(
        selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);
    FirebaseFirestore.instance
        .collection('transactions')
        .where('tanggal_trx', isGreaterThanOrEqualTo: _start)
        .where('tanggal_trx', isLessThanOrEqualTo: _end)
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
                    radius: 20,
                    child: Icon(
                        doc["jenis_trx"] == "Expense"
                            ? Icons.money_off_csred_outlined
                            : doc["jenis_trx"] == "Income"
                                ? Icons.attach_money_outlined
                                : doc["jenis_trx"] == "Transfer"
                                    ? Icons.compare_arrows
                                    : Icons.close,
                        color: Colors.white),
                    backgroundColor: doc["jenis_trx"] == "Expense"
                        ? Colors.redAccent
                        : doc["jenis_trx"] == "Income"
                            ? Colors.greenAccent[400]
                            : doc["jenis_trx"] == "Transfer"
                                ? Colors.blueAccent
                                : Colors.black,
                  ),
                  title: Text(doc["kategori_trx"],
                      style: TextStyle(
                        fontSize: 13,
                      )),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doc["akun_trx"],
                          style: TextStyle(
                            fontSize: 12,
                          )),
                      Text(
                        "${doc["tanggal_trx"].toDate()}".split(' ')[0],
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  dense: true,
                  onTap: () => showDetails(context, doc),
                  trailing: Text('Rp${doc["jumlah_trx"]}',
                      style: TextStyle(
                        fontSize: 20,
                        color: doc["jenis_trx"] == "Expense"
                            ? Colors.redAccent
                            : doc["jenis_trx"] == "Income"
                                ? Colors.greenAccent[400]
                                : doc["jenis_trx"] == "Transfer"
                                    ? Colors.blueAccent
                                    : Colors.black,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Divider(
                    // color: doc["akun_trx"] == "BRI" ? Colors.redAccent : Colors.greenAccent,
                    height: 0,
                    thickness: 0.7,
                  ),
                ),
              ]),
        ));
      });
    });
    itemsData = listItems;
    tempItemsData = itemsData;
  }

  void updateAllData() {
    num income = 0;
    num expense = 0;
    num inex = 0;
    num totAkun = 0;

    FirebaseFirestore.instance
        .collection('transactions')
        .where('jenis_trx', isEqualTo: 'Income')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        income = income + doc['jumlah_trx'];

        FirebaseFirestore.instance
            .collection('inexData')
            .doc('inex')
            .update({'jumlah_in': income})
            .then((value) => print("Income Updated"))
            .catchError((error) => print("Failed to update Income: $error"));
      });
    });

    FirebaseFirestore.instance
        .collection('transactions')
        .where('jenis_trx', isEqualTo: 'Expense')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        expense = expense + doc['jumlah_trx'];

        FirebaseFirestore.instance
            .collection('inexData')
            .doc('inex')
            .update({'jumlah_ex': expense})
            .then((value) => print("expense Updated"))
            .catchError((error) => print("Failed to update expense: $error"));
      });
    });

    FirebaseFirestore.instance
        .collection('transactions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        inex = inex + doc['jumlah_trx'];

        FirebaseFirestore.instance
            .collection('inexData')
            .doc('inex')
            .update({'jumlah_inex': inex})
            .then((value) => print("inex Updated"))
            .catchError((error) => print("Failed to update inex: $error"));
      });
    });

    FirebaseFirestore.instance
        .collection('accounts')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        totAkun = totAkun + doc['jumlah_akun'];

        FirebaseFirestore.instance
            .collection('inexData')
            .doc('inex')
            .update({'total_account': totAkun})
            .then((value) => print("totAkun Updated"))
            .catchError((error) => print("Failed to update totAkun: $error"));
      });
    });
  }

  void startTheCounter() async {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      _counter.value += 1;
      print(_counter);
    }
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    updateAllData();
    startTheCounter();
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////  MAINPAGE BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ///////////////////////////////////////////////////////////////////////// BALANCE
          Balance(),
          // balance gw pindahin keluar, biar bisa dipake banyak page.

          ///////////////////////////////////////////////////////////////////////// DATE AND TIME
          Container(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                            icon: const Icon(Icons.keyboard_arrow_left_rounded),
                            onPressed: () {
                              setState(() {
                                selectedDate = selectedDate
                                    .subtract(const Duration(days: 1));
                              });
                              getPostsData();
                              startTheCounter();
                            }),
                        TextButton(
                          onPressed: () => _selectDate(context),
                          child:
                              Text("${selectedDate.toLocal()}".split(' ')[0]),
                        ),
                        IconButton(
                            icon:
                                const Icon(Icons.keyboard_arrow_right_rounded),
                            onPressed: () {
                              setState(() {
                                selectedDate =
                                    selectedDate.add(const Duration(days: 1));
                              });
                              getPostsData();
                              startTheCounter();
                            }),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.filter_list_alt),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/filterby');
                      },
                    ),
                  ),
                ]),
          ),
          Divider(
            color: Colors.grey[400],
            height: 0,
          ),

          /////////////////////////////////////////////////////////////////////////  CONTENT
          ValueListenableBuilder<int>(
            builder: (BuildContext context, int value, Widget? child) {
              // This builder will only get called when the _counter
              // is updated.
              return Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('transactions')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Loading...');
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return itemsData[index];
                      },
                    );
                  } else
                    return const Text('Error');
                },
              ));
            },
            valueListenable: _counter,
            // The child parameter is most helpful if the child is
            // expensive to build and does not depend on the value from
            // the notifier.
            child: goodJob,
          ),
          // Expanded(
          //     child: StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance
          //       .collection('transactions')
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return const Text('Loading...');
          //     } else if (snapshot.hasData) {
          //       return ListView.builder(
          //         itemCount: itemsData.length,
          //         physics: BouncingScrollPhysics(),
          //         itemBuilder: (context, index) {
          //           return itemsData[index];
          //         },
          //       );
          //     } else
          //       return const Text('Error');
          //   },
          // )),
        ],
      ),

      ///////////////////////////////////////////////////////////////////////// FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "btn1",
        onPressed: () => Navigator.pushNamed(context, '/addrecord'),
        icon: Icon(Icons.add_circle_outline, color: Colors.black),
        label: Text('Add New Records',
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

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
