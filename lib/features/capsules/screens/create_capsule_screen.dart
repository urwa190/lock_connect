// // lib/features/capsules/screens/create_capsule_screen.dart
//
// import 'package:flutter/material.dart';
// // FIX: Import the colors file to resolve "Undefined name" errors
// import 'package:lock_connect/core/constants/colors.dart';
//
// class CreateCapsuleScreen extends StatelessWidget {
//   const CreateCapsuleScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create New Capsule'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildTitleSection(context),
//             const SizedBox(height: 16),
//             _buildCollaboratorsSection(context),
//             const SizedBox(height: 16),
//             _buildUnlockDateSection(context),
//             const SizedBox(height: 16),
//             _buildContentSection(context),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildNextStepButton(context),
//     );
//   }
//
//   // Helper for creating the structured dark card container
//   Widget _buildCardContainer({required Widget child, EdgeInsets? padding}) {
//     return Container(
//       width: double.infinity,
//       padding: padding ?? const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: kCardColor, // Uses kCardColor (now white/light)
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       child: child,
//     );
//   }
//
//   // --- All helper methods are included below for completeness ---
//
//   // --- 1. Title Section ---
//   Widget _buildTitleSection(BuildContext context) {
//     return _buildCardContainer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Title',
//                 style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kDarkTextColor),
//               ),
//               const Icon(Icons.lock_rounded, size: 20, color: kInactiveColor),
//             ],
//           ),
//           const SizedBox(height: 8),
//           // Placeholder for the input field
//           Text('Trip to Kyoto Memories', style: TextStyle(fontSize: 18, color: kDarkTextColor, fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }
//
//   // --- 2. Collaborators Section ---
//   Widget _buildCollaboratorsSection(BuildContext context) {
//     return _buildCardContainer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Collaborators',
//             style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kDarkTextColor),
//           ),
//           const SizedBox(height: 12),
//           // Placeholder Row for collaborator profile pictures
//           Row(
//             children: [
//               const CircleAvatar(radius: 18, backgroundColor: kInactiveColor),
//               const SizedBox(width: 8),
//               const CircleAvatar(radius: 18, backgroundColor: kInactiveColor),
//               const SizedBox(width: 8),
//               const CircleAvatar(radius: 18, backgroundColor: kInactiveColor),
//               const SizedBox(width: 8),
//               CircleAvatar(radius: 18, backgroundColor: kInactiveColor, child: Text('+3', style: TextStyle(color: kDarkTextColor))),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // --- 3. Unlock Date Section ---
//   Widget _buildUnlockDateSection(BuildContext context) {
//     return _buildCardContainer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Unlock Date',
//             style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kDarkTextColor),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Button to navigate to Collaborators Screen (Screen 15)
//               TextButton.icon(
//                 onPressed: () { /* TODO: Navigation to Add Collaborators Screen (15) */ },
//                 icon: const Icon(Icons.person_add, color: kPrimaryAccentColor),
//                 label: const Text('Add People', style: TextStyle(color: kPrimaryAccentColor)),
//                 style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.centerLeft),
//               ),
//               // Calendar Icon
//               const Icon(Icons.calendar_month, color: kInactiveColor),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // --- 4. Add Content Section ---
//   Widget _buildContentSection(BuildContext context) {
//     return _buildCardContainer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Add Content',
//             style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kDarkTextColor),
//           ),
//           const SizedBox(height: 12),
//
//           // Photos/Videos Button
//           _buildContentButton(context, icon: Icons.photo_camera_rounded, label: 'Photos/Videos'),
//           const SizedBox(height: 8),
//
//           // Voice Clips Button
//           _buildContentButton(context, icon: Icons.mic_none_rounded, label: 'Voice Clips'),
//           const SizedBox(height: 16),
//
//           // Placeholder for media previews
//           Row(
//             children: [
//               _buildMediaPreview(),
//               const SizedBox(width: 8),
//               _buildMediaPreview(),
//               const SizedBox(width: 8),
//               _buildMediaPreview(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Helper for the small media preview boxes
//   Widget _buildMediaPreview() {
//     return Container(
//       height: 60,
//       width: 60,
//       decoration: BoxDecoration(color: kInactiveColor.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
//     );
//   }
//
//   // Helper for the content buttons (Photos/Videos, Voice Clips)
//   Widget _buildContentButton(BuildContext context, {required IconData icon, required String label}) {
//     return Row(
//       children: [
//         Icon(icon, color: kInactiveColor),
//         const SizedBox(width: 8),
//         Text(
//           label,
//           style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kDarkTextColor),
//         ),
//       ],
//     );
//   }
//
//   // --- Bottom Button: Next Step (Gradient Look) ---
//   Widget _buildNextStepButton(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       // FIX: The context is no longer required to be const here
//       decoration: BoxDecoration(
//         color: kLightBackgroundColor, // Use light background for the button area
//       ),
//       child: Container(
//         height: 50,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           gradient: const LinearGradient(
//             colors: [Color(0xFFF3C759), Color(0xFFD4A73D)], // Gold/Yellow Tones
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//         ),
//         child: ElevatedButton(
//           onPressed: () { /* TODO: Proceed to the next step of capsule creation */ },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.transparent, // Transparent background for gradient show-through
//             shadowColor: Colors.transparent,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           ),
//           child: const Text(
//             'Next Step',
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/features/capsules/screens/create_capsule_screen.dart

