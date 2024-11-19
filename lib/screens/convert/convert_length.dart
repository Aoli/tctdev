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


class InchAndMillimeterPage extends StatefulWidget {
  @override
  _InchAndMillimeterPageState createState() => _InchAndMillimeterPageState();
}

class _InchAndMillimeterPageState extends State<InchAndMillimeterPage> {
  _InchAndMillimeterPageState();

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
            'Inch and mm',
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

    convertResultPressurePsi = 14.5;
    convertResultPressureAtmosphere = 0.98692;
    convertResultPressureKiloPascal = 100.0;
    convertResultPressureBar = 1.0;

    convertResultLengthInch = 1.0;
    convertResultLengthMillimeter = 25.4;
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
            Text(AppLocalizations.of(context).translate('convert_length_0000')
                //'LENGTH Conversion',
                , style: kAppBarTextStyle, textScaleFactor: textScaleFactorTc),
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
                              'convert_length_0010') //'Length',
                              , style: kSecondSubjectTextStyle,
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
                                              .translate('convert_length_0020')
                                          // 'Inch',
                                          , style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultLengthInch
                                                .toStringAsFixed(2),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitLengthInch,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_length_0030')
                                          // 'Feet',
                                          , style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Opacity(opacity: 0.7,
                                            child: Text(
                                              (convertResultLengthInch / 12)
                                                  .toStringAsFixed(3),
                                              style:
                                              kResultNumberStyleWhite18_600,
                                              textScaleFactor: textScaleFactorTc,
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
                                          AppLocalizations.of(context)
                                              .translate('convert_length_0040')
                                          // 'Yard',
                                          , style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Opacity(opacity: 0.7,
                                            child: Text(
                                              (convertResultLengthInch / 36)
                                                  .toStringAsFixed(3),
                                              style:
                                              kResultNumberStyleWhite18_600,
                                              textScaleFactor: textScaleFactorTc,
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
                                              .translate('convert_length_0050')
                                          //'Millimeter',
                                          , style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultLengthMillimeter
                                                .toStringAsFixed(2),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitLengthMillimeter,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_length_0060')
                                          //'Centimeter',
                                          , style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Opacity(opacity: 0.7,
                                            child: Text(
                                              (convertResultLengthMillimeter /
                                                  10)
                                                  .toStringAsFixed(3),
                                              style:
                                              kResultNumberStyleWhite18_600,
                                              textScaleFactor: textScaleFactorTc,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitLengthCentimeter,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_length_0070')
                                          // 'Meter',
                                         , style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Opacity(opacity: 0.7,
                                            child: Text(
                                              (convertResultLengthMillimeter /
                                                  1000)
                                                  .toStringAsFixed(5),
                                              style:
                                              kResultNumberStyleWhite18_600,
                                              textScaleFactor: textScaleFactorTc,
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
                          child: Opacity(opacity: 0.6,
                            child: Text(AppLocalizations.of(context).translate(
                                'convert_length_0080') //'Reset',
                              ,  style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc * 0.8),
                          ),
                          onPressed: () {
                            setState(() {
                              convertResultLengthMillimeter = 2.54;
                              convertResultLengthInch = 0.10;
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
                        'convert_length_0090') //'Inch',
                       , style: kSecondSubjectTextStyle,
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
                          value: convertResultLengthInch,
                          min: kMinLengthInch,
                          max: kMaxLengthInch,
                          label: convertResultLengthInch.toStringAsFixed(2),
                          inactiveColor: Color(0xFF8D8E89),
                          divisions: sliderDivisionsLengthInch,
                          onChanged: (double sliderValue) {
                            convertResultLengthInch = sliderValue;
                            debugPrint(
                                'SLIDE convertResultLengthInch $convertResultLengthInch');
                            debugPrint(
                                'SLIDE convertResultLengthMillimeter $convertResultLengthMillimeter');

                            calculateMillimeter(convertResultLengthInch);
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
                                    var kMinLengthInchTemp =
                                        kMinLengthInch + sliderLimitLength;
                                    if (convertResultLengthInch >
                                        kMinLengthInchTemp &&
                                        convertResultLengthMillimeter >
                                            kMinLengthMillimeter) {
                                      convertResultLengthInch =
                                          convertResultLengthInch -
                                              stepValueLengthInch;
                                      debugPrint(
                                          '- convertResultLengthInch $convertResultLengthInch');
                                      calculateMillimeter(
                                          convertResultLengthInch);
                                    }
                                  });
                                });
                              },
                              onPressEnd: () {
                                timer.cancel();
                              },
                              onStep: () {
                                setState(() {
                                  var kMinLengthInchTemp =
                                      kMinLengthInch + sliderLimitLength;
                                  if (convertResultLengthInch >
                                      kMinLengthInchTemp &&
                                      convertResultLengthMillimeter >
                                          kMinLengthMillimeter) {
                                    convertResultLengthInch =
                                        convertResultLengthInch -
                                            stepValueLengthInch;
                                    debugPrint(
                                        '- convertResultLengthInch $convertResultLengthInch');
                                    calculateMillimeter(
                                        convertResultLengthInch);
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
                                    var kMaxLengthInchTemp =
                                        kMaxLengthInch - sliderLimitLength;
                                    if (convertResultLengthInch <
                                        kMaxLengthInchTemp &&
                                        convertResultLengthMillimeter <
                                            kMaxLengthMillimeter) {
                                      convertResultLengthInch =
                                          convertResultLengthInch +
                                              stepValueLengthInch;
                                      debugPrint(
                                          '+ convertResultLengthInch $convertResultLengthInch');
                                      calculateMillimeter(
                                          convertResultLengthInch);
                                    }
                                  });
                                });
                              },
                              onPressEnd: () {
                                timer.cancel();
                              },
                              onStep: () {
                                setState(() {
                                  var kMaxLengthInchTemp =
                                      kMaxLengthInch - sliderLimitLength;
                                  if (convertResultLengthInch <
                                      kMaxLengthInchTemp &&
                                      convertResultLengthMillimeter <
                                          kMaxLengthMillimeter) {
                                    convertResultLengthInch =
                                        convertResultLengthInch +
                                            stepValueLengthInch;
                                    debugPrint(
                                        '+ convertResultLengthInch $convertResultLengthInch');
                                    calculateMillimeter(
                                        convertResultLengthInch);
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
                              'convert_length_0100') //'Millimeter',
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
                                value: convertResultLengthMillimeter,
                                min: kMinLengthMillimeter,
                                max: kMaxLengthMillimeter,
                                label: convertResultLengthMillimeter
                                    .toStringAsFixed(2),
                                inactiveColor: Color(0xFF8D8E89),
                                divisions: sliderDivisionsLengthMillimeter,
                                onChanged: (double sliderValue) {
                                  convertResultLengthMillimeter = sliderValue;
                                  debugPrint(
                                      'SLIDE convertResultLengthMillimeter $convertResultLengthMillimeter');
                                  debugPrint(
                                      'SLIDE convertResultLengthInch $convertResultLengthInch');

                                  calculateInch(convertResultLengthMillimeter);
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
                                          var kMinLengthMillimeterTemp =
                                              kMinLengthMillimeter +
                                                  sliderLimitLength;
                                          if (convertResultLengthMillimeter >
                                              kMinLengthMillimeterTemp &&
                                              convertResultLengthInch >
                                                  kMinLengthInch) {
                                            convertResultLengthMillimeter =
                                                convertResultLengthMillimeter -
                                                    stepValueLengthMillimeter;
                                            debugPrint(
                                                '- convertResultLengthMillimeter $convertResultLengthMillimeter');

                                            calculateInch(
                                                convertResultLengthMillimeter);
                                          }
                                        });
                                      });
                                    },
                                    onPressEnd: () {
                                      timer.cancel();
                                    },
                                    onStep: () {
                                      setState(() {
                                        var kMinLengthMillimeterTemp =
                                            kMinLengthMillimeter +
                                                sliderLimitLength;
                                        if (convertResultLengthMillimeter >
                                            kMinLengthMillimeterTemp &&
                                            convertResultLengthInch >
                                                kMinLengthInch) {
                                          convertResultLengthMillimeter =
                                              convertResultLengthMillimeter -
                                                  stepValueLengthMillimeter;
                                          debugPrint(
                                              '- convertResultLengthMillimeter $convertResultLengthMillimeter');

                                          calculateInch(
                                              convertResultLengthMillimeter);
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
                                          var kMaxLengthMillimeterTemp =
                                              kMaxLengthMillimeter -
                                                  sliderLimitLength;
                                          if (convertResultLengthMillimeter <
                                              kMaxLengthMillimeterTemp &&
                                              convertResultLengthInch <
                                                  kMaxLengthInch) {
                                            convertResultLengthMillimeter =
                                                convertResultLengthMillimeter +
                                                    stepValueLengthMillimeter;
                                            debugPrint(
                                                '+ convertResultLengthMillimeter $convertResultLengthMillimeter');

                                            calculateInch(
                                                convertResultLengthMillimeter);
                                          }
                                        });
                                      });
                                    },
                                    onPressEnd: () {
                                      timer.cancel();
                                    },
                                    onStep: () {
                                      setState(() {
                                        var kMaxLengthMillimeterTemp =
                                            kMaxLengthMillimeter -
                                                sliderLimitLength;
                                        if (convertResultLengthMillimeter <
                                            kMaxLengthMillimeterTemp &&
                                            convertResultLengthInch <
                                                kMaxLengthInch) {
                                          convertResultLengthMillimeter =
                                              convertResultLengthMillimeter +
                                                  stepValueLengthMillimeter;
                                          debugPrint(
                                              '+ convertResultLengthMillimeter $convertResultLengthMillimeter');

                                          calculateInch(
                                              convertResultLengthMillimeter);
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

  calculateMillimeter(double convertResultLengthInch) {
    setState(() {
      convertResultLengthMillimeter = calculate.conversionCalc(
          convertResultLengthInch, 'LengthInchToMillimeter');
    });
  }

  calculateInch(double convertResultLengthMillimeter) {
    setState(() {
      convertResultLengthInch = calculate.conversionCalc(
          convertResultLengthMillimeter, 'LengthMillimeterToInch');
    });
  }
}
