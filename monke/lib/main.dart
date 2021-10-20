import 'package:flutter/material.dart';
import 'record.dart';
import 'HamburgerDrawer.dart';
import 'RecordCard.dart';


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
        primarySwatch: Colors.grey,
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
                    child: Text('Daily'),
                    style: ButtonStyle(
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Weekly'),
                    style: ButtonStyle(
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Monthly'),
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
                  Text('By Time'),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('From:'),
                      TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text("${selectedDate.toLocal()}".split(' ')[0]),
                      ),
                      Text('From:'),
                      TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text("${selectedDate.toLocal()}".split(' ')[0]),
                      ),
                    ]
                  ),
                  Text('By Category'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Select Category'),
                    style: ButtonStyle(
                    ),
                  ),
                  Text('By Type'),
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
                  Text('By Account'),
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
                          onPressed: () {},
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Confirm'),
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
      Record(recordDate: selectedDate,category: 'Expense',account: 'Bank',amount: 200000),
      Record(recordDate: selectedDate,category: 'Income',account: 'Cash',amount: 300000),
      Record(recordDate: selectedDate,category: 'Income',account: 'Cash',amount: 400000),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
          //////////////////////////////// INCOME EXPENSE TOTAL /////////////////////////////////////////
          Container(
            padding: EdgeInsets.all(15.0),
            color: Colors.grey[350],
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
                          color: Colors.green,
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
                            color: Colors.red,
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
                          icon: const Icon(Icons.skip_previous),
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
                          icon: const Icon(Icons.skip_next),
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
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: records.map((record) => RecordCard(record: record)).toList(),),
            ),
          ),


        ],

      ),

    ),

      //////////////////////////////// FLOATING ACTION BUTTON /////////////////////////////////////////
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.add_circle_outline),
        label: Text('Add New Records',
            style:TextStyle(
              fontSize: 12,
            )),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


      //////////////////////////////// BOTTOM NAVIGATION BAR /////////////////////////////////////////
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
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



