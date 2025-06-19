import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/cubits/download_handler/download_handler_cubit.dart';
import 'package:mk_academy/core/shared/repos/download_handler/download_handler_repo.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';
import 'package:mk_academy/features/show_video/presentation/views-model/cubit/video_cubit/videos_cubit.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/file_download_tile.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/quality_tile.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/mark_as_watched_switch.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/sections_nav.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/video_info_message.dart';

class VideoPlayerScreen extends StatefulWidget {
  static const String routeName = '/video';
  final int? videoId;
  final int? courseId;
  final String videoName;

  const VideoPlayerScreen(
      {super.key,
      required this.videoId,
      required this.videoName,
      required this.courseId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>
    with TickerProviderStateMixin {
  late BetterPlayerController _betterPlayerController;
  late TabController _mainTabController;
  bool _isOffline = false;
  String? _localVideoPath;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 3, vsync: this);
    _mainTabController.addListener(() {
      setState(() {});
    });
    // disableScreenshot();
    toggleScreenshot();
    context
        .read<VideoCubit>()
        .getVideo(videoId: widget.videoId, courseId: widget.courseId);
  }

  void _initializePlayer(VideoDataModel? video) async {
    final source = BetterPlayerDataSource(
      _isOffline
          ? BetterPlayerDataSourceType.file
          : BetterPlayerDataSourceType.network,
      _isOffline ? _localVideoPath! : video!.hlsUrl!,
      useAsmsSubtitles: _isOffline,
      useAsmsAudioTracks: _isOffline,
    );

    try {
      _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: false,
          looping: false,
          allowedScreenSleep: false,
          aspectRatio: 16 / 9,
          controlsConfiguration: const BetterPlayerControlsConfiguration(
            enableQualities: true,
            enableOverflowMenu: true,
            enableSubtitles: false,
          ),

          errorBuilder: (context, errorMessage) =>
              _buildErrorWidget(context, errorMessage),
          // eventListener: _handlePlayerEvents,
        ),
        betterPlayerDataSource: source,
      );

      setState(() => _isPlayerReady = true);
    } catch (e) {
      setState(() => _isPlayerReady = false);
    }
  }

  // void _handlePlayerEvents(BetterPlayerEvent event) {
  //   if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
  //     context
  //         .read<MarkAsWatchedCubit>()
  //         .markAsWatched(videoId: widget.videoId!, courseId: widget.courseId!);
  //   }
  // }

  Widget _buildErrorWidget(BuildContext context, String? errorMessage) =>
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, size: 60, color: Colors.red),
            const SizedBox(height: 10),
            Text(
              // errorMessage ??
              "error".tr(context),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                try {
                  _betterPlayerController.retryDataSource();
                } catch (e) {
                  // debugPrint("Retry failed: $e");
                }
              },
              child: Text("try_again".tr(context)),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    // enableScreenshot();
    toggleScreenshot();
    _betterPlayerController.dispose();
    _mainTabController.dispose();
    super.dispose();
  }

  /// Called by a QualityTile when the user taps “Play” on a downloaded file.
  void _playOffline(String filePath) {
    setState(() {
      _isOffline = true;
      _localVideoPath = filePath;
      _isPlayerReady = false;
    });

    // Re‐initialize the BetterPlayerController with the local file.
    _betterPlayerController.dispose();
    _initializePlayer(null);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
            widget.videoName,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: "cocon-next-arabic",
            ),
          ),
        ),
        body: BlocBuilder<VideoCubit, VideoState>(
          builder: (context, state) {
            if (state.status == VideoStatus.success && !_isPlayerReady) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.microtask(() => _initializePlayer(state.video));
              });
            }
            if (state.status == VideoStatus.success && _isPlayerReady) {
              return SafeArea(
                child: Container(
                  height: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // ─── Video Section ─────────────────────────────────────────
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: _isPlayerReady
                              ? BetterPlayer(
                                  controller: _betterPlayerController)
                              : const Center(
                                  child: CircularProgressIndicator()),
                        ),

                        // If currently “playing offline,” show a button to go back online:
                        if (_isOffline)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _isOffline = false;
                                  _isPlayerReady = false;
                                });
                                if (_betterPlayerController
                                    .isVideoInitialized()!) {
                                  _betterPlayerController.dispose();
                                }

                                _initializePlayer(state.video!);
                              },
                              icon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: const Icon(Icons.wifi),
                              ),
                              label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("go_online".tr(context)),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColors,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),

                        SectionsNav(
                          tabController: _mainTabController,
                          titles: [
                            "info".tr(context),
                            "files".tr(context),
                            "qualities".tr(context)
                          ],
                        ),
                        IndexedStack(
                            index: _mainTabController.index,
                            children: [
                              // ─── Mark As Watched Section ─────────────────────────────
                              Column(
                                children: [
                                  VideoInfoMessage(
                                      show: !state.video!.isViewed!),
                                  MarkAsWatchedSwitch(
                                    isVideoWatched: state.video!.isViewed!,
                                    videoId: widget.videoId!,
                                    courseId: widget.courseId!,
                                    onToggle: (value) => setState(() {
                                      state.video!.isViewed = value;
                                    }),
                                  ),
                                ],
                              ),
                              // ─── Download File Section (if any) ──────────────────────
                              Column(
                                children: [
                                  if (state.video!.file != null)
                                    BlocProvider(
                                      create: (context) => DownloadCubit(
                                          repo:
                                              getit.get<DownloadHandlerRepo>())
                                        ..checkExistingDownload(
                                            fileName: state.video!.name!,
                                            id: state.video!.id!),
                                      child:
                                          FileDownloadTile(video: state.video!),
                                    ),
                                ],
                              ),
                              // ─── Download Qualities Section ──────────────────────────
                              Column(
                                children: [
                                  if (state.video!.downloadUrls!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8),
                                      child: Text(
                                        "watch_offline".tr(context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  // Build one QualityTile per available quality.
                                  if (state.video!.downloadUrls!.isNotEmpty)
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: state.video!.downloadUrls!
                                          .map(
                                            (quality) => QualityTile(
                                              videoId:
                                                  state.video!.id!.toString(),
                                              quality: quality,
                                              onPlayOffline: _playOffline,
                                            ),
                                          )
                                          .toList(),
                                    ),
                                ],
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state.status == VideoStatus.failure) {
              return CustomErrorWidget(
                  errorMessage: state.errorMessage!,
                  onRetry: () => context.read<VideoCubit>().getVideo(
                      videoId: widget.videoId, courseId: widget.courseId));
            } else {
              return CustomCircualProgressIndicator();
            }
          },
        ),
      );
}
