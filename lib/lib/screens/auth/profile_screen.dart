import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/post_model.dart';
import '../../../widgets/post_card.dart';
import 'SettingsScreen.dart';
import 'edit_profile.dart';
import 'explore_friends.dart';
import 'friends_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTab = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 💬 Feedback Dialog Logic
  void _showFeedbackDialog() {
    final TextEditingController feedbackController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.sunsetPurple,
        title: const Text("Submit Feedback",
            style: TextStyle(color: AppColors.goldText, fontFamily: 'PlayfairDisplay')),
        content: TextField(
          controller: feedbackController,
          maxLines: 4,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Tell us what you think...",
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.black26,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.white70))
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.sunsetOrange),
            onPressed: () async {
              String feedbackText = feedbackController.text.trim();
              if (feedbackText.isNotEmpty) {
                try {
                  await _firestore.collection('feedbacks').add({
                    'userId': _auth.currentUser?.uid,
                    'text': feedbackText,
                    'timestamp': FieldValue.serverTimestamp(),
                  });
                  if (mounted) {
                    Navigator.pop(context);
                    _showSnackBar(context, "Feedback sent! Thank you.");
                  }
                } catch (e) {
                  debugPrint("FIRESTORE ERROR: $e");
                  if (mounted) _showSnackBar(context, "Error: Check your Firebase Rules");
                }
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser = _auth.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      // 🟢 The document ID must match the Auth UID exactly
      stream: _firestore.collection('users').doc(currentUser?.uid).snapshots(),
      builder: (context, snapshot) {
        String username = "Loading...";
        String bio = "Lover of memories and moments";
        String initial = "U";
        String? profileImageUrl;

        // 🟢 FIXED: Safe connection state handling
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.sunsetOrange)));
        }

        // 🟢 FIXED: Improved Null checking to prevent Map cast errors
        if (snapshot.hasData && snapshot.data != null && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;

          if (data != null) {
            username = data['username'] ?? "User";
            bio = data['bio'] ?? bio;
            initial = username.isNotEmpty ? username[0].toUpperCase() : "U";
            profileImageUrl = data['profileImageUrl'];
          }
        } else {
          // Fallback if document is missing from Firestore
          username = "User Not Found";
        }

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppColors.background,
          endDrawer: _buildAppDrawer(context, username, initial, profileImageUrl),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.sunsetBlue,
            title: const Text(
              "Profile",
              style: TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold, color: AppColors.goldText),
            ),
            actions: [
              IconButton(
                onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                icon: const Icon(Icons.menu_rounded, color: AppColors.goldText, size: 30),
              ),
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blueAccent,
                            backgroundImage: profileImageUrl != null ? NetworkImage(profileImageUrl) : null,
                            child: profileImageUrl == null
                                ? Text(initial, style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay'))
                                : null,
                          ),
                          const SizedBox(width: 25),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const _ProfileStat(label: 'Threads', value: '12'),
                                const _ProfileStat(label: 'Capsules', value: '34'),
                                StreamBuilder<QuerySnapshot>(
                                  stream: _firestore.collection('users').doc(currentUser?.uid).collection('friends').snapshots(),
                                  builder: (context, friendSnap) {
                                    String count = friendSnap.hasData ? friendSnap.data!.docs.length.toString() : "0";
                                    return _ProfileStat(label: 'Friends', value: count);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(username, style: const TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.goldText)),
                      const SizedBox(height: 5),
                      Text(bio, style: const TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 16, color: AppColors.textPrimary)),
                      const SizedBox(height: 20),
                      _buildEditButton(context),
                      const SizedBox(height: 25),
                      _buildTabsRow(),
                      const SizedBox(height: 20),
                      _selectedTab == 0 ? _buildCollectionSection() : _buildExploreSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // 📰 Social Feed Section
  Widget _buildCollectionSection() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mockPosts.length,
      itemBuilder: (context, index) {
        return PostCard(post: mockPosts[index]);
      },
    );
  }

  // 🌎 Fixed Explore Section UI
  Widget _buildExploreSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10, bottom: 40),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.people_alt_outlined, size: 80, color: AppColors.goldText),
          const SizedBox(height: 20),
          const Text(
            "Looking for your circle?",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay'),
          ),
          const SizedBox(height: 10),
          const Text(
            "Explore the Rekindl community to find friends and share memories.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.sunsetOrange,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExploreFriendsScreen()),
            ),
            child: const Text('Explore Friends', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // --- 🧭 DRAWER & UI HELPERS ---
  Drawer _buildAppDrawer(BuildContext context, String name, String initial, String? imageUrl) {
    const Color textIconColor = Colors.white;
    return Drawer(
      backgroundColor: AppColors.sunsetPurple,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey[400],
                    backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
                    child: imageUrl == null ? Text(initial, style: const TextStyle(fontSize: 24, color: Colors.white)) : null,
                  ),
                  const SizedBox(height: 10),
                  Text(name, style: const TextStyle(color: textIconColor, fontSize: 20, fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          _drawerItem(Icons.person, "My Profile", () => Navigator.pop(context), textIconColor),
          _drawerItem(Icons.settings, "Settings", () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
          }, textIconColor),
          _drawerItem(Icons.feedback_outlined, "Feedback", () {
            Navigator.pop(context);
            _showFeedbackDialog();
          }, textIconColor),
          const Spacer(),
          _drawerItem(Icons.logout, "Logout", () => _showLogoutConfirmation(context), Colors.white),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // 🟢 CORRECTED LOGOUT: Leads to Login/Signup screen
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.sunsetPurple,
        title: const Text("Logout", style: TextStyle(color: AppColors.goldText, fontFamily: 'PlayfairDisplay')),
        content: const Text("Are you sure you want to logout?", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.white70))),
          TextButton(
            onPressed: () async {
              // 1. Sign out from Firebase
              await _auth.signOut();

              // 2. Clear navigation history and go back to initial Auth route
              if (mounted) {
                // This will push the root route ('/') which should be your Login/Auth Wrapper
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              }
            },
            child: const Text("Logout", style: TextStyle(color: AppColors.sunsetOrange)),
          ),
        ],
      ),
    );
  }

  ListTile _drawerItem(IconData icon, String title, VoidCallback onTap, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontFamily: 'PlayfairDisplay', fontSize: 16)),
      onTap: onTap,
      trailing: Icon(Icons.arrow_forward_ios, color: color.withOpacity(0.5), size: 14),
    );
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: AppColors.sunsetPurple));
  }

  Widget _buildEditButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen())),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black26, padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        child: const Text('Edit profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTabsRow() {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24, width: 1)),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(0, Icons.collections, 'Collections'),
            _buildTabItem(1, Icons.explore_outlined, 'Explore')
          ]
      ),
    );
  }

  Widget _buildTabItem(int index, IconData icon, String label) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: isSelected ? const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.sunsetOrange, width: 3))) : null,
        child: Row(children: [Icon(icon, color: isSelected ? AppColors.goldText : Colors.white70, size: 18), const SizedBox(width: 5), Text(label, style: TextStyle(color: isSelected ? AppColors.goldText : AppColors.textHint, fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay'))]),
      ),
    );
  }
}

// Stats Widget
class _ProfileStat extends StatelessWidget {
  final String label, value;
  const _ProfileStat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { if (label == 'Friends') Navigator.push(context, MaterialPageRoute(builder: (context) => FriendsScreen(friendsCount: int.parse(value)))); },
      child: Column(children: [Text(value, style: const TextStyle(color: AppColors.goldText, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay')), Text(label, style: const TextStyle(color: AppColors.textHint, fontSize: 14))]),
    );
  }
}