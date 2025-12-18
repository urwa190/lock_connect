// import 'package:flutter/material.dart';
// import '../models/collab_request.dart';
// import '../services/collaboration_service.dart';
// import 'package:lock_connect/utils/fallback_user.dart';
//
// class CollaborationsRequestScreen extends StatelessWidget {
//   CollaborationsRequestScreen({super.key});
//   final _collab = CollaborationService();
//
//   @override
//   Widget build(BuildContext context) {
//     final uid = currentUserIdOrFallback();
//     return Scaffold(
//       appBar: AppBar(title: const Text('Collaboration Requests')),
//       body: StreamBuilder<List<CollabRequest>>(
//         stream: _collab.streamIncoming(toUid: uid),
//         builder: (context, snap) {
//           if (!snap.hasData) return const Center(child: CircularProgressIndicator());
//           final reqs = snap.data!;
//           if (reqs.isEmpty) return const Center(child: Text('No pending requests'));
//           return ListView.builder(
//             itemCount: reqs.length,
//             itemBuilder: (_, i) {
//               final r = reqs[i];
//               return ListTile(
//                 title: Text('Capsule: ${r.capsuleId}'),
//                 subtitle: Text('From: ${r.fromUid}'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.check, color: Colors.green),
//                       onPressed: () => _collab.respondRequest(requestId: r.id, accept: true),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.red),
//                       onPressed: () => _collab.respondRequest(requestId: r.id, accept: false),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/collab_request.dart';
import '../services/collaboration_service.dart';

class CollaborationsRequestScreen extends StatelessWidget {
  CollaborationsRequestScreen({super.key});
  final _collab = CollaborationService();

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(title: const Text('Collaboration Requests')),
      body: StreamBuilder<List<CollabRequest>>(
        stream: _collab.streamIncoming(uid),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final reqs = snap.data!;
          if (reqs.isEmpty) return const Center(child: Text('No pending requests'));
          return ListView.builder(
            itemCount: reqs.length,
            itemBuilder: (_, i) {
              final r = reqs[i];
              return ListTile(
                title: Text('Capsule: ${r.capsuleId}'),
                subtitle: Text('From: ${r.fromUid}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => _collab.respondRequest(requestId: r.id, accept: true),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => _collab.respondRequest(requestId: r.id, accept: false),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}