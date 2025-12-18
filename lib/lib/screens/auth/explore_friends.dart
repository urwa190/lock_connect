import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'friend_profile_screen.dart';

class ExploreFriendsScreen extends StatefulWidget {
  const ExploreFriendsScreen({super.key});

  @override
  State<ExploreFriendsScreen> createState() => _ExploreFriendsScreenState();
}

class _ExploreFriendsScreenState extends State<ExploreFriendsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<DocumentSnapshot> _foundUsers = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  void _onSearchChanged(String value) async {
    setState(() {
      if (value.isEmpty) {
        _foundUsers = [];
        _hasSearched = false;
        _isLoading = false;
        return;
      }
      _isLoading = true;
    });

    try {
      final results = await _firestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: value)
          .where('username', isLessThanOrEqualTo: '$value\uf8ff')
          .get();

      setState(() {
        _foundUsers = results.docs;
        _isLoading = false;
        _hasSearched = true;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  // 🚀 TWO-WAY ADD FRIEND LOGIC WITH NULL SAFETY
  void _handleAddFriend(String friendId, String friendName, String friendBio) async {
    final String myUid = _auth.currentUser!.uid;

    try {
      // 1. Fetch your own data safely
      DocumentSnapshot myDoc = await _firestore.collection('users').doc(myUid).get();

      // 🟢 FIX: Handle cases where the current user's document is missing
      if (!myDoc.exists || myDoc.data() == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error: Your user document was not found in Firestore. Please update your profile first.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
        return;
      }

      // Safe cast now that we've verified existence
      Map<String, dynamic> myData = myDoc.data() as Map<String, dynamic>;

      String myName = myData['username'] ?? 'User';
      String myBio = myData['bio'] ?? 'Rekindl User';

      // 2. Start a Batch Write to handle the "Handshake"
      WriteBatch batch = _firestore.batch();

      // Path A: Add them to YOUR friends list
      DocumentReference myFriendRef = _firestore
          .collection('users').doc(myUid).collection('friends').doc(friendId);
      batch.set(myFriendRef, {
        'username': friendName,
        'bio': friendBio,
        'addedAt': FieldValue.serverTimestamp(),
      });

      // Path B: Add ME to THEIR friends list (Handshake)
      DocumentReference theirFriendRef = _firestore
          .collection('users').doc(friendId).collection('friends').doc(myUid);
      batch.set(theirFriendRef, {
        'username': myName,
        'bio': myBio,
        'addedAt': FieldValue.serverTimestamp(),
      });

      // Commit the batch
      await batch.commit();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You and $friendName are now friends!'),
            backgroundColor: AppColors.sunsetPurple,
          ),
        );
      }
    } catch (e) {
      debugPrint("ADD FRIEND ERROR: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add friend: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      appBar: AppBar(
        title: const Text('Explore Friends', style: TextStyle(color: AppColors.goldText, fontFamily: 'PlayfairDisplay')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.goldText),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by username...',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.goldText))
                  : (_foundUsers.isEmpty && _hasSearched)
                  ? const Center(child: Text('No account found', style: TextStyle(color: Colors.white70)))
                  : ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) {
                  var userData = _foundUsers[index].data() as Map<String, dynamic>;
                  String friendId = _foundUsers[index].id;
                  String username = userData['username'] ?? 'Unknown';
                  String bio = userData['bio'] ?? 'Rekindl User';

                  // Don't show yourself in the search results
                  if (friendId == _auth.currentUser?.uid) return const SizedBox.shrink();

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FriendProfileScreen(
                          name: username, bio: bio, friendId: friendId,
                        )));
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.lightGreen.withOpacity(0.9),
                        child: Text(username[0].toUpperCase(), style: const TextStyle(color: Colors.white)),
                      ),
                      title: Text(username, style: const TextStyle(color: Colors.white, fontFamily: 'PlayfairDisplay')),
                      trailing: ElevatedButton(
                        onPressed: () => _handleAddFriend(friendId, username, bio),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.sunsetOrange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('+ Friend', style: TextStyle(color: Colors.white)),
                      ),
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