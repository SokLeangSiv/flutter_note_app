import 'package:flutter/material.dart';
import 'package:midterm/components/note_tile.dart';
import 'package:midterm/pages/note_detail.dart';
import 'package:midterm/pages/create_todo_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notes = [ // Updated to store Color as dynamic
      {
        'title': 'Home Page',
        'subtitle': 'This is the home page.vattanak is a gay always love to fap alone at homoe in the toliet and he always waering the headphone to watch porn at home ',
        'date': '2021-10-10',
        'color': Colors.yellow[100], // Color object
      },
      {
        'title': 'About Page',
        'subtitle': 'This is the about page.',
        'date': '2021-10-11',
        'color': Colors.red[100], // Color object
      },
      {
        'title': 'Contact Page',
        'subtitle': 'This is the contact page.',
        'date': '2021-10-12',
        'color': Colors.blue[100], // Color object
      },
    ];

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
                title: notes[index]['title'] as String,
                subtitle: notes[index]['subtitle'] as String,
                date: notes[index]['date'] as String,
                color: notes[index]['color'] as Color, // Cast to Color
                onDelete: () {
                  setState(() {
                    notes.removeAt(index); // Uncomment to enable deletion
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
