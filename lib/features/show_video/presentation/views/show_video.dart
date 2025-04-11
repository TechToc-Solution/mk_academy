import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  static const String routeName = '/video';

  const WebViewScreen({super.key, required this.video});
  final Video? video;
  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    final htmlContent = '''
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
          body, html { margin: 0; padding: 0; height: 100%; overflow: hidden; }
          .container { position: relative; width: 100%; height: 100vh; }
          .iframe-container { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }
        </style>
      </head>
      <body>
        <div class="container">
          <iframe class="iframe-container" src="${widget.video!.video!}" frameborder="0"
            allow="accelerometer; gyroscope; autoplay; encrypted-media; picture-in-picture" allowfullscreen></iframe>
        </div>
      </body>
      </html>
    ''';
    disableScreenshot();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(htmlContent);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    enableScreenshot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: widget.video!.name!,
              backBtn: true,
            ),
            Expanded(child: WebViewWidget(controller: _controller)),
          ],
        ),
      ),
    );
  }
}
