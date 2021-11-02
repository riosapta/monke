import 'package:flutter/material.dart';
import 'addCategory.dart' as category;

class ListCategory extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _listCategory();
}

class _listCategory extends State<ListCategory> {
  final numbers = List.generate(100, (index) => '$index');
  List<IconData> iconTypes = [
    Icons.cake,
    Icons.add_location_sharp,
    Icons.zoom_in_outlined,
    Icons.auto_awesome_motion,
    Icons.call_end_sharp,
    Icons.equalizer_rounded,
    Icons.wifi_lock,
    Icons.mail,
    Icons.cake,
    Icons.add_location_sharp,
    Icons.zoom_in_outlined,
    Icons.auto_awesome_motion,
    Icons.call_end_sharp,
    Icons.equalizer_rounded,
    Icons.wifi_lock,
    Icons.mail,
  ];
  List<String> catName = ['Cat A','Cat B','Cat C','Cat D','Cat E','Cat F','Cat G','Cat H',
    'Cat I','Cat J','Cat K','Cat L','Cat M','Cat N','Cat O','Cat Q',
  ];
  var list = new List<int>.generate(16, (i) => i + 1);
  int pickedIndex = 0;
  List<String> lstTwo = ['Income','Expense'];

  void changePickedIndex(int idx){
    setState(() {
      pickedIndex = list[idx];
    });
  }

  Widget customRadio(IconData iconTypes, String name, int idx, int idx2){
    return
      GridTile(
        child: Center(
          child:
            OutlinedButton(
              onPressed: () => changePickedIndex(idx2-1),
              child: Icon(iconTypes, color: pickedIndex == idx2 ? Colors.white : Colors.white70),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(18),
                primary: category.addCategoryState.secondaryIndex == 1 ? Colors.redAccent : Colors.greenAccent,
                side: BorderSide(color: pickedIndex == idx2 ? Colors.teal : Colors.white, width: 3)// <-- Button color
              ),
            )
        ),
        // footer: Text(
        //   name,
        //   textAlign: TextAlign.center,
        // ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return buildGridView();
  }

  Widget buildGridView() => GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5,
      childAspectRatio: 1,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
    ),
    padding: const EdgeInsets.all(4),
    itemCount: iconTypes.length,
    itemBuilder: (context, index) {
      final item = iconTypes[index];
      final name = catName[index];
      final idx = list[index];

      return buildNumber(item, name, pickedIndex, idx);
    },
  );

  Widget buildNumber(IconData iconTypes, String name, int idx, int idx2) => Container(
    padding: EdgeInsets.all(4),
    // color: Colors.orange,
    child:customRadio(iconTypes, name, idx, idx2)
    // GridTile(
    //   child: Center(
    //     child: CircleAvatar(
    //       radius: 25,
    //       child: Icon(iconTypes, color: Colors.white),
    //       backgroundColor: Colors.redAccent,
    //     ),
    //   ),
    //   footer: Text(
    //     name,
    //     textAlign: TextAlign.center,
    //   ),
    // ),
  );
}