import 'package:fl_chart/fl_chart.dart';
import 'pieData.dart';
import 'package:flutter/material.dart';

List<PieChartSectionData> getSections(int touchedIndex) => PieData.data
  .asMap()
  .map<int, PieChartSectionData>((index, data){
    final isTouched = index == touchedIndex;
    final double fontSize = isTouched ? 15 : 10;
    final double radius = isTouched ? 50 : 40;
    final String title = isTouched ? '${data.name}' : '';

    final value = PieChartSectionData(
      color: data.color,
      value: data.percent,
      title: title,
      radius: radius,
      titleStyle: TextStyle(
        fontSize: fontSize,
        color: Colors.black,
      ),
    );

    return MapEntry(index, value);
  })
  .values
  .toList();