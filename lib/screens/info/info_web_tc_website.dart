import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:tct/globals/global_variables.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS/macOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:tct/globals/constants_ui.dart';

class TcWebSitePage extends StatefulWidget {
  final bool metricUnit;

  TcWebSitePage({required Key key, required this.metricUnit}) : super(key: key);

  @override
  _TcWebSitePageState createState() => _TcWebSitePageState(metricUnit);
}

class _TcWebSitePageState extends State<TcWebSitePage> {
  bool metricUnit;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  _TcWebSitePageState(this.metricUnit);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebViewPlatform.instance = SurfaceAndroidWebView();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                width: logoSize,
                height: logoSize,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/turbo_appbar_logo.png'),
                    ))),
            Text('TurboCharger WebSite',
                style: kAppBarTextStyle, textScaleFactor: textScaleFactorTc),
            Container(width: 30.0),
          ],
        ),
      ),
      body: Platform.isIOS
          ? Container(
              child: WebView(
                initialUrl: "https://www.turbochargertuning.com/ios",
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              ),
            )
          : Container(
              child: WebView(
                initialUrl: "https://www.turbochargertuning.com/android",
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              ),
            ),
    );
  }
}
