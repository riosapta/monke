/*
 Text(
                              'By Time',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  Text(
                                    'From:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => _selectDateRange(context),
                                    child: Text(
                                        "${dateRange.start.toLocal()}".split(
                                            ' ')[0]),
                                  ),
                                  Text(
                                    'to:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => _selectDateRange(context),
                                    child: Text(
                                        "${dateRange.end.toLocal()}".split(
                                            ' ')[0]),
                                  ),
                                ]
                            ),
 */


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
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
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
              onPressed: () {Navigator.pushNamed(context, '/search');},
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
/////////////////////////////////////////////////////////////////////////////////////////////////////////// DETAILS
  void showDetails(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                        width: 500,
                        height: 320,
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
                                //padding: EdgeInsets.all(10),
                                //define the background color
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.cancel_outlined)),
                                      SizedBox(width: 10,),
                                      Container(
                                        //margin: EdgeInsets.only(left:30),
                                        child: Text('Income',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                          children: [
                                            IconButton(onPressed: () {
                                              Navigator.pushNamed(context, '/editrecord');
                                            }, icon: Icon(Icons.edit)), /////////////////////////////////////////EDIT
                                            IconButton(onPressed: () {

                                            }, icon: Icon(Icons.delete)), /////////////////////////////////////DELETE
                                          ]
                                      )
                                    ]
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Text('Rp100,000.00',
                                              style: TextStyle(
                                                fontSize: 20,
                                                //fontWeight: FontWeight.bold,
                                              ),
                                            )
                                        ),
                                      ),
                                      Divider(color: Colors.black,),
                                      SizedBox(height:5),
                                      Container(
                                          padding: EdgeInsets.symmetric(horizontal: 45),
                                          child: Column(
                                              children:[
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Category',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.bold,
                                                          )),
                                                      SizedBox(width: 20),
                                                      Text('Salary')
                                                    ]
                                                ),
                                                SizedBox(height:5),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Account',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.bold,
                                                          )),
                                                      SizedBox(width: 20),
                                                      Text('Bank')
                                                    ]
                                                ),
                                                SizedBox(height:5),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Time',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.bold,
                                                          )),
                                                      Text('3 Oct 2021, 11.23AM')
                                                    ]
                                                ),
                                              ]
                                          )
                                      ),
                                      SizedBox(height:20),
                                      Text('Note',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Container(
                                          height: 100,
                                          margin: EdgeInsets.only(top:5),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Colors.grey,
                                          ),
                                          child: Flex(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            direction: Axis.horizontal,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text('pengen nangis')
                                              )
                                            ],
                                          )
                                      )
                                    ],
                                  )
                              ),
                            ]
                        )
                    )
                );
              }
          );
        }
    );
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
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////// GETPOSTDATA
  void getPostsData() {
    //List<dynamic> responseList = RECORDS_DATA;
    List<Widget> listItems = [];
    FirebaseFirestore.instance
        .collection('transactions')
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
                    child: Icon(doc["akun_trx"] == "BRI" ? Icons.money_off_csred_outlined : Icons.attach_money_outlined, color: Colors.white),
                    backgroundColor: doc["akun_trx"] == "BRI" ? Colors.redAccent : Colors.greenAccent,
                  ),
                  title: Text(doc["jenis_trx"],
                      style: TextStyle(
                        fontSize: 13,
                      )),
                  subtitle:
                  Column(
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
                  onTap: () => showDetails(context),
                  trailing:Text('Rp${doc["jumlah_trx"]}',
                      style: TextStyle(
                        fontSize: 20,
                        color: doc["akun_trx"] == "BRI" ? Colors.redAccent : Colors.greenAccent[400],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child:
                  Divider(
                    // color: doc["akun_trx"] == "BRI" ? Colors.redAccent : Colors.greenAccent,
                    height: 0,
                    thickness: 0.7,
                  ),
                ),
              ]),
        )

          //     Card(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(15.0),
          //     ),
          //     margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
          //     child: new InkWell(
          //       onTap: () {showDetails(context);}, ///////////////////////////////// onTap!!!!
          //       child: Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.stretch,
          //             children: <Widget>[
          //               Text(
          //                 "${doc["tanggal_trx"].toDate()}".split(' ')[0],
          //                 style: TextStyle(
          //                   fontSize: 12,
          //                 ),
          //               ),
          //               SizedBox(height: 6.0),
          //               Divider(
          //                 color: Colors.black,
          //               ),
          //               Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                   children: <Widget>[
          //                     CircleAvatar(
          //                       radius: 15,
          //                       child: Text('AR',
          //                           style: TextStyle(
          //                             fontSize: 10,
          //                             color: Colors.white,
          //                           )),
          //                       backgroundColor: Colors.grey,
          //                     ),
          //                     Expanded(
          //                         child: Container(
          //                             padding: EdgeInsets.all(10),
          //                             child: Column(
          //                                 crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                                 children: <Widget>[
          //                                   Text(doc["jenis_trx"],
          //                                       style: TextStyle(
          //                                         fontSize: 13,
          //                                       )),
          //                                   Text(doc["akun_trx"],
          //                                       style: TextStyle(
          //                                         fontSize: 10,
          //                                       )),
          //                                 ]))),
          //                     Text('Rp${doc["jumlah_trx"]}',
          //                         style: TextStyle(
          //                           fontSize: 20,
          //                         )),
          //                   ])
          //             ]),
          //       )
          //     )
          // )
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
            color: Colors.grey[400],
            height: 0,
          ),

          /////////////////////////////////////////////////////////////////////////  CONTENT
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('transactions')
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
              )
          ),
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



