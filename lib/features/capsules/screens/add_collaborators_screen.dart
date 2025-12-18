// // // // import 'package:flutter/material.dart';
// // // // import '../services/user_lookup_service.dart';
// // // // import '../services/collaboration_service.dart';
// // // // import '../services/capsule_service.dart';
// // // // import 'package:lock_connect/utils/fallback_user.dart';
// // // //
// // // // class AddCollaboratorsScreen extends StatefulWidget {
// // // //   final String capsuleId;
// // // //   final CapsuleService capsuleService;
// // // //   const AddCollaboratorsScreen({
// // // //     super.key,
// // // //     required this.capsuleId,
// // // //     required this.capsuleService,
// // // //   });
// // // //
// // // //   @override
// // // //   State<AddCollaboratorsScreen> createState() => _AddCollaboratorsScreenState();
// // // // }
// // // //
// // // // class _AddCollaboratorsScreenState extends State<AddCollaboratorsScreen> {
// // // //   final _emailCtrl = TextEditingController();
// // // //   final _usernameCtrl = TextEditingController();
// // // //   final _lookup = UserLookupService();
// // // //   final _collab = CollaborationService();
// // // //   bool _sending = false;
// // // //
// // // //   Future<void> _sendRequest() async {
// // // //     final me = currentUserIdOrFallback();
// // // //     setState(() => _sending = true);
// // // //     try {
// // // //       String? toUid;
// // // //       if (_emailCtrl.text.trim().isNotEmpty) {
// // // //         toUid = await _lookup.findUserUidByEmail(_emailCtrl.text.trim());
// // // //       } else if (_usernameCtrl.text.trim().isNotEmpty) {
// // // //         toUid = await _lookup.findUserUidByUsername(_usernameCtrl.text.trim());
// // // //       }
// // // //       if (toUid == null) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not found')));
// // // //       } else {
// // // //         await _collab.sendRequest(capsuleId: widget.capsuleId, fromUid: me, toUid: toUid);
// // // //         if (mounted) Navigator.pop(context);
// // // //       }
// // // //     } catch (e) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
// // // //     } finally {
// // // //       if (mounted) setState(() => _sending = false);
// // // //     }
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(title: const Text('Add collaborator')),
// // // //       body: Padding(
// // // //         padding: const EdgeInsets.all(16),
// // // //         child: Column(
// // // //           children: [
// // // //             TextField(
// // // //               controller: _emailCtrl,
// // // //               decoration: const InputDecoration(labelText: 'Email'),
// // // //             ),
// // // //             const SizedBox(height: 8),
// // // //             Text('OR', style: Theme.of(context).textTheme.bodySmall),
// // // //             const SizedBox(height: 8),
// // // //             TextField(
// // // //               controller: _usernameCtrl,
// // // //               decoration: const InputDecoration(labelText: 'Username'),
// // // //             ),
// // // //             const SizedBox(height: 16),
// // // //             ElevatedButton(
// // // //               onPressed: _sending ? null : _sendRequest,
// // // //               child: _sending ? const CircularProgressIndicator.adaptive() : const Text('Send request'),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import '../services/user_lookup_service.dart';
// // // import '../services/collaboration_service.dart';
// // // import '../services/capsule_service.dart';
// // //
// // // class AddCollaboratorsScreen extends StatefulWidget {
// // //   final String capsuleId;
// // //   final CapsuleService capsuleService;
// // //   const AddCollaboratorsScreen({
// // //     super.key,
// // //     required this.capsuleId,
// // //     required this.capsuleService,
// // //   });
// // //
// // //   @override
// // //   State<AddCollaboratorsScreen> createState() => _AddCollaboratorsScreenState();
// // // }
// // //
// // // class _AddCollaboratorsScreenState extends State<AddCollaboratorsScreen> {
// // //   final _emailCtrl = TextEditingController();
// // //   final _usernameCtrl = TextEditingController();
// // //   final _lookup = UserLookupService();
// // //   final _collab = CollaborationService();
// // //   bool _sending = false;
// // //
// // //   Future<void> _sendRequest() async {
// // //     final me = FirebaseAuth.instance.currentUser!.uid;
// // //     setState(() => _sending = true);
// // //     try {
// // //       String? toUid;
// // //       if (_emailCtrl.text.trim().isNotEmpty) {
// // //         toUid = await _lookup.findUserUidByEmail(_emailCtrl.text.trim());
// // //       } else if (_usernameCtrl.text.trim().isNotEmpty) {
// // //         toUid = await _lookup.findUserUidByUsername(_usernameCtrl.text.trim());
// // //       }
// // //       if (toUid == null) {
// // //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not found')));
// // //       } else {
// // //         await _collab.sendRequest(capsuleId: widget.capsuleId, fromUid: me, toUid: toUid);
// // //         if (mounted) Navigator.pop(context);
// // //       }
// // //     } catch (e) {
// // //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
// // //     } finally {
// // //       if (mounted) setState(() => _sending = false);
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text('Add collaborator')),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           children: [
// // //             TextField(
// // //               controller: _emailCtrl,
// // //               decoration: const InputDecoration(labelText: 'Email'),
// // //             ),
// // //             const SizedBox(height: 8),
// // //             Text('OR', style: Theme.of(context).textTheme.bodySmall),
// // //             const SizedBox(height: 8),
// // //             TextField(
// // //               controller: _usernameCtrl,
// // //               decoration: const InputDecoration(labelText: 'Username'),
// // //             ),
// // //             const SizedBox(height: 16),
// // //             ElevatedButton(
// // //               onPressed: _sending ? null : _sendRequest,
// // //               child: _sending ? const CircularProgressIndicator.adaptive() : const Text('Send request'),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
// // import 'package:flutter/material.dart';
// // // NOTE: Using the direct paths we established in the previous conversation
// // import 'package:lock_connect/core/constants/app_colors.dart';
// // import 'package:lock_connect/core/constants/colors.dart';
// //
// //
// // class AddCollaboratorsScreen extends StatefulWidget {
// //   const AddCollaboratorsScreen({super.key});
// //
// //   @override
// //   State<AddCollaboratorsScreen> createState() => _AddCollaboratorsScreenState();
// // }
// //
// // class _AddCollaboratorsScreenState extends State<AddCollaboratorsScreen> {
// //   // Mock data for search results
// //   final List<Map<String, dynamic>> mockUsers = [
// //     {'name': 'Alex Johnson', 'status': 'Friend'},
// //     {'name': 'Sarah Lee', 'status': 'Friend'},
// //     {'name': 'Mike Chen', 'status': 'Invite Sent'},
// //     {'name': 'Jessica Smith', 'status': 'Not Friend'},
// //     {'name': 'Tom Wilson', 'status': 'Friend'},
// //     {'name': 'Olivia Brown', 'status': 'Not Friend'},
// //     {'name': 'Daniel Kim', 'status': 'Friend'},
// //   ];
// //
// //   // List to track which users are selected for the capsule
// //   final List<String> _selectedCollaborators = [];
// //   String _searchQuery = '';
// //
// //   void _toggleCollaborator(String name) {
// //     setState(() {
// //       if (_selectedCollaborators.contains(name)) {
// //         _selectedCollaborators.remove(name);
// //       } else {
// //         _selectedCollaborators.add(name);
// //       }
// //     });
// //   }
// //
// //   // Helper to build the action icon based on selection status
// //   Widget _buildActionButton(String name) {
// //     final isSelected = _selectedCollaborators.contains(name);
// //
// //     if (isSelected) {
// //       // User is selected: Show Checkmark (Sunset Orange)
// //       return const Icon(Icons.check_circle, color: AppColors.sunsetOrange, size: 28);
// //     } else {
// //       // User is not selected: Show Add Icon (Gold)
// //       return const Icon(Icons.person_add_alt_1_rounded, color: AppColors.goldText, size: 28);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final filteredUsers = mockUsers.where((user) {
// //       final nameLower = user['name'].toLowerCase();
// //       final queryLower = _searchQuery.toLowerCase();
// //       return nameLower.contains(queryLower);
// //     }).toList();
// //
// //     return Container(
// //       // --- Seamless Gradient Background ---
// //       decoration: const BoxDecoration(
// //         gradient: LinearGradient(
// //           colors: [
// //             AppColors.sunsetBlue,
// //             AppColors.sunsetPurple,
// //             AppColors.sunsetPink,
// //             AppColors.sunsetOrange,
// //           ],
// //           begin: Alignment.topCenter,
// //           end: Alignment.bottomCenter,
// //         ),
// //       ),
// //       child: Scaffold(
// //         backgroundColor: Colors.transparent,
// //         appBar: AppBar(
// //           backgroundColor: Colors.transparent,
// //           elevation: 0,
// //           iconTheme: const IconThemeData(color: AppColors.goldText),
// //           title: Text(
// //             'Add Collaborators',
// //             // --- Matching Create Capsule Title Style ---
// //             style: Theme.of(context).textTheme.titleLarge!.copyWith(
// //               fontFamily: 'PlayfairDisplay',
// //               fontWeight: FontWeight.bold,
// //               color: AppColors.goldText,
// //               fontSize: 20,
// //               letterSpacing: 1,
// //             ),
// //           ),
// //           actions: [
// //             // Display selected count
// //             Padding(
// //               padding: const EdgeInsets.only(right: 16.0),
// //               child: Center(
// //                 child: Text(
// //                   '${_selectedCollaborators.length} Selected',
// //                   style: const TextStyle(color: AppColors.goldText, fontSize: 16, fontFamily: 'Roboto'),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //
// //         body: Column(
// //           children: [
// //             // --- 1. SEARCH BAR ---
// //             Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: TextField(
// //                 onChanged: (value) {
// //                   setState(() {
// //                     _searchQuery = value;
// //                   });
// //                 },
// //                 style: const TextStyle(color: Colors.white, fontFamily: 'Roboto'),
// //                 decoration: InputDecoration(
// //                   hintText: 'Search to add collaborators...',
// //                   hintStyle: TextStyle(color: AppColors.textHint.withOpacity(0.5), fontFamily: 'Roboto'),
// //                   prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
// //                   suffixIcon: _searchQuery.isNotEmpty
// //                       ? IconButton(icon: const Icon(Icons.clear, color: AppColors.textHint), onPressed: () => setState(() => _searchQuery = ''),)
// //                       : null,
// //                   filled: true,
// //                   fillColor: Colors.black.withOpacity(0.4),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(30),
// //                     borderSide: BorderSide.none,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //
// //             // --- 2. COLLABORATOR LIST ---
// //             Expanded(
// //               child: ListView.builder(
// //                 padding: const EdgeInsets.symmetric(horizontal: 10),
// //                 itemCount: filteredUsers.length,
// //                 itemBuilder: (context, index) {
// //                   final user = filteredUsers[index];
// //                   final isSelected = _selectedCollaborators.contains(user['name']);
// //
// //                   return GestureDetector(
// //                     onTap: () => _toggleCollaborator(user['name']),
// //                     child: Container(
// //                       margin: const EdgeInsets.symmetric(vertical: 6),
// //                       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
// //                       decoration: BoxDecoration(
// //                         // Highlight selected user with semi-transparent orange background
// //                         color: isSelected ? AppColors.sunsetOrange.withOpacity(0.2) : Colors.black.withOpacity(0.6),
// //                         borderRadius: BorderRadius.circular(15),
// //                         border: Border.all(
// //                           // Border highlights selected item
// //                             color: isSelected ? AppColors.sunsetOrange : Colors.white24
// //                         ),
// //                       ),
// //                       child: Row(
// //                         children: [
// //                           // Profile Picture
// //                           CircleAvatar(
// //                             radius: 20,
// //                             backgroundColor: AppColors.sunsetPurple,
// //                             child: Text(user['name'][0], style: const TextStyle(color: Colors.white, fontFamily: 'Roboto')),
// //                           ),
// //                           const SizedBox(width: 12),
// //
// //                           // Name and Status
// //                           Expanded(
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   user['name'],
// //                                   style: TextStyle(
// //                                     // Name color is orange when selected, otherwise white
// //                                     color: isSelected ? AppColors.sunsetOrange : AppColors.textPrimary,
// //                                     fontSize: 16,
// //                                     fontWeight: FontWeight.bold,
// //                                     fontFamily: 'Roboto',
// //                                   ),
// //                                 ),
// //                                 // Text(
// //                                 //   user['status'],
// //                                 //   style: TextStyle(
// //                                 //     color: AppColors.textHint, // Status text remains subtle grey
// //                                 //     fontSize: 13,
// //                                 //     fontFamily: 'Roboto',
// //                                 //   ),
// //                                 // ),
// //                               ],
// //                             ),
// //                           ),
// //
// //                           // Action Icon (Add/Check)
// //                           _buildActionButton(user['name']),
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //
// //         floatingActionButton: FloatingActionButton.extended(
// //           onPressed: () {
// //             // Passes the selected list of collaborator names back to CreateCapsuleScreen
// //             // (CreateCapsuleScreen will handle updating its UI with the result)
// //             Navigator.pop(context, _selectedCollaborators);
// //           },
// //           // --- APPLYING SEAL CAPSULE BUTTON STYLES ---
// //
// //           // 1. Text Label (Ensures matching size/weight)
// //           label: Text(
// //             'Done (${_selectedCollaborators.length})',
// //             style: const TextStyle(
// //               color: Colors.white,
// //               fontSize: 18, // Matches the SEAL CAPSULE text size
// //               fontWeight: FontWeight.bold,
// //               fontFamily: 'PlayfairDisplay',
// //               // Added letter spacing for a branded look
// //               letterSpacing: 1.5,
// //             ),
// //           ),
// //
// //           // 2. Icon and Background
// //           icon: const Icon(Icons.check, color: Colors.white),
// //           backgroundColor: AppColors.sunsetOrange,
// //           elevation: 8,
// //
// //           // 3. Shape (Matches the rounded corners of the SEAL CAPSULE button)
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(30),
// //           ),
// //         ),
// //         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:lock_connect/core/constants/app_colors.dart';
//
// class AddCollaboratorsScreen extends StatefulWidget {
//   const AddCollaboratorsScreen({super.key});
//
//   @override
//   State<AddCollaboratorsScreen> createState() => _AddCollaboratorsScreenState();
// }
//
// class _AddCollaboratorsScreenState extends State<AddCollaboratorsScreen> {
//   // Store full user objects (ID + Name) so we can return IDs to the backend
//   final List<Map<String, String>> _selectedCollaborators = [];
//   String _searchQuery = '';
//
//   void _toggleCollaborator(String uid, String name) {
//     setState(() {
//       final index = _selectedCollaborators.indexWhere((element) => element['uid'] == uid);
//       if (index >= 0) {
//         _selectedCollaborators.removeAt(index);
//       } else {
//         _selectedCollaborators.add({'uid': uid, 'name': name});
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
//           begin: Alignment.topCenter, end: Alignment.bottomCenter,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent, elevation: 0,
//           title: Text('Add Collaborators', style: TextStyle(fontFamily: 'PlayfairDisplay', color: AppColors.goldText, fontWeight: FontWeight.bold)),
//         ),
//         body: Column(
//           children: [
//             // --- SEARCH BAR ---
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   hintText: 'Search by name...',
//                   fillColor: Colors.black.withOpacity(0.4), filled: true,
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
//                   prefixIcon: const Icon(Icons.search, color: Colors.white70),
//                 ),
//               ),
//             ),
//             // --- REAL-TIME USER LIST FROM FIREBASE ---
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance.collection('users').snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//
//                   final users = snapshot.data!.docs.where((doc) {
//                     final name = (doc['name'] ?? '').toString().toLowerCase();
//                     return name.contains(_searchQuery);
//                   }).toList();
//
//                   return ListView.builder(
//                     itemCount: users.length,
//                     itemBuilder: (context, index) {
//                       final userData = users[index].data() as Map<String, dynamic>;
//                       final uid = users[index].id;
//                       final name = userData['name'] ?? 'Unknown';
//                       final isSelected = _selectedCollaborators.any((e) => e['uid'] == uid);
//
//                       return ListTile(
//                         onTap: () => _toggleCollaborator(uid, name),
//                         leading: CircleAvatar(backgroundColor: AppColors.sunsetPurple, child: Text(name[0])),
//                         title: Text(name, style: TextStyle(color: isSelected ? AppColors.sunsetOrange : Colors.white)),
//                         trailing: Icon(
//                           isSelected ? Icons.check_circle : Icons.person_add,
//                           color: isSelected ? AppColors.sunsetOrange : AppColors.goldText,
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton.extended(
//           onPressed: () => Navigator.pop(context, _selectedCollaborators), // Returns List<Map<String, String>>
//           label: Text('Done (${_selectedCollaborators.length})'),
//           backgroundColor: AppColors.sunsetOrange,
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lock_connect/core/constants/app_colors.dart';

class AddCollaboratorsScreen extends StatefulWidget {
  const AddCollaboratorsScreen({super.key});

  @override
  State<AddCollaboratorsScreen> createState() => _AddCollaboratorsScreenState();
}

class _AddCollaboratorsScreenState extends State<AddCollaboratorsScreen> {
  // Stores Map of {'uid': '...', 'name': '...'}
  final List<Map<String, String>> _selectedCollaborators = [];
  String _searchQuery = '';

  void _toggleCollaborator(String uid, String name) {
    setState(() {
      final index = _selectedCollaborators.indexWhere((element) => element['uid'] == uid);
      if (index >= 0) {
        _selectedCollaborators.removeAt(index);
      } else {
        _selectedCollaborators.add({'uid': uid, 'name': name});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent, elevation: 0,
          title: const Text('Search Users', style: TextStyle(fontFamily: 'PlayfairDisplay', color: Colors.white)),
        ),
        body: Column(
          children: [
            // --- SEARCH BAR ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (val) => setState(() => _searchQuery = val.trim().toLowerCase()),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search by exact name or email...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  fillColor: Colors.black.withOpacity(0.4), filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                ),
              ),
            ),

            // --- REAL-TIME USER ACCESS ---
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                // Ensure your collection name is 'users'
                stream: FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
                  if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

                  // Filter users locally based on search query
                  final docs = snapshot.data!.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final name = (data['name'] ?? data['username'] ?? '').toString().toLowerCase();
                    final email = (data['email'] ?? '').toString().toLowerCase();
                    return name.contains(_searchQuery) || email.contains(_searchQuery);
                  }).toList();

                  if (docs.isEmpty) return const Center(child: Text('No users found.', style: TextStyle(color: Colors.white70)));

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      final uid = docs[index].id;
                      // Fallback logic for different naming conventions
                      final displayName = data['name'] ?? data['username'] ?? 'Anonymous';
                      final isSelected = _selectedCollaborators.any((e) => e['uid'] == uid);

                      return ListTile(
                        onTap: () => _toggleCollaborator(uid, displayName),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.sunsetPurple,
                          child: Text(displayName[0].toUpperCase(), style: const TextStyle(color: Colors.white)),
                        ),
                        title: Text(displayName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text(data['email'] ?? '', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        trailing: Icon(
                          isSelected ? Icons.check_circle : Icons.add_circle_outline,
                          color: isSelected ? AppColors.sunsetOrange : Colors.white70,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.pop(context, _selectedCollaborators),
          label: Text('Confirm (${_selectedCollaborators.length})'),
          backgroundColor: AppColors.sunsetOrange,
        ),
      ),
    );
  }
}