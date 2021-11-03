import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterBy extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FilterByState();
}

class _FilterByState extends State<FilterBy>{
  String selectedCategory = 'Select Category';
  String selectedAccount = 'Select Account';
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(hours: 24 * 3)),
  );

  //displayOpt = 0 daily, 1 weekly, 2 monthly
  int displayOpt = 0;
  //typeOpt = 0 all, 1 expense, 2 income, 3 transfer
  int typeOpt = 0;

  List<String> lst = ['Daily','Monthly'];
  List<String> lstTwo = ['Income','Expense','Transfer'];
  int secondaryIndex = 0;

  void _reset() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => FilterBy(),
      ),
    );
  }

  Future _selectDateRange(BuildContext context) async {
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2035),
    );
    if (newDateRange == null) return;
    setState(() {
      dateRange = newDateRange;
    });
  }


  void categoryButtonPressed(){
    showModalBottomSheet<dynamic>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),),
        ),
        context: context,
        builder: (context){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child:
            Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex:1,
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
                      ]
                  ),
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
                    icon: Icon(Icons.add_circle_outline, color: Colors.black),
                    label: Text('Add New Records',
                        style:TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        )),
                    style:TextButton.styleFrom(
                        minimumSize: Size(500, 0)
                    ),
                  ),
                ]
            ),
          );
        });
  }

  void selectCategory(String name){
    Navigator.pop(context);
    setState(() {
      selectedCategory = name;
    });
  }

  void accountButtonPressed(){
    showModalBottomSheet<dynamic>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),),
        ),
        context: context,
        builder: (context){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child:
            Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex:1,
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
                      ]
                  ),
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
                    icon: Icon(Icons.add_circle_outline, color: Colors.black),
                    label: Text('Add New Records',
                        style:TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        )),
                    style:TextButton.styleFrom(
                        minimumSize: Size(500, 0)
                    ),
                  ),
                ]
            ),
          );
        });
  }

  void selectAccount(String name){
    Navigator.pop(context);
    setState(() {
      selectedAccount = name;
    });
  }

  void changeSecondaryIndex(int index){
    setState(() {
      secondaryIndex = index;
    });
  }
  Widget customRadio2(String txt,int index){
    return OutlineButton(
      onPressed: () => changeSecondaryIndex(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(color: secondaryIndex == index ? Colors.teal : Colors.grey),
      child: Text(txt,style: TextStyle(color: secondaryIndex == index ?Colors.teal : Colors.grey),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Filter By",
            style: TextStyle(
              //fontFamily: 'Quicksand',
              //fontWeight: FontWeight.bold,
              fontSize: 20.0,
            )
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Display Options',
                    style: TextStyle(
                    ),),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      customRadio2(lst[0], 0),
                      customRadio2(lst[1], 1),
                    ],
                  ),
                  Container(padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                      child: Column(
                          children: [
                            Text('Filters',
                              style: TextStyle(
                              ),),
                            Divider(
                              color: Colors.black,
                            ),
                            Text(
                              'By Category',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () => setState((){
                                categoryButtonPressed();
                              }),
                              child: Text('$selectedCategory'),
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
                              onPressed: () => setState((){
                                accountButtonPressed();
                              }),
                              child: Text('$selectedAccount'),
                              style: ButtonStyle(
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 25.0),
                              child: Column(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                     _reset();
                                    },
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                                    icon: Icon(Icons.clear),
                                    label: Text('Clear Filter',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      print(Text('Display Opt: $displayOpt'));
                                      print(Text('Type Opt: $typeOpt'));
                                      Navigator.of(context).pushNamed(
                                        '/passDataToHome',
                                        arguments: 'Hello there from the first page!',
                                      );
                                    },
                                    icon: Icon(Icons.filter_list_alt),
                                    label: Text('Confirm Filter',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )
                                    ),
                                  )
                                ]
                              )
                            )
                          ]
                      )
                  )
                ]
            ),
          ),
        ),
    );
  }

}