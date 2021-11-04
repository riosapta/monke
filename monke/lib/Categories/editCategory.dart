import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class EditCategory extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _editCategoryState();
}

class _editCategoryState extends State<EditCategory>{
  int secondaryIndex = 0;
  List<String> lstTwo = ['Income','Expense'];

  String currency = 'Rp'; ///////////////////////////////////////////////////////////////////////////////// CURRENCY

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

  ///////////////////////////////////////////////////// BUILD STARTS HERE ///////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Edit Category",
              style: TextStyle(
                //fontFamily: 'Quicksand',
                //fontWeight: FontWeight.bold,
                fontSize: 20.0,
              )
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                          children: [
                            //Text('Account:'),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Category Type'),
                                customRadio2(lstTwo[0], 0),
                                customRadio2(lstTwo[1], 1),
                              ],
                            ),
                          ]
                      ),
                    ),

                    Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Category Name',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          //maxLines: null,
                        )
                    ),
                    ElevatedButton.icon(
                      onPressed: () {Navigator.of(context).maybePop();},
                      icon: Icon(Icons.edit),
                      label: Text('Edit',
                          style: TextStyle(
                            fontSize: 16,
                          )
                      ),
                    )
                  ],
                )
            )
        )
    );
  }

}