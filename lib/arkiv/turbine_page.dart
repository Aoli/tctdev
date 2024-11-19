import 'dart:async';
import 'package:tct/components/analytics_event.dart';
import 'package:tct/data_models/analytics_event_type.dart';
import 'package:tct/components/stepbutton.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/reusable_card.dart';
import '../globals/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tct/globals/calculator_brain.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:tct/globals/constants_ui.dart';

class TurbinePage extends StatefulWidget {
  final bool metricUnit;

  TurbinePage(
      {Key? key, required this.metricUnit, required RouteSettings settings})
      : super(key: key);

  @override
  _TurbinePageState createState() => _TurbinePageState(metricUnit);
}

class _TurbinePageState extends State<TurbinePage> {
  bool metricUnit;

  _TurbinePageState(this.metricUnit);

  // bool metricUnit = false;
  bool snackBarEnable = true;

  void _onChangedUnitSwitch(bool value) {
    setState(() {
      print('Anders');
      resetValues(metricUnit);
      metricUnit = value;

      if (metricUnit) {
        vMinInducerValue = kMinCompressorInducerMetric;
        vMaxInducerValue = kMaxCompressorInducerMetric;
        vMinExducerValue = kMinCompressorExducerMetric;
        vMaxExducerValue = kMaxCompressorExducerMetric;
        unitValue = unitLengthMillimeter;
        pressureUnitValue = unitPressureBar;
        exducerTurbineMetric = exducerTurbineValue;
        exducerTurbineDisplay = exducerTurbineValue.toStringAsFixed(1);
        inducerTurbineMetric = inducerTurbineValue;

        inducerTurbineDisplay = inducerTurbineValue.toStringAsFixed(1);

        pressureTurbineDisplay = pressureTurbineResult.toStringAsFixed(2);
        //sliderDivisions = null;
        sliderDivisionInducerExducer = 130;
      } else {
        vMinInducerValue = kMinCompressorInducerImperial;
        vMaxInducerValue = kMaxCompressorInducerImperial;
        vMinExducerValue = kMinCompressorExducerImperial;
        vMaxExducerValue = kMaxCompressorExducerImperial;
        unitValue = unitLengthInch;
        pressureUnitValue = unitPressurePsi;
        exducerTurbineImperial = exducerTurbineValue;
        exducerTurbineMetric =
            exducerTurbineValue * kConvertLengthInchToMillimeter;
        exducerTurbineDisplay = exducerTurbineValue.toStringAsFixed(2);
        inducerTurbineMetric =
            inducerTurbineValue * kConvertLengthInchToMillimeter;
        inducerTurbineDisplay = inducerTurbineValue.toStringAsFixed(2);
        pressureTurbineDisplay =
            (pressureTurbineResult * kConvertPressureBarToPsi)
                .toStringAsFixed(2);
        sliderDivisions = 550;
        sliderDivisionInducerExducer = 53;
      }
      resetValues(metricUnit);
    });
  }

  @override
  void setState(fn) {
    super.setState(fn);
    print('metricUnit turbine: $metricUnit');

    if (metricUnit) {
      vMinInducerValue = kMinCompressorInducerMetric;
      vMaxInducerValue = kMaxCompressorInducerMetric;
      vMinExducerValue = kMinCompressorExducerMetric;
      vMaxExducerValue = kMaxCompressorExducerMetric;

      unitValue = unitLengthMillimeter;
      pressureUnitValue = unitPressureBar;
      exducerTurbineMetric = exducerTurbineValue;
      exducerTurbineDisplay = exducerTurbineValue.toStringAsFixed(1);
      inducerTurbineMetric = inducerTurbineValue;

      inducerTurbineDisplay = inducerTurbineValue.toStringAsFixed(1);

      pressureTurbineDisplay = pressureTurbineResult.toStringAsFixed(2);
      //sliderDivisions = null;
      sliderDivisionInducerExducer = 130;
    }
  }

  @override
  void initState() {
    super.initState();

    resetValues(metricUnit);
  }

