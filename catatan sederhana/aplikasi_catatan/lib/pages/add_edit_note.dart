import 'package:flutter/material.dart';

class AddEditNote extends StatefulWidget {
  final Map<String, String>? existing;

  const AddEditNote({super.key, this.existing});

  @override
  State<AddEditNote> createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  late TextEditingController title;
  late TextEditingController description;

  @override
  void initState() {
    title = TextEditingController(text: widget.existing?['title'] ?? "");
    description =
        TextEditingController(text: widget.existing?['description'] ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existing == null ? "Catatan Baru" : "Edit Catatan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(
                labelText: "Judul",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: description,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Deskripsi",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, {
                  "title": title.text,
                  "description": description.text,
                });
              },
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
