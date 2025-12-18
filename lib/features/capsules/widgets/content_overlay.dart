// // // // import 'package:flutter/material.dart';
// // // // import 'dart:ui';
// // // // import 'package:lock_connect/core/constants/colors.dart';
// // // //
// // // // class ContentOverlay extends StatelessWidget {
// // // //   final String title;
// // // //   final bool isLocked;
// // // //
// // // //   const ContentOverlay({
// // // //     super.key,
// // // //     required this.title,
// // // //     required this.isLocked,
// // // //   });
// // // //
// // // //   // --- Helper function to build a single Avatar (FULLY OPAQUE) ---
// // // //   Widget _buildAvatar(int index) {
// // // //     const List<Color> avatarColors = [
// // // //       Color(0xFFE57373),
// // // //       Color(0xFF64B5F6),
// // // //       Color(0xFFFFB74D)
// // // //     ];
// // // //     Color avatarColor = avatarColors[index % avatarColors.length];
// // // //
// // // //     // --- CONDITIONAL BORDER COLOR FOR AVATARS ---
// // // //     final Color borderColor = isLocked ? Colors.white : Colors.black87;
// // // //
// // // //     return Container(
// // // //       decoration: BoxDecoration(
// // // //         shape: BoxShape.circle,
// // // //         // Border color flips to black when unlocked
// // // //         border: Border.all(color: borderColor, width: 2),
// // // //       ),
// // // //       child: CircleAvatar(
// // // //         radius: 11,
// // // //         backgroundColor: avatarColor,
// // // //         child: const Text('C', style: TextStyle(fontSize: 10, color: Colors.white)),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // --- HELPER FUNCTION: Builds the Correctly Stacked Avatar Stack ---
// // // //   Widget _buildAvatarStack() {
// // // //     const double avatarRadius = 12;
// // // //     const double overlapPixels = 8;
// // // //     const int maxVisible = 3;
// // // //     const int totalCollaborators = 5;
// // // //     final int visibleAvatars = totalCollaborators > maxVisible ? maxVisible : totalCollaborators;
// // // //     final int remaining = totalCollaborators - maxVisible;
// // // //
// // // //     // --- CONDITIONAL COUNTER BACKGROUND COLOR ---
// // // //     final Color counterBackgroundColor = isLocked ? kInactiveColor : Colors.black;
// // // //     final Color counterBorderColor = isLocked ? Colors.white : Colors.black;
// // // //
// // // //     List<Widget> avatarLayers = [];
// // // //
// // // //     // Avatars are positioned from LEFT to RIGHT (i=0, 1, 2)
// // // //     for (int i = 0; i < visibleAvatars; i++) {
// // // //       avatarLayers.add(
// // // //           Positioned(
// // // //             left: i * (2 * avatarRadius - overlapPixels),
// // // //             child: _buildAvatar(i),
// // // //           )
// // // //       );
// // // //     }
// // // //
// // // //     // Add the "+X" counter circle at the end of the stack
// // // //     if (remaining > 0) {
// // // //       avatarLayers.add(
// // // //         Positioned(
// // // //           left: visibleAvatars * (2 * avatarRadius - overlapPixels),
// // // //           child: Container(
// // // //             decoration: BoxDecoration(
// // // //               shape: BoxShape.circle,
// // // //               border: Border.all(color: counterBorderColor, width: 2), // <-- APPLIED CONDITIONAL COLOR
// // // //               color: counterBackgroundColor, // <-- APPLIED CONDITIONAL COLOR
// // // //             ),
// // // //             child: CircleAvatar(
// // // //               radius: 10,
// // // //               backgroundColor: counterBackgroundColor, // <-- APPLIED CONDITIONAL COLOR
// // // //               child: Text(
// // // //                   '+${remaining}',
// // // //                   // Text inside counter should always be white/light for contrast against black/dark gray
// // // //                   style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       );
// // // //     }
// // // //
// // // //     // Calculate the width the Stack needs
// // // //     double stackWidth = (visibleAvatars * 2 * avatarRadius) - ((visibleAvatars - 1) * overlapPixels) + (remaining > 0 ? (2 * avatarRadius - overlapPixels) : 0);
// // // //
// // // //     return SizedBox(
// // // //       width: stackWidth,
// // // //       height: 26,
// // // //       child: Stack(
// // // //         children: avatarLayers,
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // --- Reworked Inner Content ---
// // // //   Widget _buildInnerContent(BuildContext context) {
// // // //     // --- CRITICAL CHANGE: Foreground Color Logic ---
// // // //     final Color foregroundColor = isLocked ? Colors.white : Colors.black;
// // // //     // ---------------------------------
// // // //
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //         crossAxisAlignment: CrossAxisAlignment.stretch,
// // // //         children: [
// // // //           // 1. TITLE (PERFECTLY CENTERED VERTICALLY)
// // // //           Expanded(
// // // //             child: Center(
// // // //               child: Text(
// // // //                 title,
// // // //                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
// // // //                   // COLOR CHANGE APPLIED HERE
// // // //                   color: foregroundColor.withOpacity(0.9), // <-- Uses conditional color
// // // //                   fontWeight: FontWeight.w900,
// // // //                   fontSize: 20,
// // // //                   // fontFamily: 'Roboto', // Ensure consistent font
// // // //                 ),
// // // //                 textAlign: TextAlign.center,
// // // //                 maxLines: 4,
// // // //                 overflow: TextOverflow.ellipsis,
// // // //               ),
// // // //             ),
// // // //           ),
// // // //
// // // //           // 2. COLLABORATORS LIST
// // // //           Row(
// // // //             mainAxisAlignment: MainAxisAlignment.end,
// // // //             children: [
// // // //               // COLLABORATORS TEXT COLOR CHANGE APPLIED HERE
// // // //               Text(
// // // //                   'Collaborators:',
// // // //                   style: TextStyle(
// // // //                       color: foregroundColor, // <-- Uses conditional color
// // // //                       fontSize: 13,
// // // //                       fontFamily: 'Roboto',
// // // //                     fontWeight: FontWeight.w500,
// // // //                   )
// // // //               ),
// // // //               const SizedBox(width: 5), // Small space between text and first avatar
// // // //
// // // //               // THE STACK OF OVERLAPPING AVATARS (Uses conditional colors via helpers)
// // // //               _buildAvatarStack(),
// // // //             ],
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     double blurIntensity = isLocked ? 5.0 : 0.0;
// // // //     // Darker surface color for locked cards, very light for unlocked cards
// // // //     Color surfaceColor = isLocked ? Colors.white.withOpacity(0.25) : Colors.black.withOpacity(0.17);
// // // //
// // // //     return ClipRRect(
// // // //       borderRadius: BorderRadius.circular(12.0),
// // // //       child: Container(
// // // //         color: surfaceColor,
// // // //         // Only show blur if locked (intensity > 0)
// // // //         child: isLocked && blurIntensity > 0
// // // //             ? Stack(
// // // //           children: [
// // // //             _buildInnerContent(context),
// // // //             Positioned.fill(
// // // //               child: BackdropFilter(
// // // //                 filter: ImageFilter.blur(sigmaX: blurIntensity, sigmaY: blurIntensity),
// // // //                 child: Container(
// // // //                   color: Colors.white.withOpacity(0.05),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         )
// // // //             : _buildInnerContent(context),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // // import 'package:flutter/material.dart';
// // // import '../models/capsule_content.dart';
// // //
// // // class ContentOverlay extends StatelessWidget {
// // //   final CapsuleContent content;
// // //   const ContentOverlay({super.key, required this.content});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     switch (content.type) {
// // //       case 'text':
// // //         return Padding(
// // //           padding: const EdgeInsets.all(12),
// // //           child: Text(content.text ?? ''),
// // //         );
// // //       case 'image':
// // //         return Image.network(content.storagePath ?? '', fit: BoxFit.cover);
// // //       case 'video':
// // //         return Column(
// // //           children: [
// // //             const Icon(Icons.videocam),
// // //             Text(content.storagePath ?? ''),
// // //           ],
// // //         );
// // //       default:
// // //         return const SizedBox.shrink();
// // //     }
// // //   }
// // // }
// //
// // import 'package:flutter/material.dart';
// // import '../models/capsule_content.dart';
// //
// // class ContentOverlay extends StatelessWidget {
// //   final CapsuleContent content;
// //   const ContentOverlay({super.key, required this.content});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     switch (content.type) {
// //       case 'text':
// //         return Padding(
// //           padding: const EdgeInsets.all(12),
// //           child: Text(content.text ?? ''),
// //         );
// //       case 'image':
// //         return Image.network(content.storagePath ?? '', fit: BoxFit.cover);
// //       case 'video':
// //         return Column(
// //           children: [
// //             const Icon(Icons.videocam),
// //             Text(content.storagePath ?? ''),
// //           ],
// //         );
// //       default:
// //         return const SizedBox.shrink();
// //     }
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import '../models/capsule_content.dart';
//
// class ContentOverlay extends StatelessWidget {
//   final CapsuleContent content;
//   const ContentOverlay({super.key, required this.content});
//
//   @override
//   Widget build(BuildContext context) {
//     switch (content.type) {
//       case 'text':
//         return Padding(
//           padding: const EdgeInsets.all(12),
//           child: Text(content.text ?? ''),
//         );
//       case 'image':
//         return Image.network(content.storagePath ?? '', fit: BoxFit.cover);
//       case 'video':
//         return Column(
//           children: [
//             const Icon(Icons.videocam),
//             Text(content.storagePath ?? ''),
//           ],
//         );
//       default:
//         return const SizedBox.shrink();
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:lock_connect/core/constants/colors.dart';

