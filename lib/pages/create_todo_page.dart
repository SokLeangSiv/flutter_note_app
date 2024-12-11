import 'dart:convert';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:midterm/components/notes.dart';
import 'package:midterm/pages/home_page.dart';


void main() {
  runApp(
      MaterialApp(
          home: TodoList()
      )
  );
}

class TodoList extends StatefulWidget {
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {

  TextEditingController titleInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController resultController = TextEditingController();
  Color color = Color(0xFF00FF00);
  List<Notes> notes = List.empty(growable: true);
  late SharedPreferences sp; // declare share_preference object as global
  // String? result = "result";

  getSharedPreferences() async{
    sp = await SharedPreferences.getInstance();
    // readFromSp();
    saveIntoSp();
  }

  saveIntoSp(){
    List<String> datas = notes.map((note) => jsonEncode(note.toJson())).toList(); // convert List<object> to List<String>
    sp.setStringList("notes", datas); // it lose data in here
  }

  readFromSp() async{
    sp = await SharedPreferences.getInstance();
   List<String>? NotesListString =  sp.getStringList("notes");



   setState(() {
     if(NotesListString != null){
       notes = NotesListString.map((note) => Notes.fromJson(jsonDecode(note))).toList();
     }
   }); // use to re-render the current state. because we want to display new result on widget
  }

  Widget buildColorPicker() => ColorPicker( // show the color selection board
      pickerColor: color,
      enableAlpha: false,
      onColorChanged: (color) => setState(() => this.color = color),
  );

  void pickColor() => showDialog( // show the pop up message
      context: context,
      builder: (context) => AlertDialog(
        title: Text('pick your color'),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildColorPicker(),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 20,
                        )
                    ),
                  )
              )

            ]
        )
     )
  );


  @override
  void initState() {
    readFromSp(); // call note data from local storage
    // TODO: implement initState
    super.initState();
  }

  void create_todo() {
    String? title = titleInput.text.trim();
    String? description = descriptionInput.text.trim();
    String? date = dateInput.text.trim();

    setState(() {
      notes.add(Notes(title: title, description: description, date: date, color: color.toString()));
    }); // we re-render the state because we want to update value

    getSharedPreferences(); // save the notes data into local storage

    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => HomePage()),
    ); // after save it will navigate to homepage
  }


  @override
  Widget build(BuildContext build){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Todo List'),
      ),

     body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[

           Container(
             padding: EdgeInsets.all(20),
             child: Text(
                 "Create Todo List",
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 30
               )

             )
           ),

           Container(
             padding: EdgeInsets.only(left: 20.0),
             child: Text(
                 "Title:",
               style: TextStyle(
                 fontSize: 20,
               ),
             )
           ),

           Container(
            padding: EdgeInsets.all(20),
             child: TextField(
                 controller: titleInput,
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 label: Text("Title"),
                 prefixIcon: Icon(Icons.title_outlined ),
               )
             )
           ),


           Container(
               padding: EdgeInsets.only(left: 20.0),
               child: Text(
                 "Description:",
                 style: TextStyle(
                   fontSize: 20,
                 ),
               )
           ),

           Container(
               padding: EdgeInsets.all(20),
               child: TextField(
                   controller: descriptionInput,
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(vertical: 40),
                     border: OutlineInputBorder(),
                     label: Text("Description"),
                     prefixIcon: Icon(Icons.description),
                   )
               )
           ),

           Container(
               padding: EdgeInsets.only(left: 20.0),
               child: Text(
                 "Date:",
                 style: TextStyle(
                   fontSize: 20,
                 ),
               )
           ),

            Container(
               padding: EdgeInsets.all(20),
               child: TextField(
                   controller: dateInput,
                   decoration: InputDecoration(
                     border: OutlineInputBorder(),
                     label: Text("Date"),
                     prefixIcon: Icon(Icons.calendar_today),
                   )
               )
           ),

           Container(
               padding: EdgeInsets.only(left: 20.0),
               child: Text(
                 "Color:",
                 style: TextStyle(
                   fontSize: 20,
                 ),
               )
           ),

           Container(
             margin: EdgeInsets.all(20),
             height: 50,
             width: 50,
             decoration: BoxDecoration(
               color: color,
             ),

             child:
                 TextButton(
                 onPressed: pickColor,
                 child: Text(''),
               )

           ),


           Container(
              padding: EdgeInsets.only(left: 20.0),
              height: 50,
              child: ElevatedButton(
                    onPressed: create_todo, // press create button to store data
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),

                    ),
                    child: Text(
                        "Create",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )
                    ),
               )
           ),

           //  Text(notes[1].color.toString()),
           // Text(color.toString()),
           // Text(notes[0].title.toString()),
         ]
       ),


    );
  }



}


