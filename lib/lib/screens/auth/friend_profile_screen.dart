import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'friends_screen.dart';

class FriendProfileScreen extends StatefulWidget {
  final String name;
  final String bio;
  final String friendId;
  final int threads;
  final int capsules;

  const FriendProfileScreen({
    super.key,
    required this.name,
    required this.bio,
    required this.friendId,
    this.threads = 0,
    this.capsules = 0,
  });

  @override
  State<FriendProfileScreen> createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.sunsetBlue,
        title: Text(widget.name, style: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold, color: AppColors.goldText)),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 30),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.lightGreen,
                  child: Text(widget.name.isNotEmpty ? widget.name[0].toUpperCase() : "?",
                      style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay')),
                ),
                const SizedBox(height: 20),
                Text(widget.name, textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.goldText)),
                const SizedBox(height: 8),
                Text(widget.bio, textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 16, color: AppColors.textPrimary)),
                const SizedBox(height: 25),

                // --- STATS ROW ---
                Container(
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24, width: 1)),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ProfileStat(label: 'Threads', value: widget.threads.toString()),
                      _ProfileStat(label: 'Capsules', value: widget.capsules.toString()),

                      // 🔗 REAL-TIME FRIEND COUNT
                      StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection('users').doc(widget.friendId).collection('friends').snapshots(),
                        builder: (context, snapshot) {
                          String count = snapshot.hasData ? snapshot.data!.docs.length.toString() : "0";
                          return _ProfileStat(label: 'Friends', value: count);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                _buildCollectionHeading(),
                const SizedBox(height: 20),
                Expanded(
                  child: _buildCollectionSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionHeading() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.sunsetOrange, width: 3))),
            child: Row(children: const [
              Icon(Icons.collections, color: AppColors.goldText, size: 18),
              SizedBox(width: 5),
              Text('Collections', style: TextStyle(color: AppColors.goldText, fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay')),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionSection() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: List.generate(4, (index) => const CollectionBox(title: 'Food')),
    );
  }
} // <--- End of State class

// --- 🧱 CUSTOM WIDGETS (Defined outside the class) ---

class _ProfileStat extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (label == 'Friends') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendsScreen(friendsCount: int.parse(value)),
            ),
          );
        }
      },
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.goldText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'PlayfairDisplay',
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textHint,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class CollectionBox extends StatelessWidget {
  final String title;
  const CollectionBox({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.black.withOpacity(0.5),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(color: Colors.white24),
                Container(color: Colors.white30),
                Container(color: Colors.white24),
                Container(
                  color: Colors.black38,
                  child: const Center(
                    child: Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.sunsetOrange,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.collections, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}