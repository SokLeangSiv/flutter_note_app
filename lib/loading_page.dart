import 'dart:async';
import 'package:flutter/material.dart';
import 'package:midterm/pages/create_todo_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(
      MaterialApp(
          home: LoadApp()
      )
  );
}

class LoadApp extends StatefulWidget {
  MyHomePage createState() => MyHomePage();
}

class MyHomePage extends State<LoadApp> {

  // dashBoard(){
  //   Navigator.push(
  //     context,
  //     new MaterialPageRoute(builder: (context) => DashBoard())
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 5),
            () =>
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TodoList())
            )
    );
  }


  @override
  Widget build(BuildContext build) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Welcome To KortTra",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )
                ),

                SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.red : Colors.green,
                      ),
                    );
                  },
                ),
              ]
          )
      ),
    );
  }
}

