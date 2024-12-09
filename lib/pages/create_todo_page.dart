import 'package:flutter/material.dart';

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
                   decoration: InputDecoration(
                     border: OutlineInputBorder(),
                     label: Text("Date"),
                     prefixIcon: Icon(Icons.calendar_today),
                   )
               )
           ),

           Container(
              padding: EdgeInsets.only(left: 20.0),
              height: 50,
              child: ElevatedButton(
                    onPressed: null,
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
         ]
       ),



    );
  }

}
