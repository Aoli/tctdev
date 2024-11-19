import 'dart:async';
import 'dart:io';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:Turbocharger/globals/constants_ui.dart';


class TcWebSitePage extends StatefulWidget {
  final bool metricUnit;

  TcWebSitePage({Key key, @required this.metricUnit}) : super(key: key);

  @override
  _TcWebSitePageState createState() => _TcWebSitePageState(metricUnit);
}

class _TcWebSitePageState extends State<TcWebSitePage> {
  bool metricUnit;

  _TcWebSitePageState(this.metricUnit);

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
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
                      )
                  )),
              Text('TurboCharger WebSite', style: kAppBarTextStyle,
                  textScaleFactor: textScaleFactorTc),
              Container(width: 30.0),
            ],
          ),
        ),
        body: Platform.isIOS? Container(
          child: WebView(
            initialUrl: "https://www.turbochargertuning.com/ios",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          ),
        ):Container(
          child: WebView(
            initialUrl: "https://www.turbochargertuning.com/android",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          ),
        ),);
  }
}
