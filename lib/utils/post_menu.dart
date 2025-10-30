import 'package:flutter/material.dart';
import '../screens/thread_creation_screen.dart'; // screen for writing a thread
import '../theme/app_colors.dart';        // color definitions

//----------------------------Create Post Menu---------------------------------
void showCreatePostMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Option 1: Post a Picture
          ListTile(
            leading: const Icon(Icons.photo, color: Colors.pink),
            title: const Text('Post a Picture', style: TextStyle(color: Colors.white)),
            onTap: () => showAddToMenu(context, 'Picture'),
          ),
          // Option 2: Post a Video
          ListTile(
            leading: const Icon(Icons.videocam, color: Colors.pink),
            title: const Text('Post a Video', style: TextStyle(color: Colors.white)),
            onTap: () => showAddToMenu(context, 'Video'),
          ),
          // Option 3: Create a Thread
          ListTile(
            leading: const Icon(Icons.text_snippet, color: Colors.pink),
            title: const Text('Create a Thread', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // close menu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThreadCreationScreen()),
              );
            },
          ),
        ],
      );
    },
  );
}

//----------------------------Add To Menu (for media posts)---------------------------------
void showAddToMenu(BuildContext context, String type) {
  Navigator.pop(context); // close previous menu
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final collections = ['Travel', 'Work', 'Personal', 'Ideas']; // sample collections
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Add $type to:', style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
          ...collections.map((name) => ListTile(
            title: Text(name, style: const TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              // handle adding to collection logic here
            },
          )),
        ],
      );
    },
  );
}
