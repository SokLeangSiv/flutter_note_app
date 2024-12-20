import 'package:flutter/material.dart';
import 'package:midterm/components/notes.dart';
import 'package:midterm/pages/edit_todo.dart';

class NoteDetail extends StatelessWidget {
  // final Map<String, dynamic> note;
  final Notes note;
  const NoteDetail({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditTodo(note: note)) // parameter page
              );
            },
            icon: Icon(Icons.edit),

          ),
        ],
        title: const Text(
          'Note Detail',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.yellow,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NoteSection(
              title: 'Title',
              // content: note['title'],
              content: note.title.toString(),
              icon: Icons.title_outlined,
            ),
            const SizedBox(height: 20),
            NoteSection(
              title: 'Description',
              // content: note['subtitle'],
              content: note.description.toString(),
              icon: Icons.description,
            ),
            const SizedBox(height: 20),
            NoteSection(
              title: 'Date',
              // content: note['date'],
              content: note.date.toString(),
              icon: Icons.calendar_today,
            ),
            const SizedBox(height: 20),
            const Text(
              'Color',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                // color: note['color'],
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  note.color.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: stringToColor(note.color).computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteSection extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const NoteSection({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.blueAccent,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                    maxLines: 5, // Adjust number of lines to display
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

