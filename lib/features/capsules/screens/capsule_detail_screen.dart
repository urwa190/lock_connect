// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../models/capsule.dart';
// import '../models/capsule_content.dart';
// import '../services/capsule_service.dart';
// import 'add_collaborators_screen.dart';
// import 'package:lock_connect/utils/fallback_user.dart';
//
// class CapsuleDetailScreen extends StatefulWidget {
//   final String capsuleId;
//   final CapsuleService capsuleService;
//   const CapsuleDetailScreen({
//     super.key,
//     required this.capsuleId,
//     required this.capsuleService,
//   });
//
//   @override
//   State<CapsuleDetailScreen> createState() => _CapsuleDetailScreenState();
// }
//
// class _CapsuleDetailScreenState extends State<CapsuleDetailScreen> {
//   final _textCtrl = TextEditingController();
//
//   Future<void> _addText() async {
//     final uid = currentUserIdOrFallback();
//     if (_textCtrl.text.trim().isEmpty) return;
//     await widget.capsuleService.addTextContent(widget.capsuleId, _textCtrl.text.trim(), uid: uid);
//     _textCtrl.clear();
//   }
//
//   Future<void> _addMedia(String type) async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
//     if (picked == null) return;
//     final file = File(picked.path);
//     final uid = currentUserIdOrFallback();
//     await widget.capsuleService.addMediaContent(widget.capsuleId, file, type, uid: uid);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final uid = currentUserIdOrFallback();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Capsule Detail'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.group_add),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => AddCollaboratorsScreen(
//                   capsuleId: widget.capsuleId,
//                   capsuleService: widget.capsuleService,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: StreamBuilder<Capsule>(
//         stream: widget.capsuleService.streamCapsule(widget.capsuleId),
//         builder: (context, snap) {
//           if (!snap.hasData) return const Center(child: CircularProgressIndicator());
//           final capsule = snap.data!;
//           final isOwner = capsule.ownerId == uid;
//
//           return Column(
//             children: [
//               ListTile(
//                 title: Text(capsule.title),
//                 subtitle: Text(capsule.description),
//                 trailing: capsule.isPrivate ? const Icon(Icons.lock) : const Icon(Icons.public),
//               ),
//               Expanded(
//                 child: StreamBuilder<List<CapsuleContent>>(
//                   stream: widget.capsuleService.streamContents(widget.capsuleId),
//                   builder: (context, snap2) {
//                     if (!snap2.hasData) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     final contents = snap2.data!;
//                     if (contents.isEmpty) {
//                       return const Center(child: Text('No content yet'));
//                     }
//                     return ListView.builder(
//                       itemCount: contents.length,
//                       itemBuilder: (_, i) {
//                         final c = contents[i];
//                         if (c.type == 'text') {
//                           return ListTile(
//                             title: Text(c.text ?? ''),
//                             subtitle: Text('by ${c.createdBy}'),
//                           );
//                         } else {
//                           return ListTile(
//                             leading: c.type == 'image'
//                                 ? Image.network(c.storagePath ?? '', width: 64, height: 64, fit: BoxFit.cover)
//                                 : const Icon(Icons.videocam),
//                             title: Text(c.type),
//                             subtitle: Text('by ${c.createdBy}'),
//                           );
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: _textCtrl,
//                             decoration: const InputDecoration(labelText: 'Add text'),
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.send),
//                           onPressed: _addText,
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton.icon(
//                           onPressed: () => _addMedia('image'),
//                           icon: const Icon(Icons.image),
//                           label: const Text('Add Image'),
//                         ),
//                         ElevatedButton.icon(
//                           onPressed: () => _addMedia('image'), // change to 'video' if you add video upload endpoint
//                           icon: const Icon(Icons.video_library),
//                           label: const Text('Add Video'),
//                         ),
//                       ],
//                     ),
//                     if (isOwner)
//                       TextButton(
//                         onPressed: () async {
//                           await widget.capsuleService.deleteCapsule(widget.capsuleId);
//                           if (mounted) Navigator.pop(context);
//                         },
//                         child: const Text('Delete capsule', style: TextStyle(color: Colors.red)),
//                       ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../models/capsule.dart';
import '../models/capsule_content.dart';
import '../services/capsule_service.dart';
import 'add_collaborators_screen.dart';

class CapsuleDetailScreen extends StatefulWidget {
  final String capsuleId;
  final CapsuleService capsuleService;
  const CapsuleDetailScreen({
    super.key,
    required this.capsuleId,
    required this.capsuleService,
  });

  @override
  State<CapsuleDetailScreen> createState() => _CapsuleDetailScreenState();
}

class _CapsuleDetailScreenState extends State<CapsuleDetailScreen> {
  final _textCtrl = TextEditingController();

  Future<void> _addText() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    if (_textCtrl.text.trim().isEmpty) return;
    await widget.capsuleService.addTextContent(widget.capsuleId, _textCtrl.text.trim(), uid);
    _textCtrl.clear();
  }

  Future<void> _addMedia(String type) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked == null) return;
    final file = File(picked.path);
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await widget.capsuleService.addMediaContent(widget.capsuleId, file, type, uid);
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Capsule Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddCollaboratorsScreen(
                  capsuleId: widget.capsuleId,
                  capsuleService: widget.capsuleService,
                ),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<Capsule>(
        stream: widget.capsuleService.streamCapsule(widget.capsuleId),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final capsule = snap.data!;
          final isOwner = capsule.ownerId == uid;

          return Column(
            children: [
              ListTile(
                title: Text(capsule.title),
                subtitle: Text(capsule.description),
                trailing: capsule.isPrivate ? const Icon(Icons.lock) : const Icon(Icons.public),
              ),
              Expanded(
                child: StreamBuilder<List<CapsuleContent>>(
                  stream: widget.capsuleService.streamContents(widget.capsuleId),
                  builder: (context, snap2) {
                    if (!snap2.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final contents = snap2.data!;
                    if (contents.isEmpty) {
                      return const Center(child: Text('No content yet'));
                    }
                    return ListView.builder(
                      itemCount: contents.length,
                      itemBuilder: (_, i) {
                        final c = contents[i];
                        if (c.type == 'text') {
                          return ListTile(
                            title: Text(c.text ?? ''),
                            subtitle: Text('by ${c.createdBy}'),
                          );
                        } else {
                          return ListTile(
                            leading: c.type == 'image'
                                ? Image.network(c.storagePath ?? '', width: 64, height: 64, fit: BoxFit.cover)
                                : const Icon(Icons.videocam),
                            title: Text(c.type),
                            subtitle: Text('by ${c.createdBy}'),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textCtrl,
                            decoration: const InputDecoration(labelText: 'Add text'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _addText,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _addMedia('image'),
                          icon: const Icon(Icons.image),
                          label: const Text('Add Image'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _addMedia('image'), // change to 'video' if you add video upload endpoint
                          icon: const Icon(Icons.video_library),
                          label: const Text('Add Video'),
                        ),
                      ],
                    ),
                    if (isOwner)
                      TextButton(
                        onPressed: () async {
                          await widget.capsuleService.deleteCapsule(widget.capsuleId);
                          if (mounted) Navigator.pop(context);
                        },
                        child: const Text('Delete capsule', style: TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}