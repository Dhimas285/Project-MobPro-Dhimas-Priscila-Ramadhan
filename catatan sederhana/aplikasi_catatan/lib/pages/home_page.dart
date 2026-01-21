import 'package:flutter/material.dart';
import 'add_edit_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Catatan Saya"), centerTitle: true),
      body: notes.isEmpty
          ? const Center(child: Text("Belum ada catatan"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final item = notes[index];
                return Card(
                  child: ListTile(
                    title: Text(item['title']!),
                    subtitle: Text(
                      item['description']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () async {
                      final updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddEditNote(
                            existing: item,
                          ),
                        ),
                      );

                      if (updated != null) {
                        setState(() => notes[index] = updated);
                      }
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() => notes.removeAt(index));
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditNote()),
          );

          if (newNote != null) {
            setState(() => notes.add(newNote));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
