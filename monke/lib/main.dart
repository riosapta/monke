import 'package:flutter/material.dart';
import 'record.dart';
import 'HamburgerDrawer.dart';
import 'RecordCard.dart';
import 'recordsData.dart';


void main() {
  runApp(const MyApp());
}
//////////////////////////////// Wrapper Classes /////////////////////////////////////////
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
      home: const MyHomePage(title: 'MonkeGIGA'),
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
  List<Widget> itemsData = [];
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget recordTemplate(record){
    return RecordCard();
  }

  void getPostsData() {
    List<dynamic> responseList = RECORDS_DATA;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(Card(
          margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "${post["date"]}".split(' ')[0],
                    style: TextStyle(
                      fontSize: 12,
                    ),),
                  SizedBox(height: 6.0),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:<Widget>[
                        CircleAvatar(
                          radius: 15,
                          child: Text(
                              'AR',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              )
                          ),
                          backgroundColor: Colors.grey,
                        ),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:<Widget>[
                                      Text(post["category"],
                                          style: TextStyle(
                                            fontSize: 13,)),
                                      Text(post["account"],
                                          style: TextStyle(
                                            fontSize: 10,)),
                                    ]
                                )
                            )
                        ),
                        Text('Rp${post["amount"]}',
                            style:TextStyle(
                              fontSize: 20,
                            )),
                      ]
                  )
                ]
            ),
          )
      ));
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

  void showFilterBy(BuildContext context) => showDialog(
    context: context, barrierDismissible: false,  builder: (BuildContext context) {
    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 451.0,
        width: 500.0,
        padding: EdgeInsets.all(10.0),
        child: Column(
            children: [
              Text('Display Options'),
              Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {},
                    child:
                      Text('Daily'),
                    style: ButtonStyle(
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child:
                      Text('Weekly'),
                    style: ButtonStyle(
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child:
                      Text('Monthly'),
                    style: ButtonStyle(
                    ),
                  ),
                ],
              ),
              Container(padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Column(
                children: [
                  Text('Filters'),
                  Divider(
                    color: Colors.black,
                  ),
                  Text(
                    'By Time',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'From:',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text("${selectedDate.toLocal()}".split(' ')[0]),
                      ),
                      Text(
                        'to:',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text("${selectedDate.toLocal()}".split(' ')[0]),
                      ),
                    ]
                  ),
                  Text(
                    'By Category',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Select Category'),
                    style: ButtonStyle(
                    ),
                  ),
                  Text(
                    'By Type',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Expense'),
                        style: ButtonStyle(
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Income'),
                        style: ButtonStyle(
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Transfer'),
                        style: ButtonStyle(
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'By Account',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Select Category'),
                    style: ButtonStyle(
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child:
                            Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child:
                            Text(
                              'Confirm',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                        ),
                      ]
                  )
                ]
              )
              )
            ]
        ),
      ),
    );
  }
  );


  int _selectedIndex = 0;

  //////////////////////////////// HomePage /////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    List<Record> records = [
      Record(recordDate: selectedDate,category: 'Income',account: 'Bank',amount: 100000),
      Record(recordDate: DateTime.utc(2021, 10, 20),category: 'Expense',account: 'Bank',amount: 200000),
      Record(recordDate: DateTime.utc(2021, 10, 20),category: 'Income',account: 'Cash',amount: 300000),
      Record(recordDate: DateTime.utc(2021, 10, 22),category: 'Income',account: 'Cash',amount: 400000),
    ];


    return Scaffold(
      resizeToAvoidBottomInset: false,
      //////////////////////////////// AppBar /////////////////////////////////////////
      drawer: HamburgerDrawer(),
      appBar: AppBar(
        title: Text(
            "MONKE",
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            )
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () { },
          ),
        ]
      ),
//////////////////////////////// Body /////////////////////////////////////////
      body:
      // SingleChildScrollView(
      //   child:
        Column(
          children: <Widget>[
          //////////////////////////////// INCOME EXPENSE TOTAL /////////////////////////////////////////
          Container(
            padding: EdgeInsets.all(15.0),
            color: Colors.teal[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'INCOME',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      )
                    ),
                    Text(
                        'Rp5.000.000,00',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )
                    ),
                  ]
                ),
                Column(
                    children: <Widget>[
                      Text(
                          'EXPENSE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          )
                      ),
                      Text(
                          'Rp210.000,00',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )
                      ),
                    ]
                ),
                Column(
                    children: <Widget>[
                      Text(
                          'TOTAL',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          )
                      ),
                      Text(
                          'Rp4.790.000,00',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )
                      ),
                    ]
                ),
              ]
            )
          ),


          //////////////////////////////// DATE AND TIME /////////////////////////////////////////
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
                              selectedDate = selectedDate.subtract(const Duration(days: 1));
                            });
                          }
                        ),
                        TextButton(
                            onPressed: () => _selectDate(context),
                            child: Text("${selectedDate.toLocal()}".split(' ')[0]),
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_right_rounded),
                            onPressed: () {
                              setState(() {
                                selectedDate = selectedDate.subtract(const Duration(days: 1));
                              });
                            }
                        ),
                      ],
                  ),
                ),
                  Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.filter_list_alt),
                    onPressed: () => showFilterBy(context),
                  ),
                ),
              ]
            ),
          ),
          Divider(
            color: Colors.black,
          ),


          //////////////////////////////// CONTENT /////////////////////////////////////////
          // SingleChildScrollView(
          //   child: Container(
          //     child: Column(
          //       children: records.map((record) => RecordCard(record: record)).toList(),),
          //   ),
          // ),
          Expanded(
              child: ListView.builder(
                  itemCount: itemsData.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return itemsData[index];
                  })),


        ],

      ),

    // ),

      //////////////////////////////// FLOATING ACTION BUTTON /////////////////////////////////////////
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.add_circle_outline, color: Colors.black),
        label: Text('Add New Records',
            style:TextStyle(
              fontSize: 12,
              color: Colors.black,
            )),
        backgroundColor: Colors.amber[200],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


      //////////////////////////////// BOTTOM NAVIGATION BAR /////////////////////////////////////////
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



