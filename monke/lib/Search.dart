import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _searchState();
}

class _searchState extends State<Search>{
  String searchText = '';

  Widget getData(){
    if(searchText != ''){
      return Column();
      // enter card data here
    }
    else return Column(
      children: [
        Container(
            padding: EdgeInsets.all(10.0),
            //color: Colors.teal[400],
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
                focusColor: Colors.white,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.text,
              //maxLines: null,
            )
        ),
        Container(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 125,),
                Icon(Icons.search, size: 120),
                Text('Search by notes, category, and account name'),
              ],
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Search"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ]
      ),
      body: SingleChildScrollView (
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(10.0),
                  //color: Colors.teal[400],
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(),
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.text,
                    //maxLines: null,
                  )
              ),
              Container(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 125,),
                      Icon(Icons.search, size: 120),
                      Text('Search by notes, category, and account name'),
                    ],
                  )
              )
            ],
          )
      )
    );
  }

}