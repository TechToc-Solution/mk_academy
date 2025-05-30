import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/cubits/download_handler/download_handler_cubit.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../features/home/presentation/views-model/ads/ads_cubit.dart';
import '../../features/leaderboard/presentation/views-model/leaderboard_cubit.dart';
import '../../features/profile/presentation/views-model/profile_cubit.dart';
import '../shared/cubits/subjects/subjects_cubit.dart';
import '../widgets/cutom_dialog.dart';
import 'constats.dart';

//navigators
Route goRoute({required var x}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => x,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.fastEaseInToSlowEaseOut;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );
      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}

//messages
void messages(BuildContext context, String error, Color c, {int msgTime = 2}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    backgroundColor: c,
    content: Text(error),
    duration: Duration(seconds: msgTime),
  ));
}

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String description,
  required String primaryButtonText,
  String? secondaryButtonText,
  Color? primaryButtonColor,
  Color? secondaryButtonColor,
  IconData? icon,
  bool? oneButton,
  required void Function() onPrimaryAction,
  void Function()? onSecondaryAction,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CustomDialog(
        title: title,
        oneButton: oneButton,
        description: description,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText ?? "cancel".tr(context),
        primaryButtonColor: primaryButtonColor,
        secondaryButtonColor: secondaryButtonColor,
        icon: icon ?? Icons.lock,
        onPrimaryAction: onPrimaryAction,
        onSecondaryAction: onSecondaryAction ?? () => Navigator.pop(context),
      );
    },
  );
}

void showAwesomeDialog({
  required BuildContext context,
  required DialogType dialogType,
  required String title,
  required String desc,
  required void Function() btnOk,
  required void Function() btnCancel,
}) async {
  await AwesomeDialog(
    descTextStyle: TextStyle(fontSize: 16),
    btnOkText: "yes".tr(context),
    btnCancelText: "no".tr(context),
    context: context,
    dialogType: dialogType,
    animType: AnimType.scale,
    title: title,
    desc: desc,
    btnCancelOnPress: btnCancel,
    btnOkOnPress: btnOk,
  ).show();
}

//reset home
resetHomeCubits(BuildContext context) {
  context.read<AdsCubit>().resetPagination();
  context.read<LeaderboardCubit>().getLeaderboard(loadMore: false);
  context.read<SubjectsCubit>().getSubjects();
  context.read<AdsCubit>().getAllAds();
  isGuest ? null : context.read<ProfileCubit>().getProfile();
}

//secure the app
void toggleScreenshot() async {
  bool result = await noScreenshot.toggleScreenshot();
  debugPrint('Toggle Screenshot: $result');
}

void enableScreenshot() async {
  bool result = await noScreenshot.screenshotOn();
  debugPrint('Enable Screenshot: $result');
}

void disableScreenshot() async {
  bool result = await noScreenshot.screenshotOff();
  debugPrint('Screenshot Off: $result');
}

// download
void handleDownload(BuildContext context, String url, String fileName, int id) {
  final cubit = context.read<DownloadCubit>();

  cubit.startDownload(url: url, fileName: fileName, id: id);
}

// void _handleVideoPress(
//     BuildContext context, int index, String url, String fileName) {
//   showCustomDialog(
//     context: context,
//     title: 'alert'.tr(context),
//     description: 'download_before_watch'.tr(context),
//     primaryButtonText: 'download'.tr(context),
//     secondaryButtonText: 'watch'.tr(context),
//     primaryButtonColor: AppColors.primaryColors,
//     icon: Icons.warning_amber_rounded,
//     oneButton: false,
//     onPrimaryAction: () {
//       Navigator.pop(context);
//       _handleDownload(context, url, fileName, videos[index].id!);
//     },
//     onSecondaryAction: () {
//       Navigator.pop(context);
//       Navigator.of(context).push(goRoute(
//         // x: WebViewScreen(video: videos[index]),
//         x: VideoPlayerScreen(video: videos[index]),
//       ));
//     },
//   );
// }
