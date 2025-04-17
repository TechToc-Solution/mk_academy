import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  final Function(String) onScanned;

  const QRScannerPage({super.key, required this.onScanned});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
    );
    controller.start();
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera Preview
          MobileScanner(
            onDetect: (capture) {
              final String? code = capture.barcodes.first.rawValue;
              if (code != null) {
                widget.onScanned(code);
                Navigator.pop(context);
              }
            },
          ),
          // Cutout Area (Frame)
          Center(
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Divider(
                color: AppColors.primaryColors,
                thickness: 4,
              ),
            ),
          ),
          // Instruction Text
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "align_qr".tr(context),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // App Bar
          CustomAppBar(title: "scan_qr_code".tr(context), backBtn: true),
        ],
      ),
    );
  }
}
