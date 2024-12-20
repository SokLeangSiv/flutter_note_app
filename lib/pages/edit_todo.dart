import 'package:flutter/material.dart';
import 'package:midterm/components/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'home_page.dart';


class EditTodo extends StatefulWidget {
  final Notes note;
  const EditTodo({super.key, required this.note});
  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {

 // it mean we required the parameter note to show in this page
  @override
  void initState() {
    readFromSp();
    super.initState();
    titleInput.text = widget.note.title.toString(); // we doesn't ini state in the parameter page
    descriptionInput.text = widget.note.description.toString();
    color = stringToColor(widget.note.color);
    selectedDateString = widget.note.date.toString();
    selectedDate = stringToDate(selectedDateString!);
    String selectDateInString = selectedDate.toString().replaceAll('00:00:00.000', '');
    dateInput.text = selectDateInString;
  }

  TextEditingController titleInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  List<Notes> notes = List.empty(growable: true);
  String? selectedDateString;

  DateTime? selectedDate;
  Color color =  Color(0xFF00FF00);
  late SharedPreferences sp;



  getSharedPreferences() async{
    sp = await SharedPreferences.getInstance();
    // readFromSp();
    saveIntoSp();
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



  saveIntoSp(){
    List<String> datas = notes.map((note) => jsonEncode(note.toJson())).toList(); // convert List<object> to List<String>
    sp.setStringList("notes", datas); // it lose data in here
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

  DateTime stringToDate(String selectedDateString){
    selectedDateString += '00:00:00.000';
    selectedDate = DateTime.parse(selectedDateString);

    return selectedDate!;
  } // convert string to date


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String selectDateInString = selectedDate.toString().replaceAll('00:00:00.000', '');
        dateInput.text = selectDateInString;
      });
    }
  }


  void update_todo() {
    String? title = titleInput.text.trim();
    String? description = descriptionInput.text.trim();
    getSharedPreferences(); // get save dat from local memory
    String selectDateInString = selectedDate.toString().replaceAll('00:00:00.000', '');
    TextEditingController dateInput = TextEditingController();

    int i = notes.indexWhere((n) => n.title == widget.note.title.toString());

      setState(() {
        notes[i] = Notes(title: title, description: description, date: selectDateInString, color: color.toString());
        // find the exact object in object list
      });


    getSharedPreferences();

    Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
    );
    // after save it will navigate to homepage
  }




  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),

      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
        
              Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      "Edit Note",
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
                  child: TextFormField(
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
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select Date'),
                  ),
              ),
        
              Container(
                  padding: EdgeInsets.all(20),
                  width: 200,
                  child: TextField(
                    readOnly: true,
                    controller: dateInput,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Date"),
                        prefixIcon: Icon(Icons.calendar_today )
                    ),
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
                    onPressed: update_todo, // press create button to store data
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
        
                    ),
                    child: Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )
                    ),
                  )
              ),
        
              // Text(oldTitle),
              // Text(notes[0].title.toString()),
            ]
        ),
      ),


    );
  }
}