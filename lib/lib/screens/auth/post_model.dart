class PostModel {
  final String username;
  final String content;
  final String? imageUrl;
  final String timeAgo;
  final int likes;

  PostModel({
    required this.username,
    required this.content,
    this.imageUrl,
    required this.timeAgo,
    this.likes = 0,
  });
}

// Dummy data for testing the Profile Feed
final List<PostModel> mockPosts = [
  PostModel(
    username: "Sarah",
    content: "Just finished organizing my latest memory capsule! It's amazing how photos can take you back. ✨",
    imageUrl: "https://images.unsplash.com/photo-1527529482837-4698179dc6ce?w=500&q=80",
    timeAgo: "1h ago",
    likes: 56,
  ),
  PostModel(
    username: "Sarah",
    content: "Does anyone have recommendations for travel spots in Japan for my next collection?",
    timeAgo: "4h ago",
    likes: 12,
  ),
];