import 'dart:async';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:Turbocharger/globals/constants_ui.dart';


class TurboSelectorFeedback extends StatefulWidget {
  final String feedbackLink;

  TurboSelectorFeedback({Key key, @required this.feedbackLink})
      : super(key: key);

  @override
  _TurboSelectorFeedbackState createState() =>
      _TurboSelectorFeedbackState(feedbackLink);
}

class _TurboSelectorFeedbackState extends State<TurboSelectorFeedback> {
  String feedbackLink;

  _TurboSelectorFeedbackState(this.feedbackLink);

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
              Text('Turbo Reg Feedback',
                  style: kAppBarTextStyle, textScaleFactor: textScaleFactorTc),
              Container(width: 30.0),
            ],
          ),
        ),
        body: WebView(
          initialUrl: "$feedbackLink",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
