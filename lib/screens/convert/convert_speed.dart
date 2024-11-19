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


class SpeedPage extends StatefulWidget {
  @override
  _SpeedPageState createState() => _SpeedPageState();
}

class _SpeedPageState extends State<SpeedPage> {
  _SpeedPageState();

  //bool metricUnit = false;
  bool snackbarEnable = true;

  Widget get submitRatingButton {
    if (snackbarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState
                .showSnackBar(snackBar);

            // parameters
            var _analyticsParameter = {'Snackbar': 'Conv Speed'};
            // Execute a function to send logEvent() to Firebase Analytics
            Analytics.analyticsLogEvent(
                AnalyticsEventType.snack_bar, _analyticsParameter);
          });
    }
    return null;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
    content: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Speed conversions',
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textScaleFactor: textScaleFactorTc,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            kSnackBarDevelopmentInfo,
            style: kSnackBarTextStyle, textScaleFactor: textScaleFactorTc,
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

  CalculatorBrain calculate = CalculatorBrain();

  @override
  void initState() {
    super.initState();
    print('radioValue $radioValue');

    convertResultLengthInch = 1.0;
    convertResultLengthMillimeter = 25.4;

    convertResultTemperatureCelsius = 20.0;
    convertResultTemperatureFahrenheit = 68.0;

    resetValues();
    labelTextStyleResult0 = kLabelTextStyleActive;
    labelTextStyleResult1 = kLabelTextStyle;
    labelTextStyleResult2 = kLabelTextStyle;
    labelTextStyleResult3 = kLabelTextStyle;
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
            Text(AppLocalizations.of(context).translate('convert_speed_0000')
              //SPEED Conversion',
             , style: kAppBarTextStyle,
              textScaleFactor: textScaleFactorTc,
            ),
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
                          Text(
                            AppLocalizations.of(context).translate(
                                'convert_speed_0010') //'Speed',
                           , style: kSecondSubjectTextStyle,
                            textScaleFactor: textScaleFactorTc,
                          ),
// *********** DataTable ;
//
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
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          )),
                                      DataColumn(
                                          numeric: true,
                                          label: Text(
                                            '',
                                            style: kLabelTextStyleActive,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          )),
                                      DataColumn(
                                          numeric: true,
                                          label: Text(
                                            '',
                                            style: kLabelTextStyleActive,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          )),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_speed_0020')
                                          //  'Miles per hour',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultSpeedMilesPerHour
                                                .toStringAsFixed(1),
                                            style: kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitSpeedMph,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_speed_0030')
                                          // 'Kilometer per hour',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultSpeedKilometerPerHour
                                                .toStringAsFixed(1),
                                            style: kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitSpeedKmh,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_speed_0040')
                                          // 'Meter per second',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            (convertResultSpeedKilometerPerHour /
                                                3.6).toStringAsFixed(1),
                                            style: kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitSpeedMeterPerSecond,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_speed_0050')
                                          //  'Feet per second',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            (convertResultSpeedMilesPerHour *
                                                1.46666667)
                                                .toStringAsFixed(1),
                                            style: kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitSpeedFeetPerSecond,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_speed_0060')
                                          // 'Knots',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            (convertResultSpeedMilesPerHour *
                                                kConvertSpeedMilesPerHourToKnots)
                                                .toStringAsFixed(1),
                                            style: kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitKnots,
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
                    ],
                  ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                child: Text(convertSliderHeaderSpeedTextAll,
                                    style: kSecondSubjectTextStyle,
                                    textScaleFactor: textScaleFactorTc),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),

                          // Divider(), //Vikten (ton)

                          //Center(
                          // child: Image(
                          //   image: AssetImage('images/turbo_picture.jpg'),
                          // ),
                          //)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                    kMinSliderConvertSpeedAll
                                        .toStringAsFixed(0),
                                    style: TextStyle(color: Colors.white30),
                                    textScaleFactor: textScaleFactorTc),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Text(
                                  kMaxSliderConvertSpeedAll.toStringAsFixed(0),
                                  style: TextStyle(color: Colors.white30),
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                            ],
                          ),
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
                                value: convertSliderResultSpeedAll,
                                min: kMinSliderConvertSpeedAll * 0.99,
                                max: kMaxSliderConvertSpeedAll * 1.02,
                                label: convertSliderResultSpeedAll
                                    .toStringAsFixed(0),
                                inactiveColor: Color(0xFF8D8E89),
                                divisions: sliderSliderConvertSpeedAll,
                                onChanged: (double sliderValue) {
                                  convertSliderResultSpeedAll = sliderValue;
                                  debugPrint(
                                      'SLIDE convertSliderResultSpeedAll $convertSliderResultSpeedAll');
                                  debugPrint(
                                      'SLIDE convertResultTemperatureCelsius $convertResultTemperatureCelsius');

                                  calculateSpeed(
                                      convertSliderResultSpeedAll, radioValue);
                                }),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 0),
                                child: StepButton(
                                    icon: FontAwesomeIcons.minus,
                                    onStepPress: () {
                                      timer = Timer.periodic(
                                          Duration(milliseconds: tapTime), (t) {
                                        setState(() {
                                          if (Decimal.parse(
                                              convertSliderResultSpeedAll
                                                  .toStringAsFixed(0)) >
                                              Decimal.parse(
                                                  kMinSliderConvertSpeedAll
                                                      .toStringAsFixed(0))) {
                                            convertSliderResultSpeedAll =
                                                convertSliderResultSpeedAll -
                                                    stepSliderConvertSpeedAll;
                                            debugPrint(
                                                '- convertSliderResultSpeedAll $convertSliderResultSpeedAll');
                                            calculateSpeed(
                                                convertSliderResultSpeedAll,
                                                radioValue);
                                          }
                                        });
                                      });
                                    },
                                    onPressEnd: () {
                                      timer.cancel();
                                    },
                                    onStep: () {
                                      setState(() {
                                        if (Decimal.parse(
                                            convertSliderResultSpeedAll
                                                .toStringAsFixed(0)) >
                                            Decimal.parse(
                                                kMinSliderConvertSpeedAll
                                                    .toStringAsFixed(0))) {
                                          convertSliderResultSpeedAll =
                                              convertSliderResultSpeedAll -
                                                  stepSliderConvertSpeedAll;
                                          debugPrint(
                                              '- convertSliderResultSpeedAll $convertSliderResultSpeedAll');
                                          calculateSpeed(
                                              convertSliderResultSpeedAll,
                                              radioValue);
                                        }
                                      });
                                    }),
                              ),
                              Container(
                                width: kInputNumberBigWidth,
                                child: Text(
                                    convertSliderResultSpeedAll
                                        .toStringAsFixed(1),
                                    style: kResultNumberStyleWhite18_600,
                                    textScaleFactor: textScaleFactorTc),
                              ),
                              Container(
                                width: kInputUnitWidth,
                                child: Text(unitSliderConvertSpeedAll,
                                    style: kUnitTextStyleAirflow,
                                    textScaleFactor: textScaleFactorTc),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 0),
                                child: StepButton(
                                    icon: FontAwesomeIcons.plus,
                                    onStepPress: () {
                                      timer = Timer.periodic(
                                          Duration(milliseconds: tapTime), (t) {
                                        setState(() {
                                          if ((Decimal.parse(
                                              convertSliderResultSpeedAll
                                                  .toStringAsFixed(1)) <
                                              (Decimal.parse(
                                                  kMaxSliderConvertSpeedAll
                                                      .toStringAsFixed(1))))) {
                                            convertSliderResultSpeedAll =
                                                convertSliderResultSpeedAll +
                                                    stepSliderConvertSpeedAll;
                                            debugPrint(
                                                '+ convertSliderResultSpeedAll $convertSliderResultSpeedAll');
                                            calculateSpeed(
                                                convertSliderResultSpeedAll,
                                                radioValue);
                                          }
                                        });
                                      });
                                    },
                                    onPressEnd: () {
                                      timer.cancel();
                                    },
                                    onStep: () {
                                      setState(() {
                                        if ((Decimal.parse(
                                            convertSliderResultSpeedAll
                                                .toStringAsFixed(1)) <
                                            (Decimal.parse(
                                                kMaxSliderConvertSpeedAll
                                                    .toStringAsFixed(1))))) {
                                          convertSliderResultSpeedAll =
                                              convertSliderResultSpeedAll +
                                                  stepSliderConvertSpeedAll;
                                          debugPrint(
                                              '+ convertSliderResultSpeedAll $convertSliderResultSpeedAll');
                                          calculateSpeed(
                                              convertSliderResultSpeedAll,
                                              radioValue);
                                        }
                                      });
                                    }),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Radio<int>(
                                    value: 0,
                                    groupValue: radioValue,
                                    activeColor: Colors.white,
                                    onChanged: handleRadioValueChanged,
                                  ),
                                  Text(AppLocalizations.of(context).translate(
                                      'convert_speed_0070') //'Miles Per Hour',
                                     , style: kUnitTextStyleAirflow,
                                      textScaleFactor: textScaleFactorTc),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Radio<int>(
                                    value: 1,
                                    groupValue: radioValue,
                                    activeColor: Colors.white,
                                    onChanged: handleRadioValueChanged,
                                  ),
                                  Text(AppLocalizations.of(context).translate(
                                      'convert_speed_0080')
                                      //'Kilometer Per Hour',
                                     , style: kUnitTextStyleAirflow,
                                      textScaleFactor: textScaleFactorTc),
                                ],
                              ),
                            ],
                          )
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

  int radioValue = 0;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      resetValues();

      switch (radioValue) {
        case 0:
          print('0 convertSliderResultSpeedAll $convertSliderResultSpeedAll');
          print('0 kMinSliderConvertSpeedAll $kMinSliderConvertSpeedAll');
          print('0 kMaxSliderConvertSpeedAll $kMaxSliderConvertSpeedAll');
          print('0 convertSliderResultSpeedAll $convertSliderResultSpeedAll');
          print('0 sliderSliderConvertSpeedAll $sliderSliderConvertSpeedAll');
          print('0 stepSliderConvertSpeedAll $stepSliderConvertSpeedAll');
          print('0 kMaxConvertSpeedMilesPerHour $kMaxConvertSpeedMilesPerHour');
          print(
              '0 kMaxConvertSpeedKilometerPerHour $kMaxConvertSpeedKilometerPerHour');
          // if(convertResultSpeedMilesPerHour>kMaxSliderConvertSpeedAll){
          //   convertResultSpeedMilesPerHour = kMaxSliderConvertSpeedAll;
          // }
          labelTextStyleResult0 = kLabelTextStyleActive;
          labelTextStyleResult1 = kLabelTextStyle;
          labelTextStyleResult2 = kLabelTextStyle;
          labelTextStyleResult3 = kLabelTextStyle;

          convertSliderHeaderSpeedTextAll = 'Miles Per Hour';
          unitSliderConvertSpeedAll = unitSpeedMph;
          convertSliderResultSpeedAll = kResetValueMilesPerHour;
          kMinSliderConvertSpeedAll = kMinConvertSpeedMilesPerHour;
          kMaxSliderConvertSpeedAll = kMaxConvertSpeedMilesPerHour;
          sliderSliderConvertSpeedAll = sliderConvertSpeedMilesPerHour;
          stepSliderConvertSpeedAll = stepValueConvertSpeedMilesPerHour;

          break;

        case 1:
          labelTextStyleResult0 = kLabelTextStyle;
          labelTextStyleResult1 = kLabelTextStyleActive;
          labelTextStyleResult2 = kLabelTextStyle;
          labelTextStyleResult3 = kLabelTextStyle;
          print('1 convertSliderResultSpeedAll $convertSliderResultSpeedAll');
          print('1 kMinSliderConvertSpeedAll $kMinSliderConvertSpeedAll');
          print('1 kMaxSliderConvertSpeedAll $kMaxSliderConvertSpeedAll');
          print('1 convertSliderResultSpeedAll $convertSliderResultSpeedAll');
          print(
              '1 convertResultSpeedKilometerPerHour $convertResultSpeedKilometerPerHour');

          print('1 sliderSliderConvertSpeedAll $sliderSliderConvertSpeedAll');
          print('1 stepSliderConvertSpeedAll $stepSliderConvertSpeedAll');
          print('1 kMaxConvertSpeedMilesPerHour $kMaxConvertSpeedMilesPerHour');
          print(
              '1 kMaxConvertSpeedKilometerPerHour $kMaxConvertSpeedKilometerPerHour');
          // if(convertResultSpeedKilogram>kMaxSliderConvertSpeedAll){
          //   convertResultSpeedKilogram = kMaxSliderConvertSpeedAll;
          // }
          convertSliderHeaderSpeedTextAll = 'Kilometer Per Hour';
          unitSliderConvertSpeedAll = unitSpeedKmh;
          convertSliderResultSpeedAll = kResetValueKilometerPerHour;
          kMinSliderConvertSpeedAll = kMinConvertSpeedKilometerPerHour;
          kMaxSliderConvertSpeedAll = kMaxConvertSpeedKilometerPerHour;
          sliderSliderConvertSpeedAll = sliderConvertSpeedKilometerPerHour;
          stepSliderConvertSpeedAll = stepValueConvertSpeedKilometerPerHour;
          break;
      }
      print('radioValue $radioValue');
    });
  }

  calculateSpeed(double convertSliderResultSpeedAll, int radioValue) {
    setState(() {
      switch (radioValue) {
        case 0:
          convertResultSpeedMilesPerHour = convertSliderResultSpeedAll;
          convertResultSpeedKilometerPerHour = calculate.conversionCalc(
              convertSliderResultSpeedAll,
              'SpeedMilesPerHourToKilometerPerHour');

          break;

        case 1:
          print(
              'innan calbrain convertResultSpeedKilometerPerHour: $convertResultSpeedKilometerPerHour');
          print(
              'innan calbrain convertSliderResultSpeedAll: $convertSliderResultSpeedAll');
          convertResultSpeedKilometerPerHour = convertSliderResultSpeedAll;
          convertResultSpeedMilesPerHour = calculate.conversionCalc(
              convertSliderResultSpeedAll,
              'SpeedKilometerPerHourToMilesPerHour');
          // convertResultSpeedMilesPerHour = 10.0;
          print(
              'efter calcbrain convertResultSpeedMilesPerHour: $convertResultSpeedMilesPerHour');

          break;
      }
    });
  }

  void resetValues() {
    setState(() {
      //radioValue = 0;
      kMinSliderConvertSpeedAll = kMinConvertSpeedMilesPerHour;
      kMaxSliderConvertSpeedAll = kMaxConvertSpeedMilesPerHour;
      stepSliderConvertSpeedAll = stepValueConvertSpeedMilesPerHour;
      sliderSliderConvertSpeedAll = sliderConvertSpeedMilesPerHour;
      convertResultSpeedKilometerPerHour = kResetValueKilometerPerHour;
      convertResultSpeedMilesPerHour = kResetValueMilesPerHour;
      convertSliderResultSpeedAll = kResetValueMilesPerHour;
      unitSliderConvertSpeedAll = unitSpeedMph;
      calculateSpeed(convertSliderResultSpeedAll, 0);
    });
  }
}
