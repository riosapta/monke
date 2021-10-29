import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteReset extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _deleteResetState();
}

class _deleteResetState extends State<DeleteReset>{
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
                  'Delete & Reset',
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
                                'Delete all records',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            subtitle: Text('Delete all records, but keep everything else.'),
                            onTap: () => (''),
                          ),
                          ListTile(
                            title: Text(
                                'Reset all',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            subtitle: Text('Reset everything, reverting the app to its initial state.'),
                            onTap: () => (''),
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
