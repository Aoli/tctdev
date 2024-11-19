import 'dart:async';

import 'package:Turbocharger/components/stepbutton.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/reusable_card.dart';
import '../globals/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Turbocharger/globals/calculator_brain.dart';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:Turbocharger/globals/constants_ui.dart';


class BasicCompressorPage extends StatefulWidget {
  final bool metricUnit;

  BasicCompressorPage(
      {Key key, @required this.metricUnit, RouteSettings settings})
      : super(key: key);

  @override
  _BasicCompressorPageState createState() =>
      new _BasicCompressorPageState(metricUnit);
}

class _BasicCompressorPageState extends State<BasicCompressorPage> {
  bool metricUnit;

  _BasicCompressorPageState(this.metricUnit);

  // bool metricUnit = true;
  bool snackbarEnable = false;

  @override
  void setState(key) {
    super.setState(key);

    if (metricUnit) {
      vMinInducerValue = kMinCompressorInducerMetric;
      vMaxInducerValue = kMaxCompressorInducerMetric;
      //stepValue = stepValueMillimeter;


      unitValue = unitLengthMillimeter;
      //inducerCompressorValue = inducerCompressorMetric;
      inducerCompressorMetric = inducerCompressorValue;
      inducerCompressorDisplay = inducerCompressorValue.toStringAsFixed(1);
      sliderDivisionInducer = 1300;
      print('Key inducerCompressorValue $inducerCompressorValue');
      print('Key inducerCompressorDisplay $inducerCompressorDisplay');
    } else {
      vMinInducerValue = kMinCompressorInducerImperial;
      vMaxInducerValue = kMaxCompressorInducerImperial;

      unitValue = unitLengthInch;
      inducerCompressorMetric =
          inducerCompressorValue * kConvertLengthInchToMillimeter;
      inducerCompressorDisplay = inducerCompressorValue.toStringAsFixed(2);
      sliderDivisionInducer = 530;
    }
  }

