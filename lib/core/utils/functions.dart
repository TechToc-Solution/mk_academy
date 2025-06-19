import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_session/audio_session.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'package:mk_academy/core/shared/cubits/download_handler/download_handler_cubit.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../features/home/presentation/views-model/ads/ads_cubit.dart';
import '../../features/leaderboard/presentation/views-model/leaderboard_cubit.dart';
import '../../features/profile/presentation/views-model/profile_cubit.dart';
import '../shared/cubits/subjects/subjects_cubit.dart';
import '../widgets/cutom_dialog.dart';
import 'constats.dart';

//secret keys
String getStaticKey() {
  return ['TechToc', 'AppAESKey', '12345678', '90abcd00'].join();
}

const _encryptedKey =
    '/WBrxIreRSfLCV9taIo+Y1wnkrszW+t7L1gtCeu7/NQmpozKQ4FrFQOZCE/w9g7O';
const _ivBase64 = 'k3D7jLeEfp7sp0RqLtEkQQ==';

Future<void> initAudioSession() async {
  // Initialize silent audio player
  await silencePlayer.setLoopMode(LoopMode.one);
  await silencePlayer.setVolume(0.0);

  // Configure audio session
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration(
    avAudioSessionCategory: AVAudioSessionCategory.playback,
    avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.mixWithOthers,
    avAudioSessionMode: AVAudioSessionMode.defaultMode,
  ));
  enableScreenshot();
}

Future<void> toggleScreenshot() async {
  if (isSecureMode) {
    await enableScreenshot();
  } else {
    await disableScreenshot();
  }
}

Future<void> enableScreenshot() async {
  // 1. Allow screenshots
  await noScreenshot.screenshotOn();

  // 2. Restore audio session
  final session = await AudioSession.instance;
  await session.setActive(true);

  // 3. Stop silent audio
  await silencePlayer.stop();

  isSecureMode = false;
}

Future<void> disableScreenshot() async {
  // 1. Block screenshots/recordings
  await noScreenshot.screenshotOff();

  // 2. Mute through audio session
  final session = await AudioSession.instance;
  await session.setActive(false);

  // 3. Play silent audio to occupy audio channel
  await silencePlayer.setAsset('assets/audio/silence.mp3');
  await silencePlayer.play();
  isSecureMode = true;
}

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

BoxDecoration boxDecoration() => BoxDecoration(
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
Future<bool> isRunningOnEmulator() async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    return !androidInfo.isPhysicalDevice ||
        androidInfo.model.toLowerCase().contains('sdk') ||
        androidInfo.manufacturer.toLowerCase().contains('genymotion');
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    return !iosInfo.isPhysicalDevice;
  }

  return false;
}

Future<void> blockIfDebugOrEmulator() async {
  final emulator = await isRunningOnEmulator();
  var inDebugMode = false;

  assert(() {
    inDebugMode = true;
    return true;
  }());

  if (inDebugMode || emulator) {
    exit(0);
  }
}

String getDecryptedSecretKey() {
  final key = Key.fromUtf8(getStaticKey());
  final iv = IV.fromBase64(_ivBase64);

  final encrypter = Encrypter(AES(key));
  final decrypted = encrypter.decrypt64(_encryptedKey, iv: iv);

  return decrypted;
}

String decryptVideoData(String base64Data, String token) {
  final secret = getDecryptedSecretKey();
  // 1. Derive AES key from token + secret
  final keyBytes = sha256.convert(utf8.encode(token + secret)).bytes;
  final key = Key(Uint8List.fromList(keyBytes));

  // 2. Decode base64-encoded input (IV + ciphertext)
  final fullData = base64.decode(base64Data);

  // 3. Split IV and ciphertext
  final iv = IV(fullData.sublist(0, 16));
  final cipherText = fullData.sublist(16);

  // 4. AES Decrypt using AES-256-CBC
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  final decrypted = encrypter.decrypt(Encrypted(cipherText), iv: iv);
  return fixBadCdnUrl(decrypted);
}

String fixBadCdnUrl(String decryptedJsonString) {
  final jsonMap = json.decode(decryptedJsonString);

  String fixUrl(String url) {
    final uri = Uri.parse(url);

    // Extract query parameters
    final queryParams = uri.queryParameters;

    if (!queryParams.containsKey('token_path')) return url;

    String tokenPath = queryParams['token_path']!;
    tokenPath = Uri.decodeComponent(tokenPath); // decode once

    // Ensure single slash between paths
    tokenPath = tokenPath.replaceAll(RegExp('/+'), '/');

    // Rebuild the query with corrected token_path
    final newQueryParams = Map<String, String>.from(queryParams)
      ..['token_path'] = tokenPath;

    final newUri = Uri(
      scheme: uri.scheme,
      host: uri.host,
      pathSegments: uri.pathSegments,
      queryParameters: newQueryParams,
    );

    return newUri.toString();
  }

  // إصلاح الحقول المطلوبة
  jsonMap['hls_url'] = fixUrl(jsonMap['hls_url']);

  if (jsonMap['download_urls'] is List) {
    for (var item in jsonMap['download_urls']) {
      item['url'] = fixUrl(item['url']);
    }
  }

  return json.encode(jsonMap);
}
