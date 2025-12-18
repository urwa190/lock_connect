import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../theme/AppColors.dart';

class PreviewScreen extends StatefulWidget {
  final File file;
  final bool isVideo;

  const PreviewScreen({Key? key, required this.file, required this.isVideo}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _controller = VideoPlayerController.file(widget.file)
        ..initialize().then((_) {
          setState(() {});
          _controller?.play();
          _controller?.setLooping(true);
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Preview", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true), // Returns "true" to post
            child: const Text("POST", style: TextStyle(color: AppColors.goldText, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
        ],
      ),
      body: Center(
        child: widget.isVideo
            ? (_controller != null && _controller!.value.isInitialized
            ? AspectRatio(aspectRatio: _controller!.value.aspectRatio, child: VideoPlayer(_controller!))
            : const CircularProgressIndicator())
            : Image.file(widget.file),
      ),
    );
  }
}