import 'package:flutter/material.dart';
import 'package:midterm/components/note_tile.dart';
import 'package:midterm/pages/note_detail.dart';
import 'package:midterm/pages/create_todo_page.dart';
import 'package:midterm/components/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Notes> notes = List.empty(growable: true);
  late SharedPreferences sp;
  String searchQuery = "";
  List<Notes> filteredNotes = [];

  getSharedPreferences() async {
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  saveIntoSp() async {
    sp = await SharedPreferences.getInstance();
    List<String> datas = notes.map((note) => jsonEncode(note.toJson())).toList();
    sp.setStringList("notes", datas);
  }

  readFromSp() {
    List<String>? NotesListString = sp.getStringList("notes");
    if (NotesListString != null) {
      notes = NotesListString.map((note) => Notes.fromJson(jsonDecode(note))).toList();
      filteredNotes = notes;
    }
    setState(() {});
  }

  void filterNotes(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredNotes = notes;
      } else {
        filteredNotes = notes.where((note) {
          final titleMatch = note.title!.toLowerCase().contains(query.toLowerCase());
          final subtitleMatch = note.description!.toLowerCase().contains(query.toLowerCase());
          return titleMatch || subtitleMatch;
        }).toList();
      }
    });
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TodoList()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Search Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearchDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: filteredNotes.isEmpty
            ? const Center(child: Text("No results found"))
            : ListView.builder(
                itemCount: filteredNotes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return NoteDetail(
                          note: filteredNotes[index],
                        );
                      }));
                    },
                    child: NoteTile(
                      title: filteredNotes[index].title.toString(),
                      subtitle: filteredNotes[index].description.toString(),
                      date: filteredNotes[index].date as String,
                      color: stringToColor(filteredNotes[index].color) as Color,
                      onDelete: () {
                        setState(() {
                          final noteToRemove = filteredNotes[index];
                          notes.remove(noteToRemove);
                          filteredNotes.removeAt(index);
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

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Search Notes"),
          content: TextField(
            decoration: const InputDecoration(hintText: "Enter search query"),
            onChanged: (value) {
              filterNotes(value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                filterNotes("");
                Navigator.of(context).pop();
              },
              child: const Text("Clear"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}