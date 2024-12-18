import 'package:flutter/material.dart';
import 'package:midterm/pages/home_page.dart';

import 'loading_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'vattanak is not here',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: Colors.yellow[50], // body background color
        appBarTheme: const AppBarTheme( // pre-design for appbar
          backgroundColor: Colors.yellow,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        )
      ),
      home: LoadApp() ,
    );
  }
}