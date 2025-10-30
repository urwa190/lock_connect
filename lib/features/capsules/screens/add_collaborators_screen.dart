

import 'package:flutter/material.dart';
// NOTE: Using the direct paths we established in the previous conversation
import 'package:lock_connect/core/constants/app_colors.dart';
import 'package:lock_connect/core/constants/colors.dart';


class AddCollaboratorsScreen extends StatefulWidget {
  const AddCollaboratorsScreen({super.key});

  @override
  State<AddCollaboratorsScreen> createState() => _AddCollaboratorsScreenState();
}

class _AddCollaboratorsScreenState extends State<AddCollaboratorsScreen> {
  // Mock data for search results
  final List<Map<String, dynamic>> mockUsers = [
    {'name': 'Alex Johnson', 'status': 'Friend'},
    {'name': 'Sarah Lee', 'status': 'Friend'},
    {'name': 'Mike Chen', 'status': 'Invite Sent'},
    {'name': 'Jessica Smith', 'status': 'Not Friend'},
    {'name': 'Tom Wilson', 'status': 'Friend'},
    {'name': 'Olivia Brown', 'status': 'Not Friend'},
    {'name': 'Daniel Kim', 'status': 'Friend'},
  ];

  // List to track which users are selected for the capsule
  final List<String> _selectedCollaborators = [];
  String _searchQuery = '';

  void _toggleCollaborator(String name) {
    setState(() {
      if (_selectedCollaborators.contains(name)) {
        _selectedCollaborators.remove(name);
      } else {
        _selectedCollaborators.add(name);
      }
    });
  }

  // Helper to build the action icon based on selection status
  Widget _buildActionButton(String name) {
    final isSelected = _selectedCollaborators.contains(name);

    if (isSelected) {
      // User is selected: Show Checkmark (Sunset Orange)
      return const Icon(Icons.check_circle, color: AppColors.sunsetOrange, size: 28);
    } else {
      // User is not selected: Show Add Icon (Gold)
      return const Icon(Icons.person_add_alt_1_rounded, color: AppColors.goldText, size: 28);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = mockUsers.where((user) {
      final nameLower = user['name'].toLowerCase();
      final queryLower = _searchQuery.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    return Container(
      // --- Seamless Gradient Background ---
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.goldText),
          title: Text(
            'Add Collaborators',
            // --- Matching Create Capsule Title Style ---
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.bold,
              color: AppColors.goldText,
              fontSize: 20,
              letterSpacing: 1,
            ),
          ),
          actions: [
            // Display selected count
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  '${_selectedCollaborators.length} Selected',
                  style: const TextStyle(color: AppColors.goldText, fontSize: 16, fontFamily: 'Roboto'),
                ),
              ),
            ),
          ],
        ),

        body: Column(
          children: [
            // --- 1. SEARCH BAR ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: const TextStyle(color: Colors.white, fontFamily: 'Roboto'),
                decoration: InputDecoration(
                  hintText: 'Search to add collaborators...',
                  hintStyle: TextStyle(color: AppColors.textHint.withOpacity(0.5), fontFamily: 'Roboto'),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(icon: const Icon(Icons.clear, color: AppColors.textHint), onPressed: () => setState(() => _searchQuery = ''),)
                      : null,
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // --- 2. COLLABORATOR LIST ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  final isSelected = _selectedCollaborators.contains(user['name']);

                  return GestureDetector(
                    onTap: () => _toggleCollaborator(user['name']),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      decoration: BoxDecoration(
                        // Highlight selected user with semi-transparent orange background
                        color: isSelected ? AppColors.sunsetOrange.withOpacity(0.2) : Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          // Border highlights selected item
                            color: isSelected ? AppColors.sunsetOrange : Colors.white24
                        ),
                      ),
                      child: Row(
                        children: [
                          // Profile Picture
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.sunsetPurple,
                            child: Text(user['name'][0], style: const TextStyle(color: Colors.white, fontFamily: 'Roboto')),
                          ),
                          const SizedBox(width: 12),

                          // Name and Status
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user['name'],
                                  style: TextStyle(
                                    // Name color is orange when selected, otherwise white
                                    color: isSelected ? AppColors.sunsetOrange : AppColors.textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                // Text(
                                //   user['status'],
                                //   style: TextStyle(
                                //     color: AppColors.textHint, // Status text remains subtle grey
                                //     fontSize: 13,
                                //     fontFamily: 'Roboto',
                                //   ),
                                // ),
                              ],
                            ),
                          ),

                          // Action Icon (Add/Check)
                          _buildActionButton(user['name']),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Passes the selected list of collaborator names back to CreateCapsuleScreen
            // (CreateCapsuleScreen will handle updating its UI with the result)
            Navigator.pop(context, _selectedCollaborators);
          },
          // --- APPLYING SEAL CAPSULE BUTTON STYLES ---

          // 1. Text Label (Ensures matching size/weight)
          label: Text(
            'Done (${_selectedCollaborators.length})',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18, // Matches the SEAL CAPSULE text size
              fontWeight: FontWeight.bold,
              fontFamily: 'PlayfairDisplay',
              // Added letter spacing for a branded look
              letterSpacing: 1.5,
            ),
          ),

          // 2. Icon and Background
          icon: const Icon(Icons.check, color: Colors.white),
          backgroundColor: AppColors.sunsetOrange,
          elevation: 8,

          // 3. Shape (Matches the rounded corners of the SEAL CAPSULE button)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}


