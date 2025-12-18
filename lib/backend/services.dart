import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class BackendService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //-------------------Upload to Cloudinary
  Future<String?> uploadToCloudinary(File file) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/YOUR_CLOUD_NAME/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'YOUR_PRESET_NAME'
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final data = jsonDecode(await response.stream.bytesToString());
      return data['secure_url']; // link we save to Firestore
    }
    return null;
  }

  //----------------- Save metadata to Firestore
  Future<void> savePost({required String caption, String? mediaUrl, required bool isThread}) async {
    await _db.collection('posts').add({
      'caption': caption,
      'mediaUrl': mediaUrl ?? '',
      'isThread': isThread,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}