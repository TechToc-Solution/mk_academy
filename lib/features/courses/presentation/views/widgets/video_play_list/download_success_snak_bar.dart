import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:open_file/open_file.dart';

class DownloadSnackBar {
  /// Shows a custom Snackbar with a download success message
  /// and an action button to open the file.
  static void show({
    required BuildContext context,
    required String filePath,
  }) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green[600],
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.all(16.0),
      duration: const Duration(seconds: 4),
      content: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.white),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              "download_success".tr(context),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: "open_file".tr(context),
        textColor: Colors.white,
        onPressed: () {
          OpenFile.open(filePath);
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
