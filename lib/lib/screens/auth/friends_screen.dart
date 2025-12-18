import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'friend_profile_screen.dart';

class FriendsScreen extends StatefulWidget {
  final int friendsCount;

  const FriendsScreen({super.key, required this.friendsCount});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _currentUserId = FirebaseAuth.instance.currentUser!.uid;

  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Logic to remove a friend from YOUR list
  void _deleteFriend(String friendId, String friendName) async {
    try {
      await _firestore
          .collection('users')
          .doc(_currentUserId)
          .collection('friends')
          .doc(friendId)
          .delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$friendName removed from friends')),
        );
      }
    } catch (e) {
      debugPrint("Delete error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.sunsetBlue,
        iconTheme: const IconThemeData(color: AppColors.goldText),
        title: Text(
          'Friends', // We will let the stream count them
          style: const TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold,
            color: AppColors.goldText,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.sunsetBlue,
              AppColors.sunsetPurple,
              AppColors.sunsetPink,
              AppColors.sunsetOrange,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: AppColors.goldText),
                onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
                decoration: InputDecoration(
                  hintText: 'Search friends...',
                  hintStyle: const TextStyle(color: AppColors.textHint),
                  prefixIcon: const Icon(Icons.search, color: AppColors.goldText),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Expanded(
              // 🔗 This is the magic part: it only shows friends added to YOUR account
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('users')
                    .doc(_currentUserId)
                    .collection('friends')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.goldText));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "You haven't added any friends yet.",
                        style: TextStyle(color: Colors.white70, fontFamily: 'PlayfairDisplay'),
                      ),
                    );
                  }

                  // Filtering logic for the search bar
                  final friendsList = snapshot.data!.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final name = data['username']?.toString().toLowerCase() ?? '';
                    return name.contains(_searchQuery);
                  }).toList();

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    itemCount: friendsList.length,
                    itemBuilder: (context, index) {
                      final doc = friendsList[index];
                      final friend = doc.data() as Map<String, dynamic>;
                      final String friendId = doc.id;
                      final String name = friend['username'] ?? 'User';
                      final String bio = friend['bio'] ?? 'Rekindl User';

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => _deleteFriend(friendId, name),
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                            ),

                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.green,
                              child: Text(
                                name.isNotEmpty ? name[0].toUpperCase() : '?',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'PlayfairDisplay',
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FriendProfileScreen(
                                        name: name,
                                        bio: bio,
                                        friendId: friendId, // 🟢 Passed the ID we got from doc.id
                                        // threads: friend['threads'] ?? 0, // Optional: if you have this in the doc
                                        // capsules: friend['capsules'] ?? 0, // Optional
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        color: AppColors.goldText,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'PlayfairDisplay',
                                      ),
                                    ),
                                    Text(
                                      bio,
                                      style: const TextStyle(
                                        color: AppColors.textHint,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}