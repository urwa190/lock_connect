import 'package:flutter/material.dart';
import '../models/post_model.dart';             // PostModel definition
import '../theme/app_colors.dart';             // Custom color palette
import '../widgets/local_video_player.dart';   // Widget to play local videos
import '../widgets/local_video_player.dart';

class PostCard extends StatefulWidget {
  final PostModel post; // Takes one mock post

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  // State variables
  bool isLiked = false; // track post if liked
  bool showComments = false; // toggle comments
  final TextEditingController _commentController = TextEditingController(); // input for comments
  final List<String> comments = []; // list for comments

  // ---1. Helper Function: Formats time for display---
  String _timeAgo(DateTime time) {
    final difference = DateTime.now().difference(time);
    if (difference.inDays > 0) return '${difference.inDays}d ago';
    if (difference.inHours > 0) return '${difference.inHours}h ago';
    if (difference.inMinutes > 0) return '${difference.inMinutes}min ago';
    if (difference.inSeconds > 0) return '${difference.inSeconds}sec ago';
    if (difference.inMilliseconds > 0) return '${difference.inMilliseconds}ms ago';
    return 'Just Now';
  }

  // ---2. Three dot menu helper function logic---
  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardSecondaryText,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Post Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(color: Colors.grey, thickness: 2),

              ListTile(
                leading: const Icon(Icons.bookmark_border, color: Colors.pink),
                title: const Text('Save Post'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Post has been saved!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.flag_outlined, color: Colors.pink),
                title: const Text('Report Content'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Your request shall be reviewed shortly!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.block_outlined, color: Colors.pink),
                title: const Text('Block User'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User Blocked!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.link, color: Colors.pink),
                title: const Text('Copy Link'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Link Copied!')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------- Main UI ----------
  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.black.withOpacity(0.6), // consistent purple background
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 12),

            // Show media only if available
            if (post.isVideo && post.videoPath != null || post.mediaUrl.isNotEmpty) ...[
              _buildMediaContent(),
              const SizedBox(height: 12),
            ],

            // Caption text
            Text(
              post.caption,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 10),

            // Like and comment buttons
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.redAccent : AppColors.headerBackground,
                  ),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.comment, color: AppColors.headerBackground),
                  onPressed: () {
                    setState(() {
                      showComments = !showComments;
                    });
                  },
                ),
              ],
            ),

            if (showComments) _buildCommentsSection(),
          ],
        ),
      ),
    );
  }

  // ---------- Header ----------
  Widget _buildHeader(BuildContext context) {
    final post = widget.post;
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage(post.authorAvatarUrl), // switched to local asset
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.authorName,
              style: const TextStyle(color: AppColors.cardText, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            if (post.isThread)
              Text(
                'Long Read',
                style: TextStyle(
                    color: Colors.pink[400],
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),
            Text(
              _timeAgo(post.timestamp),
              style: const TextStyle(color: AppColors.cardSecondaryText, fontSize: 12),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.more_horiz, color: AppColors.cardText),
          onPressed: () => _showOptionsMenu(context),
        ),
      ],
    );
  }

  // ---------- Media (image or video) ----------
  Widget _buildMediaContent() {
    final post = widget.post;

    Widget mediaWidget;

    if (post.isVideo && post.videoPath != null) {
      mediaWidget = LocalVideoPlayer(assetPath: post.videoPath!);
    } else {
      mediaWidget = Image.asset(post.mediaUrl, fit: BoxFit.cover);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: mediaWidget,
    );
  }

  // ---------- Comments section ----------
  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (String comment in comments)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              comment,
              style: const TextStyle(color: AppColors.pink),
            ),
          ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                style: const TextStyle(color: AppColors.cardText),
                decoration: const InputDecoration(
                  hintText: "Add a comment...",
                  hintStyle: TextStyle(color: Colors.white54),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: AppColors.cardText),
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  setState(() {
                    comments.add(_commentController.text);
                    _commentController.clear();
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
