import 'package:flutter/material.dart';
import 'package:midterm/components/note_tile.dart';
import 'package:midterm/pages/note_detail.dart';
import 'package:midterm/pages/create_todo_page.dart';
import 'package:midterm/components/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Notes> notes = List.empty(growable: true);
  late SharedPreferences sp; // declare share_preference object as global
  // String? result = "result";

  getSharedPreferences() async{
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  saveIntoSp() async{
    sp = await SharedPreferences.getInstance();
    List<String> datas = notes.map((note) => jsonEncode(note.toJson())).toList(); // convert List<object> to List<String>
    sp.setStringList("notes", datas);
  } // responce for delete in this page, it delete and then save the data

  readFromSp(){
    List<String>? NotesListString =  sp.getStringList("notes");
    if(NotesListString != null){
      notes = NotesListString.map((note) => Notes.fromJson(jsonDecode(note))).toList();
    }
    setState(() {

    }); // use to re-render the current state. because we want to display new result on widget
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> notes = [ // Updated to store Color as dynamic
    //   {
    //     'title': 'Home Page',
    //     'subtitle': 'This is the home page.vattanak is a gay always love to fap alone at homoe in the toliet and he always waering the headphone to watch porn at home ',
    //     'date': '2021-10-10',
    //     'color': Colors.yellow[100], // Color object
    //   },
    //   {
    //     'title': 'About Page',
    //     'subtitle': 'This is the about page.',
    //     'date': '2021-10-11',
    //     'color': Colors.red[100], // Color object
    //   },
    //   {
    //     'title': 'Contact Page',
    //     'subtitle': 'This is the contact page.',
    //     'date': '2021-10-12',
    //     'color': Colors.blue[100], // Color object
    //   },
    // ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.push(context,
            new MaterialPageRoute(builder: (context) => TodoList())
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context
                    , MaterialPageRoute(builder: (context) {
                  return NoteDetail(
                    note: notes[index],
                  );
                }));
              },
              child: NoteTile(
                // title: notes[index]['title'] as String,
                // subtitle: notes[index]['subtitle'] as String,
                // date: notes[index]['date'] as String,
                // color: notes[index]['color'] as Color, // Cast to Color

                title: notes[index].title as String,
                subtitle: notes[index].description as String,
                date: notes[index].date as String,
                color: Colors.green,

                onDelete: () {
                  setState(() {
                    notes.removeAt(index); // Uncomment to enable deletion
                    saveIntoSp();
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
