import 'package:flutter/material.dart';
import 'main.dart';
import 'FilterBy.dart';
import 'Search.dart';
import 'Accounts/addAccount.dart';
import 'Accounts/editAccount.dart';
import 'Accounts/detailsAccount.dart';
import 'Categories/addCategory.dart';
import 'Categories/editCategory.dart';
import 'AddRecords/AddRecord.dart';
import 'AddRecords/EditRecord.dart';
import 'Authentication/mainAuthentication.dart';
import 'Authentication/Login.dart';
import 'Authentication/Signup.dart';
import 'DrawerPages/Profile.dart';
import 'DrawerPages/SettingsPage.dart';
import 'DrawerPages/Export.dart';
import 'DrawerPages/DeleteReset.dart';
import 'DrawerPages/About.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage(title: 'MonkeGIGA'));
      case '/filterby':
        return MaterialPageRoute(builder: (_) => FilterBy());
      case '/addrecord':
        return MaterialPageRoute(builder: (_) => AddRecord());
      case '/addaccount':
        return MaterialPageRoute(builder: (_) => AddAccount());
      case '/addcategory':
        return MaterialPageRoute(builder: (_) => AddCategory());
      case '/editrecord':
        return MaterialPageRoute(builder: (_) => EditRecord());
      case '/editaccount':
        return MaterialPageRoute(builder: (_) => EditAccount());
      case '/editcategory':
        return MaterialPageRoute(builder: (_) => EditCategory());
      case '/detailsaccount':
        return MaterialPageRoute(builder: (_) => DetailsAccount());
      case '/authentication':
        return MaterialPageRoute(builder: (_) => mainAuthentication());
      case '/authentication/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/authentication/signup':
        return MaterialPageRoute(builder: (_) => Signup());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/export':
        return MaterialPageRoute(builder: (_) => Export());
      case '/deletereset':
        return MaterialPageRoute(builder: (_) => DeleteReset());
      case '/about':
        return MaterialPageRoute(builder: (_) => About());
      case '/search':
        return MaterialPageRoute(builder: (_) => Search());
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    };
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

/*
        routes: {
        '/': (context) => MyHomePage(
              title: 'Homepage',
            ),
        '/filterby': (context) => FilterBy(),
        '/addrecord': (context) => AddRecord(),
        '/addaccount': (context) => AddAccount(),
        '/addcategory': (context) => AddCategory(),
        '/editrecord': (context) => EditRecord(),
        '/editaccount': (context) => EditAccount(),
        '/editcategory': (context) => EditCategory(),
        '/detailsaccount': (context) => DetailsAccount(),
        '/authentication': (context) => mainAuthentication(),
        '/authentication/login': (context) => Login(),
        '/authentication/signup': (context) => Signup(),
        '/profile': (context) => Profile(),
        '/settings': (context) => SettingsPage(),
        '/export': (context) => Export(),
        '/deletereset': (context) => DeleteReset(),
        '/about': (context) => About(),
        '/search': (context) => Search(),
      },
*/

