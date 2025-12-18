// // // import 'package:flutter/material.dart';
// // // import 'dart:ui';
// // // import 'package:lock_connect/core/constants/colors.dart';
// // // import 'content_overlay.dart'; // Import the inner card widget
// // //
// // // class VisualCapsuleCard extends StatelessWidget {
// // //   final String title;
// // //   final Color baseColor;
// // //   final bool isLocked;
// // //   final String creationDate;
// // //   final VoidCallback onTap;
// // //
// // //   const VisualCapsuleCard({
// // //     super.key,
// // //     required this.title,
// // //     required this.baseColor,
// // //     required this.isLocked,
// // //     required this.creationDate,
// // //     required this.onTap,
// // //   });
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // --- CONDITIONAL COLOR LOGIC ---
// // //     // If locked (dark background), foreground is white.
// // //     // If unlocked (light/yellow card), foreground is black for contrast.
// // //
// // //     final Color foregroundColor = isLocked ? Colors.white : Colors.black;
// // //     // ---------------------------------
// // //
// // //     // Secondary color for the gradient effect
// // //     Color secondaryColor = isLocked ? baseColor.withOpacity(0.6) : baseColor.withOpacity(0.6);
// // //
// // //     // Wrap the entire card in a GestureDetector for clickability
// // //     return GestureDetector(
// // //       onTap: onTap,
// // //       child: Container(
// // //         margin: const EdgeInsets.symmetric(vertical: 10.0),
// // //         height: 180,
// // //         decoration: BoxDecoration(
// // //           borderRadius: BorderRadius.circular(18.0),
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color: kDarkTextColor.withOpacity(0.15),
// // //               blurRadius: 15,
// // //               offset: const Offset(0, 4),
// // //             ),
// // //           ],
// // //         ),
// // //         child: ClipRRect(
// // //           borderRadius: BorderRadius.circular(16.0),
// // //           child: Container(
// // //             // OUTER CARD: Gradient Background
// // //             decoration: BoxDecoration(
// // //               gradient: LinearGradient(
// // //                 colors: [baseColor.withOpacity(0.9), secondaryColor.withOpacity(0.8)],
// // //                 begin: Alignment.topLeft,
// // //                 end: Alignment.bottomRight,
// // //               ),
// // //             ),
// // //             child: Stack(
// // //               children: [
// // //                 // 1. Structural Elements (Lock Icon/Status, Creation Date)
// // //                 Padding(
// // //                   padding: const EdgeInsets.all(12.0),
// // //                   child: Column(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       // TOP SECTION (Lock Icon & Status - Pushed Right)
// // //                       Row(
// // //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // //                         children: [
// // //                           const SizedBox.shrink(), // Spacer for alignment
// // //                           Column(
// // //                             crossAxisAlignment: CrossAxisAlignment.end,
// // //                             mainAxisAlignment: MainAxisAlignment.end,
// // //                             children: [
// // //                               // ICON COLOR CHANGE APPLIED HERE
// // //                               Icon(
// // //                                   isLocked ? Icons.lock_rounded : Icons.lock_open_rounded,
// // //                                   size: 24,
// // //                                   color: foregroundColor // <-- USES conditional color
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ],
// // //                       ),
// // //
// // //                       // Spacer to push the inner card and bottom section
// // //                       const SizedBox.shrink(),
// // //
// // //                       // BOTTOM SECTION (Creation Date - Lower Left)
// // //                       Text(
// // //                           'Created On: $creationDate',
// // //                           style: TextStyle(
// // //                               color: foregroundColor, // <-- USES conditional color
// // //                               fontSize: 12,
// // //                               fontWeight: FontWeight.bold,
// // //                             fontFamily: 'Roboto',
// // //                           )
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //
// // //                 // 2. INNER CARD (Content Overlay - Centered and Conditioned)
// // //                 Center(
// // //                   child: SizedBox( // Changed Container to SizedBox for consistency/simplicity
// // //                     width: MediaQuery.of(context).size.width * 0.75, // Responsive width
// // //                     height: 100, // Fixed height for the inner card
// // //                     child: ContentOverlay(
// // //                       title: title,
// // //                       isLocked: isLocked, // Pass lock status to control its content colors
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// // import 'package:flutter/material.dart';
// // import '../models/capsule.dart';
// //
// // class VisualCapsuleCard extends StatelessWidget {
// //   final Capsule capsule;
// //   const VisualCapsuleCard({super.key, required this.capsule});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //       child: ListTile(
// //         leading: capsule.coverImageUrl.isNotEmpty
// //             ? ClipRRect(
// //           borderRadius: BorderRadius.circular(8),
// //           child: Image.network(
// //             capsule.coverImageUrl,
// //             width: 56,
// //             height: 56,
// //             fit: BoxFit.cover,
// //           ),
// //         )
// //             : const Icon(Icons.collections),
// //         title: Text(capsule.title),
// //         subtitle: Text(capsule.description),
// //         trailing: Row(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             if (capsule.isPrivate) const Icon(Icons.lock, size: 18),
// //             const SizedBox(width: 6),
// //             Text('${capsule.collaborators.length + 1} members'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import '../models/capsule.dart';
//
// class VisualCapsuleCard extends StatelessWidget {
//   final Capsule capsule;
//   const VisualCapsuleCard({super.key, required this.capsule});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: ListTile(
//         leading: capsule.coverImageUrl.isNotEmpty
//             ? ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Image.network(
//             capsule.coverImageUrl,
//             width: 56,
//             height: 56,
//             fit: BoxFit.cover,
//           ),
//         )
//             : const Icon(Icons.collections),
//         title: Text(capsule.title),
//         subtitle: Text(capsule.description),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (capsule.isPrivate) const Icon(Icons.lock, size: 18),
//             const SizedBox(width: 6),
//             Text('${capsule.collaborators.length + 1} members'),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/capsule.dart';

class VisualCapsuleCard extends StatelessWidget {
  final Capsule capsule;
  const VisualCapsuleCard({super.key, required this.capsule});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: capsule.coverImageUrl.isNotEmpty
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            capsule.coverImageUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
        )
            : const Icon(Icons.collections),
        title: Text(capsule.title),
        subtitle: Text(capsule.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (capsule.isPrivate) const Icon(Icons.lock, size: 18),
            const SizedBox(width: 6),
            Text('${capsule.collaborators.length + 1} members'),
          ],
        ),
      ),
    );
  }
}