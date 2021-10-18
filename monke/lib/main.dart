import 'package:flutter/material.dart';
import 'record.dart';


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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
    return Card(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "${record.recordDate.toLocal()}".split(' ')[0],
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
                              Text(record.category,
                                  style: TextStyle(
                                    fontSize: 13,)),
                              Text(record.account,
                                  style: TextStyle(
                                    fontSize: 10,)),
                            ]
                        )
                    )
                  ),
                  Text('Rp${record.amount}',
                  style:TextStyle(
                    fontSize: 20,
                  )),
                ]
              )
            ]
        ),
      )
    );
  }

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
      //////////////////////////////// AppBar /////////////////////////////////////////
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Text(
                        'MONKE',
                        style: TextStyle(
                          fontFamily: 'QuickSand',
                          fontWeight: FontWeight.bold,
                          fontSize: 45.0,
                        )
                    ),
                    Text(
                        'Your Personal Money Manager',
                        style: TextStyle(
                          fontFamily: 'QuickSand',
                          fontSize: 10.5,
                        )
                    ),
                    Container(
                        padding: EdgeInsets.all(22),
                        child:  Text(
                            'Sign In',
                            style: TextStyle(
                              fontFamily: 'QuickSand',
                              //fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            )
                        ),
                    ),
                  ],
                )
              )
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 12,
                child: Text(
                    'AR',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    )
                ),
                backgroundColor: Colors.grey,
              ),
              title: const Text('Profile'),

              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: const Text('Export'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_forever_sharp),
              title: const Text('Delete & Reset'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
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
                    onPressed: () { },
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
                children: records.map((record) => recordTemplate(record)).toList(),
              ),
            )
          )

        ],
      ),
    ));
  }
}
