import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onDelete;
  final String date;
  final Color color; // Changed from String to Color

  const NoteTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onDelete,
    required this.date,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          onDelete();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title deleted')),
          );
        },
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.red,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color, // Now using Color directly
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: Text(
              date,
              style: const TextStyle(
                color: Color.fromARGB(255, 116, 115, 115),
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
