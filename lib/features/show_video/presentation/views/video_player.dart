// lib/features/courses/presentation/views/video_play_list/screens/video_player_screen.dart

import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/download_section.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/mark_as_watched_switch.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/video_info_message.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  static const String routeName = '/video';

  const VideoPlayerScreen({super.key, required this.video});
  final Video? video;

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  bool _isLoading = true;
  bool _isVideoCompleted = false;
  bool _isVideoWatched = false;

  @override
  void initState() {
    super.initState();

    disableScreenshot();

    if (widget.video?.video != null) {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.video!.video!));

      _controller.initialize().then((_) {
        setState(() {
          _isLoading = false;
        });

        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: false,
          showControls: true,
          allowFullScreen: true,
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );

        _controller.addListener(() {
          if (_controller.value.position >= _controller.value.duration) {
            setState(() {
              _isVideoCompleted = true;
              _isVideoWatched = true;
            });
          }
        });
      }).catchError((error) {
        debugPrint("Video initialization error: $error");
      });
    }
  }

  @override
  void dispose() {
    enableScreenshot();
    _chewieController?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Important!
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryColors,
                AppColors.secColors,
              ],
            ),
          ),
        ),
        title: Text(
          widget.video?.name ?? "Video",
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: "cocon-next-arabic",
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Video Player
            SizedBox(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Chewie(controller: _chewieController!),
                ),
              ),
            ),

            const Divider(color: AppColors.primaryColors),

            // Info Message
            VideoInfoMessage(show: !_isVideoCompleted),

            // Toggle Switch
            MarkAsWatchedSwitch(
              isVideoWatched: _isVideoWatched,
              isVideoCompleted: _isVideoCompleted,
              onToggle: (value) {
                setState(() {
                  _isVideoWatched = value;
                });
              },
            ),

            // Download Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DownloadSection(video: widget.video),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
