import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/post_model.dart';
import '../../theme/AppColors.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLiked = false;

  // --- 🌟 BACKEND ACTIONS ---
  Future<void> _deletePost() async {
    await FirebaseFirestore.instance.collection('posts').doc(widget.post.id).delete();
  }

  Future<void> _reportPost() async {
    await FirebaseFirestore.instance.collection('reports').add({
      'postId': widget.post.id,
      'author': widget.post.authorName,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void _showPostOptions(BuildContext context) {
    final user = _auth.currentUser;
    final bool isOwner = (user?.displayName == widget.post.authorName || user?.email == widget.post.authorName);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
              leading: const Icon(Icons.delete, color: Colors.redAccent),
              title: const Text("Delete Post", style: TextStyle(color: Colors.redAccent)),
              onTap: () { Navigator.pop(context); _deletePost(); },
            ),
          if (!isOwner) ...[
            ListTile(
              leading: const Icon(Icons.block, color: Colors.orange),
              title: const Text("Block User", style: TextStyle(color: Colors.orange)),
              onTap: () { Navigator.pop(context); /* Block Logic */ },
            ),
            ListTile(
              leading: const Icon(Icons.report, color: Colors.yellow),
              title: const Text("Report Content", style: TextStyle(color: Colors.yellow)),
              onTap: () { Navigator.pop(context); _reportPost(); },
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: widget.post.authorAvatarUrl.startsWith('http')
                  ? NetworkImage(widget.post.authorAvatarUrl) as ImageProvider
                  : AssetImage(widget.post.authorAvatarUrl),
            ),
            title: Text(widget.post.authorName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            trailing: IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () => _showPostOptions(context)),
          ),
          if (!widget.post.isThread && widget.post.mediaUrl.isNotEmpty)
            Image.network(widget.post.mediaUrl, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Align(alignment: Alignment.centerLeft, child: Text(widget.post.caption, style: const TextStyle(color: Colors.white))),
          ),
        ],
      ),
    );
  }
}