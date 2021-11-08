import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class EditAccount extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _editAccountState();
}

class _editAccountState extends State<EditAccount>{
  int secondaryIndex = 0;
  List<String> lstTwo = ['Income','Expense','Transfer'];

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
              "Edit Account",
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
                    // Container(
                    //   margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: <Widget>[
                    //       customRadio2(lstTwo[0], 0),
                    //       customRadio2(lstTwo[1], 1),
                    //       customRadio2(lstTwo[2], 2),
                    //     ],
                    //   ),
                    // ),

                    Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Initial Balance',
                              border: OutlineInputBorder(),
                            ),
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.number,
                            inputFormatters:<TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyTextInputFormatter(
                                  symbol: '$currency'
                              ),
                            ]
                        )
                    ),
                    // https://stackoverflow.com/questions/50395032/flutter-textfield-with-currency-format
                    // https://www.youtube.com/watch?v=eWa6iGncZ5Q
                    // https://stackoverflow.com/questions/50736571/when-i-select-a-textfield-the-keyboard-moves-over-it
                    Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Account Name',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          //maxLines: null,
                        )
                    ),
                    ElevatedButton.icon(
                      onPressed: () {Navigator.pushReplacementNamed(context, '/');},
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