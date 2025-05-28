import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/download_section.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/mark_as_watched_switch.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/video_info_message.dart';

class VideoPlayerScreen extends StatefulWidget {
  static const String routeName = '/video';

  const VideoPlayerScreen({super.key, required this.video});
  final Video? video;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late BetterPlayerController _betterPlayerController;
  bool _isVideoCompleted = false;
  bool _isVideoWatched = false;

  @override
  void initState() {
    super.initState();
    disableScreenshot();
    initializePlayer();
  }

  void initializePlayer() {
    String url =
        "https://vz-1d08d856-dd0.b-cdn.net/473a209d-3f0c-4437-8a47-2eb73473fd6f/playlist.m3u8";

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
      useAsmsSubtitles: true,
      useAsmsAudioTracks: true,
    );

    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        looping: false,
        allowedScreenSleep: false,
        aspectRatio: 16 / 9,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          enableQualities: true,
          enableOverflowMenu: true,
        ),
        eventListener: (event) {
          if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
            setState(() {
              _isVideoCompleted = true;
              _isVideoWatched = true;
            });
          }
        },
      ),
      betterPlayerDataSource: dataSource,
    );
  }

  @override
  void dispose() {
    enableScreenshot();
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColors, AppColors.secColors],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          widget.video?.name ?? "video",
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: "cocon-next-arabic",
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: BetterPlayer(controller: _betterPlayerController),
              ),
              const Divider(color: AppColors.primaryColors),
              VideoInfoMessage(show: !_isVideoCompleted),
              MarkAsWatchedSwitch(
                isVideoWatched: _isVideoWatched,
                isVideoCompleted: _isVideoCompleted,
                onToggle: (value) {
                  setState(() {
                    _isVideoWatched = value;
                  });
                },
              ),
              DownloadSection(video: widget.video),
            ],
          ),
        ),
      ),
    );
  }
}
