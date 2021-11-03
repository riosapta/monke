import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'pieChart.dart';

class mainAnalysis extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _mainAnalysisState();
}
class _mainAnalysisState extends State<mainAnalysis> {
  DateTime selectedDate = DateTime.now();
  int secondaryIndex = 0;
  List<String> lst = ['Expense Overview','Income Overview', 'Expense Flow','Income Flow'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2035));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  void changeSecondaryIndex(int index){
    setState(() {
      secondaryIndex = index;
    });
  }

  Widget customRadio(String txt,int index){
    return ElevatedButton(
      onPressed: () => changeSecondaryIndex(index),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(50, 40.0),
        maximumSize: Size(95, 110),
        primary: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        side: BorderSide(color: secondaryIndex == index ? Colors.teal : Colors.grey, width: 2),
      ),
      child:
        Flexible(
          child:
          Text(txt,style: TextStyle(color: secondaryIndex == index ?Colors.teal : Colors.grey),textAlign: TextAlign.center,),
        )

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Column(
            children: <Widget>[

      ///////////////////////////////////////////////////////////////////////// DATE AND TIME
        Container(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.keyboard_arrow_left_rounded),
                          onPressed: () {
                            setState(() {
                              selectedDate = selectedDate
                                  .subtract(const Duration(days: 1));
                            });
                          }),
                      TextButton(
                        onPressed: () => _selectDate(context),
                        child:
                        Text("${selectedDate.toLocal()}".split(' ')[0]),
                      ),
                      IconButton(
                          icon:
                          const Icon(Icons.keyboard_arrow_right_rounded),
                          onPressed: () {
                            setState(() {
                              selectedDate =
                                  selectedDate.add(const Duration(days: 1));
                            });
                          }),
                      ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.filter_list_alt),
                    onPressed: () {
                      Navigator.pushNamed(context, '/filterby');
                    },
                  ),
                ),
              ]),
          ),
          Divider(
            color: Colors.grey[400],
            height: 0,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                customRadio(lst[0], 0),
                customRadio(lst[1], 1),
                customRadio(lst[2], 2),
                customRadio(lst[3], 3),
              ],
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PieChartSample2(),
            Text('pengennangis'),
          ],
        ),
      ])
    );
  }
}