import 'package:flutter/material.dart';
import 'package:lock_connect/core/constants/colors.dart';
import 'add_collaborators_screen.dart'; // Import Screen 15

// --- DARK MODE OVERRIDES ---
const Color kAppBackground = Color(0xFF121212);
const Color kAppBarForeground = Colors.white;
const Color kDarkCardBackground = Color(0xFF1E1E1E);

class CreateCapsuleScreen extends StatelessWidget {
  const CreateCapsuleScreen({super.key});

  // Helper for structured, dark card container used for form sections
  Widget _buildCardContainer({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kDarkCardBackground,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: child,
    );
  }

  // Helper for the gold gradient button at the bottom
  Widget _buildNextStepButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(color: kAppBackground),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFFF3C759), Color(0xFFD4A73D)], // Gold/Yellow Tones
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ElevatedButton(
          onPressed: () { /* TODO: Finalize capsule creation */ },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: const Text(
            'CREATE CAPSULE',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackground,
      appBar: AppBar(
        backgroundColor: kAppBackground,
        foregroundColor: kAppBarForeground,
        title: const Text('Create New Capsule'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. TITLE SECTION (TextField) ---
            _buildCardContainer(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Capsule Title',
                  labelStyle: TextStyle(color: Colors.white70),
                  hintText: 'e.g., Trip to Kyoto Memories',
                  hintStyle: TextStyle(color: kInactiveColor.withOpacity(0.5)),
                  border: InputBorder.none, // Clean look
                  suffixIcon: const Icon(Icons.lock_rounded, size: 20, color: Colors.white70),
                ),
                style: const TextStyle(color: kAppBarForeground, fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 16),

            // --- 2. COLLABORATORS SECTION (Navigation to Screen 15) ---
            _buildCardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add Collaborators', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Placeholder Row for profile pictures
                      Row(
                        children: [
                          ...List.generate(3, (index) =>
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(radius: 18, backgroundColor: Colors.white54),
                          )),
                          if (4 > 3) const Text('+1 more', style: TextStyle(color: Colors.white70)),
                        ],
                      ),

                      // Button to navigate to Screen 15
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: kPrimaryAccentColor, size: 16),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCollaboratorsScreen()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- 3. UNLOCK DATE SECTION (Date Picker Placeholder) ---
            _buildCardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Set Unlock Time', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 8),

                  TextButton.icon(
                    onPressed: () { /* TODO: Show Date/Time Picker */ },
                    icon: const Icon(Icons.calendar_month, color: kPrimaryAccentColor),
                    label: const Text('Select Date and Time', style: TextStyle(color: kPrimaryAccentColor, fontSize: 18)),
                    style: TextButton.styleFrom(alignment: Alignment.centerLeft, padding: EdgeInsets.zero),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- 4. ADD MEDIA/NOTES SECTION ---
            _buildCardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Media & Note', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 12),

                  // Text Note Input
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Add a tiny note (max 150 words) to the capsule...',
                      hintStyle: TextStyle(color: kInactiveColor.withOpacity(0.5)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color(0xFF303030), // Slightly lighter background for the input field
                    ),
                    style: const TextStyle(color: kAppBarForeground),
                  ),
                  const SizedBox(height: 12),

                  // Media Buttons
                  Row(
                    children: [
                      _buildMediaButton(Icons.photo, 'Photos'),
                      const SizedBox(width: 10),
                      _buildMediaButton(Icons.videocam, 'Videos'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: _buildNextStepButton(context),
    );
  }

  Widget _buildMediaButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF303030),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: kPrimaryAccentColor, size: 20),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: kPrimaryAccentColor)),
        ],
      ),
    );
  }
}