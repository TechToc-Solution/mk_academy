import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/cubits/download_handler/download_handler_cubit.dart';
import 'package:mk_academy/core/shared/repos/download_handler/download_handler_repo.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';
import 'package:mk_academy/features/show_video/presentation/views-model/cubit/video_cubit/videos_cubit.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/file_download_tile.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/mark_as_watched_switch.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/sections_nav.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/video_info_message.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _mainTabController;
  bool _isPlayerReady = false;

  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _mainTabController = TabController(length: 2, vsync: this);
    _mainTabController.addListener(() {
      setState(() {});
    });
    toggleScreenshot();
    context
        .read<VideoCubit>()
        .getVideo(videoId: widget.videoId, courseId: widget.courseId);
  }

  void _initializePlayer(VideoDataModel? video) async {
    if (video == null || video.iframeUrl == null) {
      setState(() => _isPlayerReady = false);
      return;
    }

    final htmlContent = '''
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
          body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
            background-color: #000;
          }
          .container {
            position: relative;
            width: 100%;
            height: 100vh;
          }
          .iframe-container {
            position: absolute;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
          }
          .error-overlay {
            display: none;
            position: absolute;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            background-color: #111;
            color: white;
            font-family: sans-serif;
            font-size: 1.5rem;
            text-align: center;
            padding-top: 20%;
            box-sizing: border-box;
          }
        </style>
      </head>
      <body>
        <div class="container">
            <iframe class="iframe-container" id="videoFrame"
              src="${video.iframeUrl!}"
              frameborder="0"
              allow="accelerometer; gyroscope; autoplay; encrypted-media;"
              allowfullscreen>
            </iframe>

          <div class="error-overlay" id="errorOverlay">
            Sorry, the video could not be loaded.
          </div>
        </div>

        <script>
          const iframe = document.getElementById('videoFrame');
          const errorOverlay = document.getElementById('errorOverlay');

          iframe.onerror = function () {
            iframe.style.display = 'none';
            errorOverlay.style.display = 'block';
          };
        </script>
      </body>
      </html>
    ''';
    if (_controller == null) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(NavigationDelegate(
          onPageFinished: (_) {
            setState(() => _isPlayerReady = true);
          },
        ))
        ..loadHtmlString(htmlContent);
    } else {
      setState(() => _isPlayerReady = true);
    }
  }

  @override
  void dispose() {
    // enableScreenshot();
    toggleScreenshot();

    _mainTabController.dispose();
    super.dispose();
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
            if (state.status == VideoStatus.success) {
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
                              ? WebViewWidget(controller: _controller!)
                              : const Center(
                                  child: CircularProgressIndicator()),
                        ),

                        SectionsNav(
                          tabController: _mainTabController,
                          titles: [
                            "info".tr(context),
                            "files".tr(context),
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
