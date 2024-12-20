import 'package:flutter/material.dart';
import 'package:midterm/components/notes.dart';
import 'package:midterm/pages/edit_todo.dart';

class NoteDetail extends StatelessWidget {
  final Notes note;
  const NoteDetail({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    // Convert the color string to a Flutter Color object
    final Color noteColor = stringToColor(note.color ?? '#FFFFFF');

    return Scaffold(
      backgroundColor: noteColor, // Set the background color of the Scaffold
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditTodo(note: note)),
              );
            },
            icon: const Icon(Icons.edit),
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
          decoration: BoxDecoration(
            color: noteColor, // Set the color of the AppBar
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
              content: note.title.toString(),
              icon: Icons.title_outlined,
            ),
            const SizedBox(height: 20),
            NoteSection(
              title: 'Description',
              content: note.description.toString(),
              icon: Icons.description,
            ),
            const SizedBox(height: 20),
            NoteSection(
              title: 'Date',
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
                color: noteColor, // Set the container's color dynamically
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
                    color: noteColor.computeLuminance() > 0.5
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

// Helper function to convert a color string to a Color object
Color stringToColor(String colorString) {
  // Assuming the color string is in hex format (e.g., "#FF5733" or "FF5733")
  final buffer = StringBuffer();
  if (colorString.length == 6 || colorString.length == 7) buffer.write('ff'); // Add opacity if not provided
  buffer.write(colorString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
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
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
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
