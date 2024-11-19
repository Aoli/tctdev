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


class PsiAndBarPage extends StatefulWidget {
  @override
  _PsiAndBarPageState createState() => _PsiAndBarPageState();
}

class _PsiAndBarPageState extends State<PsiAndBarPage> {
  _PsiAndBarPageState();

  //bool metricUnit = false;
  bool snackbarEnable = true;

  Widget get submitRatingButton {
    if (snackbarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState.showSnackBar(snackBar);

            // parameters
            var _analyticsParameter = {'Snackbar': 'Conv Pressure'};
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
            'PsiToBar page',
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

  CalculatorBrain calculate = CalculatorBrain();

  @override
  void initState() {
    super.initState();

    convertResultPressureBar = 1.01325;
    calculatePsi(convertResultPressureBar);
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
            Text(AppLocalizations.of(context).translate('convert_pressure_0000')
                //'PRESSURE Conversion',
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
                          Text(
                            AppLocalizations.of(context).translate(
                                'convert_pressure_0010') //'Pressure',
                            , style: kSecondSubjectTextStyle,
                            textScaleFactor: textScaleFactorTc,

                          ),
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
                                              .translate(
                                              'convert_pressure_0020')
                                          // 'Pound per square inch',
                                         , style: kLabelTextStyleLarge,
                                          textScaleFactor:
                                          textScaleFactorTc * .9,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultPressurePsi
                                                .toStringAsFixed(2),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitPressurePsi,
                                            style: kLabelTextStyle,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'convert_pressure_0030') // 'Bar',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor:
                                          textScaleFactorTc * .9,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultPressureBar
                                                .toStringAsFixed(3),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitPressureBar,
                                            style: kLabelTextStyle,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          '',
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor:
                                          textScaleFactorTc * .9,
                                        )),
                                        DataCell(
                                          Text(
                                            '',
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '',
                                            style: kLabelTextStyle,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'convert_pressure_0040')
                                          // 'Kilopascal',
                                         , style: kLabelTextStyleLarge,
                                          textScaleFactor:
                                          textScaleFactorTc * .9,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultPressureKiloPascal
                                                .toStringAsFixed(1),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitPressureKiloPascal,
                                            style: kLabelTextStyle,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'convert_pressure_0050')
                                          // 'Atmosphere',
                                         , style: kLabelTextStyleLarge,
                                          textScaleFactor:
                                          textScaleFactorTc * .9,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultPressureAtmosphere
                                                .toStringAsFixed(3),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitPressureAtmosphere,
                                            style: kLabelTextStyle,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'convert_pressure_0060')
                                          // 'Inch of mercury',
                                         , style: kLabelTextStyleLarge,
                                          textScaleFactor:
                                          textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultPressureInchOfMercury
                                                .toStringAsFixed(2),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor:
                                            textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitPressureInchOfMercury,
                                            style: kLabelTextStyle,
                                            textScaleFactor:
                                            textScaleFactorTc,
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
                          textColor: Colors.white38,
                          child: Text(AppLocalizations.of(context).translate(
                              'convert_pressure_0070') //'Reset',
                              , style: kLabelTextStyle
                              , textScaleFactor: textScaleFactorTc * 0.8),
                          onPressed: () {
                            convertResultPressureBar = 1.01325;
                            calculatePsi(convertResultPressureBar);
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
                    //length Feet
                    //Text('Change', style: kChangeStyle),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(AppLocalizations.of(context).translate(
                              'convert_pressure_0080') //'Psi',
                             , style: kSecondSubjectTextStyle,
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
                                        convertResultPressurePsi
                                            .toStringAsFixed(2),
                                        style: kResultNumberStyleWhite18_600,
                                        textScaleFactor: textScaleFactorTc),
                                    Text(unitPressurePsi,
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
                                value: convertResultPressurePsi,
                                min: kMinPressurePsi - 0.05,
                                max: kMaxPressurePsi + 0.05,
                                label:
                                convertResultPressurePsi.toStringAsFixed(2),
                                inactiveColor: Color(0xFF8D8E89),
                                divisions: sliderDivisionsPressurePsi,
                                onChanged: (double sliderValue) {
                                  convertResultPressurePsi = sliderValue;
                                  debugPrint(
                                      'convertResultPressurePsi $convertResultPressurePsi');
                                  if (convertResultPressurePsi <
                                      kMinPressurePsi) {
                                    convertResultPressurePsi = kMinPressurePsi;
                                  } else if (convertResultPressurePsi >
                                      kMaxPressurePsi) {
                                    convertResultPressurePsi = kMaxPressurePsi;
                                  } else {
                                    calculateBar(convertResultPressurePsi);
                                  }
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
                                          if (Decimal.parse(
                                              convertResultPressurePsi
                                                  .toStringAsFixed(2)) >
                                              Decimal.parse(kMinPressurePsi
                                                  .toStringAsFixed(2))) {
                                            convertResultPressurePsi =
                                                convertResultPressurePsi -
                                                    stepValuePressurePsi;
                                            calculateBar(
                                                convertResultPressurePsi);
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
                                            convertResultPressurePsi
                                                .toStringAsFixed(2)) >
                                            Decimal.parse(kMinPressurePsi
                                                .toStringAsFixed(2))) {
                                          convertResultPressurePsi =
                                              convertResultPressurePsi -
                                                  stepValuePressurePsi;
                                          calculateBar(
                                              convertResultPressurePsi);
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
                                          if ((Decimal.parse(
                                              convertResultPressurePsi
                                                  .toStringAsFixed(1)) <
                                              (Decimal.parse(kMaxPressurePsi
                                                  .toStringAsFixed(1))))) {
                                            convertResultPressurePsi =
                                                convertResultPressurePsi +
                                                    stepValuePressurePsi;
                                            calculateBar(
                                                convertResultPressurePsi);
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
                                            convertResultPressurePsi
                                                .toStringAsFixed(1)) <
                                            (Decimal.parse(kMaxPressurePsi
                                                .toStringAsFixed(1))))) {
                                          convertResultPressurePsi =
                                              convertResultPressurePsi +
                                                  stepValuePressurePsi;
                                          calculateBar(
                                              convertResultPressurePsi);
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
                              'convert_pressure_0090') //'Bar',
                             , style: kSecondSubjectTextStyle,
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
                                        convertResultPressureBar
                                            .toStringAsFixed(3),
                                        style: kResultNumberStyleWhite18_600,
                                        textScaleFactor: textScaleFactorTc),
                                    Text(unitPressureBar,
                                        style: kInputTextStyle),
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
                                value: convertResultPressureBar,
                                min: kMinPressureBar - 0.01,
                                max: kMaxPressureBar + 0.01,
                                label:
                                convertResultPressureBar.toStringAsFixed(2),
                                inactiveColor: Color(0xFF8D8E89),
                                divisions: sliderDivisionsPressureBar,
                                onChanged: (double sliderValue) {
                                  convertResultPressureBar = sliderValue;
                                  debugPrint(
                                      'convertResultPressureBar $convertResultPressureBar');
                                  if (convertResultPressureBar <
                                      kMinPressureBar) {
                                    convertResultPressureBar = kMinPressureBar;
                                  } else if (convertResultPressureBar >
                                      kMaxPressureBar) {
                                    convertResultPressureBar = kMaxPressureBar;
                                  } else {
                                    calculatePsi(convertResultPressureBar);
                                  }
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
                                          if (Decimal.parse(
                                              convertResultPressureBar
                                                  .toStringAsFixed(1)) >
                                              Decimal.parse(kMinPressureBar
                                                  .toStringAsFixed(1))) {
                                            convertResultPressureBar =
                                                convertResultPressureBar -
                                                    stepValuePressureBar;
                                            calculatePsi(
                                                convertResultPressureBar);
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
                                            convertResultPressureBar
                                                .toStringAsFixed(1)) >
                                            Decimal.parse(kMinPressureBar
                                                .toStringAsFixed(1))) {
                                          convertResultPressureBar =
                                              convertResultPressureBar -
                                                  stepValuePressureBar;
                                          calculatePsi(
                                              convertResultPressureBar);
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
                                          if ((Decimal.parse(
                                              convertResultPressureBar
                                                  .toStringAsFixed(1)) <
                                              (Decimal.parse(kMaxPressureBar
                                                  .toStringAsFixed(1))))) {
                                            convertResultPressureBar =
                                                convertResultPressureBar +
                                                    stepValuePressureBar;
                                            calculatePsi(
                                                convertResultPressureBar);
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
                                            convertResultPressureBar
                                                .toStringAsFixed(1)) <
                                            (Decimal.parse(kMaxPressureBar
                                                .toStringAsFixed(1))))) {
                                          convertResultPressureBar =
                                              convertResultPressureBar +
                                                  stepValuePressureBar;
                                          calculatePsi(
                                              convertResultPressureBar);
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

  calculateBar(double convertResultPressurePsi) {
    setState(() {
      // debugPrint('X convertResultPressurePsi $convertResultPressurePsi');
      convertResultPressureBar = calculate.conversionCalc(
          convertResultPressurePsi, 'PressurePsiToBar');
      convertResultPressureKiloPascal = calculate.conversionCalc(
          convertResultPressurePsi, 'PressurePsiToKiloPascal');
      convertResultPressureAtmosphere = calculate.conversionCalc(
          convertResultPressurePsi, 'PressurePsiToAtmosphere');
      convertResultPressureInchOfMercury = calculate.conversionCalc(
          convertResultPressurePsi, 'PressurePsiToInchOfMercuryColumn');
    });
  }

  calculatePsi(double convertResultPressureBar) {
    setState(() {
      // debugPrint('X convertResultPressureBar $convertResultPressureBar');
      convertResultPressurePsi = calculate.conversionCalc(
          convertResultPressureBar, 'PressureBarToPsi');
      convertResultPressureKiloPascal = calculate.conversionCalc(
          convertResultPressureBar, 'PressureBarToKiloPascal');
      convertResultPressureAtmosphere = calculate.conversionCalc(
          convertResultPressureBar, 'PressureBarToAtmosphere');
      convertResultPressureInchOfMercury = calculate.conversionCalc(
          convertResultPressureBar, 'PressureBarToInchOfMercuryColumn');
    });
  }
}
