import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _isPrivateAccount = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.sunsetBlue,
        title: const Text("Settings",
            style: TextStyle(fontFamily: 'PlayfairDisplay', color: AppColors.goldText)),
        iconTheme: const IconThemeData(color: AppColors.goldText),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.sunsetBlue, AppColors.sunsetPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- TOP SECTION: TOGGLES ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader("Preferences"),
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications, color: AppColors.goldText),
                    title: const Text("Notifications", style: TextStyle(color: Colors.white)),
                    value: _notificationsEnabled,
                    onChanged: (val) => setState(() => _notificationsEnabled = val),
                    activeColor: AppColors.sunsetOrange,
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.lock, color: AppColors.goldText),
                    title: const Text("Private Profile", style: TextStyle(color: Colors.white)),
                    value: _isPrivateAccount,
                    onChanged: (val) => setState(() => _isPrivateAccount = val),
                    activeColor: AppColors.sunsetOrange,
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.white24, thickness: 1),
            _sectionHeader("  My Feedbacks"),

            // --- BOTTOM SECTION: LIST OF FEEDBACKS ---
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                // 🛠️ FIX: Removed .orderBy temporarily.
                // Firestore requires a manual index to use 'where' and 'orderBy' together.
                stream: FirebaseFirestore.instance
                    .collection('feedbacks')
                    .where('userId', isEqualTo: user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  // 1. Handle Errors (This will show you if an Index is missing)
                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Error: ${snapshot.error}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.redAccent, fontSize: 12)),
                      ),
                    );
                  }

                  // 2. Handle Loading State
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.goldText));
                  }

                  // 3. Handle Empty State
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No feedback submitted yet.",
                          style: TextStyle(color: Colors.white54)),
                    );
                  }

                  // 4. Data exists - Build the list
                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      final text = data['text'] ?? "Empty feedback";
                      final timestamp = data['timestamp'] as Timestamp?;

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              text,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ID: ${docs[index].id.substring(0, 5)}...",
                                  style: const TextStyle(color: Colors.white24, fontSize: 10),
                                ),
                                Text(
                                  timestamp != null
                                      ? "${timestamp.toDate().day}/${timestamp.toDate().month}/${timestamp.toDate().year}"
                                      : "Sending...",
                                  style: const TextStyle(color: AppColors.goldText, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ],
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

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Text(title,
          style: const TextStyle(
              color: AppColors.goldText,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'PlayfairDisplay'
          )
      ),
    );
  }
}