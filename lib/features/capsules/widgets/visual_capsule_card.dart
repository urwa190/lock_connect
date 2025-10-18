// import 'package:flutter/material.dart';
// import 'dart:ui';
// import 'package:lock_connect/core/constants/colors.dart';
// import 'content_overlay.dart';
//
// class VisualCapsuleCard extends StatelessWidget {
//   final String title;
//   final Color baseColor;
//   final bool isLocked;
//   final String creationDate;
//
//   const VisualCapsuleCard({
//     super.key,
//     required this.title,
//     required this.baseColor,
//     required this.isLocked,
//     required this.creationDate,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Secondary color for the gradient effect
//     Color secondaryColor = isLocked ? baseColor.withOpacity(0.8) : baseColor.withOpacity(0.9);
//
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       height: 180, // Final height for better fit
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(18.0),
//         boxShadow: [
//           BoxShadow(
//             color: kDarkTextColor.withOpacity(0.15),
//             blurRadius: 15,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16.0),
//         child: Container(
//           // OUTER CARD: Gradient Background (Fully visible)
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [baseColor.withOpacity(0.9), secondaryColor],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Stack(
//             children: [
//               // 1. Structural Elements (Date and Lock Icon/Status)
//               Padding(
//                 padding: const EdgeInsets.all(14.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // TOP SECTION (Lock Icon & Status - Pushed Right)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox.shrink(), // Spacer for alignment
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Icon(isLocked ? Icons.lock_rounded : Icons.lock_open_rounded, size: 26, color: Colors.white),
//                             // const SizedBox(height: 5),
//                            // Text(isLocked ? 'Locked' : 'Unlocked', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12)),
//                           ],
//                         ),
//                       ],
//                     ),
//
//                     // Spacer for the inner card and bottom section
//                     const SizedBox.shrink(),
//                     // BOTTOM SECTION (Creation Date - Lower Left)
//                     Text('Created On: $creationDate', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//
//               // 2. INNER CARD (Content Overlay - Centered and Conditioned)
//               Center(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.75, // Responsive width
//                   height: 100, // Fixed height for the inner card
//                   child: ContentOverlay(
//                     title: title,
//                     isLocked: isLocked, // Pass the lock status to control its blur
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// lib/features/capsules/widgets/visual_capsule_card.dart

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:lock_connect/core/constants/colors.dart';
import 'content_overlay.dart'; // Import the inner card widget

class VisualCapsuleCard extends StatelessWidget {
  final String title;
  final Color baseColor;
  final bool isLocked;
  final String creationDate;
  final VoidCallback onTap; // NEW: The click handler property

  const VisualCapsuleCard({
    super.key,
    required this.title,
    required this.baseColor,
    required this.isLocked,
    required this.creationDate,
    required this.onTap, // NEW: Must be required in constructor
  });

  @override
  Widget build(BuildContext context) {
    // Secondary color for the gradient effect
    Color secondaryColor = isLocked ? baseColor.withOpacity(0.8) : baseColor.withOpacity(0.9);

    // Conditional blur intensity
    double blurIntensity = isLocked ? 10.0 : 3.0;

    // Wrap the entire card in a GestureDetector for clickability
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: 180, // Height maintained at 180
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
              color: kDarkTextColor.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            // OUTER CARD: Gradient Background (Fully visible)
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [baseColor.withOpacity(0.9), secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // 1. Structural Elements (Lock Icon/Status, Creation Date)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TOP SECTION (Lock Icon & Status - Pushed Right)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox.shrink(), // Spacer for alignment
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(isLocked ? Icons.lock_rounded : Icons.lock_open_rounded, size: 24, color: Colors.white),
                              // Text(isLocked ? 'LOCKED' : 'UNLOCKED', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),

                      // Spacer to push the inner card and bottom section
                      const SizedBox.shrink(),

                      // BOTTOM SECTION (Creation Date - Lower Left)
                      Text('Created On: $creationDate', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                // 2. INNER CARD (Content Overlay - Centered and Conditioned)
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75, // Responsive width
                    height: 100, // Fixed height for the inner card
                    child: ContentOverlay(
                      title: title,
                      isLocked: isLocked, // Pass the lock status to control its blur
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}