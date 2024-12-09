import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
          home: TodoList()
      )
  );
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
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
             padding: const EdgeInsets.all(20),
             child: const Text(
                 "Create Todo List",
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 30
               )

             )
           ),

           Container(
             padding: const EdgeInsets.only(left: 20.0),
             child: const Text(
                 "Title:",
               style: TextStyle(
                 fontSize: 20,
               ),
             )
           ),

           Container(
            padding: const EdgeInsets.all(20),
             child: const TextField(
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 label: Text("Title"),
                 prefixIcon: Icon(Icons.title_outlined ),
               )
             )
           ),


           Container(
               padding: const EdgeInsets.only(left: 20.0),
               child: const Text(
                 "Description:",
                 style: TextStyle(
                   fontSize: 20,
                 ),
               )
           ),

           Container(
               padding: const EdgeInsets.all(20),
               child: const TextField(
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(vertical: 40),
                     border: OutlineInputBorder(),
                     label: Text("Description"),
                     prefixIcon: Icon(Icons.description),
                   )
               )
           ),

           Container(
               padding: const EdgeInsets.only(left: 20.0),
               child: const Text(
                 "Date:",
                 style: TextStyle(
                   fontSize: 20,
                 ),
               )
           ),

            Container(
               padding: const EdgeInsets.all(20),
               child: const TextField(
                   decoration: InputDecoration(
                     border: OutlineInputBorder(),
                     label: Text("Date"),
                     prefixIcon: Icon(Icons.calendar_today),
                   )
               )
           ),

           Container(
              padding: const EdgeInsets.only(left: 20.0),
              height: 50,
              child: ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.yellow),

                    ),
                    child: const Text(
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