class ContentOverlay extends StatelessWidget {
  final String title;
  final bool isLocked;

  const ContentOverlay({
    super.key,
    required this.title,
    required this.isLocked,
  });

  // --- Helper function to build a single Avatar (FULLY OPAQUE) ---
  Widget _buildAvatar(int index) {
    const List<Color> avatarColors = [
      Color(0xFFE57373),
      Color(0xFF64B5F6),
      Color(0xFFFFB74D)
    ];
    Color avatarColor = avatarColors[index % avatarColors.length];

    // --- CONDITIONAL BORDER COLOR FOR AVATARS ---
    final Color borderColor = isLocked ? Colors.white : Colors.black87;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Border color flips to black when unlocked
        border: Border.all(color: borderColor, width: 2),
      ),
      child: CircleAvatar(
        radius: 11,
        backgroundColor: avatarColor,
        child: const Text('C', style: TextStyle(fontSize: 10, color: Colors.white)),
      ),
    );
  }

  // --- HELPER FUNCTION: Builds the Correctly Stacked Avatar Stack ---
  Widget _buildAvatarStack() {
    const double avatarRadius = 12;
    const double overlapPixels = 8;
    const int maxVisible = 3;
    const int totalCollaborators = 5;
    final int visibleAvatars = totalCollaborators > maxVisible ? maxVisible : totalCollaborators;
    final int remaining = totalCollaborators - maxVisible;

    // --- CONDITIONAL COUNTER BACKGROUND COLOR ---
    final Color counterBackgroundColor = isLocked ? kInactiveColor : Colors.black;
    final Color counterBorderColor = isLocked ? Colors.white : Colors.black;

    List<Widget> avatarLayers = [];

    // Avatars are positioned from LEFT to RIGHT (i=0, 1, 2)
    for (int i = 0; i < visibleAvatars; i++) {
      avatarLayers.add(
          Positioned(
            left: i * (2 * avatarRadius - overlapPixels),
            child: _buildAvatar(i),
          )
      );
    }

    // Add the "+X" counter circle at the end of the stack
    if (remaining > 0) {
      avatarLayers.add(
        Positioned(
          left: visibleAvatars * (2 * avatarRadius - overlapPixels),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: counterBorderColor, width: 2), // <-- APPLIED CONDITIONAL COLOR
              color: counterBackgroundColor, // <-- APPLIED CONDITIONAL COLOR
            ),
            child: CircleAvatar(
              radius: 10,
              backgroundColor: counterBackgroundColor, // <-- APPLIED CONDITIONAL COLOR
              child: Text(
                  '+${remaining}',
                  // Text inside counter should always be white/light for contrast against black/dark gray
                  style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ),
      );
    }

    // Calculate the width the Stack needs
    double stackWidth = (visibleAvatars * 2 * avatarRadius) - ((visibleAvatars - 1) * overlapPixels) + (remaining > 0 ? (2 * avatarRadius - overlapPixels) : 0);

    return SizedBox(
      width: stackWidth,
      height: 26,
      child: Stack(
        children: avatarLayers,
      ),
    );
  }

  // --- Reworked Inner Content ---
  Widget _buildInnerContent(BuildContext context) {
    // --- CRITICAL CHANGE: Foreground Color Logic ---
    final Color foregroundColor = isLocked ? Colors.white : Colors.black;
    // ---------------------------------

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. TITLE (PERFECTLY CENTERED VERTICALLY)
          Expanded(
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  // COLOR CHANGE APPLIED HERE
                  color: foregroundColor.withOpacity(0.9), // <-- Uses conditional color
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  // fontFamily: 'Roboto', // Ensure consistent font
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          // 2. COLLABORATORS LIST
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // COLLABORATORS TEXT COLOR CHANGE APPLIED HERE
              Text(
                  'Collaborators:',
                  style: TextStyle(
                    color: foregroundColor, // <-- Uses conditional color
                    fontSize: 13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  )
              ),
              const SizedBox(width: 5), // Small space between text and first avatar

              // THE STACK OF OVERLAPPING AVATARS (Uses conditional colors via helpers)
              _buildAvatarStack(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double blurIntensity = isLocked ? 5.0 : 0.0;
    // Darker surface color for locked cards, very light for unlocked cards
    Color surfaceColor = isLocked ? Colors.white.withOpacity(0.25) : Colors.black.withOpacity(0.17);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        color: surfaceColor,
        // Only show blur if locked (intensity > 0)
        child: isLocked && blurIntensity > 0
            ? Stack(
          children: [
            _buildInnerContent(context),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurIntensity, sigmaY: blurIntensity),
                child: Container(
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
          ],
        )
            : _buildInnerContent(context),
      ),
    );
  }
}