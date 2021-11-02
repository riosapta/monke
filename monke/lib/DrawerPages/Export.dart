import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Export extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _exportState();
}

class _exportState extends State<Export>{
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(hours: 24 * 3)),
  );

  Future _selectDateRange(BuildContext context) async {
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2035),
    );
    if (newDateRange == null) return;
    setState(() {
      dateRange = newDateRange;
    });
  }

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
                'Export',
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
                Container(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height:70),
                      Icon(Icons.document_scanner_outlined, color: Colors.grey, size: 120),
                      SizedBox(height:15),
                      Text(
                        'All records between set time range can be exported as a worksheet (.csv format)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height:35),


                      Text(
                        'From:',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _selectDateRange(context),
                        child: Text(
                            "${dateRange.start.toLocal()}".split(
                                ' ')[0]),
                      ),
                      Text(
                        'to:',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _selectDateRange(context),
                        child: Text(
                            "${dateRange.end.toLocal()}".split(
                                ' ')[0]),
                      ),
                      SizedBox(height:35),



                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.exit_to_app),
                        label: Text('Export',
                            style: TextStyle(
                              fontSize: 16,
                            )
                        ),
                      )
                    ]
                  ),
                )
              ],
            )
          )
        )
    );
  }

}