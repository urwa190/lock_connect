// lib/features/capsules/widgets/collaborator_list_item.dart

import 'package:flutter/material.dart';
import 'package:lock_connect/core/constants/colors.dart';
// Ensure your project name matches 'lock_connect' or change it here

class CollaboratorListItem extends StatelessWidget {
  final String name;
  final String username;
  final bool isAdded;
  final VoidCallback onAction;

  const CollaboratorListItem({
    super.key,
    required this.name,
    required this.username,
    required this.isAdded,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 20,
        backgroundColor: Colors.cyan, // Placeholder color
        child: Text('F', style: TextStyle(color: Colors.black)),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('@$username', style: const TextStyle(color: Colors.white70)),
      trailing: isAdded
          ? IconButton(
        icon: const Icon(Icons.check_circle, color: kPrimaryAccentColor),
        onPressed: onAction,
        tooltip: 'Remove',
      )
          : OutlinedButton(
        onPressed: onAction,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: kPrimaryAccentColor),
          foregroundColor: kPrimaryAccentColor,
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        child: const Text('Add'),
      ),
    );
  }
}