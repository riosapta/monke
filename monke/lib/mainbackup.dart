//import 'MainFunctions/RecordCard.dart';
//import 'record.dart';

import 'package:flutter/material.dart';
import 'MainFunctions/HamburgerDrawer.dart';
import 'FilterBy.dart';
import 'MainFunctions/Balance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'AddRecords/AddRecord.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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
      routes: {
        '/': (context) => MyHomePage(
          title: 'Homepage',
        ),
        '/filterby': (context) => FilterBy(),
        '/addrecord': (context) => AddRecord(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final tabs = [
    mainPage(),
    Text('Test2'),
    Text('Test3'),
    Text('Test4'),
  ];

  ///////////////////////////////////////////////////////////////////////////////////////////////// WIDGET BUILD MAINFRAME
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      ///////////////////////////////////////////////////////////////////////// AppBar
      drawer: HamburgerDrawer(),
      appBar: AppBar(
          title: Text("MONKE",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              )),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ]
      ),

/////////////////////////////////////////////////////////////////////////  Body
      body: tabs[_selectedIndex],

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

class mainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _mainPageState();
}




/////////////////////////////////////////////////////////////////////////////////////////////////////////  MAINPAGE CLASS

class _mainPageState extends State<mainPage> {
  List<Widget> itemsData = [];
  DateTime selectedDate = DateTime.now();

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

  void getPostsData() {
    //List<dynamic> responseList = RECORDS_DATA;
    List<Widget> listItems = [];
    FirebaseFirestore.instance
        .collection('transactions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        listItems.add(Card(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            child: new InkWell(
                onTap: () {print('tapped');},
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "${doc["tanggal_trx"].toDate()}".split(' ')[0],
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Divider(
                          color: Colors.black,
                        ),
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
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(doc["jenis_trx"],
                                                style: TextStyle(
                                                  fontSize: 13,
                                                )),
                                            Text(doc["akun_trx"],
                                                style: TextStyle(
                                                  fontSize: 10,
                                                )),
                                          ]))),
                              Text('Rp${doc["jumlah_trx"]}',
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                            ])
                      ]),
                )
            )
        )
        );
      });
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
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
                            }),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.filter_list_alt),
                      onPressed: () {
                        Navigator.pushNamed(context, '/filterby');
                      },
                    ),
                  ),
                ]),
          ),
          Divider(
            color: Colors.black,
          ),

          /////////////////////////////////////////////////////////////////////////  CONTENT
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('transactions')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('Loading...');
                  return ListView.builder(
                    itemCount: itemsData.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return itemsData[index];
                    },
                  );
                },
              )),
        ],
      ),

      ///////////////////////////////////////////////////////////////////////// FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton.extended(
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