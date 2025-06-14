import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';
import 'package:mk_academy/features/show_video/presentation/views-model/cubit/manager/download_manager_cubit.dart';

typedef OnPlayOfflineCallback = void Function(String localFilePath);

class QualityTile extends StatefulWidget {
  const QualityTile({
    super.key,
    required this.videoId,
    required this.quality,
    required this.onPlayOffline,
  });

  final String videoId;
  final DownloadUrls quality;
  final OnPlayOfflineCallback onPlayOffline;

  @override
  State<QualityTile> createState() => _QualityTileState();
}

class _QualityTileState extends State<QualityTile> {
  late final DownloadManagerCubit _manager;
  DownloadStatus? _lastTaskStatus;
  @override
  void initState() {
    super.initState();
    _manager = context.read<DownloadManagerCubit>();

    // If a task for this key already exists (partial or failed), resume it.
    final key = '${widget.videoId}-${widget.quality.resolution}';
    final existing = _manager.state.tasks[key];
    if (existing != null && existing.status != DownloadStatus.success) {
      _manager.startDownload(widget.videoId, widget.quality);
    }
  }

  @override
  void dispose() {
    _lastTaskStatus = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final key = '${widget.videoId}-${widget.quality.resolution}';

    return BlocListener<DownloadManagerCubit, DownloadManagerState>(
      listener: (context, state) {
        final key = '${widget.videoId}-${widget.quality.resolution}';
        final task = state.tasks[key];

        if (task != null && task.status != _lastTaskStatus) {
          _lastTaskStatus = task.status;

          if (task.status == DownloadStatus.success &&
              task.downloaded == false) {
            // Show success message
            messages(
                context,
                "${"video_downloaded".tr(context)} ${widget.quality.resolution}",
                AppColors.primaryColors);
            task.downloaded = true;
          } else if (task.status == DownloadStatus.failure) {
            // Show error dialog
            showCustomDialog(
              context: context,
              title: "video_error_download".tr(context),
              description: "",
              primaryButtonText: "ok".tr(context),
              onPrimaryAction: () => Navigator.pop(context),
            );
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: boxDecoration(),
        child: ListTile(
          leading: const Icon(Icons.video_library),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: Text(
            "${"quality".tr(context)}: ${widget.quality.resolution}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          trailing: BlocBuilder<DownloadManagerCubit, DownloadManagerState>(
            builder: (context, state) {
              final task = state.tasks[key];

              // If download succeeded, show Play button
              if (task != null && task.status == DownloadStatus.success) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColors,
                  ),
                  child: IconButton(
                    icon:
                        const Icon(Icons.play_circle_fill, color: Colors.white),
                    tooltip: "play_offline".tr(context),
                    onPressed: () {
                      widget.onPlayOffline(task.filePath!);
                    },
                  ),
                );
              }

              // If download is in progress, show MB downloaded / total MB
              return Row(mainAxisSize: MainAxisSize.min, children: [
                if (task != null && task.status == DownloadStatus.inProgress)
                  Text(
                    "${(task.receivedBytes / (1024 * 1024)).toStringAsFixed(1)}/${(task.totalBytes / (1024 * 1024)).toStringAsFixed(1)} MB",
                    style: const TextStyle(fontSize: 10),
                  ),
                SizedBox(
                  width: 8,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (task != null &&
                        task.status == DownloadStatus.inProgress)
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          color: AppColors.secColors,
                          value: (task.progress / 100),
                        ),
                      ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColors,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.download, color: Colors.white),
                        tooltip: "download".tr(context),
                        onPressed: () => showCustomDialog(
                            icon: Icons.warning,
                            context: context,
                            title: '',
                            description: "download_warning".tr(context),
                            primaryButtonText: "yes".tr(context),
                            onPrimaryAction: () async {
                              _manager.startDownload(
                                widget.videoId,
                                widget.quality,
                              );

                              Navigator.pop(context);
                            }),
                      ),
                    ),
                  ],
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }
}
