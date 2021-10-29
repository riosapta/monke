import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _signupState();
}

class _signupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Center(
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 80),
                          Image.asset('assets/graphics/logo proto.png',
                            height: 110,
                            width: 110,
                          ),
                          Text("MONKE",
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 50.0,
                              )
                          ),
                          Text("Your Personal Money Manager",
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                //fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              )
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
                              child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(10),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Username',
                                            border: OutlineInputBorder(),
                                          ),
                                          keyboardType: TextInputType.text,
                                          //maxLines: null,
                                        )
                                    ),
                                    Container(
                                        margin: EdgeInsets.all(10),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Password',
                                            border: OutlineInputBorder(),
                                          ),
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          //maxLines: null,
                                        )
                                    ),
                                    Container(
                                        margin: EdgeInsets.all(10),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Re-type password',
                                            border: OutlineInputBorder(),
                                          ),
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          //maxLines: null,
                                        )
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top:15),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.amber[200]
                                          ),
                                          onPressed: () {},
                                          child: Container(
                                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                              child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          'Sign up',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.black,
                                                          )
                                                      ),
                                                    )
                                                  ]
                                              )
                                          )
                                      ),
                                    ),
                                  ]
                              )
                          )
                        ],
                      )
                  )
              ),
            )
        )
    );
  }
}