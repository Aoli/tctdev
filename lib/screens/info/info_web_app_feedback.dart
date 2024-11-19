import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:tct/globals/constants_ui.dart';

class FeedbackPage extends StatefulWidget {
  final bool metricUnit;

  FeedbackPage({required Key key, required this.metricUnit}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState(metricUnit);
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool metricUnit;

  _FeedbackPageState(this.metricUnit);

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
                      ))),
              Text('TurboCharger Feedback',
                  style: kAppBarTextStyle, textScaleFactor: textScaleFactorTc),
              Container(width: 30.0),
            ],
          ),
        ),
        body: WebView(
          initialUrl:
              "https://docs.google.com/forms/d/e/1FAIpQLSeOGSMAnC4QbM9ad6iJa-l2mKP4xfRWLrRZs-sv265zVjaDWg/viewform?usp=sf_link",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
