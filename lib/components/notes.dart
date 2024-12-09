
import 'package:flutter/material.dart';

class Notes{
  String? title;
  String? description;
  String?  date;
  Color? color;

  Notes({this.title,this.description,this.date, this.color});

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    title: json["title"],
    description: json["description"],
    date: json["date"]
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "date": date,
  };
}