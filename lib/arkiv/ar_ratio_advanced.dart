import 'dart:async';
import 'package:tct/components/stepbutton_close.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../globals/calculator_brain.dart';
import '../components/reusable_card.dart';
import '../globals/constant.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:tct/globals/constants_ui.dart';

class ArRatioAdvancedPage extends StatefulWidget {
  final bool metricUnit;

  ArRatioAdvancedPage(
      {Key key, @required this.metricUnit, RouteSettings settings})
      : super(key: key);

  @override
  _ArRatioAdvancedPageState createState() =>
      _ArRatioAdvancedPageState(metricUnit);
}

class _ArRatioAdvancedPageState extends State<ArRatioAdvancedPage> {
  bool metricUnit;

  _ArRatioAdvancedPageState(this.metricUnit);

  //bool metricUnit = false;
  bool snackbarEnable = true;

  Widget get submitRatingButton {
    if (snackbarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () => _scaffoldCompressorKey.currentState
              .showSnackBar(snackBarCompressor));
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
            'AR ratio advanced',
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

  CalculatorBrain calculate = CalculatorBrain();

  @override
  void initState() {
    super.initState();
    print('radioValue $radioValue');

    resetValues(metricUnit);

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
              'A/R ratio advanced',
              style: kAppBarTextStyle,
              textScaleFactor: textScaleFactorTc,
            ),
            submitRatingButton,
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
                            'A/R ratio',
                            style: kSecondSubjectTextStyle,
                            textScaleFactor: textScaleFactorTc,
                          ),
                          Divider(height: 15.0, color: Colors.white),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                // color: Colors.red,
                                width: kWidthResultTextContainer,
                                height: kHeightResultTextHeight,
                                child: Text(
                                  'A/R Ratio',
                                  style: labelTextStyleResult0,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.blue,
                                width: kWidthResultTextNumber,
                                height: kHeightResultTextHeight,
                                child: Text(
                                  convertResultMassPound.toStringAsFixed(2),
                                  style: kResultNumberStyleWhite18_600,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.green,
                                width: kWidthResultTextUnit,
                                height: kHeightResultTextHeight,
                                child: Text(
                                  unitArRatio,
                                  style: kUnitTextStyleAirflow,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                // color: Colors.red,
                                width: kWidthResultTextContainer,
                                height: kHeightResultTextHeight,
                                child: Text(
                                  'Area',
                                  style: labelTextStyleResult2,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.blue,
                                width: kWidthResultTextNumber,
                                height: kHeightResultTextHeight,
                                child: Text(
                                  convertResultMassKilogram.toStringAsFixed(2),
                                  style: kResultNumberStyleWhite18_600,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.green,
                                width: kWidthResultTextUnit,
                                height: kHeightResultTextHeight,
                                child: Text(
                                  unitAreaArRatioMillimeter,
                                  style: kUnitTextStyleAirflow,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                // color: Colors.red,
                                width: kWidthResultTextContainer,
                                height: kHeightResultTextHeight,
                                child: Text(
                                  'Radius',
                                  style: labelTextStyleResult1,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.blue,
                                width: kWidthResultTextNumber,
                                height: kHeightResultTextHeight,
                                child: Text(
                                  convertResultMassGram.toStringAsFixed(0),
                                  style: kResultNumberStyleWhite18_600,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.green,
                                width: kWidthResultTextUnit,
                                height: kHeightResultTextHeight,
                                child: Text(
                                  unitRadiusArRatioMillimeter,
                                  style: kUnitTextStyleAirflow,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                            ],
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
                                child: Text('Input: Area and Radius',
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

                          Column(
                            children: <Widget>[
                              SizedBox(height: 15),
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: Text('Area',
                                    style: kLabelTextStyle,
                                    textScaleFactor: textScaleFactorTc),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 95,
                                    // color: Colors.blue,
                                    child: Text(
                                        areaArCalculation.toStringAsFixed(2),
                                        style: kResultNumberStyleWhite18_600,
                                        textScaleFactor: textScaleFactorTc),
                                  ),
                                  Container(
                                    width: 95,
                                    // color: Colors.orange,
                                    child: Text(unitAreaArRatioMillimeter,
                                        textAlign: TextAlign.center,
                                        style: kUnitTextStyleAirflow,
                                        textScaleFactor: textScaleFactorTc),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          StepButtonClose(
                                            icon: FontAwesomeIcons.minus,
                                            onStepPress: () {
                                              timer = Timer.periodic(
                                                  Duration(
                                                      milliseconds: tapTime),
                                                  (t) {
                                                setState(() {
                                                  print('- press');

                                                  if ((Decimal.parse(strokeInput
                                                          .toStringAsFixed(2)) >
                                                      (Decimal.parse(
                                                          vMinStrokeInput
                                                              .toStringAsFixed(
                                                                  2))))) {
                                                    strokeInput = strokeInput -
                                                        stepStrokeInput;

                                                    compressorOrTurbine = true;

                                                    calcArRatio(
                                                        areaArCalculation,
                                                        radiusArCalculation,
                                                        compressorOrTurbine);
                                                  }
                                                });
                                              });
                                            },
                                            onPressEnd: () {
                                              timer.cancel();
                                            },
                                            onStep: () {
                                              setState(() {
                                                if ((Decimal.parse(strokeInput
                                                        .toStringAsFixed(2)) >
                                                    (Decimal.parse(
                                                        vMinStrokeInput
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  strokeInput = strokeInput -
                                                      stepStrokeInput;

                                                  compressorOrTurbine = true;

                                                  calcArRatio(
                                                      areaArCalculation,
                                                      radiusArCalculation,
                                                      compressorOrTurbine);
                                                }
                                              });
                                            },
                                          ),
                                          StepButtonClose(
                                            icon: FontAwesomeIcons.plus,
                                            onStepPress: () {
                                              timer = Timer.periodic(
                                                  Duration(
                                                      milliseconds: tapTime),
                                                  (t) {
                                                setState(() {
                                                  print('+ press');
                                                  print(
                                                      'strokeInput $strokeInput');
                                                  print(
                                                      'kMaxStrokeInput $vMaxStrokeInput');
                                                  if ((Decimal.parse(strokeInput
                                                          .toStringAsFixed(2)) <
                                                      (Decimal.parse(
                                                          vMaxStrokeInput
                                                              .toStringAsFixed(
                                                                  2))))) {
                                                    strokeInput = strokeInput +
                                                        stepStrokeInput;

                                                    compressorOrTurbine = true;

                                                    calcArRatio(
                                                        areaArCalculation,
                                                        radiusArCalculation,
                                                        compressorOrTurbine);
                                                  }
                                                });
                                              });
                                            },
                                            onPressEnd: () {
                                              timer.cancel();
                                            },
                                            onStep: () {
                                              setState(() {
                                                if ((Decimal.parse(strokeInput
                                                        .toStringAsFixed(2)) <
                                                    (Decimal.parse(
                                                        vMaxStrokeInput
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  strokeInput = strokeInput +
                                                      stepStrokeInput;

                                                  compressorOrTurbine = true;

                                                  calcArRatio(
                                                      areaArCalculation,
                                                      radiusArCalculation,
                                                      compressorOrTurbine);
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('Radius',
                                    style: kLabelTextStyle,
                                    textScaleFactor: textScaleFactorTc),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 95,
                                    child: Text(radiusArCalculation.toString(),
                                        style: kResultNumberStyleWhite18_600,
                                        textScaleFactor: textScaleFactorTc),
                                  ),
                                  Container(
                                    width: 95,
                                    child: Text(unitRadiusArRatioMillimeter,
                                        textAlign: TextAlign.center,
                                        style: kUnitTextStyleAirflow,
                                        textScaleFactor: textScaleFactorTc),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      StepButtonClose(
                                        icon: FontAwesomeIcons.minus,
                                        onStepPress: () {
                                          timer = Timer.periodic(
                                              Duration(milliseconds: tapTime),
                                              (t) {
                                            setState(() {
                                              print('- press');

                                              if ((Decimal.parse(cylinderInput
                                                      .toString()) >
                                                  (Decimal.parse(kMinNrCylinder
                                                      .toString())))) {
                                                cylinderInput = cylinderInput -
                                                    stepNrCylinder;

                                                compressorOrTurbine = true;

                                                calcArRatio(
                                                    areaArCalculation,
                                                    radiusArCalculation,
                                                    compressorOrTurbine);
                                              }
                                            });
                                          });
                                        },
                                        onPressEnd: () {
                                          timer.cancel();
                                        },
                                        onStep: () {
                                          setState(() {
                                            if ((Decimal.parse(cylinderInput
                                                    .toStringAsFixed(2)) >
                                                (Decimal.parse(kMinNrCylinder
                                                    .toStringAsFixed(2))))) {
                                              cylinderInput = cylinderInput -
                                                  stepNrCylinder;

                                              compressorOrTurbine = true;

                                              calcArRatio(
                                                  areaArCalculation,
                                                  radiusArCalculation,
                                                  compressorOrTurbine);
                                            }
                                          });
                                        },
                                      ),
                                      StepButtonClose(
                                        icon: FontAwesomeIcons.plus,
                                        onStepPress: () {
                                          timer = Timer.periodic(
                                              Duration(milliseconds: tapTime),
                                              (t) {
                                            setState(() {
                                              print('+ press');
                                              print(
                                                  'cylinderInput $cylinderInput');
                                              print(
                                                  'kMaxNrCylinder $kMaxNrCylinder');
                                              if ((Decimal.parse(cylinderInput
                                                      .toString()) <
                                                  (Decimal.parse(kMaxNrCylinder
                                                      .toString())))) {
                                                cylinderInput = cylinderInput +
                                                    stepNrCylinder;

                                                compressorOrTurbine = true;

                                                calcArRatio(
                                                    areaArCalculation,
                                                    radiusArCalculation,
                                                    compressorOrTurbine);
                                              }
                                            });
                                          });
                                        },
                                        onPressEnd: () {
                                          timer.cancel();
                                        },
                                        onStep: () {
                                          setState(() {
                                            if ((Decimal.parse(cylinderInput
                                                    .toStringAsFixed(2)) <
                                                (Decimal.parse(kMaxNrCylinder
                                                    .toStringAsFixed(2))))) {
                                              cylinderInput = cylinderInput +
                                                  stepNrCylinder;

                                              compressorOrTurbine = true;

                                              calcArRatio(
                                                  areaArCalculation,
                                                  radiusArCalculation,
                                                  compressorOrTurbine);
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Divider(),
                          Text('Area Calculation'),
                          Text('Shape of Area'),
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
                                  Text('Rectangle',
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
                                  Text('Rounded Rectangle',
                                      textScaleFactor: textScaleFactorTc),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Radio<int>(
                                    value: 2,
                                    groupValue: radioValue,
                                    activeColor: Colors.white,
                                    onChanged: handleRadioValueChanged,
                                  ),
                                  Text('Circle',
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
      resetValues(metricUnit);

      switch (radioValue) {
        case 0:
          print('0 convertSliderResultMassAll $convertSliderResultMassAll');
          print('0 kMinSliderConvertMassAll $kMinSliderConvertMassAll');
          print('0 kMaxSliderConvertMassAll $kMaxSliderConvertMassAll');
          print('0 convertSliderResultMassAll $convertSliderResultMassAll');
          print('0 sliderSliderConvertMassAll $sliderSliderConvertMassAll');
          print('0 stepSliderConvertMassAll $stepSliderConvertMassAll');
          print('0 kMaxConvertMassPound $kMaxConvertMassPound');
          print('0 kMaxConvertMassGram $kMaxConvertMassGram');
          print('0 kMaxConvertMassKilogram $kMaxConvertMassKilogram');
          // if(convertResultMassPound>kMaxSliderConvertMassAll){
          //   convertResultMassPound = kMaxSliderConvertMassAll;
          // }
          labelTextStyleResult0 = kLabelTextStyleActive;
          labelTextStyleResult1 = kLabelTextStyle;
          labelTextStyleResult2 = kLabelTextStyle;
          labelTextStyleResult3 = kLabelTextStyle;

          convertSliderHeaderMassTextAll = 'Area and Radius';
          unitSliderConvertMassAll = 'lb';
          convertSliderResultMassAll = kResetValuePound;
          kMinSliderConvertMassAll = kMinConvertMassPound;
          kMaxSliderConvertMassAll = kMaxConvertMassPound;
          sliderSliderConvertMassAll = sliderConvertMassPound;
          stepSliderConvertMassAll = stepConvertMassPound;
          vMinSliderConvertVolumeAllStepper = kMinConvertMassPound * 1.05;
          vMaxSliderConvertVolumeAllStepper = kMaxConvertMassPound * 0.95;

          break;

        case 1:
          labelTextStyleResult0 = kLabelTextStyle;
          labelTextStyleResult1 = kLabelTextStyle;
          labelTextStyleResult2 = kLabelTextStyleActive;
          labelTextStyleResult3 = kLabelTextStyle;
          print('2 convertSliderResultMassAll $convertSliderResultMassAll');
          print('2 kMinSliderConvertMassAll $kMinSliderConvertMassAll');
          print('2 kMaxSliderConvertMassAll $kMaxSliderConvertMassAll');
          print('2 convertSliderResultMassAll $convertSliderResultMassAll');
          print('2 sliderSliderConvertMassAll $sliderSliderConvertMassAll');
          print('2 stepSliderConvertMassAll $stepSliderConvertMassAll');
          print('2 kMaxConvertMassPound $kMaxConvertMassPound');
          print('2 kMaxConvertMassGram $kMaxConvertMassGram');
          print('2 kMaxConvertMassKilogram $kMaxConvertMassKilogram');
          // if(convertResultMassKilogram>kMaxSliderConvertMassAll){
          //   convertResultMassKilogram = kMaxSliderConvertMassAll;
          // }
          convertSliderHeaderMassTextAll = 'Kilogram';
          unitSliderConvertMassAll = 'Kg';
          convertSliderResultMassAll = kResetValueKilogram;
          kMinSliderConvertMassAll = kMinConvertMassKilogram;
          kMaxSliderConvertMassAll = kMaxConvertMassKilogram;
          sliderSliderConvertMassAll = sliderConvertMassKilogram;
          stepSliderConvertMassAll = stepConvertMassKilogram;
          vMinSliderConvertVolumeAllStepper = kMinConvertMassKilogram * 1.05;
          vMaxSliderConvertVolumeAllStepper = kMaxConvertMassKilogram * 0.95;

          break;
        case 2:
          labelTextStyleResult0 = kLabelTextStyle;
          labelTextStyleResult1 = kLabelTextStyleActive;
          labelTextStyleResult2 = kLabelTextStyle;
          labelTextStyleResult3 = kLabelTextStyle;
          print('1 convertSliderResultMassAll $convertSliderResultMassAll');
          print('1 kMinSliderConvertMassAll $kMinSliderConvertMassAll');
          print('1 kMaxSliderConvertMassAll $kMaxSliderConvertMassAll');
          print('1 convertSliderResultMassAll $convertSliderResultMassAll');
          print('1 sliderSliderConvertMassAll $sliderSliderConvertMassAll');
          print('1 stepSliderConvertMassAll $stepSliderConvertMassAll');
          print('1 kMaxConvertMassPound $kMaxConvertMassPound');
          print('1 kMaxConvertMassLiter $kMaxConvertMassGram');
          print('1 kMaxConvertMassKilogram $kMaxConvertMassKilogram');
          // if(convertResultMassLitre>kMaxSliderConvertMassAll){
          //   kMaxSliderConvertMassAll = kMaxConvertMassLiter;
          //}
          convertSliderHeaderMassTextAll = 'Gram';
          unitSliderConvertMassAll = 'g';
          convertSliderResultMassAll = kResetValueGram;
          kMinSliderConvertMassAll = kMinConvertMassGram;
          kMaxSliderConvertMassAll = kMaxConvertMassGram;
          sliderSliderConvertMassAll = sliderConvertMassGram;
          stepSliderConvertMassAll = stepConvertMassGram;
          vMinSliderConvertVolumeAllStepper = kMinConvertMassGram * 1.05;
          vMaxSliderConvertVolumeAllStepper = kMaxConvertMassGram * 0.95;
          break;
      }
      print('radioValue $radioValue');
    });
  }

  calculateMass(double convertSliderResultMassAll, int radioValue) {
    setState(() {
      switch (radioValue) {
        case 0:
          convertResultMassPound = convertSliderResultMassAll;
          convertResultMassGram = calculate.conversionCalc(
              convertSliderResultMassAll, 'MassPoundToGram');
          convertResultMassKilogram = calculate.conversionCalc(
              convertSliderResultMassAll, 'MassPoundToKilogram');
          break;

        case 1:
          convertResultMassKilogram = convertSliderResultMassAll;
          convertResultMassPound = calculate.conversionCalc(
              convertSliderResultMassAll, 'MassKilogramToPound');
          convertResultMassGram = calculate.conversionCalc(
              convertSliderResultMassAll, 'MassKilogramToGram');
          break;
        case 2:
          convertResultMassGram = convertSliderResultMassAll;
          convertResultMassPound = calculate.conversionCalc(
              convertSliderResultMassAll, 'MassGramToPound');
          convertResultMassKilogram = calculate.conversionCalc(
              convertSliderResultMassAll, 'MassGramToKilogram');
          break;
      }
    });
  }

  void resetValues(bool metricUnit) {
    setState(() {
      //radioValue = 0;

      calculateMass(convertSliderResultMassAll, 0);
    });
  }

  void calcArRatio(double areaArCalculation, double radiusArCalculation,
      bool compressorOrTurbine) {}
}
