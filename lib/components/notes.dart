
import 'package:flutter/material.dart';


Color stringToColor(String? colorString) {
  if(colorString == null) return Color(0xff00ff00);
  String valueString = colorString.replaceAll('Color(', '');
  String newValueString = valueString.replaceAll(')', '');
  int value = int.parse(newValueString);
  return Color(value).withAlpha(0xFF); // Ensure full opacity .withAlpha(0xFF)
}

class Notes{
  String? title;
  String? description;
  String?  date;
  String? color;

  Notes({this.title,this.description,this.date,this.color});

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    title: json["title"],
    description: json["description"],
    date: json["date"],
    color: json["color"]
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "date": date,
    "color": color,
  };
}