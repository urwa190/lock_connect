// // // import 'dart:io';
// // // import 'package:http/http.dart' as http;
// // //
// // // class CloudinaryUploader {
// // //   final String cloudName;
// // //   final String uploadPreset; // unsigned preset
// // //
// // //   CloudinaryUploader({
// // //     required this.cloudName,
// // //     required this.uploadPreset,
// // //   });
// // //
// // //   Future<String> uploadImage(File file) async {
// // //     final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
// // //     final req = http.MultipartRequest('POST', uri)
// // //       ..fields['upload_preset'] = uploadPreset
// // //       ..files.add(await http.MultipartFile.fromPath('file', file.path));
// // //     final res = await req.send();
// // //     final body = await res.stream.bytesToString();
// // //     if (res.statusCode != 200 && res.statusCode != 201) {
// // //       throw Exception('Cloudinary upload failed: ${res.statusCode} $body');
// // //     }
// // //     final url = RegExp(r'"secure_url":"([^"]+)"').firstMatch(body)?.group(1);
// // //     if (url == null) throw Exception('No secure_url in response');
// // //     return url.replaceAll(r'\/', '/');
// // //   }
// // // }
// //
// //
// // import 'dart:io';
// // import 'package:http/http.dart' as http;
// //
// // class CloudinaryUploader {
// //   final String cloudName;
// //   final String uploadPreset; // unsigned preset
// //
// //   CloudinaryUploader({
// //     required this.cloudName,
// //     required this.uploadPreset,
// //   });
// //
// //   Future<String> uploadImage(File file) async {
// //     final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
// //     final req = http.MultipartRequest('POST', uri)
// //       ..fields['upload_preset'] = uploadPreset
// //       ..files.add(await http.MultipartFile.fromPath('file', file.path));
// //     final res = await req.send();
// //     final body = await res.stream.bytesToString();
// //     if (res.statusCode != 200 && res.statusCode != 201) {
// //       throw Exception('Cloudinary upload failed: ${res.statusCode} $body');
// //     }
// //     final url = RegExp(r'"secure_url":"([^"]+)"').firstMatch(body)?.group(1);
// //     if (url == null) throw Exception('No secure_url in response');
// //     return url.replaceAll(r'\/', '/');
// //   }
// // }
//
//
//
// import 'dart:io';
// import 'package:http/http.dart' as http;
//
// class CloudinaryUploader {
//   final String cloudName;
//   final String uploadPreset; // unsigned preset
//
//   CloudinaryUploader({
//     required this.cloudName,
//     required this.uploadPreset,
//   });
//
//   Future<String> uploadImage(File file) async {
//     final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
//     final req = http.MultipartRequest('POST', uri)
//       ..fields['upload_preset'] = uploadPreset
//       ..files.add(await http.MultipartFile.fromPath('file', file.path));
//     final res = await req.send();
//     final body = await res.stream.bytesToString();
//     if (res.statusCode != 200 && res.statusCode != 201) {
//       throw Exception('Cloudinary upload failed: ${res.statusCode} $body');
//     }
//     final url = RegExp(r'"secure_url":"([^"]+)"').firstMatch(body)?.group(1);
//     if (url == null) throw Exception('No secure_url in response');
//     return url.replaceAll(r'\/', '/');
//   }
// }

import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CloudinaryUploader {
  final String cloudName;
  final String uploadPreset;

  CloudinaryUploader({required this.cloudName, required this.uploadPreset});

  Future<String> uploadImage(File file) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      return jsonDecode(responseData)['secure_url'];
    } else {
      throw Exception('Cloudinary upload failed');
    }
  }
}