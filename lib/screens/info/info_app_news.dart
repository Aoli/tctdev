import 'dart:async';
import 'package:tct/globals/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:tct/globals/constants_ui.dart';

class TctAppNewsPage extends StatefulWidget {
  final bool metricUnit;

  TctAppNewsPage({Key key, @required this.metricUnit}) : super(key: key);

  @override
  _TctAppNewsPageState createState() => _TctAppNewsPageState(metricUnit);
}

class _TctAppNewsPageState extends State<TctAppNewsPage> {
  bool metricUnit;

  _TctAppNewsPageState(this.metricUnit);

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
              Text('TCT App News',
                  style: kAppBarTextStyle, textScaleFactor: textScaleFactorTc),
              Container(width: 30.0),
            ],
          ),
        ),
        body: WebView(
          initialUrl: "https://www.turbochargertuning.com/app-news",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
