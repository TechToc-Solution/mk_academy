import 'package:flutter/material.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  static const String routeName = '/video';

  const WebViewScreen({super.key});
  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  final String url =
      "https://iframe.mediadelivery.net/embed/399054/9a5c88dd-2c88-49bd-b4f2-d8bba7697858?token=3062beb925d363b30d6eb0f2b13ad77a701c9f5e8820c6d041d52d4f8fdd338f&expires=1743174086&autoplay=false&loop=false&muted=false&preload=false&responsive=true";
  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString('''
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
            <iframe class="iframe-container" src="$url" frameborder="0"
              allow="accelerometer; gyroscope; autoplay; encrypted-media; picture-in-picture" allowfullscreen></iframe>
          </div>
        </body>
        </html>
      ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "",
              backBtn: true,
            ),
            Expanded(child: WebViewWidget(controller: _controller)),
          ],
        ),
      ),
    );
  }
}
