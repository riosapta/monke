import 'package:flutter/material.dart';

class HamburgerDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 225.0,
            child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff00A29B),

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
                        Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 11, 0, 0),
                            child: CircleAvatar(
                              radius: 25,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(22, 5, 22, 0),
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
          ),

          ListTile(
            leading: Icon(Icons.account_circle_rounded),
              // CircleAvatar(
              //   radius: 12,
              //   child: Text(
              //       'AR',
              //       style: TextStyle(
              //         fontSize: 10,
              //         color: Colors.white,
              //       )
              //   ),
              //   backgroundColor: Colors.grey,
              // ),
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
    );
  }
}