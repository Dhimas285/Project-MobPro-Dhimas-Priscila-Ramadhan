import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteDetail extends StatelessWidget {
  final Note note;
  const NoteDetail({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Catatan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Dibuat: ${note.createdAt}'),
            const Divider(),
            const SizedBox(height: 8),
            Text(note.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