  Widget get infoButton {
    if (inducerTurbineValue < exducerTurbineValue) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.red.shade900,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            // parameters
            var analyticsParameter = {'Snackbar': 'Turbine'};
            // Execute a function to send logEvent() to Firebase Analytics
            Analytics.analyticsLogEvent(
                AnalyticsEventType.snack_bar, analyticsParameter);
          });
    }
    return Text('');
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
            'On the turbine, the inducer should be larger than the exducer.\n\nIncrease the size of the inducer or decrease the size of the exducer.',
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

  late double petrolTurboCalc;

  CalculatorBrain calculateWithBrain = CalculatorBrain(
    compressorInducerSize: inducerTurbineValue,
    compressorExducerSize: exducerTurbineValue,
    turbineInducerSize: inducerTurbineValue,
    turbineExducerSize: exducerTurbineValue,
  );

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
            Text('TURBINE',
                style: kAppBarTextStyle, textScaleFactor: textScaleFactorTc),
            Container(width: 30.0, child: infoButton),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ReusableCard(
            onPress: () {},
            //Turbine side Inducer *****************************
            colour: kActiveCardColourInput,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    StepButton(
                        icon: FontAwesomeIcons.minus,
                        onStepPress: () {
                          timer = Timer.periodic(
                              Duration(milliseconds: tapTime), (t) {
                            setState(() {
                              if (Decimal.parse(
                                      inducerTurbineValue.toStringAsFixed(2)) >
                                  Decimal.parse(
                                      vMinInducerValue.toStringAsFixed(2))) {
                                inducerTurbineValue = inducerTurbineValue -
                                    stepValueCompressorTurbine;

                                trimTurbineResult =
                                    calculateWithBrain.calculateTurbineTrim(
                                        inducerTurbineValue,
                                        exducerTurbineValue);
                                pressureTurbineResult =
                                    calculateWithBrain.calculateTurbinePressure(
                                        inducerTurbineValue,
                                        exducerTurbineValue);
                                print('stepDirection - $stepDirection');
                                print(
                                    'inducerTurbineValueStepA $inducerTurbineValue');
                                print(
                                    'inducerTurbineValue $inducerTurbineValue');
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
                                    inducerTurbineValue.toStringAsFixed(2)) >
                                Decimal.parse(
                                    vMinInducerValue.toStringAsFixed(2))) {
                              inducerTurbineValue = inducerTurbineValue -
                                  stepValueCompressorTurbine;

                              trimTurbineResult =
                                  calculateWithBrain.calculateTurbineTrim(
                                      inducerTurbineValue, exducerTurbineValue);
                              pressureTurbineResult =
                                  calculateWithBrain.calculateTurbinePressure(
                                      inducerTurbineValue, exducerTurbineValue);
                              print('stepDirection - $stepDirection');
                              print(
                                  'inducerTurbineValueStepA $inducerTurbineValue');
                              print('inducerTurbineValue $inducerTurbineValue');
                            }
                          });
                        }),
                    Column(
                      children: <Widget>[
                        Text('INDUCER',
                            style: kLabelTextStyleLarge,
                            textScaleFactor: textScaleFactorTc * 1.2),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.white,
                            thumbColor: kTurbineInducerSliderNob,
                            valueIndicatorColor: kTurbineInducerSliderNob,
                            overlayColor: kTurbineSliderOverlayColor,
                            inactiveTrackColor: kInactiveSlideColour,
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: kNobThumbShapeLarge),
                            overlayShape: RoundSliderOverlayShape(
                                overlayRadius: kNobOverlayShapeLarge),
                          ),
                          child: Slider(
                              value: inducerTurbineValue,
                              min: vMinInducerValue * 0.99,
                              max: vMaxExducerValue * 1.01,
                              label: inducerTurbineValue.toStringAsFixed(2),
                              inactiveColor: Color(0xFF8D8E89),
                              divisions: sliderDivisionInducerExducer,
                              onChanged: (double newInducerValue) {
                                setState(() {
                                  inducerTurbineValue = newInducerValue;
                                  trimTurbineResult =
                                      calculateWithBrain.calculateTurbineTrim(
                                          inducerTurbineValue,
                                          exducerTurbineValue);
                                  pressureTurbineResult = calculateWithBrain
                                      .calculateTurbinePressure(
                                          inducerTurbineValue,
                                          exducerTurbineValue);
                                });
                              }),
                        ),
                      ],
                    ),
                    StepButton(
                        icon: FontAwesomeIcons.plus,
                        onStepPress: () {
                          timer = Timer.periodic(
                              Duration(milliseconds: tapTime), (t) {
                            setState(() {
                              if (Decimal.parse(
                                      inducerTurbineValue.toStringAsFixed(2)) <
                                  Decimal.parse(
                                      vMaxInducerValue.toStringAsFixed(2))) {
                                inducerTurbineValue = inducerTurbineValue +
                                    stepValueCompressorTurbine;

                                trimTurbineResult =
                                    calculateWithBrain.calculateTurbineTrim(
                                        inducerTurbineValue,
                                        exducerTurbineValue);
                                pressureTurbineResult =
                                    calculateWithBrain.calculateTurbinePressure(
                                        inducerTurbineValue,
                                        exducerTurbineValue);
                                print('stepDirection + $stepDirection');
                                print(
                                    'inducerTurbineValueStepB $inducerTurbineValue');
                                print(
                                    'inducerTurbineValue $inducerTurbineValue');
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
                                    inducerTurbineValue.toStringAsFixed(2)) <
                                Decimal.parse(
                                    vMaxInducerValue.toStringAsFixed(2))) {
                              inducerTurbineValue = inducerTurbineValue +
                                  stepValueCompressorTurbine;

                              trimTurbineResult =
                                  calculateWithBrain.calculateTurbineTrim(
                                      inducerTurbineValue, exducerTurbineValue);
                              pressureTurbineResult =
                                  calculateWithBrain.calculateTurbinePressure(
                                      inducerTurbineValue, exducerTurbineValue);
                              print('stepDirection + $stepDirection');
                              print(
                                  'inducerTurbineValueStepB $inducerTurbineValue');
                              print('inducerTurbineValue $inducerTurbineValue');
                            }
                          });
                        }),
                  ],
                ),

                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 130,
                        child: Column(
                          children: <Widget>[
                            Text('INDUCER',
                                style: kLabelTextStyleLarge,
                                textScaleFactor: textScaleFactorTc),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: kInputNumberWidth,
                                  child: Text(inducerTurbineDisplay,
                                      style: kResultNumberStyleWhite18_600,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    width: kInputUnitWidth,
                                    child: Text(unitValue,
                                        style: kUnitTextStyleAirflow,
                                        textScaleFactor: textScaleFactorTc)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AnimatedContainer(
                              // Use the properties stored in the State class.
                              width: 5,
                              height: 2,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              // Define how long the animation should take.
                              duration: Duration(seconds: 4),
                              // Provide an optional curve to make the animation feel smoother.
                              curve: Curves.fastLinearToSlowEaseIn,
                            ),
                            AnimatedContainer(
                              // Use the properties stored in the State class.
                              width: 13,
                              height: inducerTurbineMetric * 0.7,
                              decoration: BoxDecoration(
                                color: kTurbineInducerSliderNob,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              // Define how long the animation should take.
                              duration: Duration(seconds: 4),
                              // Provide an optional curve to make the animation feel smoother.
                              curve: Curves.fastLinearToSlowEaseIn,
                            ),
                            AnimatedContainer(
                              // Use the properties stored in the State class.
                              width: 0,
                              height: 100,
                              decoration: BoxDecoration(
                                color: kActiveCardColourOutput,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              // Define how long the animation should take.
                              duration: Duration(seconds: 4),
                              // Provide an optional curve to make the animation feel smoother.
                              curve: Curves.fastLinearToSlowEaseIn,
                            ),
                            AnimatedContainer(
                              // Use the properties stored in the State class.
                              width: 13,
                              height: exducerTurbineMetric * 0.7,
                              decoration: BoxDecoration(
                                color: kTurbineExducerSliderNob,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              // Define how long the animation should take.
                              duration: Duration(seconds: 4),
                              // Provide an optional curve to make the animation feel smoother.
                              curve: Curves.fastLinearToSlowEaseIn,
                            ),
                            AnimatedContainer(
                              // Use the properties stored in the State class.
                              width: 5,
                              height: 2,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              // Define how long the animation should take.
                              duration: Duration(seconds: 4),
                              // Provide an optional curve to make the animation feel smoother.
                              curve: Curves.fastLinearToSlowEaseIn,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 130,
                        child: Column(
                          children: <Widget>[
                            Text('EXDUCER',
                                style: kLabelTextStyleLarge,
                                textScaleFactor: textScaleFactorTc),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: kInputNumberWidth,
                                  child: Text(exducerTurbineDisplay,
                                      style: kResultNumberStyleWhite18_600,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    width: kResultUnitWidth,
                                    child: Text(unitValue,
                                        style: kUnitTextStyleAirflow,
                                        textScaleFactor: textScaleFactorTc)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //Axel **************s
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    StepButton(
                        icon: FontAwesomeIcons.minus,
                        onStepPress: () {
                          timer = Timer.periodic(
                              Duration(milliseconds: tapTime), (t) {
                            setState(() {
                              if ((Decimal.parse(
                                      exducerTurbineValue.toStringAsFixed(2)) >
                                  (Decimal.parse(
                                      vMinExducerValue.toStringAsFixed(2))))) {
                                exducerTurbineValue = exducerTurbineValue -
                                    stepValueCompressorTurbine;

                                trimTurbineResult =
                                    calculateWithBrain.calculateTurbineTrim(
                                        inducerTurbineValue,
                                        exducerTurbineValue);
                                pressureTurbineResult =
                                    calculateWithBrain.calculateTurbinePressure(
                                        inducerTurbineValue,
                                        exducerTurbineValue);
                                print('stepDirection - $stepDirection');
                                print(
                                    'exducerTurbineValueStepA $exducerTurbineValue');
                                print(
                                    'exducerTurbineValue $exducerTurbineValue');
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
                                    exducerTurbineValue.toStringAsFixed(2)) >
                                (Decimal.parse(
                                    vMinExducerValue.toStringAsFixed(2))))) {
                              exducerTurbineValue = exducerTurbineValue -
                                  stepValueCompressorTurbine;

                              trimTurbineResult =
                                  calculateWithBrain.calculateTurbineTrim(
                                      inducerTurbineValue, exducerTurbineValue);
                              pressureTurbineResult =
                                  calculateWithBrain.calculateTurbinePressure(
                                      inducerTurbineValue, exducerTurbineValue);
                              print('stepDirection - $stepDirection');
                              print(
                                  'exducerTurbineValueStepA $exducerTurbineValue');
                              print('exducerTurbineValue $exducerTurbineValue');
                            }
                          });
                        }),
                    Column(
                      children: <Widget>[
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: kActiveSlideColour,
                            thumbColor: kTurbineExducerSliderNob,
                            valueIndicatorColor: kTurbineExducerSliderNob,
                            overlayColor: kTurbineSliderOverlayColor,
                            inactiveTrackColor: kActiveSlideColour,
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: kNobThumbShapeLarge),
                            overlayShape: RoundSliderOverlayShape(
                                overlayRadius: kNobOverlayShapeLarge),
                          ),
                          child: Slider(
                              value: exducerTurbineValue,
                              min: vMinInducerValue * 0.99,
                              max: vMaxExducerValue * 1.01,
                              label: exducerTurbineValue.toStringAsFixed(2),
                              inactiveColor: Color(0xFF8D8E89),
                              divisions: sliderDivisionInducerExducer,
                              onChanged: (double newExducerValue) {
                                setState(() {
                                  exducerTurbineValue = newExducerValue;
                                  trimTurbineResult =
                                      calculateWithBrain.calculateTurbineTrim(
                                          inducerTurbineValue,
                                          exducerTurbineValue);
                                  pressureTurbineResult = calculateWithBrain
                                      .calculateTurbinePressure(
                                          inducerTurbineValue,
                                          exducerTurbineValue);
                                });
                              }),
                        ),
                        Text('EXDUCER',
                            textAlign: TextAlign.left,
                            style: kLabelTextStyleLarge,
                            textScaleFactor: textScaleFactorTc * 1.2),
                      ],
                    ),
                    StepButton(
                        icon: FontAwesomeIcons.plus,
                        onStepPress: () {
                          timer = Timer.periodic(
                              Duration(milliseconds: tapTime), (t) {
                            setState(() {
                              if ((Decimal.parse(
                                      exducerTurbineValue.toStringAsFixed(2)) <
                                  (Decimal.parse(
                                      vMaxExducerValue.toStringAsFixed(2))))) {
                                exducerTurbineValue = exducerTurbineValue +
                                    stepValueCompressorTurbine;

                                trimTurbineResult =
                                    calculateWithBrain.calculateTurbineTrim(
                                        inducerTurbineValue,
                                        exducerTurbineValue);
                                pressureTurbineResult =
                                    calculateWithBrain.calculateTurbinePressure(
                                        inducerTurbineValue,
                                        exducerTurbineValue);
                                print('stepDirection + $stepDirection');
                                print(
                                    'exducerTurbineValue $exducerTurbineValue');
                                print(
                                    'exducerTurbineValue $exducerTurbineValue');
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
                                    exducerTurbineValue.toStringAsFixed(2)) <
                                (Decimal.parse(
                                    vMaxExducerValue.toStringAsFixed(2))))) {
                              exducerTurbineValue = exducerTurbineValue +
                                  stepValueCompressorTurbine;

                              trimTurbineResult =
                                  calculateWithBrain.calculateTurbineTrim(
                                      inducerTurbineValue, exducerTurbineValue);
                              pressureTurbineResult =
                                  calculateWithBrain.calculateTurbinePressure(
                                      inducerTurbineValue, exducerTurbineValue);
                              print('stepDirection + $stepDirection');
                              print('exducerTurbineValue $exducerTurbineValue');
                              print('exducerTurbineValue $exducerTurbineValue');
                            }
                          });
                        }),
                  ],
                ),

                //Center(
                // child: Image(
                //   image: AssetImage('images/turbo_picture.jpg'),
                // ),
                //)
              ],
            ),
          ), //Turbo-Size
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  onPress: () {},
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(' ',
                          style: kLabelTextStyle,
                          textScaleFactor: textScaleFactorTc),
                      Text('TRIM',
                          style: kLabelTextStyleLarge,
                          textScaleFactor: textScaleFactorTc),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(trimTurbineResult.toStringAsFixed(0),
                              style: kResultNumberStyleWhite18_600,
                              textScaleFactor: textScaleFactorTc),
                        ],
                      ),
                    ],
                  ),
                  colour: kActiveCardColourOutput,
                ),
              ),
              Expanded(
                child: ReusableCard(
                  onPress: () {},
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('BACK',
                          style: kLabelTextStyleLarge,
                          textScaleFactor: textScaleFactorTc),
                      Text('PRESSURE',
                          style: kLabelTextStyleLarge,
                          textScaleFactor: textScaleFactorTc),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: kResultNumberBigWidth,
                            child: Text(pressureTurbineDisplay,
                                style: kResultNumberStyleWhite18_600,
                                textScaleFactor: textScaleFactorTc),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: kResultUnitWidth,
                            child: Text(pressureUnitValue,
                                style: kUnitTextStyleAirflow,
                                textScaleFactor: textScaleFactorTc),
                          ),
                        ],
                      ),
                    ],
                  ),
                  colour: kActiveCardColourOutput,
                ),
              ),
            ],
          )),
          ReusableCard(
            onPress: () {},
            colour: kActiveCardColourInput,
            cardChild: (Container(
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Inch',
                                style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc,
                              ),
                              Text(
                                'psi',
                                style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc,
                              ),
                            ],
                          ),
                          SizedBox(width: 6),
                          Container(
                            child: Switch.adaptive(
                              value: metricUnit,
                              activeColor: vEngineSizeSwitchActiveColor,
                              activeTrackColor:
                                  vEngineSizeSwitchInActiveThumbColor,
                              inactiveTrackColor:
                                  vEngineSizeSwitchActiveTrackColor,
                              inactiveThumbColor:
                                  vEngineSizeSwitchInActiveTrackColor,

                              //secondary: Icon(Icons.linear_scale),
                              onChanged: _onChangedUnitSwitch,
                              // contentPadding: EdgeInsets.only(
                              // left: 17.0, top: 0.0, right: 17.0, bottom: 0.0),
//                  title: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(
//                        'Imperal or Metric Units',
//                        style: TextStyle(
//                            fontWeight: FontWeight.bold, color: Colors.grey),
//                        textScaleFactor: textScaleFactorTc - 0.3,
//                      ),
//                      Text(
//                        'Inch - Millimeter',
//                        style: TextStyle(
//                            fontWeight: FontWeight.bold, color: Colors.white),
//                        textScaleFactor: textScaleFactorTc - 0.15,
//                      ),
//                    ],
//                  ),
                            ),
                          ),
                          SizedBox(width: 6),
                          Column(
                            children: <Widget>[
                              Text(
                                'mm',
                                style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc,
                              ),
                              Text(
                                'bar',
                                style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '(Switch will reset the values to default)',
                            style: kBodyItalicTextStyle,
                            textScaleFactor: textScaleFactorTc * 0.8,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )),
          )

          //Inch and Info
        ],
      ),
    );
  }

  void resetValues(bool metricUnit) {
    setState(() {
      if (metricUnit) {
        vMinInducerValue = kMinTurbineInducerMetric;
        vMaxInducerValue = kMaxTurbineInducerMetric;
        vMinExducerValue = kMinTurbineExducerMetric;
        vMaxExducerValue = kMaxTurbineExducerMetric;

        unitValue = unitLengthMillimeter;
        pressureUnitValue = unitPressureBar;

        inducerTurbineMetric = kMaxTurbineInducerMetric;
        exducerTurbineMetric = kMinTurbineExducerMetric;
        inducerTurbineValue = kMaxTurbineInducerMetric;
        exducerTurbineValue = kMinTurbineExducerMetric;

        exducerTurbineDisplay = exducerTurbineValue.toStringAsFixed(1);
        inducerTurbineDisplay = inducerTurbineValue.toStringAsFixed(1);
        pressureTurbineDisplay = pressureTurbineResult.toStringAsFixed(2);
        trimTurbineDisplay = trimTurbineResult.toStringAsFixed(0);

        sliderDivisionInducerExducer = 130;
      } else {
        vMinInducerValue = kMinTurbineInducerImperial;
        vMaxInducerValue = kMaxTurbineInducerImperial;
        vMinExducerValue = kMinTurbineExducerImperial;
        vMaxExducerValue = kMaxTurbineExducerImperial;

        unitValue = unitLengthInch;
        pressureUnitValue = unitPressurePsi;

        inducerTurbineImperial = kMaxTurbineInducerImperial;
        exducerTurbineImperial = kMinTurbineExducerImperial;
        inducerTurbineValue = kMaxTurbineInducerImperial;
        exducerTurbineValue = kMinTurbineExducerImperial;

        inducerTurbineDisplay = kMinTurbineInducerImperial.toStringAsFixed(2);
        exducerTurbineDisplay = kMaxTurbineExducerMetric.toStringAsFixed(2);
        pressureTurbineResult = calculateWithBrain.calculateTurbinePressure(
            inducerTurbineValue, exducerTurbineValue);
        pressureTurbineDisplay = pressureTurbineResult.toStringAsFixed(2);
        trimTurbineDisplay = trimCompressorResult.toStringAsFixed(0);

        sliderDivisionInducerExducer = 53;
      }
    });
  }
}
