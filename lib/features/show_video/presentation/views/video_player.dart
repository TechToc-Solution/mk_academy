import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/file_download_tile.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/quality_tile.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/mark_as_watched_switch.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/video_info_message.dart';

class VideoPlayerScreen extends StatefulWidget {
  static const String routeName = '/video';
  final Video? video;

  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late BetterPlayerController _betterPlayerController;

  bool _isVideoCompleted = false;
  bool _isVideoWatched = false;

  /// If true, we switch the data source to a local file.
  bool _isOffline = false;

  /// Local file path for the quality that was tapped “Play”
  String? _localVideoPath;

  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    disableScreenshot();
    _initializePlayer();
  }

  void _initializePlayer() {
    final source = BetterPlayerDataSource(
      _isOffline
          ? BetterPlayerDataSourceType.file
          : BetterPlayerDataSourceType.network,
      _isOffline ? _localVideoPath! : widget.video!.video!,
      useAsmsSubtitles: !_isOffline,
      useAsmsAudioTracks: !_isOffline,
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
        errorBuilder: (context, errorMessage) =>
            _buildErrorWidget(context, errorMessage),
        eventListener: _handlePlayerEvents,
      ),
      betterPlayerDataSource: source,
    );

    setState(() => _isPlayerReady = true);
  }

  void _handlePlayerEvents(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
      setState(() {
        _isVideoCompleted = true;
        _isVideoWatched = true;
      });
    }
  }

  Widget _buildErrorWidget(BuildContext context, String? errorMessage) =>
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, size: 60, color: Colors.red),
            const SizedBox(height: 10),
            Text(
              errorMessage ?? "error".tr(context),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _betterPlayerController.retryDataSource(),
              child: Text("try_again".tr(context)),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    enableScreenshot();
    _betterPlayerController.dispose();
    super.dispose();
  }

  /// Called by a QualityTile when the user taps “Play” on a downloaded file.
  void _playOffline(String filePath) {
    setState(() {
      _isOffline = true;
      _localVideoPath = filePath;
      _isPlayerReady = false;
      _isVideoCompleted = false;
      _isVideoWatched = false;
    });

    // Re‐initialize the BetterPlayerController with the local file.
    _betterPlayerController.dispose();
    _initializePlayer();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                // ─── Video Section ─────────────────────────────────────────
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _isPlayerReady
                      ? BetterPlayer(controller: _betterPlayerController)
                      : const Center(child: CircularProgressIndicator()),
                ),
                const Divider(color: AppColors.primaryColors),

                // ─── Mark As Watched Section ─────────────────────────────
                VideoInfoMessage(show: !_isVideoCompleted),
                MarkAsWatchedSwitch(
                  isVideoWatched: _isVideoWatched,
                  isVideoCompleted: _isVideoCompleted,
                  onToggle: (value) => setState(() => _isVideoWatched = value),
                ),
                const Divider(color: AppColors.primaryColors),

                // ─── Download File Section (if any) ──────────────────────
                if (widget.video!.filePath != null)
                  FileDownloadTile(video: widget.video!),
                if (widget.video!.filePath != null)
                  const Divider(color: AppColors.primaryColors),

                // ─── Download Qualities Section ──────────────────────────
                if (widget.video!.downloads!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Text(
                      "watch_offline".tr(context),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),

                // If currently “playing offline,” show a button to go back online:
                if (_isOffline)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isOffline = false;
                          _isPlayerReady = false;
                        });
                        _betterPlayerController.dispose();
                        _initializePlayer();
                      },
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: const Icon(Icons.wifi),
                      ),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("go_online".tr(context)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColors,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                // Build one QualityTile per available quality.
                if (widget.video!.downloads!.isNotEmpty)
                  Column(
                    children: widget.video!.downloads!
                        .map(
                          (quality) => QualityTile(
                            videoId: widget.video!.id!.toString(),
                            quality: quality,
                            onPlayOffline: _playOffline,
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
      );
}
