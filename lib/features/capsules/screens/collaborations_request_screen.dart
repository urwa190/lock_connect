import 'package:flutter/material.dart';
import 'package:lock_connect/core/constants/app_colors.dart';
import 'package:lock_connect/core/constants/colors.dart';

class CollaborationRequestsScreen extends StatefulWidget {
  const CollaborationRequestsScreen({super.key});

  @override
  State<CollaborationRequestsScreen> createState() => _CollaborationRequestsScreenState();
}

class _CollaborationRequestsScreenState extends State<CollaborationRequestsScreen> {
  // Mock data for collaboration requests
  final List<Map<String, dynamic>> _requests = [
    {'name': 'Alice Johnson', 'capsule': 'Holiday Party Photos', 'type': 'Pending'},
    {'name': 'Mark Chen', 'capsule': 'Summer Trip Memories \'24', 'type': 'Pending'},
    {'name': 'Sarah Lee', 'capsule': 'Project Launch Notes', 'type': 'Accepted'},
    {'name': 'David Kim', 'capsule': 'Family Vacation 2023', 'type': 'Rejected'},
    {'name': 'Ethan Foster', 'capsule': 'Graduation Day Archive', 'type': 'Pending'},
  ];

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.sunsetPurple,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // --- NEW: Function to handle Accept/Reject logic ---
  void _handleRequestAction(String name, String action) {
    // In a real app, this would update the backend/state
    setState(() {
      // Find and update the request status for UI change
      int index = _requests.indexWhere((req) => req['name'] == name);
      if (index != -1) {
        _requests[index]['type'] = action;
      }
    });

    _showSnackBar('Request from $name was ${action.toLowerCase()}!');
  }


  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.goldText),
          title: Text(
            'Requests',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'PlayfairDisplay',
              color: AppColors.goldText,
              fontSize: 22,
              letterSpacing: 1,
            ),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _requests.length,
          itemBuilder: (context, index) {
            final request = _requests[index];
            return _buildRequestCard(request);
          },
        ),
      ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    final bool isPending = request['type'] == 'Pending';
    final Color statusColor = isPending ? AppColors.sunsetOrange : (request['type'] == 'Accepted' ? Colors.green : Colors.red);
    final String initial = request['name'][0].toUpperCase();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- PROFILE AVATAR ---
          CircleAvatar(
            radius: 20,
            backgroundColor: statusColor, // Color based on status
            child: Text(
              initial,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sender Name
                Text(
                  request['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 4),
                // Capsule Name
                Text(
                  'wants to share: ${request['capsule']}',
                  style: TextStyle(
                    color: AppColors.textHint,
                    fontSize: 13,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),

          // --- ACTION/STATUS AREA ---
          if (isPending)
          // 3-DOT MENU FOR ACCEPT/REJECT
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'Accept') {
                  _handleRequestAction(request['name'], 'Accepted');
                } else if (result == 'Reject') {
                  _handleRequestAction(request['name'], 'Rejected');
                }
              },
              color: Colors.black, // Dark background for menu items
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                // Accept Option
                PopupMenuItem<String>(
                  value: 'Accept',
                  child: Text('Accept', style: TextStyle(color: Colors.green, fontFamily: 'Roboto')),
                ),
                // Reject Option
                PopupMenuItem<String>(
                  value: 'Reject',
                  child: Text('Reject', style: TextStyle(color: Colors.red, fontFamily: 'Roboto')),
                ),
              ],
              icon: const Icon(Icons.more_vert, color: AppColors.textHint),
            )
          else
          // Status Tag for Accepted/Rejected
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                request['type'],
                style: const TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Roboto'),
              ),
            ),
        ],
      ),
    );
  }
}