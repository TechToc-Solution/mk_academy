import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';
import 'package:mk_academy/features/show_video/presentation/views-model/cubit/download_video_cubit.dart';

class VideoDownloadTile extends StatefulWidget {
  final bool isDownloaded;
  final bool isDownloading;
  final int downloadProgress;
  final int downloadTotalSize;
  final int downloadReceivedSize;
  final Duration estimatedTime;

  final Video video;

  const VideoDownloadTile({
    super.key,
    required this.isDownloaded,
    required this.isDownloading,
    required this.downloadProgress,
    required this.downloadTotalSize,
    required this.downloadReceivedSize,
    required this.estimatedTime,
    required this.video,
  });

  @override
  State<VideoDownloadTile> createState() => _VideoDownloadTileState();
}

class _VideoDownloadTileState extends State<VideoDownloadTile> {
  String? selectedItem;
  List<String> downloadedQualities = [];
  @override
  void initState() {
    super.initState();
    _loadDownloadedQualities();
  }

  void _loadDownloadedQualities() async {
    // final qualities = await context
    //     .read<DownloadVideoCubit>()
    //     .getDownloadedQualities(
    //         widget.video.id.toString(), widget.video.downloads ?? []);
    // setState(() {
    //   downloadedQualities = qualities;
    // });
  }

  bool get isSelectedDownloaded =>
      selectedItem != null && downloadedQualities.contains(selectedItem);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: _boxDecoration(),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: Text("download_video".tr(context),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
          subtitle: widget.video.downloads != null
              ? DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: AppColors.primaryColors,
                  hint: Text("select_quality".tr(context)),
                  value: selectedItem,
                  items: widget.video.downloads!.map((item) {
                    return DropdownMenuItem(
                      value: item.quality,
                      child: Text(item.quality),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedItem = value;
                    });
                  },
                )
              : SizedBox(),
          trailing: widget.isDownloading
              ? _buildDownloadProgress(context)
              : selectedItem != null && isSelectedDownloaded
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : GestureDetector(
                      onTap: selectedItem != null
                          ? () {
                              showCustomDialog(
                                  icon: Icons.warning,
                                  context: context,
                                  title: '',
                                  description: "download_warning".tr(context),
                                  primaryButtonText: "yes".tr(context),
                                  onPrimaryAction: () async {
                                    context
                                        .read<DownloadVideoCubit>()
                                        .downloadVideo(
                                          widget.video.id.toString(),
                                          widget.video.downloads!.firstWhere(
                                              (item) =>
                                                  item.quality == selectedItem),
                                        );

                                    Navigator.pop(context);
                                  });
                            }
                          : () {
                              messages(
                                  context,
                                  "select_quality_error".tr(context),
                                  Colors.red);
                            },
                      child: const CircleAvatar(
                        backgroundColor: AppColors.primaryColors,
                        child: Icon(Icons.download_for_offline_rounded,
                            color: Colors.white),
                      ),
                    ),
        ),
      );

  Widget _buildDownloadProgress(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 100,
            child: LinearProgressIndicator(
              value: widget.downloadProgress / 100,
              backgroundColor: Colors.grey[200],
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primaryColors),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${(widget.downloadReceivedSize / (1024 * 1024)).toStringAsFixed(1)} / "
            "${(widget.downloadTotalSize / (1024 * 1024)).toStringAsFixed(1)} MB",
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          Text(
            "${"time".tr(context)}: ${widget.estimatedTime.inSeconds} ${"sec".tr(context)}",
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      );

  BoxDecoration _boxDecoration() => BoxDecoration(
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
      );
}
