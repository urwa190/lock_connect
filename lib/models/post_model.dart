import 'dart:core';

// this is a blueprint for a single post. kinda like the backend for the post. includes
//what attributes a post will be recorded. mock data hs been added for now. It is NOT a WIDGET

class PostModel {
  final String id;               //for future database purposes
  final String authorName;
  final String authorAvatarUrl;  //user's profile pic url
  final String caption;
  final String mediaUrl;          //URL for photo/video, empty string for a thread
  final DateTime timestamp;
  final bool isThread;//true if a post is a thread(long-text form)
  final String? videoPath; // local asset path
  final bool isVideo;
//constructor
PostModel ({
  required this.id ,//achieves this.id = id
  required this.authorName ,
  required this.authorAvatarUrl ,
  required this.caption ,
  required this.mediaUrl,
  required this.timestamp,
  required this.isThread,
  required this.videoPath,
  required this.isVideo,
 });
}
//---List of posts to test UI---
//---outside of class to make it available for the entire app---
//---List used because listview works with ordered list---
final List<PostModel> mockPosts = [
  PostModel (
    id: '1' ,
    authorName: 'Jenna J' ,
    authorAvatarUrl: 'https://picsum.photos/seed/100/100/100' ,
    caption: 'Great trip to the coast last weekend! Feeling refreshed!' ,
    mediaUrl: 'assets/images/beach.jpg' ,
    timestamp: DateTime.now().subtract(const Duration(hours : 4)),
    isThread: false,
    isVideo: false,
    videoPath: '',
  ),
  PostModel (
      id : '2' ,
      authorName : 'Alex Blanco' ,
      authorAvatarUrl : 'https://picsum.photos/seed/101/100/100' ,
      caption : 'The complete history of why I started collecting vinyl records.\np.s: This took me ages to write!' ,
      mediaUrl : '' ,
      timestamp: DateTime.now().subtract(const Duration(days : 7)),
      isThread : true,
    isVideo: false,
    videoPath: '',
  ),
  PostModel (
      id : '3' ,
      authorName : 'Yousuf Saif'  ,
      authorAvatarUrl : 'https://picsum.photos/seed/102/100/100' ,
      caption : 'My son\'s first goal! Had to share this moment.' ,
      mediaUrl : 'assets/images/cycling.jpg' ,
      timestamp: DateTime.now().subtract(const Duration(days : 8)) ,
      isThread : false,
    isVideo: false,
    videoPath: '',
  ),
  PostModel (
      id : '4' ,
      authorName : 'Nadia Ghafoor' ,
      authorAvatarUrl : 'https://picsum.photos/seed/103/100/100' ,
      caption : 'First time trying this recipe! The result was surprisingly good' ,
      mediaUrl : 'assets/images/recepie.jpg' ,
      timestamp: DateTime.now().subtract(const Duration(minutes : 15)) ,
      isThread : false,
    isVideo: false,
    videoPath: '',
  ),
  PostModel (
      id : '5' ,
      authorName : 'itzzzzZAINABhere' ,
    authorAvatarUrl : 'https://picsum.photos/seed/110/100/100',
      caption : 'A deep dive into my recent productivity challenge. My biggest realization this year has been the power of 15-minute bursts' ,
      mediaUrl : '' ,
      timestamp: DateTime.now().subtract(const Duration(minutes : 37)) ,
      isThread : true,
    isVideo: false,
    videoPath: '',
  ),
  PostModel (
      id : '6' ,
      authorName : '@Amal Maqsood' ,
      authorAvatarUrl : 'https://picsum.photos/seed/105/100/100' ,
      caption : 'Found this old video of us in college. What a throwback!' ,
      mediaUrl : 'https://placehold.co/600x400/40E0D0/000000?text=COLLEGE+VIDEO' ,
      timestamp: DateTime.now().subtract(const Duration(minutes : 66)),
      isThread : false,
      videoPath:'assets/videos/highschool.mp4',
      isVideo: true,
  ),
  PostModel (
      id : '7' ,
      authorName : 'Hamna_K' ,
      authorAvatarUrl : 'https://picsum.photos/seed/106/100/100' ,
      caption : 'Quick snap of the morning mist over the lake. Peaceful start to the day.' ,
      mediaUrl : 'assets/images/lake.jpg' ,
      timestamp: DateTime.now().subtract(const Duration(seconds : 15))  ,
      isThread : false,
    isVideo: false,
    videoPath: '',
  ),
  PostModel (
      id : '8' ,
      authorName : 'Rumi\'s Spot'  ,
      authorAvatarUrl : 'https://picsum.photos/seed/107/100/100' ,
      caption : 'A comprehensive long read on modern architecture trends and their impact on city planning. Read and let me know your thoughts!' ,
      mediaUrl : '' ,
      timestamp: DateTime.now().subtract(const Duration(milliseconds : 90)) ,
      isThread : true,
    isVideo: false,
    videoPath: '',
  ),
  PostModel (
      id : '9' ,
      authorName : 'Sunny\'s Side' ,
      authorAvatarUrl : 'https://picsum.photos/seed/108/100/100' ,
      caption : 'Some deep thoughts on life and philosophy. Is consciousness merely an emergent property, or something more?' ,
      mediaUrl : '' ,
      timestamp: DateTime.now().subtract(const Duration(hours : 45))  ,
      isThread : true,
    isVideo: false,
    videoPath: '',
  ),
  PostModel (
      id : '10' ,
      authorName : 'Gabriel Kim' ,
      authorAvatarUrl : 'https://picsum.photos/seed/109/100/100' ,
      caption : 'Almost ready for the weekend trip! Just finishing up the packing list now.' ,
      mediaUrl : 'assets/images/trip.jpg' ,
      timestamp: DateTime.now().subtract(const Duration(minutes : 25))  ,
      isThread : false,
    isVideo: false,
    videoPath: '',

  )
];