import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/file_download_tile.dart';
import 'package:mk_academy/features/show_video/presentation/views/widgets/video_info_message.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  static const String routeName = '/webview';

  const WebViewScreen({super.key, required this.video});
  final VideoDataModel? video;

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  final bool _isVideoCompleted = false;
  @override
  void initState() {
    super.initState();
    final htmlContent = '''
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
          body, html { margin: 0; padding: 0; height: 100%; overflow: hidden; background-color: #000; }
          .container { position: relative; width: 100%; height: 100vh; }
          .iframe-container {
            position: absolute; top: 0; left: 0;
            width: 100%; height: 100%;
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
          }
        </style>
      </head>
      <body>
        <div class="container">
          <iframe class="iframe-container" src="${widget.video!.hlsUrl!}" frameborder="0"
            allow="accelerometer; gyroscope; autoplay; encrypted-media; picture-in-picture" allowfullscreen></iframe>
        </div>
      </body>
      </html>
    ''';

    // disableScreenshot();
    toggleScreenshot();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) {
          setState(() {
            _isLoading = false;
          });
        },
      ))
      ..loadHtmlString(htmlContent);
  }

  @override
  void dispose() {
    // enableScreenshot();
    toggleScreenshot();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Important!
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryColors,
                AppColors.secColors,
              ],
            ),
          ),
        ),
        title: Text(
          overflow: TextOverflow.ellipsis,
          widget.video!.name!,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: "cocon-next-arabic"),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  WebViewWidget(controller: _controller),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(color: AppColors.primaryColors),

            // Info Message
            VideoInfoMessage(show: !_isVideoCompleted),

            // Toggle Switch
            // MarkAsWatchedSwitch(
            //   isVideoWatched: _isVideoWatched,
            //   isVideoCompleted: _isVideoCompleted,

            //   onToggle: (value) {
            //     setState(() {
            //       _isVideoWatched = value;
            //     });
            //   },
            // ),

            if (widget.video!.file != null)
              FileDownloadTile(video: widget.video!),
          ],
        ),
      ),
    );
  }
}
