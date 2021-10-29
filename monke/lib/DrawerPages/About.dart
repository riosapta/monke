import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _aboutState();
}

class _aboutState extends State<About>{
  /*void showFilterBy(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) {
  return StatefulBuilder(
  builder: (context, setState) {
  return Dialog(
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20),
  ),
  child: Container());*/

  void showKRN(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
      return StatefulBuilder(
        builder: (context, setState){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
                height: 300.0,
                width: 500.0,
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('MONKE: Money Keeper',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
                  Text('Version BETA0.1',
                      textAlign: TextAlign.center),
                  SizedBox(height: 20),
                  Text('This software was made by Universitas Padjadjaran student which are listed below:',
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Text('140810180030 Rio Sapta Samudera',
                      textAlign: TextAlign.center),
                  Text('140810180046 Kevin Dyandradiva',
                      textAlign: TextAlign.center),
                  Text('140810180048 Nadhifal Rendusara',
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Text('With the help of Lecturer:',
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Text('Mira Suryani, S.Pd., M.Kom.',
                      textAlign: TextAlign.center),
                  Text('Aditya Pradana, S.T., M.Eng.',
                      textAlign: TextAlign.center),
                ],
              )
            ),
          );
        }
      );
    }
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                  'About',
                  style: TextStyle(
                    color: Colors.black,
                  )
              ),
              centerTitle: true,
            ),
            body: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [
                    Divider(color: Colors.black),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                                'Privacy policy',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            onTap: () => (''),
                          ),
                          ListTile(
                            title: Text(
                                'MONKE vBETA0.1',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            subtitle: Text('Developed by KRN'),
                            onTap: () => showKRN(context),
                          ),
                        ]
                    ),
                  ],
                )
            )
        )
    );
  }
}
