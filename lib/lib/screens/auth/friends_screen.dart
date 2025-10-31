import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'friend_profile_screen.dart';

// Change from StatelessWidget to StatefulWidget
class FriendsScreen extends StatefulWidget {
  final int friendsCount;

  const FriendsScreen({super.key, required this.friendsCount});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _allFriendsList = [
    {'name': 'Alice', 'bio': 'Loves photography', 'threads': 5, 'capsules': 10, 'friends': 12},
    {'name': 'Bob', 'bio': 'Coffee enthusiast', 'threads': 3, 'capsules': 8, 'friends': 9},
    {'name': 'Charlie', 'bio': 'Travel junkie', 'threads': 7, 'capsules': 5, 'friends': 15},
    {'name': 'Daisy', 'bio': 'Foodie and chef', 'threads': 2, 'capsules': 6, 'friends': 7},
    {'name': 'Ethan', 'bio': 'Tech geek', 'threads': 9, 'capsules': 12, 'friends': 20},
    {'name': 'Fiona', 'bio': 'Music lover', 'threads': 4, 'capsules': 7, 'friends': 8},
    {'name': 'George', 'bio': 'Sports fanatic', 'threads': 6, 'capsules': 9, 'friends': 14},
  ];

  List<Map<String, dynamic>> _filteredFriendsList = [];

  @override
  void initState() {
    super.initState();
    _filteredFriendsList = _allFriendsList;
    _searchController.addListener(_filterFriends);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterFriends() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredFriendsList = _allFriendsList;
      } else {
        _filteredFriendsList = _allFriendsList.where((friend) {
          return friend['name']!.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.sunsetBlue,
        iconTheme: const IconThemeData(color: AppColors.goldText),
        title: Text(
          'Friends (${widget.friendsCount})',
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: AppColors.goldText),
                decoration: InputDecoration(
                  hintText: 'Search friends...',
                  hintStyle: const TextStyle(color: AppColors.textHint),
                  prefixIcon: const Icon(Icons.search, color: AppColors.goldText),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.textHint),
                    onPressed: () {
                      _searchController.clear();
                      _filterFriends();
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (_) => _filterFriends(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                itemCount: _filteredFriendsList.length,
                itemBuilder: (context, index) {
                  final friend = _filteredFriendsList[index];
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
                        // 🔴 Delete Icon (changed to red)
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Delete ${friend['name']} tapped')),
                            );
                          },
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                        ),

                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.green,
                          child: Text(
                            friend['name'][0].toUpperCase(), // first initial
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
                                    name: friend['name'],
                                    bio: friend['bio'],
                                    friendsCount: friend['friends'],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  friend['name'],
                                  style: const TextStyle(
                                    color: AppColors.goldText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'PlayfairDisplay',
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  friend['bio'],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
