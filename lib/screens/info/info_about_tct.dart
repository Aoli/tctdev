import 'dart:io' show Platform;
import 'package:Turbocharger/components/analytics_event.dart';
import 'package:Turbocharger/data_models/analytics_event_type.dart';
import 'package:Turbocharger/data_models/Map_iphone_models.dart';
import 'package:Turbocharger/globals/app_localizations.dart';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:Turbocharger/components/turbocharger_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:package_info/package_info.dart';
import '../../components/reusable_card.dart';
import '../../globals/constant.dart';
import 'package:Turbocharger/globals/constants_ui.dart';

class AppInformationPage extends StatefulWidget {
  final bool metricUnit;

  AppInformationPage({Key key, @required this.metricUnit}) : super(key: key);

  @override
  _AppInformationPageState createState() =>
      _AppInformationPageState(metricUnit);
}

class _AppInformationPageState extends State<AppInformationPage> {
  bool metricUnit;

  _AppInformationPageState(this.metricUnit);

  //************ END Airflow *******************************************

  // bool metricUnit = false;
  bool snackbarEnable = true;

  Future<void> deviceInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
  }

  Widget get submitRatingButton {
    if (snackbarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            _scaffoldCompressorKey.currentState
                .showSnackBar(snackBarCompressor);

            // parameters
            var _analyticsParameter = {'Snackbar': 'About TCT'};
            // Execute a function to send logEvent() to Firebase Analytics
            Analytics.analyticsLogEvent(
                AnalyticsEventType.snack_bar, _analyticsParameter);
          });
    }
    return null;
  }

  final GlobalKey<ScaffoldState> _scaffoldCompressorKey =
  new GlobalKey<ScaffoldState>();
  final snackBarCompressor = SnackBar(
    content: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Information page about the TurboCharger app.',
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            kSnackBarDevelopmentInfo,
            style: kSnackBarTextStyle,
            textScaleFactor: textScaleFactorTc,
          ),
        ],
      ),
    ),
    backgroundColor: Colors.grey.shade400,
    duration: Duration(seconds: 60),
    action: SnackBarAction(
      label: 'Close',
      textColor: Colors.grey.shade600,
      onPressed: () {},
    ),
  );

  // delete double petrolTurboCalc;

  @override
  void initState() {
    super.initState();
    deviceInfo();
    // metricUnit = false;
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldCompressorKey,
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
            Text(AppLocalizations.of(context).translate('info_about_tct_0000')
                //'ABOUT TCT',
                , style: kAppBarTextStyle, textScaleFactor: textScaleFactorTc),
            Container(width: 30.0, child: submitRatingButton),
          ],
        ),
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ReusableCard(
                colour: kActiveCardColourOutput,
                cardChild: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            AppLocalizations.of(context).translate(
                                'info_about_tct_0010')
                            //'TCT - TurboCharger Tuning',
                            , style: kSecondSubjectTextStyle,
                            textScaleFactor: textScaleFactorTc,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Center(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                'info_about_tct_0020')
                                            //'The TCT is made with turbo engine enthusiasts in mind. The app calculates: ',
                                            ,style: kLabelTextStyle,
                                        textScaleFactor: textScaleFactorTc),
                                        SizedBox(height: 20),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                leading: Icon(TurbochargerIcons
                                                    .iconturbo2048px),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'info_about_tct_0030')
                                                    //'Turbo',
                                                    ,textScaleFactor:
                                                    textScaleFactorTc),
                                                subtitle: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'info_about_tct_0040') //'Trim, Boost/Back Pressure'
                                                ),

                                                // subtitle: Text('Max HP based on inducer size'),
                                              ),
                                              ListTile(
                                                leading: Icon(TurbochargerIcons
                                                    .iconturbo2048px),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'info_about_tct_0050')
                                                    //'Airflow',
                                                    ,textScaleFactor:
                                                    textScaleFactorTc),
                                                subtitle: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'info_about_tct_0060') //'Airflow calculations'
                                                ),
                                              ),
                                              ListTile(
                                                leading: Icon(TurbochargerIcons
                                                    .iconcylinder2048px),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'info_about_tct_0070')
                                                    //'Tuning',
                                                    ,textScaleFactor:
                                                    textScaleFactorTc),
                                                subtitle: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'info_about_tct_0080') //'Engine Displacement, Torque, Horsepower'
                                                ),
                                              ),
                                              ListTile(
                                                leading: Icon(TurbochargerIcons
                                                    .iconenginecalc2048px),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'info_about_tct_0090')
                                                    //'Convert',
                                                    ,textScaleFactor:
                                                    textScaleFactorTc),
                                                subtitle: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'info_about_tct_0100') //'Convert units'
                                                ),
                                              ),
                                              ListTile(
                                                leading:
                                                Icon(Icons.info_outline),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'info_about_tct_0110')
                                                    //'Info',
                                                   , textScaleFactor:
                                                    textScaleFactorTc),
                                                subtitle: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'info_about_tct_0120') //'Information about the app'
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
//                                        Text(
//                                            'We are working on a search and find function for compressor maps.',
//                                            textScaleFactor: textScaleFactorTc),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: AssetImage('images/inducer_exducer.jpg'),
                          ),
                        ),
                      ),

                      //Exducer

                      SizedBox(height: 15.0),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            AppLocalizations.of(context).translate(
                                'info_about_tct_0130') //'Disclaimer',
                           , textScaleFactor: textScaleFactorTc,
                            style: kSecondSubjectTextStyle,
                          ),
                        ),
                      ),
                      //Exducer
                      SizedBox(height: 2.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              AppLocalizations.of(context).translate(
                                  'info_about_tct_0140')
                              //'All calculations in this app are well-known formulas within the turbocharger and tuning community. But there are a lot of recipes, formulas, and methods out there with alternative ways to make similar calculations, dependent on situations or prerequisites. We believe that you are familiar with what this tool has to offer and that you can realize when this tool is useful or not. Always consult professionals, your Turbo handbook, or Turbo shop for specific guidance within this area before purchase and mounting any turbo or tuning related items. We don\'t take any responsibility for errors or wrong buying, using, or mounting any gear or, equipment related to the use of this app.',
                    ,style: TextStyle(fontStyle: FontStyle.italic),textScaleFactor: textScaleFactorTc,

                            ),
                          )
                        ],
                      ),
                      Divider(color: Colors.white),
                      Container(
                        //alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 40),
                            Text(
                              AppLocalizations.of(context).translate(
                                  'info_about_tct_0150') //'TCT ',
                              ,style: kBuildVersionStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                            Text(
                              currentVersionNumberGlobal,
                              style: kBuildVersionStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                            Text(' ',
                                style: kBuildVersionStyle,
                                textScaleFactor: textScaleFactorTc),
                            Text(
                              'Build:' + currentBuildNumberGlobal.toString(),
                              style: kBuildVersionStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                            Text('  ',
                                style: kBuildVersionStyle,
                                textScaleFactor: textScaleFactorTc),
                            Text('b:' + deviceWidth.toStringAsFixed(0),
                                style: kBuildVersionStyle,
                                textScaleFactor: textScaleFactorTc),
                            Text(' h:' + displaySizeLength.toStringAsFixed(0),
                                style: kBuildVersionStyle,
                                textScaleFactor: textScaleFactorTc),
                            Text(
                              ' RC:' + remoteConfigBuild.toString(),
                              style: kBuildVersionStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white),
                      Platform.isAndroid
                          ? Text(
                        '$manufacturer, $model, Android $release, ',
                        style: kBuildVersionStyle,
                        textScaleFactor: textScaleFactorTc,
                      )
                          : Text(
                        '${iphoneMapping[modelIphone]}, $systemName $version',
                        style: kBuildVersionStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                      // Divider(color: Colors.white),
                      // Text('telefon: ${iphoneMapping[modelIphone]}'),

                      Divider(color: Colors.white),

                      Text(
                        haveStartedTimes,
                        style: kBuildVersionStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                      //Exducer 2
                    ],
                  ),
                ),
              ),

              //Fuel (Hp)
            ],
          ),
        );
      }),
    );
  }
}