  @override
  void initState() {
    super.initState();
    resetValues(metricUnit);
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
            'Warning: Exducer is always larger than Inducer on the compressor',
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            //Icon(TurbochargerIcons.iconturbo2048px),

            Container(
                width: 36.0,
                height: 36.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/turbo_appbar_logo.png'),
                    ))),

            SizedBox(width: 10),
            Text('MAX HORSEPOWER',
                style: kAppBarTextStyle, textScaleFactor: textScaleFactorTc),
          ],
        ),
      ),
      body: Builder(builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: ReusableCard(
                colour: kActiveCardColourInput,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Compressor Inducer',
                        style: kThirdSubjectTextStyle,
                        textScaleFactor: textScaleFactorTc),
                    SizedBox(height: 5),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                          child: Text(
                              'Max horsepower based on compressor inducer size',
                              style: kLabelTextStyle,
                              textAlign: TextAlign.center,
                              textScaleFactor: textScaleFactorTc),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          //width: 50,
                          child: Container(
                            child: StepButton(
                                icon: FontAwesomeIcons.minus,
                                onStepPress: () {
                                  timer = Timer.periodic(
                                      Duration(milliseconds: tapTime), (t) {
                                    setState(() {
                                      if (Decimal.parse(inducerCompressorValue
                                          .toStringAsFixed(2)) >
                                          Decimal.parse(vMinInducerValue
                                              .toStringAsFixed(2))) {
                                        inducerCompressorValue =
                                            inducerCompressorValue -
                                                stepValueCompressorTurbine;

                                        exducerCompressorMetric =
                                            exducerCompressorValue;
                                        exducerCompressorDisplay =
                                            exducerCompressorValue
                                                .toStringAsFixed(1);
                                        inducerCompressorMetric =
                                            inducerCompressorValue;
                                        inducerCompressorDisplay =
                                            inducerCompressorValue
                                                .toStringAsFixed(1);

                                        hpPetrolResult =
                                            calculate.calculatePetrolHp(
                                                inducerCompressorMetric);
                                        hpDieselResult =
                                            calculate.calculateDieselHp(
                                                inducerCompressorMetric);
                                        trimCompressorResult =
                                            calculate.calculateCompressorTrim(
                                                inducerCompressorValue,
                                                exducerCompressorValue);
                                        pressureCompressorResult = calculate
                                            .calculateCompressorPressure(
                                            inducerCompressorValue,
                                            exducerCompressorValue);
                                        print('stepDirection - $stepDirection');
                                        print(
                                            'inducerCompressorValueStepA $inducerCompressorValue');
                                        print(
                                            'inducerCompressorValue $inducerCompressorValue');
                                      }
                                    });
                                  });
                                },
                                onPressEnd: () {
                                  timer.cancel();
                                },
                                onStep: () {
                                  setState(() {
                                    if (Decimal.parse(inducerCompressorValue
                                        .toStringAsFixed(2)) >
                                        Decimal.parse(vMinInducerValue
                                            .toStringAsFixed(2))) {
                                      inducerCompressorValue =
                                          inducerCompressorValue -
                                              stepValueCompressorTurbine;

                                      exducerCompressorMetric =
                                          exducerCompressorValue;
                                      exducerCompressorDisplay =
                                          exducerCompressorValue
                                              .toStringAsFixed(1);
                                      inducerCompressorMetric =
                                          inducerCompressorValue;
                                      inducerCompressorDisplay =
                                          inducerCompressorValue
                                              .toStringAsFixed(1);

                                      hpPetrolResult =
                                          calculate.calculatePetrolHp(
                                              inducerCompressorMetric);
                                      hpDieselResult =
                                          calculate.calculateDieselHp(
                                              inducerCompressorMetric);
                                      trimCompressorResult =
                                          calculate.calculateCompressorTrim(
                                              inducerCompressorValue,
                                              exducerCompressorValue);
                                      pressureCompressorResult =
                                          calculate.calculateCompressorPressure(
                                              inducerCompressorValue,
                                              exducerCompressorValue);
                                      print('stepDirection - $stepDirection');
                                      print(
                                          'inducerCompressorValueStepA $inducerCompressorValue');
                                      print(
                                          'inducerCompressorValue $inducerCompressorValue');
                                    }
                                  });
                                }),
                          ),
                        ),
                        Container(
                          // width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                width: kResultNumberWidth,
                                child: Column(
                                  children: <Widget>[
                                    Text(inducerCompressorDisplay.toString(),
                                        style: kResultNumberStyleWhite18_600,
                                        textScaleFactor: textScaleFactorTc
                                      //hpCalculate(inducerCompressor).toString(),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: kResultUnitWidth,
                                child: Text(unitValue,
                                    style: kUnitTextStyleAirflow,
                                    textScaleFactor: textScaleFactorTc),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          //width: 50,
                          child: Container(
                            child: StepButton(
                                icon: FontAwesomeIcons.plus,
                                onStepPress: () {
                                  timer = Timer.periodic(
                                      Duration(milliseconds: tapTime), (t) {
                                    setState(() {
                                      if (Decimal.parse(inducerCompressorValue
                                          .toStringAsFixed(1)) <
                                          Decimal.parse(vMaxInducerValue
                                              .toStringAsFixed(1))) {
                                        inducerCompressorValue =
                                            inducerCompressorValue +
                                                stepValueCompressorTurbine;
                                        hpPetrolResult =
                                            calculate.calculatePetrolHp(
                                                inducerCompressorMetric);
                                        hpDieselResult =
                                            calculate.calculateDieselHp(
                                                inducerCompressorMetric);
                                        trimCompressorResult =
                                            calculate.calculateCompressorTrim(
                                                inducerCompressorValue,
                                                exducerCompressorValue);
                                        pressureCompressorResult = calculate
                                            .calculateCompressorPressure(
                                            inducerCompressorValue,
                                            exducerCompressorValue);
                                        print('stepDirection + $stepDirection');
                                        print(
                                            'inducerCompressorValueStepB $inducerCompressorValue');
                                        print(
                                            'inducerCompressorValue $inducerCompressorValue');
                                      }
                                    });
                                  });
                                },
                                onPressEnd: () {
                                  timer.cancel();
                                },
                                onStep: () {
                                  setState(() {
                                    if (Decimal.parse(inducerCompressorValue
                                        .toStringAsFixed(1)) <
                                        Decimal.parse(vMaxInducerValue
                                            .toStringAsFixed(1))) {
                                      inducerCompressorValue =
                                          inducerCompressorValue +
                                              stepValueCompressorTurbine;
                                      hpPetrolResult =
                                          calculate.calculatePetrolHp(
                                              inducerCompressorMetric);
                                      hpDieselResult =
                                          calculate.calculateDieselHp(
                                              inducerCompressorMetric);
                                      trimCompressorResult =
                                          calculate.calculateCompressorTrim(
                                              inducerCompressorValue,
                                              exducerCompressorValue);
                                      pressureCompressorResult =
                                          calculate.calculateCompressorPressure(
                                              inducerCompressorValue,
                                              exducerCompressorValue);
                                      print('stepDirection + $stepDirection');
                                      print(
                                          'inducerCompressorValueStepB $inducerCompressorValue');
                                      print(
                                          'inducerCompressorValue $inducerCompressorValue');
                                    }
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30.0),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        thumbColor: kCompressorInducerSliderNob,
                        valueIndicatorColor: kCompressorInducerSliderNob,
                        overlayColor: kCompressorSliderOverlayColor,
                        inactiveTrackColor: kInactiveSlideColour,
                        thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: kNobThumbShapeLarge),
                        overlayShape: RoundSliderOverlayShape(
                            overlayRadius: kNobOverlayShapeLarge),
                      ),
                      child: Slider(
                          value: inducerCompressorValue,
                          min: vMinInducerValue * 0.992,
                          max: vMaxInducerValue * 1.002,
                          label: inducerCompressorValue.toStringAsFixed(1),
                          inactiveColor: Color(0xFF8D8E89),
                          divisions: sliderDivisionInducerExducer,
                          onChanged: (double newValue) {
                            setState(() {
                              inducerCompressorValue = newValue;
                              hpPetrolResult = calculate
                                  .calculatePetrolHp(inducerCompressorMetric);
                              hpDieselResult = calculate
                                  .calculateDieselHp(inducerCompressorMetric);
                              if (inducerCompressorMetric > exducerCompressor &&
                                  snackbarEnable) {
                                snackbarEnable = false;
                                // _scaffoldKey.currentState
                                //     .removeCurrentSnackBar();
                                _scaffoldKey.currentState
                                    .showSnackBar(snackBar);
                              } else if (inducerCompressorMetric <=
                                  exducerCompressor) {
                                snackbarEnable = false;
                              }
                              print(vMaxInducerValue);
                              print(vMinInducerValue);
                              print(inducerCompressorValue);
                            });
                          }),
                    ),

                    //Center(
                  ],
                ),
              ),
            ),
            //Turbo-Size
            Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Petrol',
                                style: kLabelTextStyleLarge,
                                textScaleFactor: textScaleFactorTc),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: kResultNumberWidth,
                                  child: Text(hpPetrolResult.toStringAsFixed(0),
                                      style: kResultNumberStyleWhite18_600,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: kResultUnitWidth,
                                  child: Text(unitHorsepower,
                                      style: kUnitTextStyleAirflow,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //  crossAxisAlignment: CrossAxisAlignment.center,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                SizedBox(
                                  width: 15.0,
                                ),
                              ],
                            )
                          ],
                        ),
                        colour: kActiveCardColourOutput,
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text('Diesel',
                                style: kLabelTextStyleLarge,
                                textScaleFactor: textScaleFactorTc),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: kResultNumberWidth,
                                  child: Text(hpDieselResult.toStringAsFixed(0),
//                        age.toString(),
                                      style: kResultNumberStyleWhite18_600,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: kResultUnitWidth,
                                  child: Text(unitHorsepower,
                                      style: kUnitTextStyleAirflow,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[],
                            )
                          ],
                        ),
                        colour: kActiveCardColourOutput,
                      ),
                    ),
                  ],
                )), //Fuel (Hp)
          ],
        );
      }),
    );
  }

  void resetValues(bool metricUnit) {
    setState(() {
      if (metricUnit) {
        vMinInducerValue = kMinCompressorInducerMetric;
        vMaxInducerValue = kMaxCompressorInducerMetric;
        vMinExducerValue = kMinCompressorExducerMetric;
        vMaxExducerValue = kMaxCompressorExducerMetric;


        unitValue = unitLengthMillimeter;
        pressureUnitValue = unitPressureBar;

        inducerCompressorMetric = kMinCompressorInducerMetric;
        exducerCompressorMetric = kMaxCompressorExducerMetric;
        inducerCompressorValue = kMinCompressorInducerMetric;
        exducerCompressorValue = kMaxCompressorExducerMetric;

        exducerCompressorDisplay = exducerCompressorValue.toStringAsFixed(1);
        inducerCompressorDisplay = inducerCompressorValue.toStringAsFixed(1);
        pressureCompressorDisplay = pressureCompressorResult.toStringAsFixed(2);
        trimCompressorDisplay = trimCompressorResult.toStringAsFixed(0);

        sliderDivisionInducerExducer = 130;
      }
    });
  }
}
