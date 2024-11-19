import 'dart:async';

import 'package:Turbocharger/components/analytics_event.dart';
import 'package:Turbocharger/data_models/analytics_event_type.dart';
import 'package:Turbocharger/components/stepbutton.dart';
import 'package:Turbocharger/provider/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/reusable_card.dart';
import '../globals/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Turbocharger/globals/calculator_brain.dart';
import 'package:decimal/decimal.dart';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:Turbocharger/globals/constants_ui.dart';


class CompressorPage extends StatefulWidget {
  final bool metricUnit;

  CompressorPage({Key key, @required this.metricUnit, RouteSettings settings})
      : super(key: key);

  @override
  _CompressorPageState createState() => _CompressorPageState(metricUnit);
}

class _CompressorPageState extends State<CompressorPage> {
  bool metricUnit;

  _CompressorPageState(this.metricUnit);

  //bool metricUnit = false;
  bool snackbarEnable = true;

  void _onChangedUnitSwitch(bool value) {
//    SettingsNotifier settings = Provider.of<SettingsNotifier>(context, listen: false);

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
        exducerCompressorMetric = exducerCompressorValue;
        exducerCompressorDisplay = exducerCompressorValue.toStringAsFixed(1);
        inducerCompressorMetric = inducerCompressorValue;
        inducerCompressorDisplay = inducerCompressorValue.toStringAsFixed(1);

        pressureCompressorDisplay = pressureCompressorResult.toStringAsFixed(2);
        sliderDivisionInducerExducer = 130;
      } else {
        vMinInducerValue = kMinCompressorInducerImperial;
        vMaxInducerValue = kMaxCompressorInducerImperial;
        vMinExducerValue = kMinCompressorExducerImperial;
        vMaxExducerValue = kMaxCompressorExducerImperial;

        unitValue = unitLengthInch;
        pressureUnitValue = unitPressurePsi;
        exducerCompressorMetric =
            exducerCompressorValue * kConvertLengthInchToMillimeter;
        exducerCompressorDisplay = exducerCompressorValue.toStringAsFixed(2);
        inducerCompressorMetric =
            inducerCompressorValue * kConvertLengthInchToMillimeter;
        inducerCompressorDisplay = inducerCompressorValue.toStringAsFixed(2);
        pressureCompressorDisplay =
            (pressureCompressorResult * kConvertPressureBarToPsi)
                .toStringAsFixed(2);
        sliderDivisions = 550;
        sliderDivisionInducerExducer = 53;
      }
      resetValues(metricUnit);
    });
  }

  @override
  void setState(key) {
    super.setState(key);

    if (metricUnit) {
      vMinInducerValue = kMinCompressorInducerMetric;
      vMaxInducerValue = kMaxCompressorInducerMetric;
      vMinExducerValue = kMinCompressorExducerMetric;
      vMaxExducerValue = kMaxCompressorExducerMetric;

      unitValue = unitLengthMillimeter;
      pressureUnitValue = unitPressureBar;
      exducerCompressorMetric = exducerCompressorValue;
      exducerCompressorDisplay = exducerCompressorValue.toStringAsFixed(1);
      inducerCompressorMetric = inducerCompressorValue;
      inducerCompressorDisplay = inducerCompressorValue.toStringAsFixed(1);

      pressureCompressorDisplay = pressureCompressorResult.toStringAsFixed(2);
      sliderDivisions = null;
      sliderDivisionInducerExducer = 130;
    } else {
      vMinInducerValue = kMinCompressorInducerImperial;
      vMaxInducerValue = kMaxCompressorInducerImperial;
      vMinExducerValue = kMinCompressorExducerImperial;
      vMaxExducerValue = kMaxCompressorExducerImperial;


      unitValue = unitLengthInch;
      pressureUnitValue = unitPressurePsi;

      exducerCompressorMetric =
          exducerCompressorValue * kConvertLengthInchToMillimeter;
      exducerCompressorDisplay = exducerCompressorValue.toStringAsFixed(2);
      inducerCompressorMetric =
          inducerCompressorValue * kConvertLengthInchToMillimeter;
      inducerCompressorDisplay = inducerCompressorValue.toStringAsFixed(2);
      pressureCompressorDisplay =
          (pressureCompressorResult * kConvertPressureBarToPsi)
              .toStringAsFixed(2);
      sliderDivisions = 550;
      sliderDivisionInducerExducer = 53;
    }
  }

  @override
  void initState() {
    super.initState();


    resetValues(metricUnit);
  }

  Widget get submitRatingButton {
    if (inducerCompressorValue > exducerCompressorValue) {
      return IconButton(
        icon: Icon(Icons.info_outline),
        color: Colors.red.shade900,
          onPressed: () {
            _scaffoldKey.currentState
                .showSnackBar(snackBar);

            // parameters
            var _analyticsParameter = {'Snackbar': 'Airflow HP RPM'};
            // Execute a function to send logEvent() to Firebase Analytics
            Analytics.analyticsLogEvent(
                AnalyticsEventType.snack_bar, _analyticsParameter);
          });
    }
    return Text('');
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
            'On the compressor, the exducer should be larger than the inducer.\n\nIncrease the size of the exducer or decrease the size of the inducer.',
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

  double petrolTurboCalc;

  CalculatorBrain calculate = CalculatorBrain();

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settings = Provider.of<SettingsNotifier>(context);
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
            Text('COMPRESSOR',
                style: kAppBarTextStyle, textScaleFactor: textScaleFactorTc),
            Container(width: 30.0, child: submitRatingButton),
          ],
        ),
      ),
      body: Builder(builder: (context) {
        return Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ReusableCard(
              //Compressor side Inducer *****************************
              colour: kActiveCardColourInput,
              cardChild: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.end,
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
                                if (Decimal.parse(inducerCompressorValue
                                    .toStringAsFixed(2)) >
                                    Decimal.parse(
                                        vMinInducerValue.toStringAsFixed(2))) {
                                  inducerCompressorValue =
                                      inducerCompressorValue -
                                          stepValueCompressorTurbine;

                                  exducerCompressorMetric =
                                      exducerCompressorValue;
                                  exducerCompressorDisplay =
                                      exducerCompressorValue.toStringAsFixed(1);
                                  inducerCompressorMetric =
                                      inducerCompressorValue;
                                  inducerCompressorDisplay =
                                      inducerCompressorValue.toStringAsFixed(1);

                                  hpPetrolResult = calculate.calculatePetrolHp(
                                      inducerCompressorMetric);
                                  hpDieselResult = calculate.calculateDieselHp(
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
                            });
                          },
                          onPressEnd: () {
                            timer.cancel();
                          },
                          onStep: () {
                            setState(() {
                              if (Decimal.parse(inducerCompressorValue
                                  .toStringAsFixed(2)) >
                                  Decimal.parse(
                                      vMinInducerValue.toStringAsFixed(2))) {
                                inducerCompressorValue =
                                    inducerCompressorValue -
                                        stepValueCompressorTurbine;

                                exducerCompressorMetric =
                                    exducerCompressorValue;
                                exducerCompressorDisplay =
                                    exducerCompressorValue.toStringAsFixed(1);
                                inducerCompressorMetric =
                                    inducerCompressorValue;
                                inducerCompressorDisplay =
                                    inducerCompressorValue.toStringAsFixed(1);

                                hpPetrolResult = calculate
                                    .calculatePetrolHp(inducerCompressorMetric);
                                hpDieselResult = calculate
                                    .calculateDieselHp(inducerCompressorMetric);
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
                      Column(
                        children: <Widget>[
                          Text('INDUCER',
                              style: kLabelTextStyleLarge,
                              textScaleFactor: textScaleFactorTc * 1.2),
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
                                min: vMinInducerValue * 0.99,
                                max: vMaxInducerValue * 1.02,
                                label:
                                inducerCompressorValue.toStringAsFixed(2),
                                inactiveColor: Color(0xFF8D8E89),
                                divisions: sliderDivisionInducerExducer,
                                onChanged: (double newInducerCompressorValue) {
                                  setState(() {
                                    inducerCompressorValue =
                                        newInducerCompressorValue;
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
                                if (Decimal.parse(inducerCompressorValue
                                    .toStringAsFixed(2)) <
                                    Decimal.parse(
                                        vMaxInducerValue.toStringAsFixed(2))) {
                                  inducerCompressorValue =
                                      inducerCompressorValue +
                                          stepValueCompressorTurbine;
                                  hpPetrolResult = calculate.calculatePetrolHp(
                                      inducerCompressorMetric);
                                  hpDieselResult = calculate.calculateDieselHp(
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
                            });
                          },
                          onPressEnd: () {
                            timer.cancel();
                          },
                          onStep: () {
                            setState(() {
                              if (Decimal.parse(inducerCompressorValue
                                  .toStringAsFixed(2)) <
                                  Decimal.parse(
                                      vMaxInducerValue.toStringAsFixed(2))) {
                                inducerCompressorValue =
                                    inducerCompressorValue +
                                        stepValueCompressorTurbine;
                                hpPetrolResult = calculate
                                    .calculatePetrolHp(inducerCompressorMetric);
                                hpDieselResult = calculate
                                    .calculateDieselHp(inducerCompressorMetric);
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
                    ],
                  ),

                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                                  child: Text(inducerCompressorDisplay,
                                      style: kResultNumberStyleWhite18_600,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: kInputUnitWidth,
                                  child: Text(unitValue,
                                      style: kUnitTextStyleAirflow,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: kInputNumberWidth,
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AnimatedContainer(
                                // Use the properties stored in the State class.
                                width: 5,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                // Define how long the animation should take.
                                duration: Duration(seconds: 4),
                                // Provide an optional curve to make the animation feel smoother.
                                curve: Curves.fastLinearToSlowEaseIn,
                              ),
                              AnimatedContainer(
                                // Use the properties stored in the State class.
                                width: 13,
                                height: inducerCompressorMetric * 0.7,
                                decoration: BoxDecoration(
                                  color: kCompressorInducerSliderNob,
                                  borderRadius: BorderRadius.circular(5),
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
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                // Define how long the animation should take.
                                duration: Duration(seconds: 4),
                                // Provide an optional curve to make the animation feel smoother.
                                curve: Curves.fastLinearToSlowEaseIn,
                              ),
                              AnimatedContainer(
                                // Use the properties stored in the State class.
                                width: 13,
                                height: exducerCompressorMetric * 0.7,
                                decoration: BoxDecoration(
                                  color: kCompressorExducerSliderNob,
                                  borderRadius: BorderRadius.circular(5),
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
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                // Define how long the animation should take.
                                duration: Duration(seconds: 4),
                                // Provide an optional curve to make the animation feel smoother.
                                curve: Curves.fastLinearToSlowEaseIn,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  child: Text(exducerCompressorDisplay,
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
                    ],
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
                                if ((Decimal.parse(exducerCompressorValue
                                    .toStringAsFixed(2)) >
                                    (Decimal.parse(vMinExducerValue
                                        .toStringAsFixed(2))))) {
                                  exducerCompressorValue =
                                      exducerCompressorValue -
                                          stepValueCompressorTurbine;

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
                                      'exducerCompressorValueStepA $exducerCompressorValue');
                                  print(
                                      'exducerCompressorValue $exducerCompressorValue');
                                }
                              });
                            });
                          },
                          onPressEnd: () {
                            timer.cancel();
                          },
                          onStep: () {
                            setState(() {
                              if ((Decimal.parse(exducerCompressorValue
                                  .toStringAsFixed(2)) >
                                  (Decimal.parse(
                                      vMinExducerValue.toStringAsFixed(2))))) {
                                exducerCompressorValue =
                                    exducerCompressorValue -
                                        stepValueCompressorTurbine;

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
                                    'exducerCompressorValueStepA $exducerCompressorValue');
                                print(
                                    'exducerCompressorValue $exducerCompressorValue');
                              }
                            });
                          }),
                      Column(
                        children: <Widget>[
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: kActiveSlideColour,
                              thumbColor: kCompressorExducerSliderNob,
                              valueIndicatorColor: kCompressorExducerSliderNob,
                              overlayColor: kCompressorSliderOverlayColor,
                              inactiveTrackColor: kActiveSlideColour,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: kNobThumbShapeLarge),
                              overlayShape: RoundSliderOverlayShape(
                                  overlayRadius: kNobOverlayShapeLarge),
                            ),
                            child: Slider(
                                value: exducerCompressorValue,
                                min: vMinExducerValue * 0.99,
                                max: vMaxExducerValue * 1.01,
                                label:
                                exducerCompressorValue.toStringAsFixed(2),
                                inactiveColor: Color(0xFF8D8E89),
                                divisions: sliderDivisionInducerExducer,
                                onChanged: (double newValue) {
                                  setState(() {
                                    exducerCompressorValue = newValue;
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
                                  });
                                }),
                          ),
                          Text('EXDUCER',
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
                                print(
                                    'exducerCompressorValueStepA $exducerCompressorValue');
                                print(
                                    'exducerCompressorValueA $exducerCompressorValue');
                                if ((Decimal.parse(exducerCompressorValue
                                    .toStringAsFixed(2)) <
                                    (Decimal.parse(vMaxExducerValue
                                        .toStringAsFixed(2))))) {
                                  exducerCompressorValue =
                                      exducerCompressorValue +
                                          stepValueCompressorTurbine;

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
                                      'exducerCompressorValueStepB $exducerCompressorValue');
                                  print(
                                      'exducerCompressorValueB $exducerCompressorValue');
                                }
                              });
                            });
                          },
                          onPressEnd: () {
                            timer.cancel();
                          },
                          onStep: () {
                            setState(() {
                              if ((Decimal.parse(exducerCompressorValue
                                  .toStringAsFixed(2)) <
                                  (Decimal.parse(
                                      vMaxExducerValue.toStringAsFixed(2))))) {
                                exducerCompressorValue =
                                    exducerCompressorValue +
                                        stepValueCompressorTurbine;

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
                                    'exducerCompressorValueStepB $exducerCompressorValue');
                                print(
                                    'exducerCompressorValue $exducerCompressorValue');
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
                        colour: kActiveCardColourOutput,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(' ',
                                style: kLabelTextStyleLarge,
                                textScaleFactor: textScaleFactorTc),
                            Text('TRIM',
                                style: kLabelTextStyleLarge,
                                textScaleFactor: textScaleFactorTc),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  //(100 *
                                  //      ((pow(inducerCompressor, 2)) /
                                  //        (pow(exducerCompressor, 2))))
                                    trimCompressorResult.toStringAsFixed(0),
                                    //weight.toString(),
                                    style: kResultNumberStyleWhite18_600,
                                    textScaleFactor: textScaleFactorTc),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour: kActiveCardColourOutput,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('BOOST',
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
                                  child: Text(pressureCompressorDisplay,
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
                      ),
                    ),
                  ],
                )),

            Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        colour: kActiveCardColourOutput,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('GASOLINE',
                                style: kLabelTextStyleLarge,
                                textScaleFactor: textScaleFactorTc),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: kResultNumberBigWidth,
                                  child: Text(hpPetrolResult.toStringAsFixed(0),
                                      //weight.toString(),
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
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour: kActiveCardColourOutput,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('DIESEL',
                                style: kLabelTextStyleLarge,
                                textScaleFactor: textScaleFactorTc),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: kResultNumberBigWidth,
                                  child: Text(hpDieselResult.toStringAsFixed(0),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            ReusableCard(
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
            ) //Fuel (Hp)
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
      } else {
        vMinInducerValue = kMinCompressorInducerImperial;
        vMaxInducerValue = kMaxCompressorInducerImperial;
        vMinExducerValue = kMinCompressorExducerImperial;
        vMaxExducerValue = kMaxCompressorExducerImperial;

        unitValue = unitLengthInch;
        pressureUnitValue = unitPressurePsi;

        inducerCompressorImperial = kMinCompressorInducerImperial;
        exducerCompressorImperial = kMaxCompressorExducerImperial;
        inducerCompressorValue = kMinCompressorInducerImperial;
        exducerCompressorValue = kMaxCompressorExducerImperial;

        inducerCompressorDisplay =
            kMinCompressorInducerImperial.toStringAsFixed(2);
        exducerCompressorDisplay =
            kMaxCompressorExducerImperial.toStringAsFixed(2);
        pressureCompressorResult = calculate.calculateCompressorPressure(
            inducerCompressorValue, exducerCompressorValue);
        pressureCompressorDisplay = pressureCompressorResult.toStringAsFixed(2);
        trimCompressorDisplay = trimCompressorResult.toStringAsFixed(0);

        sliderDivisionInducerExducer = 53;
      }
    });
  }
}
