import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/features/show_video/presentation/views-model/cubit/download_video_cubit.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/file_download_tile.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/video_download_tile.dart';
import 'package:path_provider/path_provider.dart';
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

  bool _isDownloaded = false;
  bool _isPlayerReady = false;

  String? _localVideoPath;

  String? selectedResolution;

  List<String> _downloadedQualities = [];

  @override
  void initState() {
    super.initState();
    disableScreenshot();
    context
        .read<DownloadVideoCubit>()
        .getDownloadedQualities(
          widget.video!.id.toString(),
          widget.video!.downloads ?? [],
        )
        .then((qualities) {
      setState(() {
        _downloadedQualities = qualities;
      });
    });
    context
        .read<DownloadVideoCubit>()
        .checkIfDownloaded(
            widget.video!.id.toString(), widget.video!.downloads![0].quality)
        .then((downloaded) {
      if (downloaded) {
        final directory = getApplicationDocumentsDirectory();
        directory.then((dir) {
          final path = "${dir.path}/${widget.video!.id}.mp4";
          setState(() {
            _isDownloaded = true;
            _localVideoPath = path;
          });
          _initializePlayer();
        });
      } else {
        _initializePlayer();
      }
    });
  }

  void _initializePlayer() {
    final source = BetterPlayerDataSource(
      _isDownloaded
          ? BetterPlayerDataSourceType.file
          : BetterPlayerDataSourceType.network,
      _isDownloaded ? _localVideoPath! : widget.video!.video!,
      useAsmsSubtitles: !_isDownloaded,
      useAsmsAudioTracks: !_isDownloaded,
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
            Text(errorMessage ?? "error".tr(context),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
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
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _isPlayerReady
                      ? BetterPlayer(controller: _betterPlayerController)
                      : const Center(child: CircularProgressIndicator()),
                ),
                const Divider(color: AppColors.primaryColors),
                VideoInfoMessage(show: !_isVideoCompleted),
                MarkAsWatchedSwitch(
                  isVideoWatched: _isVideoWatched,
                  isVideoCompleted: _isVideoCompleted,
                  onToggle: (value) => setState(() => _isVideoWatched = value),
                ),
                if (widget.video!.filePath != null)
                  FileDownloadTile(video: widget.video!),
                BlocBuilder<DownloadVideoCubit, DownloadVideoState>(
                  builder: (context, state) {
                    final allQualities = widget.video?.downloads
                            ?.map((e) => e.quality)
                            .toList() ??
                        [];

                    final allDownloaded = allQualities.every(
                        (quality) => _downloadedQualities.contains(quality));

                    if (allDownloaded) {
                      return const SizedBox();
                    }

                    return VideoDownloadTile(
                      video: widget.video!,
                      isDownloaded:
                          _isDownloaded || state is DownloadVideoSuccess,
                      isDownloading: state is DownloadVideoInProgress,
                      downloadProgress:
                          state is DownloadVideoInProgress ? state.progress : 0,
                      downloadTotalSize:
                          state is DownloadVideoInProgress ? state.total : 0,
                      downloadReceivedSize:
                          state is DownloadVideoInProgress ? state.received : 0,
                      estimatedTime: state is DownloadVideoInProgress
                          ? state.estimatedTime
                          : Duration.zero,
                    );
                  },
                ),
                if (_downloadedQualities.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isDownloaded = false;
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
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Text(
                      "watch_offline".tr(context),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Column(
                    children: _downloadedQualities.map((quality) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.video_library),
                          title: Text("${"quality".tr(context)}: $quality"),
                          trailing: IconButton(
                            icon: const Icon(Icons.play_arrow,
                                color: AppColors.primaryColors),
                            onPressed: () async {
                              final path = await context
                                  .read<DownloadVideoCubit>()
                                  .getDownloadedPath(
                                      widget.video!.id.toString(), quality);

                              if (path != null) {
                                setState(() {
                                  _localVideoPath = path;
                                  _isDownloaded = true;
                                  _isPlayerReady = false;
                                });
                                _betterPlayerController.dispose();
                                _initializePlayer(); // يعيد تهيئة المشغل لعرض الفيديو الأوفلاين
                              }
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
}
