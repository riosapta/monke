import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pieChartSection.dart';
import 'indicator.dart';
import 'pieData.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/percent_indicator.dart';

class mainAnalysis extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _mainAnalysisState();
}
class _mainAnalysisState extends State<mainAnalysis> {
  DateTime selectedDate = DateTime.now();
  int secondaryIndex = 0;
  List<String> lst = ['Expense Overview','Income Overview', 'Expense Flow','Income Flow'];
  List<Widget> itemsData = [];
  int touchedIndex = -1;

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
        Text(txt,style: TextStyle(color: secondaryIndex == index ?Colors.teal : Colors.grey),textAlign: TextAlign.center,),


    );
  }

  void getPostsData() {
    //List<dynamic> responseList = RECORDS_DATA;
    List<Widget> listItems = [];
    FirebaseFirestore.instance
        .collection('transactions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        listItems.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    radius: 15,
                    child: Icon(
                        doc["jenis_trx"] == "Expense"
                            ? Icons.money_off_csred_outlined
                            : doc["jenis_trx"] == "Income"
                            ? Icons.attach_money_outlined
                            : doc["jenis_trx"] == "Transfer"
                            ? Icons.compare_arrows
                            : Icons.close,
                        color: Colors.white),
                    backgroundColor: doc["jenis_trx"] == "Expense"
                        ? Colors.redAccent
                        : doc["jenis_trx"] == "Income"
                        ? Colors.greenAccent[400]
                        : doc["jenis_trx"] == "Transfer"
                        ?Colors.blueAccent
                        :Colors.black,
                  ),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(doc["kategori_trx"],
                            style: TextStyle(
                              fontSize: 14,
                            )),
                        Text('Rp${doc["jumlah_trx"]}',
                            style: TextStyle(
                              fontSize: 14,
                              color: doc["jenis_trx"] == "Expense"
                                  ? Colors.redAccent
                                  : doc["jenis_trx"] == "Income"
                                  ? Colors.greenAccent[400]
                                  : doc["jenis_trx"] == "Transfer"
                                  ?Colors.blueAccent
                                  :Colors.black,
                            )),
                      ],
                    ),
                  subtitle: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width /1.7,
                    animation: true,
                    animationDuration: 2000,
                    lineHeight: 16.0,
                    percent: 0.7,
                    backgroundColor: Colors.grey[200],
                    progressColor: doc["jenis_trx"] == "Expense"
                        ? Colors.redAccent
                        : doc["jenis_trx"] == "Income"
                        ? Colors.greenAccent[400]
                        : doc["jenis_trx"] == "Transfer"
                        ?Colors.blueAccent
                        :Colors.black,
                  ),
                  dense: true,
                  onTap: (){},
                  trailing: Text('70.0%',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Divider(
                    // color: doc["akun_trx"] == "BRI" ? Colors.redAccent : Colors.greenAccent,
                    height: 0,
                    thickness: 0.7,
                  ),
                ),
              ]),
        ));
      });
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
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
          Expanded(
            child:Column(
              children: <Widget>[Padding(
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
              AspectRatio(
                aspectRatio: 2.4,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(touchCallback:
                        (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    }),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 35,

                    sections: getSections(touchedIndex),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 7,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey, width: 1),
                //   borderRadius: BorderRadius.all(
                //       Radius.circular(10.0)
                //   ),
                // ),
                child: ListView.builder(
                  itemCount: 1,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: IndicatorsWidget(),
                          ),
                        ],
                      );
                    },
                  )
              ),
                Text('scroll for more', style: TextStyle(color: Colors.grey[400]),),
              Divider(
                // color: doc["akun_trx"] == "BRI" ? Colors.redAccent : Colors.greenAccent,
                height: 10,
                thickness: 1,
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('transactions')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text('Loading...');
                      } else if (snapshot.hasData){
                        return ListView.builder(
                          itemCount: itemsData.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return itemsData[index];
                          },
                        );
                      } else return const Text ('Error');
                    },
                  )),
                Text('scroll for more', style: TextStyle(color: Colors.grey[400]),),
              // ),
            ]),
          ),


        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     PieChartSample2(),
        //     Text('pengennangis'),
        //   ],
        // ),
      ])
    );
  }
}