import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(name: 'Category x', percent: 40, color: Colors.redAccent),
    Data(name: 'Category y', percent: 30, color: Colors.greenAccent.shade400),
    Data(name: 'Category z', percent: 15, color: Colors.amberAccent),
    Data(name: 'Category x', percent: 40, color: Colors.greenAccent),
    Data(name: 'Category y', percent: 30, color: Colors.deepPurpleAccent.shade400),
    Data(name: 'Category z', percent: 15, color: Colors.pinkAccent),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({required this.name, required this.percent, required this.color});
}