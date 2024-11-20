import 'package:flutter/material.dart';
import 'package:tct/components/analytics_event.dart';
import 'package:tct/data_models/analytics_event_type.dart';
import 'package:tct/globals/app_localizations.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../components/reusable_card.dart';
import '../../globals/constant.dart';
import 'package:tct/globals/constants_ui.dart';

class CreditsPage extends StatefulWidget {
  final bool metricUnit;

  CreditsPage({required Key key, required this.metricUnit}) : super(key: key);

  @override
  _CreditsPageState createState() => _CreditsPageState(metricUnit);
}

class _CreditsPageState extends State<CreditsPage> {
  bool metricUnit;

  _CreditsPageState(this.metricUnit);

  //************ END Airflow *******************************************

  // bool metricUnit = false;
  bool snackbarEnable = true;

  Widget get submitRatingButton {
    if (snackbarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(snackBarCompressor);

            // parameters
            var _analyticsParameter = {'Snackbar': 'Credits'};
            // Execute a function to send logEvent() to Firebase Analytics
            Analytics.analyticsLogEvent(
                AnalyticsEventType.snack_bar, _analyticsParameter);
          });
    }
    return Container();
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
            'Credit page for The TurboCharger app saga.',
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
            Text(
                AppLocalizations.of(context).translate('info_credits_0000')
                //'Credits',
                ,
                style: kAppBarTextStyle,
                textScaleFactor: textScaleFactorTc),
            Container(width: 30.0, child: submitRatingButton),
          ],
        ),
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ReusableCard(
                onPress: () {},
                colour: kActiveCardColourOutput,
                cardChild: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                                        SizedBox(height: 20),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      'info_credits_0010') // 'Special Thanks to:',
                                              ,
                                              style: kSecondSubjectTextStyle,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle_outline),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'info_credits_0020')
                                                  // 'All TurboCharger Tuning app users.',
                                                  ,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                ),
                                                // subtitle: Text('Max HP based on inducer size'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle_outline),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'info_credits_0030')
                                                  //  'All users who are filling in the feedback form in the "Info tab".',
                                                  ,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                ),
                                                // subtitle: Text('Max HP based on inducer size'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle_outline),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'info_credits_0040')
                                                      //  'Technology and math',
                                                      ,
                                                      style:
                                                          kSecondSubjectTextStyle,
                                                      textScaleFactor:
                                                          textScaleFactorTc,
                                                    ),
                                                    Text(
                                                      'Christian Eriksson, Jörgen Westling, Rasmus Lundström, Kaami Tondkar.',
                                                      textScaleFactor:
                                                          textScaleFactorTc,
                                                    ),
                                                  ],
                                                ),
                                                // subtitle: Text('Max HP based on inducer size'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle_outline),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'info_credits_0050') // 'Programming',
                                                      ,
                                                      style:
                                                          kSecondSubjectTextStyle,
                                                      textScaleFactor:
                                                          textScaleFactorTc,
                                                    ),
                                                    Text(
                                                      'Angie Yu at AppBrewery, Matt Rešetár at Reso Coder, Kamal at Whatsupcoders, Andrea Bizzotto at Code with Andrea, Andy Judlow, Julian Currie at Coding with Curry, Pawan Kumar at MtechViral.',
                                                      textScaleFactor:
                                                          textScaleFactorTc,
                                                    ),
                                                  ],
                                                ),

                                                // subtitle: Text('Max HP based on inducer size'),
                                              ),

                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle_outline),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'info_credits_0060')
                                                      // 'Communities and companies',
                                                      ,
                                                      style:
                                                          kSecondSubjectTextStyle,
                                                      textScaleFactor:
                                                          textScaleFactorTc,
                                                    ),
                                                    Text(
                                                      'Google development team, Apple development team, The Flutter team, The Dart team, The FireBase team, Intellij, JetBrains, VsCode team at Microsoft, Google Cloud Platform team, Googele ML team, All other Google services teams (You Tube, Analytics, Sites, Gmail, and more).',
                                                      textScaleFactor:
                                                          textScaleFactorTc,
                                                    ),
                                                  ],
                                                ),

                                                // subtitle: Text('Max HP based on inducer size'),
                                              ),

                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle_outline),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'info_credits_0070')
                                                      //'Books, web and info',
                                                      ,
                                                      style:
                                                          kSecondSubjectTextStyle,
                                                      textScaleFactor:
                                                          textScaleFactorTc,
                                                    ),
                                                    Text(
                                                      'TurboCharger Performance Handbook by Jeff Hartman at MotorBooks, Performance Automotive Engine Math by John Baechtel at CarTech, Garrett Motion website, Borg Warner website.',
                                                      textScaleFactor:
                                                          textScaleFactorTc,
                                                    ),
                                                  ],
                                                ),

                                                // subtitle: Text('Max HP based on inducer size'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle_outline),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'info_credits_0080')
                                                  //'All helpful guys/girls at various internet formus like: Sävarturbo STS-forum in Sweden and more.',
                                                  ,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                ),
                                                // subtitle: Text('Max HP based on inducer size'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle_outline),
                                                // trailing: Icon(Icons.keyboard_arrow_right),
                                                title: Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'info_credits_0090')
                                                  //'Supporting friends and family.',
                                                  ,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                ),
                                                // subtitle: Text('Max HP based on inducer size'),
                                              ),

                                              // subtitle: Text('Max HP based on inducer size'),

//                                              ListTile(
//                                                leading: Icon(
//                                                    Icons.check_circle_outline),
//                                                // trailing: Icon(Icons.keyboard_arrow_right),
//                                                title: Text(
//                                                    'The Flutter/Dart community'),
//                                                // subtitle: Text('Max HP based on inducer size'),
//                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('info_credits_0100')
                                          //'The TurboCharger app is developed by AOLI using Dart and FLutter, for Android and the iOS platforms. Copyright 2019-2020 AOLI',
                                          ,
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey,
                                          ),
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      //Exducer

                      //Exducer

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
