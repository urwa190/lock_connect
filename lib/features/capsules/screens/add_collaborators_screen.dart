// import 'package:flutter/material.dart';
// import '../services/user_lookup_service.dart';
// import '../services/collaboration_service.dart';
// import '../services/capsule_service.dart';
// import 'package:lock_connect/utils/fallback_user.dart';
//
// class AddCollaboratorsScreen extends StatefulWidget {
//   final String capsuleId;
//   final CapsuleService capsuleService;
//   const AddCollaboratorsScreen({
//     super.key,
//     required this.capsuleId,
//     required this.capsuleService,
//   });
//
//   @override
//   State<AddCollaboratorsScreen> createState() => _AddCollaboratorsScreenState();
// }
//
// class _AddCollaboratorsScreenState extends State<AddCollaboratorsScreen> {
//   final _emailCtrl = TextEditingController();
//   final _usernameCtrl = TextEditingController();
//   final _lookup = UserLookupService();
//   final _collab = CollaborationService();
//   bool _sending = false;
//
//   Future<void> _sendRequest() async {
//     final me = currentUserIdOrFallback();
//     setState(() => _sending = true);
//     try {
//       String? toUid;
//       if (_emailCtrl.text.trim().isNotEmpty) {
//         toUid = await _lookup.findUserUidByEmail(_emailCtrl.text.trim());
//       } else if (_usernameCtrl.text.trim().isNotEmpty) {
//         toUid = await _lookup.findUserUidByUsername(_usernameCtrl.text.trim());
//       }
//       if (toUid == null) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not found')));
//       } else {
//         await _collab.sendRequest(capsuleId: widget.capsuleId, fromUid: me, toUid: toUid);
//         if (mounted) Navigator.pop(context);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//     } finally {
//       if (mounted) setState(() => _sending = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add collaborator')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailCtrl,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             const SizedBox(height: 8),
//             Text('OR', style: Theme.of(context).textTheme.bodySmall),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _usernameCtrl,
//               decoration: const InputDecoration(labelText: 'Username'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _sending ? null : _sendRequest,
//               child: _sending ? const CircularProgressIndicator.adaptive() : const Text('Send request'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/user_lookup_service.dart';
import '../services/collaboration_service.dart';
import '../services/capsule_service.dart';

class AddCollaboratorsScreen extends StatefulWidget {
  final String capsuleId;
  final CapsuleService capsuleService;
  const AddCollaboratorsScreen({
    super.key,
    required this.capsuleId,
    required this.capsuleService,
  });

  @override
  State<AddCollaboratorsScreen> createState() => _AddCollaboratorsScreenState();
}

class _AddCollaboratorsScreenState extends State<AddCollaboratorsScreen> {
  final _emailCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _lookup = UserLookupService();
  final _collab = CollaborationService();
  bool _sending = false;

  Future<void> _sendRequest() async {
    final me = FirebaseAuth.instance.currentUser!.uid;
    setState(() => _sending = true);
    try {
      String? toUid;
      if (_emailCtrl.text.trim().isNotEmpty) {
        toUid = await _lookup.findUserUidByEmail(_emailCtrl.text.trim());
      } else if (_usernameCtrl.text.trim().isNotEmpty) {
        toUid = await _lookup.findUserUidByUsername(_usernameCtrl.text.trim());
      }
      if (toUid == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not found')));
      } else {
        await _collab.sendRequest(capsuleId: widget.capsuleId, fromUid: me, toUid: toUid);
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add collaborator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 8),
            Text('OR', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            TextField(
              controller: _usernameCtrl,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sending ? null : _sendRequest,
              child: _sending ? const CircularProgressIndicator.adaptive() : const Text('Send request'),
            ),
          ],
        ),
      ),
    );
  }
}