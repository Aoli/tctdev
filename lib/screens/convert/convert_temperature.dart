import 'dart:async';
import 'package:tct/components/analytics_event.dart';
import 'package:tct/data_models/analytics_event_type.dart';
import 'package:tct/components/stepbutton.dart';
import 'package:tct/globals/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../globals/calculator_brain.dart';
import '../../components/reusable_card.dart';
import '../../globals/constant.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:tct/globals/constants_ui.dart';

class CelsiusToFahrenheitPage extends StatefulWidget {
  @override
  _CelsiusToFahrenheitPageState createState() =>
      _CelsiusToFahrenheitPageState();
}

class _CelsiusToFahrenheitPageState extends State<CelsiusToFahrenheitPage> {
  _CelsiusToFahrenheitPageState();

  //bool metricUnit = false;
  bool snackbarEnable = true;
  int sliderLimit = 1;

  Widget get submitRatingButton {
    if (snackbarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            // parameters
            var _analyticsParameter = {'Snackbar': 'Conv Temperature'};
            // Execute a function to send logEvent() to Firebase Analytics
            Analytics.analyticsLogEvent(
                AnalyticsEventType.snack_bar, _analyticsParameter);
          });
    }
    return Container();
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
            'Celsius and Fahrenheit',
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

  CalculatorBrain calculate = CalculatorBrain(
    compressorInducerSize: 0.0,
    compressorExducerSize: 0.0,
    turbineInducerSize: 0.0,
    turbineExducerSize: 0.0,
  );

  @override
  void initState() {
    super.initState();

    convertResultLengthInch = 1.0;
    convertResultLengthMillimeter = 25.4;

    convertResultTemperatureCelsius = 20.0;
    convertResultTemperatureFahrenheit = 68.0;
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
                AppLocalizations.of(context).translate(
                    'convert_temperature_0000') //'TEMPERATURE Conversion',
                ,
                style: kAppBarTextStyle,
                textScaleFactor: textScaleFactorTc - 0.1),
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
                onPress: () => {},
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
                                  'convert_temperature_0010') //'Temperature',
                              ,
                              style: kSecondSubjectTextStyle,
                              textScaleFactor: textScaleFactorTc),
                          Center(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  dividerColor: kActiveCardColourOutput),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DataTable(
                                    horizontalMargin: 0,
                                    headingRowHeight: 25,
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
                                                  'convert_temperature_0020')
                                          // 'Fahrenheit',
                                          ,
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultTemperatureFahrenheit
                                                .toStringAsFixed(1),
                                            style:
                                                kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitFahrenheit,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'convert_temperature_0030')
                                          // 'Celsius',
                                          ,
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultTemperatureCelsius
                                                .toStringAsFixed(2),
                                            style:
                                                kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitCelsius,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'convert_temperature_0040')
                                          //'Kelvin',
                                          ,
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            (convertResultTemperatureCelsius +
                                                    274.15)
                                                .toStringAsFixed(1),
                                            style:
                                                kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitKelvin,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'convert_temperature_0050')
                                          // 'Rankine',
                                          ,
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            (convertResultTemperatureFahrenheit +
                                                    458.67)
                                                .toStringAsFixed(1),
                                            style:
                                                kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitRankine,
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
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white38,
                            splashFactory: InkRipple.splashFactory,
                          ),
                          child: Text(
                              AppLocalizations.of(context).translate(
                                  'convert_temperature_0060'), //'Reset',
                              style: kLabelTextStyle,
                              textScaleFactor: textScaleFactorTc * 0.8),
                          onPressed: () {
                            setState(() {
                              convertResultTemperatureCelsius = 20.0;
                              convertResultTemperatureFahrenheit = 68.0;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ReusableCard(
                onPress: () => {},
                //Compressor side Inducer *****************************
                colour: kActiveCardColourInput,
                cardChild: Column(
                  children: <Widget>[
                    //length Feet
                    //Text('Change', style: kChangeStyle),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                              AppLocalizations.of(context).translate(
                                  'convert_temperature_0070') //'Fahrenheit',
                              ,
                              style: kSecondSubjectTextStyle,
                              textScaleFactor: textScaleFactorTc),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 80,
                                alignment: Alignment.center,
                                // color: Colors.red.shade800,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        convertResultTemperatureFahrenheit
                                            .toStringAsFixed(1),
                                        style: kResultNumberStyleWhite18_600,
                                        textScaleFactor: textScaleFactorTc),
                                    Text(unitFahrenheit,
                                        style: kInputTextStyle,
                                        textScaleFactor: textScaleFactorTc),
                                  ],
                                ),
                              ),
                            ],
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
                                value: convertResultTemperatureFahrenheit,
                                min: kMinConvertTempFahrenheit,
                                max: kMaxConvertTempFahrenheit,
                                label: convertResultTemperatureFahrenheit
                                    .toStringAsFixed(1),
                                inactiveColor: Color(0xFF8D8E89),
                                divisions: sliderConvertDivisionTempFahrenheit,
                                onChanged: (double sliderValue) {
                                  convertResultTemperatureFahrenheit =
                                      sliderValue;
                                  debugPrint(
                                      'SLIDE convertResultTemperatureFahrenheit $convertResultTemperatureFahrenheit');
                                  debugPrint(
                                      'SLIDE convertResultTemperatureCelsius $convertResultTemperatureCelsius');

                                  calculateCelsius(
                                      convertResultTemperatureFahrenheit);
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
                                          var kMinTempFahrenheitTemp =
                                              kMinConvertTempFahrenheit +
                                                  sliderLimit;
                                          if (convertResultTemperatureFahrenheit >
                                                  kMinTempFahrenheitTemp &&
                                              convertResultTemperatureCelsius >
                                                  kMinConvertTempCelsius) {
                                            convertResultTemperatureFahrenheit =
                                                convertResultTemperatureFahrenheit -
                                                    stepConvertTempFahrenheit;
                                            debugPrint(
                                                '- convertResultTemperatureFahrenheit $convertResultTemperatureFahrenheit');

                                            debugPrint(
                                                '- kMinTempFahrenheitTemp $kMinTempFahrenheitTemp');

                                            calculateCelsius(
                                                convertResultTemperatureFahrenheit);
                                          }
                                        });
                                      });
                                    },
                                    onPressEnd: () {
                                      timer.cancel();
                                    },
                                    onStep: () {
                                      setState(() {
                                        var kMinTempFahrenheitTemp =
                                            kMinConvertTempFahrenheit +
                                                sliderLimit;
                                        if (convertResultTemperatureFahrenheit >
                                                kMinTempFahrenheitTemp &&
                                            convertResultTemperatureCelsius >
                                                kMinConvertTempCelsius) {
                                          convertResultTemperatureFahrenheit =
                                              convertResultTemperatureFahrenheit -
                                                  stepConvertTempFahrenheit;
                                          debugPrint(
                                              '- convertResultTemperatureFahrenheit $convertResultTemperatureFahrenheit');
                                          calculateCelsius(
                                              convertResultTemperatureFahrenheit);
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
                                          var kMaxTempFahrenheitTemp =
                                              kMaxConvertTempFahrenheit -
                                                  sliderLimit;
                                          if (convertResultTemperatureFahrenheit <
                                                  kMaxTempFahrenheitTemp &&
                                              convertResultTemperatureCelsius <
                                                  kMaxConvertTempCelsius) {
                                            convertResultTemperatureFahrenheit =
                                                convertResultTemperatureFahrenheit +
                                                    stepConvertTempFahrenheit;
                                            debugPrint(
                                                '+ convertResultTemperatureFahrenheit $convertResultTemperatureFahrenheit');
                                            calculateCelsius(
                                                convertResultTemperatureFahrenheit);
                                          }
                                        });
                                      });
                                    },
                                    onPressEnd: () {
                                      timer.cancel();
                                    },
                                    onStep: () {
                                      setState(() {
                                        var kMaxTempFahrenheitTemp =
                                            kMaxConvertTempFahrenheit -
                                                sliderLimit;
                                        if (convertResultTemperatureFahrenheit <
                                                kMaxTempFahrenheitTemp &&
                                            convertResultTemperatureCelsius <
                                                kMaxConvertTempCelsius) {
                                          convertResultTemperatureFahrenheit =
                                              convertResultTemperatureFahrenheit +
                                                  stepConvertTempFahrenheit;
                                          debugPrint(
                                              '+ convertResultTemperatureFahrenheit $convertResultTemperatureFahrenheit');
                                          calculateCelsius(
                                              convertResultTemperatureFahrenheit);
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
              ReusableCard(
                onPress: () => {},
                //Compressor side Inducer *****************************
                colour: kActiveCardColourInput,
                cardChild: Column(
                  children: <Widget>[
                    //length Feet
                    //Text('Change', style: kChangeStyle),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                              AppLocalizations.of(context).translate(
                                  'convert_temperature_0080') //'Celsius',
                              ,
                              style: kSecondSubjectTextStyle,
                              textScaleFactor: textScaleFactorTc),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 80,
                                alignment: Alignment.center,
                                // color: Colors.red.shade800,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        convertResultTemperatureCelsius
                                            .toStringAsFixed(2),
                                        style: kResultNumberStyleWhite18_600,
                                        textScaleFactor: textScaleFactorTc),
                                    Text(unitCelsius,
                                        style: kInputTextStyle,
                                        textScaleFactor: textScaleFactorTc),
                                  ],
                                ),
                              ),
                            ],
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
                                value: convertResultTemperatureCelsius,
                                min: kMinConvertTempCelsius,
                                max: kMaxConvertTempCelsius,
                                label: convertResultTemperatureCelsius
                                    .toStringAsFixed(1),
                                inactiveColor: Color(0xFF8D8E89),
                                divisions: sliderConvertDivisionTempCelsius,
                                onChanged: (double sliderValue) {
                                  convertResultTemperatureCelsius = sliderValue;
                                  debugPrint(
                                      'SLIDE convertResultTemperatureCelsius $convertResultTemperatureCelsius');
                                  debugPrint(
                                      'SLIDE convertResultTemperatureFahrenheit $convertResultTemperatureFahrenheit');

                                  calculateFahrenheit(
                                      convertResultTemperatureCelsius);
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
                                          var kMinTempCelsiusTemp =
                                              kMinConvertTempCelsius +
                                                  sliderLimit;
                                          if (convertResultTemperatureCelsius >
                                                  kMinTempCelsiusTemp &&
                                              convertResultTemperatureFahrenheit >
                                                  kMinConvertTempFahrenheit) {
                                            convertResultTemperatureCelsius =
                                                convertResultTemperatureCelsius -
                                                    stepConvertTempCelsius;
                                            debugPrint(
                                                '- convertResultTemperatureCelsius $convertResultTemperatureCelsius');

                                            calculateFahrenheit(
                                                convertResultTemperatureCelsius);
                                          }
                                        });
                                      });
                                    },
                                    onPressEnd: () {
                                      timer.cancel();
                                    },
                                    onStep: () {
                                      setState(() {
                                        var kMinTempCelsiusTemp =
                                            kMinConvertTempCelsius +
                                                sliderLimit;
                                        if (convertResultTemperatureCelsius >
                                                kMinTempCelsiusTemp &&
                                            convertResultTemperatureFahrenheit >
                                                kMinConvertTempFahrenheit) {
                                          convertResultTemperatureCelsius =
                                              convertResultTemperatureCelsius -
                                                  stepConvertTempCelsius;
                                          debugPrint(
                                              '- convertResultTemperatureCelsius $convertResultTemperatureCelsius');

                                          calculateFahrenheit(
                                              convertResultTemperatureCelsius);
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
                                          var kMaxTempCelsiusTemp =
                                              kMaxConvertTempCelsius -
                                                  sliderLimit;
                                          if (convertResultTemperatureCelsius <
                                                  kMaxTempCelsiusTemp &&
                                              convertResultTemperatureFahrenheit <
                                                  kMaxConvertTempFahrenheit) {
                                            convertResultTemperatureCelsius =
                                                convertResultTemperatureCelsius +
                                                    stepConvertTempCelsius;
                                            debugPrint(
                                                '+ convertResultTemperatureCelsius $convertResultTemperatureCelsius');

                                            calculateFahrenheit(
                                                convertResultTemperatureCelsius);
                                          }
                                        });
                                      });
                                    },
                                    onPressEnd: () {
                                      timer.cancel();
                                    },
                                    onStep: () {
                                      setState(() {
                                        var kMaxTempCelsiusTemp =
                                            kMaxConvertTempCelsius -
                                                sliderLimit;
                                        if (convertResultTemperatureCelsius <
                                                kMaxTempCelsiusTemp &&
                                            convertResultTemperatureFahrenheit <
                                                kMaxConvertTempFahrenheit) {
                                          convertResultTemperatureCelsius =
                                              convertResultTemperatureCelsius +
                                                  stepConvertTempCelsius;
                                          debugPrint(
                                              '+ convertResultTemperatureCelsius $convertResultTemperatureCelsius');

                                          calculateFahrenheit(
                                              convertResultTemperatureCelsius);
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

  calculateFahrenheit(double convertResultTemperatureCelsius) {
    setState(() {
      convertResultTemperatureFahrenheit = calculate.conversionCalc(
          convertResultTemperatureCelsius, 'TemperatureCelsiusToFahrenheit');
    });
  }

  calculateCelsius(double convertResultTemperatureFahrenheit) {
    setState(() {
      convertResultTemperatureCelsius = calculate.conversionCalc(
          convertResultTemperatureFahrenheit, 'TemperatureFahrenheitToCelsius');
    });
  }
}
