import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _profileState();
}

class _profileState extends State<Profile>{

  String name = 'Username';
  String gender = 'Gender';
  DateTime birthday = DateTime.now();

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        print('Insert Sign out Here');
        break;
      case 1:
        print('Insert Edit Here');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Profile",
              style: TextStyle(
                //fontFamily: 'Quicksand',
                //fontWeight: FontWeight.bold,
                //fontSize: 30.0,
              )),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text('Sign out'),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text('Edit'),
                ),
              ],
            ),
          ]
      ),
      body: Container(
        padding: EdgeInsets.only(top: 45),
        child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                ),
                SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name:'),
                    SizedBox(width: 15),
                    Text('$name'),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Gender:'),
                    SizedBox(width: 15),
                    Text('$gender'),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name:'),
                    SizedBox(width: 15),
                    Text("${birthday.toLocal()}".split(' ')[0]),
                  ],
                ),
              ],
            )
        )
      )
    );
  }
  
}