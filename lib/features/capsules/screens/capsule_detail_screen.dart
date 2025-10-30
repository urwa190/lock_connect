import 'package:flutter/material.dart';
import 'package:lock_connect/core/constants/colors.dart';
import 'package:lock_connect/core/constants/app_colors.dart'; // Import AppColors for gradient/gold

// --- DARK MODE OVERRIDES (Ensure consistency) ---
const Color kAppBackground = Color(0xFF121212);
const Color kAppBarForeground = Colors.white;
const Color kDarkCardBackground = Color(0xFF1E1E1E);

class CapsuleDetailScreen extends StatelessWidget {
  final bool isLocked;
  final String capsuleTitle;
  final String creationDate;
  final String unlocksIn;
  final List<String> mockMediaUrls;
  final String mockNotes;

  const CapsuleDetailScreen({
    super.key,
    this.isLocked = false,
    required this.capsuleTitle,
    required this.creationDate,
    required this.unlocksIn,
    // Increased mock media for better scroll view demonstration
    this.mockMediaUrls = const ['p1', 'p2', 'p3', 'p4', 'p5'],
    // Simulated 150-word note
    this.mockNotes = 'This capsule was opened to reveal memories from our incredible trip! We included five photos and a short video summarizing the best moments. This note serves as the official caption, documenting our thoughts and feelings upon seeing this content again after so long. It\'s truly amazing how quickly time passes, but these digitized moments keep the past vibrant and close. We hope future versions of ourselves continue to add to this archive of friendship and shared experiences!',
  });

  // Helper to build a clean card container
  Widget _buildInfoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kDarkCardBackground.withOpacity(0.60), // Use opacity for cards
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  // Helper to build a media placeholder item
  Widget _buildMediaItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isVideo = index % 2 == 0;

    return Container(
      width: screenWidth, // FULL WIDTH for Instagram post style
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Color(0xFF303030),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FONT: Roboto
            Icon(isVideo ? Icons.videocam : Icons.photo, size: 80, color: kInactiveColor),
            Text(isVideo ? 'Video Clip' : 'High-Res Photo', style: const TextStyle(color: kInactiveColor, fontSize: 16, fontFamily: 'Roboto')),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // --- WRAP THE ENTIRE SCREEN IN THE GRADIENT CONTAINER ---
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.sunsetBlue,
            AppColors.sunsetPurple,
            AppColors.sunsetPink,
            AppColors.sunsetOrange,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Scaffold transparent
        appBar: AppBar(
          backgroundColor: Colors.transparent, // AppBar transparent
          foregroundColor: kAppBarForeground,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.goldText),

          title: Text(
            capsuleTitle,
            // --- APPLIED CAPSULE HOME SCREEN TITLE STYLING ---
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'PlayfairDisplay',
              color: AppColors.goldText, // Gold for branding
              letterSpacing: 1,
              fontSize: 20, // Matches Capsule Home Screen

            ),
          ),

          // actions: [
          //   IconButton(icon: const Icon(Icons.share_outlined, color: kAppBarForeground), onPressed: () {}),
          // ],
        ),
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent, // AppBar transparent
        //   foregroundColor: kAppBarForeground,
        //   elevation: 0,
        //   title: Text(
        //     capsuleTitle,
        //     // --- APPLIED CAPSULE HOME SCREEN TITLE STYLING ---
        //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
        //       fontWeight: FontWeight.bold,
        //       fontFamily: 'PlayfairDisplay',
        //       color: AppColors.goldText, // Gold for branding
        //       letterSpacing: 1,
        //       fontSize: 24,
        //     ),
        //     // --- MODIFIED LINES FOR WRAPPING ---
        //     maxLines: 2,
        //     overflow: TextOverflow.ellipsis,
        //   ),
        //   actions: [
        //     IconButton(icon: const Icon(Icons.share_outlined, color: kAppBarForeground), onPressed: () {}),
        //   ],
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. HORIZONTAL MEDIA GALLERY (Instagram-style scroll) ---
            SizedBox(
              height: 350, // Large, fixed height for media viewing
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mockMediaUrls.length,
                itemBuilder: (context, index) => _buildMediaItem(context, index), // Call helper
              ),
            ),

            // --- 2. Scrollable Detail Content ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Info & Dates ---
                    _buildInfoCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text('Created On', style: TextStyle(color: Colors.white70, fontSize: 13, fontFamily: 'Roboto')), // FONT: Roboto
                            Text(creationDate, style: const TextStyle(color: kAppBarForeground, fontWeight: FontWeight.bold, fontFamily: 'Roboto')), // FONT: Roboto
                          ]),
                          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            const Text('Unlocked On', style: TextStyle(color: Colors.white70, fontSize: 13, fontFamily: 'Roboto')), // FONT: Roboto
                            Text(unlocksIn, style: const TextStyle(color: kPrimaryAccentColor, fontWeight: FontWeight.bold, fontFamily: 'Roboto')), // FONT: Roboto
                          ]),
                        ],
                      ),
                    ),

                    // --- Display Tiny NOTES (The caption) ---
                    Text(
                        'Note:',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: kAppBarForeground,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto' // FONT: Roboto
                        )
                    ),
                    _buildInfoCard(
                      child: Text(mockNotes, style: const TextStyle(color: kAppBarForeground, height: 1.5, fontFamily: 'Roboto')), // FONT: Roboto
                    ),
                    const SizedBox(height: 10),

                    // --- Collaborators Section ---
                    Text(
                        'Collaborators:',
                        // style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        //     color: kAppBarForeground,
                        //     fontWeight: FontWeight.bold,
                        //     fontFamily: 'Roboto' // FONT: Roboto
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PlayfairDisplay',
                          color: AppColors.goldText, // Gold for branding
                          letterSpacing: 1,
                          fontSize: 18,
                        )
                    ),
                    const SizedBox(height: 10),
                    _buildMockCollaboratorList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build a mock collaborator list
  Widget _buildMockCollaboratorList() {
    return Column(
      children: [
        _buildAvatarStackItem('Alex Johnson'),
        _buildAvatarStackItem('Sarah Lee'),
        _buildAvatarStackItem('Mike Chen'),
      ],
    );
  }

  // Simple avatar placeholder
  Widget _buildAvatarStackItem(String name) {
    return _buildInfoCard(
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: kPrimaryAccentColor,
              radius: 18,
              child: Text(name[0], style: const TextStyle(color: Colors.black, fontFamily: 'Roboto')), // FONT: Roboto
            ),
            const SizedBox(width: 10),
            Text(name, style: const TextStyle(color: kAppBarForeground, fontSize: 16, fontFamily: 'Roboto')), // FONT: Roboto
          ],
        )
    );
  }
}