import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mainAuthentication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _mainAuthenticationState();
}

class _mainAuthenticationState extends State<mainAuthentication> {
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
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber[200]
                          ),
                          onPressed: () {Navigator.pushNamed(context, '/authentication/login');},
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        'Log in',
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
                      Container(
                        padding: EdgeInsets.only(top:15),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.amber[200]
                            ),
                            onPressed: () {Navigator.pushNamed(context, '/authentication/signup');},
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
                      Container(
                        padding: EdgeInsets.only(top:50),
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/graphics/logo facebook.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Login with Facebook')
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/graphics/logo google.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Login with Google')
                                ],
                              ),
                            ),
                          ],
                        )
                      ),
                    ]
                  )
                )
              ],
            )
          )
        )
      )
    );
  }
}