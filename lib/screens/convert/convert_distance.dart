import 'dart:async';
import 'package:Turbocharger/components/analytics_event.dart';
import 'package:Turbocharger/data_models/analytics_event_type.dart';
import 'package:Turbocharger/components/stepbutton.dart';
import 'package:Turbocharger/globals/app_localizations.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../globals/calculator_brain.dart';
import '../../components/reusable_card.dart';
import '../../globals/constant.dart';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:Turbocharger/globals/constants_ui.dart';

class ConvertDistancePage extends StatefulWidget {
  @override
  _ConvertDistancePageState createState() => _ConvertDistancePageState();
}

class _ConvertDistancePageState extends State<ConvertDistancePage> {
  _ConvertDistancePageState();

  //bool metricUnit = false;
  bool snackbarEnable = true;
  int sliderLimitLength = 5;

  Widget get submitRatingButton {
    if (snackbarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState.showSnackBar(snackBar);

            // parameters
            var _analyticsParameter = {'Snackbar': 'Conv Length'};
            // Execute a function to send logEvent() to Firebase Analytics
            Analytics.analyticsLogEvent(
                AnalyticsEventType.snack_bar, _analyticsParameter);
          });
    }
    return null;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
    content: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Convert Distances',
            style: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textScaleFactor: textScaleFactorTc,
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

  CalculatorBrain calculate = CalculatorBrain();

  @override
  void initState() {
    super.initState();

    convertResultDistanceMiles = 1.0;
    convertResultDistanceKilometer = 25.4;
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                AppLocalizations.of(context).translate('convert_distance_0000')
                //'Distance Conversion',
                ,style: kAppBarTextStyle,
                textScaleFactor: textScaleFactorTc),
            Container(width: 30.0, child: submitRatingButton),
          ],
        ),
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // ETA
              ReusableCard(
                colour: kActiveCardColourOutput,
                cardChild: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(AppLocalizations.of(context).translate(
                              'convert_distance_0010') //'Distance',
                              ,style: kSecondSubjectTextStyle,
                              textScaleFactor: textScaleFactorTc),
                          Center(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  dividerColor: kActiveCardColourOutput),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DataTable(
                                    horizontalMargin: 0,
                                    headingRowHeight: 0,
                                    columnSpacing: 30,
                                    dataRowHeight: tableRowHeight,
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                            '',
                                            style: kLabelTextStyleActive,
                                            textScaleFactor: textScaleFactorTc,
                                          )),
                                      DataColumn(
                                          numeric: true,
                                          label: Text(
                                            '',
                                            style: kLabelTextStyleActive,
                                            textScaleFactor: textScaleFactorTc,
                                          )),
                                      DataColumn(
                                          numeric: true,
                                          label: Text(
                                            '',
                                            style: kLabelTextStyleActive,
                                            textScaleFactor: textScaleFactorTc,
                                          )),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'convert_distance_0020')
                                          //'Miles',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultDistanceMiles
                                                .toStringAsFixed(2),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitLengthMile,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'convert_distance_0030')
                                          // 'Yard',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Opacity(
                                            opacity: 0.7,
                                            child: Text(
                                              (convertResultDistanceMiles *
                                                  kConvertDistanceMileToYard)
                                                  .toStringAsFixed(0),
                                              style:
                                              kResultNumberStyleWhite18_600,
                                              textScaleFactor:
                                              textScaleFactorTc,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitLengthYard,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'convert_distance_0040') //'Feet',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Opacity(
                                            opacity: 0.7,
                                            child: Text(
                                              (convertResultDistanceMiles *
                                                  kConvertDistanceMileToFoot)
                                                  .toStringAsFixed(0),
                                              style:
                                              kResultNumberStyleWhite18_600,
                                              textScaleFactor:
                                              textScaleFactorTc,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitLengthFeet,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          '',
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            '',
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '',
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'convert_distance_0050')
                                          //'Kilometer',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultDistanceKilometer
                                                .toStringAsFixed(2),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitLengthKilometer,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'convert_distance_0060')
                                          //  'Meter',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Opacity(
                                            opacity: 0.7,
                                            child: Text(
                                              (convertResultDistanceKilometer *
                                                  1000)
                                                  .toStringAsFixed(0),
                                              style:
                                              kResultNumberStyleWhite18_600,
                                              textScaleFactor:
                                              textScaleFactorTc,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitLengthMeter,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'convert_distance_0070')
                                          //'Nautical Miles',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Opacity(
                                            opacity: 0.7,
                                            child: Text(
                                              (convertResultDistanceKilometer *
                                                  kConvertDistanceKilometerToNauticalMile)
                                                  .toStringAsFixed(2),
                                              style:
                                              kResultNumberStyleWhite18_600,
                                              textScaleFactor:
                                              textScaleFactorTc,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitNauticalMile,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: FlatButton(
                          // color: Colors.blueGrey,
                          splashColor: Color(0xFF4c8c4a),
                          //textColor: Colors.white38,
                          child: Opacity(
                            opacity: 0.6,
                            child: Text(AppLocalizations.of(context).translate(
                                'convert_distance_0080') //'Reset',
                               , style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc * 0.8),
                          ),
                          onPressed: () {
                            setState(() {
                              convertResultDistanceKilometer = 2.54;
                              convertResultDistanceMiles = 0.10;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ReusableCard(
                //Compressor side Inducer *****************************
                colour: kActiveCardColourInput,
                cardChild: Column(
                  children: <Widget>[
                    Text(AppLocalizations.of(context).translate(
                        'convert_distance_0090') //'Miles',
                        ,style: kSecondSubjectTextStyle,
                        textScaleFactor: textScaleFactorTc),
                    SizedBox(height: 20.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[],
                    ),

                    // Divider(), //Vikten (ton)

                    //Center(
                    // child: Image(
                    //   image: AssetImage('images/turbo_picture.jpg'),
                    // ),
                    //)

                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        thumbColor: kConversionSliderNob,
                        overlayColor: kConversionSliderOverlayColor,
                        valueIndicatorColor: kConversionSliderLabelColor,
                        inactiveTrackColor: kInactiveSlideColour,
                        thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: kNobThumbShapeLarge),
                        overlayShape: RoundSliderOverlayShape(
                            overlayRadius: kNobOverlayShapeLarge),
                      ),
                      child: Slider(
                          value: convertResultDistanceMiles,
                          min: kMinDistanceMiles,
                          max: kMaxDistanceMiles,
                          label: convertResultDistanceMiles.toStringAsFixed(2),
                          inactiveColor: Color(0xFF8D8E89),
                          divisions: sliderDivisionsDistanceMiles,
                          onChanged: (double sliderValue) {
                            convertResultDistanceMiles = sliderValue;
                            debugPrint(
                                'SLIDE convertResultDistanceMiles $convertResultDistanceMiles');
                            debugPrint(
                                'SLIDE convertResultDistanceKilometer $convertResultDistanceKilometer');

                            calculateMilesToKilometer(
                                convertResultDistanceMiles);
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: StepButton(
                              icon: FontAwesomeIcons.minus,
                              onStepPress: () {
                                timer = Timer.periodic(
                                    Duration(milliseconds: tapTime), (t) {
                                  setState(() {
                                    var kMinDistanceMilesTemp =
                                        kMinDistanceMiles + sliderLimitLength;
                                    if (convertResultDistanceMiles >
                                        kMinDistanceMilesTemp &&
                                        convertResultDistanceKilometer >
                                            kMinDistanceKilometer) {
                                      convertResultDistanceMiles =
                                          convertResultDistanceMiles -
                                              stepValueDistanceMiles;
                                      debugPrint(
                                          '- convertResultDistanceMiles $convertResultDistanceMiles');
                                      calculateMilesToKilometer(
                                          convertResultDistanceMiles);
                                    }
                                  });
                                });
                              },
                              onPressEnd: () {
                                timer.cancel();
                              },
                              onStep: () {
                                setState(() {
                                  var kMinDistanceMilesTemp =
                                      kMinDistanceMiles + sliderLimitLength;
                                  if (convertResultDistanceMiles >
                                      kMinDistanceMilesTemp &&
                                      convertResultDistanceKilometer >
                                          kMinDistanceKilometer) {
                                    convertResultDistanceMiles =
                                        convertResultDistanceMiles -
                                            stepValueDistanceMiles;
                                    debugPrint(
                                        '- convertResultDistanceMiles $convertResultDistanceMiles');
                                    calculateMilesToKilometer(
                                        convertResultDistanceMiles);
                                  }
                                });
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: StepButton(
                              icon: FontAwesomeIcons.plus,
                              onStepPress: () {
                                timer = Timer.periodic(
                                    Duration(milliseconds: tapTime), (t) {
                                  setState(() {
                                    var kMaxDistanceMilesTemp =
                                        kMaxDistanceMiles - sliderLimitLength;
                                    if (convertResultDistanceMiles <
                                        kMaxDistanceMilesTemp &&
                                        convertResultDistanceKilometer <
                                            kMaxDistanceKilometer) {
                                      convertResultDistanceMiles =
                                          convertResultDistanceMiles +
                                              stepValueDistanceMiles;
                                      debugPrint(
                                          '+ convertResultDistanceMiles $convertResultDistanceMiles');
                                      calculateMilesToKilometer(
                                          convertResultDistanceMiles);
                                    }
                                  });
                                });
                              },
                              onPressEnd: () {
                                timer.cancel();
                              },
                              onStep: () {
                                setState(() {
                                  var kMaxDistanceMilesTemp =
                                      kMaxDistanceMiles - sliderLimitLength;
                                  if (convertResultDistanceMiles <
                                      kMaxDistanceMilesTemp &&
                                      convertResultDistanceKilometer <
                                          kMaxDistanceKilometer) {
                                    convertResultDistanceMiles =
                                        convertResultDistanceMiles +
                                            stepValueDistanceMiles;
                                    debugPrint(
                                        '+ convertResultDistanceMiles $convertResultDistanceMiles');
                                    calculateMilesToKilometer(
                                        convertResultDistanceMiles);
                                  }
                                });
                              }),
                        ),
                      ],
                    ), //PSI slider
                    // Divider(),
                  ],
                ),
              ),
              ReusableCard(
                //Compressor side Inducer *****************************
                colour: kActiveCardColourInput,
                cardChild: Column(
                  children: <Widget>[
                    //length Feet
                    //Text('Change', style: kChangeStyle),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(AppLocalizations.of(context).translate(
                              'convert_distance_0100') //'Kilometer',
                             , style: kSecondSubjectTextStyle,
                              textScaleFactor: textScaleFactorTc),
                          SizedBox(height: 20.0),

                          //Center(
                          // child: Image(
                          //   image: AssetImage('images/turbo_picture.jpg'),
                          // ),
                          //)

                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.white,
                              thumbColor: kConversionSliderNob,
                              overlayColor: kConversionSliderOverlayColor,
                              valueIndicatorColor: kConversionSliderLabelColor,
                              inactiveTrackColor: kInactiveSlideColour,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: kNobThumbShapeLarge),
                              overlayShape: RoundSliderOverlayShape(
                                  overlayRadius: kNobOverlayShapeLarge),
                            ),
                            child: Slider(
                                value: convertResultDistanceKilometer,
                                min: kMinDistanceKilometer,
                                max: kMaxDistanceKilometer,
                                label: convertResultDistanceKilometer
                                    .toStringAsFixed(2),
                                inactiveColor: Color(0xFF8D8E89),
                                divisions: sliderDivisionsDistanceKilometer,
                                onChanged: (double sliderValue) {
                                  convertResultDistanceKilometer = sliderValue;
                                  debugPrint(
                                      'SLIDE convertResultDistanceKilometer $convertResultDistanceKilometer');
                                  debugPrint(
                                      'SLIDE convertResultDistanceMiles $convertResultDistanceMiles');

                                  calculateKilometerToMiles(
                                      convertResultDistanceKilometer);
                                }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: StepButton(
                                    icon: FontAwesomeIcons.minus,
                                    onStepPress: () {
                                      timer = Timer.periodic(
                                          Duration(milliseconds: tapTime), (t) {
                                        setState(() {
                                          var kMinDistanceKilometerTemp =
                                              kMinDistanceKilometer +
                                                  sliderLimitLength;
                                          if (convertResultDistanceKilometer >
                                              kMinDistanceKilometerTemp &&
                                              convertResultDistanceMiles >
                                                  kMinDistanceMiles) {
                                            convertResultDistanceKilometer =
                                                convertResultDistanceKilometer -
                                                    stepValueDistanceKilometer;
                                            debugPrint(
                                                '- convertResultDistanceKilometer $convertResultDistanceKilometer');

                                            calculateKilometerToMiles(
                                                convertResultDistanceKilometer);
                                          }
                                        });
                                      });
                                    },
                                    onPressEnd: () {
                                      timer.cancel();
                                    },
                                    onStep: () {
                                      setState(() {
                                        var kMinDistanceKilometerTemp =
                                            kMinDistanceKilometer +
                                                sliderLimitLength;
                                        if (convertResultDistanceKilometer >
                                            kMinDistanceKilometerTemp &&
                                            convertResultDistanceMiles >
                                                kMinDistanceMiles) {
                                          convertResultDistanceKilometer =
                                              convertResultDistanceKilometer -
                                                  stepValueDistanceKilometer;
                                          debugPrint(
                                              '- convertResultDistanceKilometer $convertResultDistanceKilometer');

                                          calculateKilometerToMiles(
                                              convertResultDistanceKilometer);
                                        }
                                      });
                                    }),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: StepButton(
                                    icon: FontAwesomeIcons.plus,
                                    onStepPress: () {
                                      timer = Timer.periodic(
                                          Duration(milliseconds: tapTime), (t) {
                                        setState(() {
                                          var kMaxDistanceKilometerTemp =
                                              kMaxDistanceKilometer -
                                                  sliderLimitLength;
                                          if (convertResultDistanceKilometer <
                                              kMaxDistanceKilometerTemp &&
                                              convertResultDistanceMiles <
                                                  kMaxDistanceMiles) {
                                            convertResultDistanceKilometer =
                                                convertResultDistanceKilometer +
                                                    stepValueDistanceKilometer;
                                            debugPrint(
                                                '+ convertResultDistanceKilometer $convertResultDistanceKilometer');

                                            calculateKilometerToMiles(
                                                convertResultDistanceKilometer);
                                          }
                                        });
                                      });
                                    },
                                    onPressEnd: () {
                                      timer.cancel();
                                    },
                                    onStep: () {
                                      setState(() {
                                        var kMaxDistanceKilometerTemp =
                                            kMaxDistanceKilometer -
                                                sliderLimitLength;
                                        if (convertResultDistanceKilometer <
                                            kMaxDistanceKilometerTemp &&
                                            convertResultDistanceMiles <
                                                kMaxDistanceMiles) {
                                          convertResultDistanceKilometer =
                                              convertResultDistanceKilometer +
                                                  stepValueDistanceKilometer;
                                          debugPrint(
                                              '+ convertResultDistanceKilometer $convertResultDistanceKilometer');

                                          calculateKilometerToMiles(
                                              convertResultDistanceKilometer);
                                        }
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ), //PSI slider
                    // Divider(),
                  ],
                ),
              ),
              // Speed

              // Kilometer
              // Mile

              //Fuel (Hp)
            ],
          ),
        );
      }),
    );
  }

  calculateKilometerToMiles(double convertResultDistanceKilometer) {
    setState(() {
      convertResultDistanceMiles = calculate.conversionCalc(
          convertResultDistanceKilometer, 'DistanceKilometerToMile');
    });
  }

  calculateMilesToKilometer(double convertResultDistanceMiles) {
    setState(() {
      convertResultDistanceKilometer = calculate.conversionCalc(
          convertResultDistanceMiles, 'DistanceMileToKm');
    });
  }
}
