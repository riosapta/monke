import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mainCategories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _mainCategoriesState();
}
class _mainCategoriesState extends State<mainCategories> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Text('Categories'),
        )
    );
  }
}