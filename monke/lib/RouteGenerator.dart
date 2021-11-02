import 'package:flutter/material.dart';
import 'main.dart';


/////////////// PAGES IMPORT
import 'FilterBy.dart';
import 'Search.dart';
import 'MainFunctions/HamburgerDrawer.dart';
import 'MainFunctions/Balance.dart';
import 'Accounts/mainAccounts.dart';
import 'Accounts/addAccount.dart';
import 'Analysis/mainAnalysis.dart';
import 'Categories/mainCategories.dart';
import 'Categories/addCategory.dart';
import 'AddRecords/AddRecord.dart';
import 'Authentication/mainAuthentication.dart';
import 'Authentication/Login.dart';
import 'Authentication/Signup.dart';
import 'DrawerPages/Profile.dart';
import 'DrawerPages/SettingsPage.dart';
import 'DrawerPages/Export.dart';
import 'DrawerPages/DeleteReset.dart';
import 'DrawerPages/About.dart';

/*
'/': (context) => MyHomePage(
              title: 'Homepage',
            ),
        '/filterby': (context) => FilterBy(),
        '/addrecord': (context) => AddRecord(),
        '/addaccount': (context) => AddAccount(),
        '/addcategory': (context) => AddCategory(),
        '/authentication': (context) => mainAuthentication(),
        '/authentication/login': (context) => Login(),
        '/authentication/signup': (context) => Signup(),
        '/profile': (context) => Profile(),
        '/settings': (context) => SettingsPage(),
        '/export': (context) => Export(),
        '/deletereset': (context) => DeleteReset(),
        '/about': (context) => About(),
        '/search': (context) => Search(),

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage(title: 'MonkeGIGA'));
    };
  }
}*/