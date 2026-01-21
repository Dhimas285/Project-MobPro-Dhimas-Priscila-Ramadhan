import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const NoteItem({
    super.key,
    required this.note,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final timeAgo = _getTimeAgo(note.createdAt);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 3,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: _getCategoryColor(note.title),
                  width: 4,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon/Color Indicator
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(note.title).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getCategoryIcon(note.title),
                    color: _getCategoryColor(note.title),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              note.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2C3E50),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(
                                note.title,
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              timeAgo,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getCategoryColor(note.title),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        note.content,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          // Tags (jika ada kategori)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _getCategory(note.title),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          // Action Buttons
                          _buildActionButton(
                            icon: Icons.edit_outlined,
                            color: const Color(0xFF4A6FA5),
                            onPressed: onEdit,
                          ),
                          const SizedBox(width: 8),
                          _buildActionButton(
                            icon: Icons.delete_outline,
                            color: Colors.red,
                            onPressed: onDelete,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  Color _getCategoryColor(String title) {
    final keywords = title.toLowerCase();
    if (keywords.contains('belajar') || keywords.contains('study')) {
      return const Color(0xFF4A6FA5); // Blue
    } else if (keywords.contains('meeting') || keywords.contains('rapat')) {
      return const Color(0xFF6C8EAD); // Teal
    } else if (keywords.contains('desain') || keywords.contains('design')) {
      return const Color(0xFF9DB4C0); // Light Blue
    } else if (keywords.contains('urgent') || keywords.contains('penting')) {
      return const Color(0xFFE74C3C); // Red
    } else {
      return const Color(0xFF95A5A6); // Grey
    }
  }

  IconData _getCategoryIcon(String title) {
    final keywords = title.toLowerCase();
    if (keywords.contains('belajar') || keywords.contains('study')) {
      return Icons.school_outlined;
    } else if (keywords.contains('meeting') || keywords.contains('rapat')) {
      return Icons.groups_outlined;
    } else if (keywords.contains('desain') || keywords.contains('design')) {
      return Icons.design_services_outlined;
    } else if (keywords.contains('urgent') || keywords.contains('penting')) {
      return Icons.priority_high_outlined;
    } else {
      return Icons.note_outlined;
    }
  }

  String _getCategory(String title) {
    final keywords = title.toLowerCase();
    if (keywords.contains('belajar') || keywords.contains('study')) {
      return 'Edukasi';
    } else if (keywords.contains('meeting') || keywords.contains('rapat')) {
      return 'Meeting';
    } else if (keywords.contains('desain') || keywords.contains('design')) {
      return 'Desain';
    } else if (keywords.contains('urgent') || keywords.contains('penting')) {
      return 'Penting';
    } else {
      return 'Umum';
    }
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}j';
    } else {
      return '${difference.inDays}h';
    }
  }
}
