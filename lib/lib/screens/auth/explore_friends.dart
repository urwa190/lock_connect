import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ExploreFriendsScreen extends StatefulWidget {
  const ExploreFriendsScreen({super.key});

  @override
  State<ExploreFriendsScreen> createState() => _ExploreFriendsScreenState();
}

class _ExploreFriendsScreenState extends State<ExploreFriendsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allUsers = ['Alice', 'Ali', 'Aiman', 'Ahmad', 'Sara', 'Hassan'];
  final List<String> _friends = [];
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final List<String> filteredUsers = _allUsers
        .where((user) => user.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      appBar: AppBar(
        title: const Text(
          'Explore Friends',
          style: TextStyle(
            color: AppColors.goldText,
            fontFamily: 'PlayfairDisplay',
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.goldText),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for friends...',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.green),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Friend list
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  final isFriend = _friends.contains(user);
                  final initial = user.isNotEmpty ? user[0].toUpperCase() : '?';

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.lightGreen.withOpacity(0.9),
                        radius: 22,
                        child: Text(
                          initial,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      title: Text(
                        user,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'PlayfairDisplay',
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: isFriend
                            ? null
                            : () {
                          setState(() {
                            _friends.add(user);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          isFriend ? Colors.grey : AppColors.sunsetOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          isFriend ? 'Added' : '+ Friend',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'PlayfairDisplay',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Friends added section
            if (_friends.isNotEmpty) ...[
              const SizedBox(height: 10),
              const Text(
                'Friends Added:',
                style: TextStyle(
                  color: AppColors.goldText,
                  fontSize: 16,
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 8,
                children: _friends
                    .map((f) => Chip(
                  label: Text(
                    f,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ),
                  backgroundColor:
                  AppColors.sunsetOrange.withOpacity(0.7),
                ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
