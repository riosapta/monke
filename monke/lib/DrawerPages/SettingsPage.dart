import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _settingsState();
}

class _settingsState extends State<SettingsPage>{
  String currency = 'IDR';
  String language = 'English';
  bool isSwitched = false;

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
            'Settings',
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
                      SizedBox(height:5),
                      Text(
                          'Appearance',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                            color: Colors.grey
                          )
                      ),
                      ListTile(
                        title: Text(
                          'Currency',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                        subtitle: Text('$currency'),
                        onTap: () => (''),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:5.0),
                        child:
                        Divider(
                          height: 0,
                          thickness: 0.7,
                        ),
                      ),
                      SizedBox(height:15),
                      Text(
                          'Notification',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                          )
                      ),
                      ListTile(
                        title: Text(
                            'Daily Reminder',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            )
                        ),
                        subtitle: Text('Notification to remind you'),
                        onTap: () => (''),
                        trailing: Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.blueAccent,
                          activeColor: Colors.blue,
                        ),
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
