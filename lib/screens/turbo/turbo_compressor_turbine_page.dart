import 'dart:async';
import 'package:tct/components/analytics_event.dart';
import 'package:tct/data_models/analytics_event_type.dart';
import 'package:tct/components/stepbutton.dart';
import 'package:tct/globals/app_localizations.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/reusable_card.dart';
import '../../globals/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tct/globals/calculator_brain.dart';
import 'package:decimal/decimal.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:tct/globals/constants_ui.dart';
import 'package:flushbar/flushbar.dart';

class CompressorTurbinePage extends StatefulWidget {
  final bool metricUnit;

  CompressorTurbinePage(
      {Key key, @required this.metricUnit, RouteSettings settings})
      : super(key: key);

  @override
  _CompressorTurbinePageState createState() =>
      _CompressorTurbinePageState(metricUnit);
}

class _CompressorTurbinePageState extends State<CompressorTurbinePage> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  bool metricUnit;

  _CompressorTurbinePageState(this.metricUnit);

  //bool metricUnit = false;
  bool buttonBool = false;
  bool flushBarStatus = false;

  void _onChangedUnitSwitch(bool value) {
//    SettingsNotifier settings = Provider.of<SettingsNotifier>(context, listen: false);
  }

  @override
  void setState(key) {
    super.setState(key);

//    print(inducerCompressorMetric);
//    print(inducerTurbineMetric);
  }

  @override
  void initState() {
    super.initState();
    resetValues(metricUnit);
  }

  helpIcon(BuildContext context) {
    var _onPressed;
    if (_enabled) {
      _onPressed = () {
        showSimpleFlushbar(context);
        setState(() {
          _enabled = false;
        });
      };
    }
    if (inducerCompressorMetric > exducerCompressorMetric ||
        inducerTurbineMetric < exducerTurbineMetric) {
      return IconButton(
        icon: Icon(
          Icons.error_outline,
          size: 30,
        ),
        color: Colors.red.shade700,
        onPressed: _onPressed,
      );
    }
    return Text('');
  }

//  var snackBarText01 =
//      'On the Compressor, the exducer should be larger than the inducer.\n\nOn the Turbine, the exducer should be smaller than the inducer.';
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//  SnackBar mysnackbar = SnackBar(
//    content: SingleChildScrollView(
//      child: Column(
//        children: <Widget>[
//          SizedBox(
//            height: 20.0,
//          ),
//          Text(
//            'On the Compressor, the exducer should be larger than the inducer.\n\nOn the Turbine, the exducer should be smaller than the inducer.',
//            style: TextStyle(
//                color: Colors.grey.shade900,
//                fontSize: 14,
//                fontWeight: FontWeight.bold),
//            textScaleFactor: textScaleFactorTc,
//          ),
//          SizedBox(
//            height: 10.0,
//          ),
//          Text(
//            kSnackBarDevelopmentInfo,
//            style: kSnackBarTextStyle,
//            textScaleFactor: textScaleFactorTc,
//          ),
//        ],
//      ),
//    ),
//    backgroundColor: Colors.grey.shade400,
//    duration: Duration(seconds: 60),
//    action: SnackBarAction(
//      label: 'Close',
//      textColor: Colors.grey.shade600,
//      onPressed: () {},
//    ),
//  );

  double petrolTurboCalc;

  CalculatorBrain calculateWithBrain = CalculatorBrain();
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    //  SettingsNotifier settings = Provider.of<SettingsNotifier>(context);

    return Scaffold(
      // key: _scaffoldKey,
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
                    'compressor_turbine_0000') //'COMPRESSOR TURBINE',
                ,
                style: kAppBarTextStyle,
                textScaleFactor: textScaleFactorTc * 0.9),
            // Container(width: 50),

            Container(width: 30.0, child: helpIcon(context)),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: Theme(
            data: Theme.of(context)
                .copyWith(dividerColor: kActiveCardColourOutput),
            child: Builder(builder: (context) {
              if (inducerCompressorMetric > exducerCompressorMetric ||
                  inducerTurbineMetric < exducerTurbineMetric) {
                buttonBool = true;
              } else {
                buttonBool = false;
              }
              return Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Container(width: 30.0, child: submitRatingButton(context)),

                  FlipCard(
                    key: cardKey,
                    direction: FlipDirection.HORIZONTAL,
                    flipOnTouch: false,
                    speed: 800,
                    front: CompressorSide(),
                    back: TurbineSide(),
                  ),
                  turboDrawing(),
                  //mapTest(),
                  ResultCard(),
                  //Turbo-Size

                  //Fuel (Hp)
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  void showSimpleFlushbar(BuildContext context) {
    String flushBarMessage05 =
        AppLocalizations.of(context).translate('compressor_turbine_0005');
    String flushBarMessage06 =
        AppLocalizations.of(context).translate('compressor_turbine_0006');
    String flushBarMessage07 =
        AppLocalizations.of(context).translate('compressor_turbine_0007');
    String flushBarMessage08 =
        AppLocalizations.of(context).translate('compressor_turbine_0008');

    flushBarStatus = true;

    // parameters
    var _analyticsParameter = {'Snackbar': 'CompressorTurbine'};
    // Execute a function to send logEvent() to Firebase Analytics
    Analytics.analyticsLogEvent(
        AnalyticsEventType.snack_bar, _analyticsParameter);

    Flushbar(
      // There is also a messageText property for when you want to
      // use a Text widget and not just a simple String

      backgroundColor: Colors.white,
      leftBarIndicatorColor: Colors.red,
      //showProgressIndicator: true,
      //progressIndicatorBackgroundColor: Colors.red,
      //progressIndicatorValueColor: Animation<Colors.red>,
      //borderColor: Colors.blue,
      //borderWidth: 10,
      messageText: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            flushBarMessage05,
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textScaleFactor: textScaleFactorTc,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            flushBarMessage06,
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
            flushBarMessage07,
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
            flushBarMessage08,
            style: kSnackBarTextStyle,
            textScaleFactor: textScaleFactorTc,
          ),
        ],
      ), //'Hello from a Flushbar',
      // Even the button can be styled to your heart's content
      mainButton: FlatButton(
        child: Text(
          'Close',
          style: TextStyle(color: Colors.black),
        ),
        // onPressed: () {},
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            _enabled = true;
          });
        },
      ),
      // duration: Duration(seconds: 5),

      // Show it with a cascading operator
    )..show(context);
  }

  Widget CompressorSide() {
    // flipSide = true;
    return ReusableCard(
      //Compressor side Inducer *****************************
      colour: kActiveCardColourInput,
      cardChild: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StepButton(
                  icon: FontAwesomeIcons.minus,
                  onStepPress: () {
                    timer =
                        Timer.periodic(Duration(milliseconds: tapTime), (t) {
                      setState(() {
                        if (Decimal.parse(
                                inducerCompressorMetric.toStringAsFixed(2)) >
                            Decimal.parse(kMinCompressorInducerMetric
                                .toStringAsFixed(2))) {
                          inducerCompressorMetric = inducerCompressorMetric -
                              stepValueCompressorTurbine;

                          hpPetrolResult = calculateWithBrain
                              .calculatePetrolHp(inducerCompressorMetric);
                          hpDieselResult = calculateWithBrain
                              .calculateDieselHp(inducerCompressorMetric);
                          trimCompressorResult =
                              calculateWithBrain.calculateCompressorTrim(
                                  inducerCompressorMetric,
                                  exducerCompressorMetric);
                          pressureCompressorResult =
                              calculateWithBrain.calculateCompressorPressure(
                                  inducerCompressorMetric,
                                  exducerCompressorMetric);
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
                              inducerCompressorMetric.toStringAsFixed(2)) >
                          Decimal.parse(
                              kMinCompressorInducerMetric.toStringAsFixed(2))) {
                        inducerCompressorMetric = inducerCompressorMetric -
                            stepValueCompressorTurbine;

                        hpPetrolResult = calculateWithBrain
                            .calculatePetrolHp(inducerCompressorMetric);
                        hpDieselResult = calculateWithBrain
                            .calculateDieselHp(inducerCompressorMetric);
                        trimCompressorResult =
                            calculateWithBrain.calculateCompressorTrim(
                                inducerCompressorMetric,
                                exducerCompressorMetric);
                        pressureCompressorResult =
                            calculateWithBrain.calculateCompressorPressure(
                                inducerCompressorMetric,
                                exducerCompressorMetric);
                      }
                    });
                  }),
              Column(
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context)
                          .translate('compressor_turbine_0010') //'INDUCER',
                      ,
                      style: kLabelTextStyleLarge,
                      textScaleFactor: textScaleFactorTc),
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
                        value: inducerCompressorMetric,
                        min: kMinCompressorInducerMetric,
                        max: kMaxCompressorInducerMetric,
                        label: inducerCompressorMetric.toStringAsFixed(2),
                        inactiveColor: Color(0xFF8D8E89),
                        divisions: sliderDivisionInducerExducer,
                        onChanged: (double ettValue) {
                          setState(() {
                            inducerCompressorMetric = ettValue;

                            hpPetrolResult = calculateWithBrain
                                .calculatePetrolHp(inducerCompressorMetric);
                            hpDieselResult = calculateWithBrain
                                .calculateDieselHp(inducerCompressorMetric);
                            trimCompressorResult =
                                calculateWithBrain.calculateCompressorTrim(
                                    inducerCompressorMetric,
                                    exducerCompressorMetric);
                            pressureCompressorResult =
                                calculateWithBrain.calculateCompressorPressure(
                                    inducerCompressorMetric,
                                    exducerCompressorMetric);
                          });
                        }),
                  ),
                ],
              ),
              StepButton(
                  icon: FontAwesomeIcons.plus,
                  onStepPress: () {
                    timer =
                        Timer.periodic(Duration(milliseconds: tapTime), (t) {
                      setState(() {
                        if (Decimal.parse(
                                inducerCompressorMetric.toStringAsFixed(2)) <
                            Decimal.parse(kMaxCompressorInducerMetric
                                .toStringAsFixed(2))) {
                          inducerCompressorMetric = inducerCompressorMetric +
                              stepValueCompressorTurbine;

                          hpPetrolResult = calculateWithBrain
                              .calculatePetrolHp(inducerCompressorMetric);
                          hpDieselResult = calculateWithBrain
                              .calculateDieselHp(inducerCompressorMetric);
                          trimCompressorResult =
                              calculateWithBrain.calculateCompressorTrim(
                                  inducerCompressorMetric,
                                  exducerCompressorMetric);
                          pressureCompressorResult =
                              calculateWithBrain.calculateCompressorPressure(
                                  inducerCompressorMetric,
                                  exducerCompressorMetric);
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
                              inducerCompressorMetric.toStringAsFixed(2)) <
                          Decimal.parse(
                              kMaxCompressorInducerMetric.toStringAsFixed(2))) {
                        inducerCompressorMetric = inducerCompressorMetric +
                            stepValueCompressorTurbine;

                        hpPetrolResult = calculateWithBrain
                            .calculatePetrolHp(inducerCompressorMetric);
                        hpDieselResult = calculateWithBrain
                            .calculateDieselHp(inducerCompressorMetric);
                        trimCompressorResult =
                            calculateWithBrain.calculateCompressorTrim(
                                inducerCompressorMetric,
                                exducerCompressorMetric);
                        pressureCompressorResult =
                            calculateWithBrain.calculateCompressorPressure(
                                inducerCompressorMetric,
                                exducerCompressorMetric);
                      }
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 60,
                    child: FlatButton(
                      color: kActiveCardColourInput,
                      splashColor: Colors.red,
//                  shape: RoundedRectangleBorder(
//                    borderRadius: new BorderRadius.circular(8.0),
//                    side: BorderSide(color: Colors.blue),
//                  ),
                      onPressed: () {
                        cardKey.currentState.toggleCard();
//                        print(flipSide);
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_back_ios,
                              size: 22,
                              color: kTurbineInducerSliderNob,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                  AppLocalizations.of(context)
                      .translate('compressor_turbine_0020') //'COMPRESSOR',
                  ,
                  style: kCompressorTextStyleLarge,
                  textScaleFactor: textScaleFactorTc * 1.5),
              Column(
                children: <Widget>[
                  Container(
                    width: 60,
                    child: FlatButton(
                      color: kActiveCardColourInput,
                      splashColor: Colors.red,
//                  shape: RoundedRectangleBorder(
//                    borderRadius: new BorderRadius.circular(8.0),
//                    side: BorderSide(color: Colors.blue),
//                  ),
                      onPressed: () {
                        cardKey.currentState.toggleCard();
//                        print(flipSide);
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 22,
                              color: kTurbineInducerSliderNob,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StepButton(
                  icon: FontAwesomeIcons.minus,
                  onStepPress: () {
                    timer =
                        Timer.periodic(Duration(milliseconds: tapTime), (t) {
                      setState(() {
                        if ((Decimal.parse(
                                exducerCompressorMetric.toStringAsFixed(2)) >
                            (Decimal.parse(kMinCompressorExducerMetric
                                .toStringAsFixed(2))))) {
                          exducerCompressorMetric = exducerCompressorMetric -
                              stepValueCompressorTurbine;

                          trimCompressorResult =
                              calculateWithBrain.calculateCompressorTrim(
                                  inducerCompressorMetric,
                                  exducerCompressorMetric);
                          pressureCompressorResult =
                              calculateWithBrain.calculateCompressorPressure(
                                  inducerCompressorMetric,
                                  exducerCompressorMetric);
//                          print('stepDirection - $stepDirection');
//                          print(
//                              'exducerCompressorMetricStepA $exducerCompressorMetric');
//                          print(
//                              'exducerCompressorMetric $exducerCompressorMetric');
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
                              exducerCompressorMetric.toStringAsFixed(2)) >
                          (Decimal.parse(kMinCompressorExducerMetric
                              .toStringAsFixed(2))))) {
                        exducerCompressorMetric = exducerCompressorMetric -
                            stepValueCompressorTurbine;

                        trimCompressorResult =
                            calculateWithBrain.calculateCompressorTrim(
                                inducerCompressorMetric,
                                exducerCompressorMetric);
                        pressureCompressorResult =
                            calculateWithBrain.calculateCompressorPressure(
                                inducerCompressorMetric,
                                exducerCompressorMetric);
//                        print('stepDirection - $stepDirection');
//                        print(
//                            'exducerCompressorMetricStepA $exducerCompressorMetric');
//                        print(
//                            'exducerCompressorMetric $exducerCompressorMetric');
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
                        value: exducerCompressorMetric,
                        min: kMinCompressorExducerMetric,
                        max: kMaxCompressorExducerMetric,
                        label: exducerCompressorMetric.toStringAsFixed(2),
                        inactiveColor: Color(0xFF8D8E89),
                        divisions: sliderDivisionInducerExducer,
                        onChanged: (double twoValue) {
                          setState(() {
                            exducerCompressorMetric = twoValue;
                            hpPetrolResult = calculateWithBrain
                                .calculatePetrolHp(inducerCompressorMetric);
                            hpDieselResult = calculateWithBrain
                                .calculateDieselHp(inducerCompressorMetric);
                            trimCompressorResult =
                                calculateWithBrain.calculateCompressorTrim(
                                    inducerCompressorMetric,
                                    exducerCompressorMetric);
                            pressureCompressorResult =
                                calculateWithBrain.calculateCompressorPressure(
                                    inducerCompressorMetric,
                                    exducerCompressorMetric);
                          });
                        }),
                  ),
                  Text(
                      AppLocalizations.of(context)
                          .translate('compressor_turbine_0030') //'EXDUCER',
                      ,
                      style: kLabelTextStyleLarge,
                      textScaleFactor: textScaleFactorTc),
                ],
              ),
              StepButton(
                  icon: FontAwesomeIcons.plus,
                  onStepPress: () {
                    timer =
                        Timer.periodic(Duration(milliseconds: tapTime), (t) {
                      setState(() {
//                        print(
//                            'exducerCompressorMetricStepA $exducerCompressorMetric');
//                        print(
//                            'exducerCompressorMetricA $exducerCompressorMetric');
                        if ((Decimal.parse(
                                exducerCompressorMetric.toStringAsFixed(2)) <
                            (Decimal.parse(kMaxCompressorExducerMetric
                                .toStringAsFixed(2))))) {
                          exducerCompressorMetric = exducerCompressorMetric +
                              stepValueCompressorTurbine;

                          trimCompressorResult =
                              calculateWithBrain.calculateCompressorTrim(
                                  inducerCompressorMetric,
                                  exducerCompressorMetric);
                          pressureCompressorResult =
                              calculateWithBrain.calculateCompressorPressure(
                                  inducerCompressorMetric,
                                  exducerCompressorMetric);
//                          print('stepDirection + $stepDirection');
//                          print(
//                              'exducerCompressorMetricStepB $exducerCompressorMetric');
//                          print(
//                              'exducerCompressorMetricB $exducerCompressorMetric');
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
                              exducerCompressorMetric.toStringAsFixed(2)) <
                          (Decimal.parse(kMaxCompressorExducerMetric
                              .toStringAsFixed(2))))) {
                        exducerCompressorMetric = exducerCompressorMetric +
                            stepValueCompressorTurbine;

                        trimCompressorResult =
                            calculateWithBrain.calculateCompressorTrim(
                                inducerCompressorMetric,
                                exducerCompressorMetric);
                        pressureCompressorResult =
                            calculateWithBrain.calculateCompressorPressure(
                                inducerCompressorMetric,
                                exducerCompressorMetric);
//                        print('stepDirection + $stepDirection');
//                        print(
//                            'exducerCompressorMetricStepB $exducerCompressorMetric');
//                        print(
//                            'exducerCompressorMetric $exducerCompressorMetric');
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
    );
  }

  Widget TurbineSide() {
    // flipSide = false;

    return ReusableCard(
      //Turbine side Inducer *****************************
      colour: kActiveCardColourInput,
      cardChild: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StepButton(
                  icon: FontAwesomeIcons.minus,
                  onStepPress: () {
                    timer =
                        Timer.periodic(Duration(milliseconds: tapTime), (t) {
                      setState(() {
                        if (Decimal.parse(
                                inducerTurbineMetric.toStringAsFixed(2)) >
                            Decimal.parse(
                                kMinTurbineInducerMetric.toStringAsFixed(2))) {
                          inducerTurbineMetric =
                              inducerTurbineMetric - stepValueCompressorTurbine;

                          trimTurbineResult =
                              calculateWithBrain.calculateTurbineTrim(
                                  inducerTurbineMetric, exducerTurbineMetric);
                          pressureTurbineResult =
                              calculateWithBrain.calculateTurbinePressure(
                                  inducerTurbineMetric, exducerTurbineMetric);
//                          print('stepDirection - $stepDirection');
//                          print(
//                              'inducerTurbineMetricStepA $inducerTurbineMetric');
//                          print('inducerTurbineMetric $inducerTurbineMetric');
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
                              inducerTurbineMetric.toStringAsFixed(2)) >
                          Decimal.parse(
                              kMinTurbineInducerMetric.toStringAsFixed(2))) {
                        inducerTurbineMetric =
                            inducerTurbineMetric - stepValueCompressorTurbine;

                        trimTurbineResult =
                            calculateWithBrain.calculateTurbineTrim(
                                inducerTurbineMetric, exducerTurbineMetric);
                        pressureTurbineResult =
                            calculateWithBrain.calculateTurbinePressure(
                                inducerTurbineMetric, exducerTurbineMetric);
                        print('stepDirection - $stepDirection');
                        print(
                            'inducerTurbineMetricStepA $inducerTurbineMetric');
                        print('inducerTurbineMetric $inducerTurbineMetric');
                      }
                    });
                  }),
              Column(
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context)
                          .translate('compressor_turbine_0040') //'INDUCER',
                      ,
                      style: kLabelTextStyleLarge,
                      textScaleFactor: textScaleFactorTc),
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
                        value: inducerTurbineMetric,
                        min: kMinTurbineExducerMetric,
                        max: kMaxTurbineExducerMetric,
                        label: inducerTurbineMetric.toStringAsFixed(2),
                        inactiveColor: Color(0xFF8D8E89),
                        divisions: sliderDivisionInducerExducer,
                        onChanged: (double newInducerValue) {
                          setState(() {
                            inducerTurbineMetric = newInducerValue;
                            trimTurbineResult =
                                calculateWithBrain.calculateTurbineTrim(
                                    inducerTurbineMetric, exducerTurbineMetric);
                            pressureTurbineResult =
                                calculateWithBrain.calculateTurbinePressure(
                                    inducerTurbineMetric, exducerTurbineMetric);
                            print('Start Slider');
                            print(
                                'inducerCompressorMetric $inducerCompressorMetric');
                            print(
                                'exducerCompressorMetric $exducerCompressorMetric');
                            print('inducerTurbineMetric $inducerTurbineMetric');
                            print('exducerTurbineMetric $exducerTurbineMetric');
                            print(
                                'stepValueCompressorTurbine $stepValueCompressorTurbine');
                            print(
                                'sliderDivisionInducerExducer $sliderDivisionInducerExducer');

                            print(
                                'kMinCompressorInducerMetric $kMinCompressorInducerMetric');
                            print(
                                'kMaxCompressorExducerMetric $kMaxCompressorExducerMetric');
                            print(
                                'kMinTurbineExducerMetric $kMinTurbineExducerMetric');
                            print(
                                'kMaxTurbineInducerMetric $kMaxTurbineInducerMetric');
                          });
                        }),
                  ),
                ],
              ),
              StepButton(
                  icon: FontAwesomeIcons.plus,
                  onStepPress: () {
                    timer =
                        Timer.periodic(Duration(milliseconds: tapTime), (t) {
                      setState(() {
                        if (Decimal.parse(
                                inducerTurbineMetric.toStringAsFixed(2)) <
                            Decimal.parse(
                                kMaxTurbineInducerMetric.toStringAsFixed(2))) {
                          inducerTurbineMetric =
                              inducerTurbineMetric + stepValueCompressorTurbine;

                          trimTurbineResult =
                              calculateWithBrain.calculateTurbineTrim(
                                  inducerTurbineMetric, exducerTurbineMetric);
                          pressureTurbineResult =
                              calculateWithBrain.calculateTurbinePressure(
                                  inducerTurbineMetric, exducerTurbineMetric);
                          print('stepDirection + $stepDirection');
                          print(
                              'inducerTurbineMetricStepB $inducerTurbineMetric');
                          print('inducerTurbineMetric $inducerTurbineMetric');
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
                              inducerTurbineMetric.toStringAsFixed(2)) <
                          Decimal.parse(
                              kMaxTurbineInducerMetric.toStringAsFixed(2))) {
                        inducerTurbineMetric =
                            inducerTurbineMetric + stepValueCompressorTurbine;

                        trimTurbineResult =
                            calculateWithBrain.calculateTurbineTrim(
                                inducerTurbineMetric, exducerTurbineMetric);
                        pressureTurbineResult =
                            calculateWithBrain.calculateTurbinePressure(
                                inducerTurbineMetric, exducerTurbineMetric);
                        print('stepDirection + $stepDirection');
                        print(
                            'inducerTurbineMetricStepB $inducerTurbineMetric');
                        print('inducerTurbineMetric $inducerTurbineMetric');
                      }
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 60,
                child: FlatButton(
                  color: kActiveCardColourInput,
                  splashColor: Colors.blue,
//              shape: RoundedRectangleBorder(
//                borderRadius: new BorderRadius.circular(8.0),
//                side: BorderSide(color: Colors.blue),
//              ),
                  onPressed: () {
                    cardKey.currentState.toggleCard();
                    print(flipSide);
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          size: 22,
                          color: kCompressorInducerSliderNob,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                  AppLocalizations.of(context)
                      .translate('compressor_turbine_0050') //'TURBINE',
                  ,
                  style: kTurbineTextStyleLarge,
                  textScaleFactor: textScaleFactorTc * 1.5),
              Container(
                width: 60,
                child: FlatButton(
                  color: kActiveCardColourInput,
                  splashColor: Colors.blue,
//              shape: RoundedRectangleBorder(
//                borderRadius: new BorderRadius.circular(8.0),
//                side: BorderSide(color: Colors.blue),
//              ),
                  onPressed: () {
                    cardKey.currentState.toggleCard();
                    print(flipSide);
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: kCompressorInducerSliderNob,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          //SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StepButton(
                  icon: FontAwesomeIcons.minus,
                  onStepPress: () {
                    timer =
                        Timer.periodic(Duration(milliseconds: tapTime), (t) {
                      setState(() {
                        if ((Decimal.parse(
                                exducerTurbineMetric.toStringAsFixed(2)) >
                            (Decimal.parse(kMinTurbineInducerMetric
                                .toStringAsFixed(2))))) {
                          exducerTurbineMetric =
                              exducerTurbineMetric - stepValueCompressorTurbine;

                          trimTurbineResult =
                              calculateWithBrain.calculateTurbineTrim(
                                  inducerTurbineMetric, exducerTurbineMetric);
                          pressureTurbineResult =
                              calculateWithBrain.calculateTurbinePressure(
                                  inducerTurbineMetric, exducerTurbineMetric);
                          print('stepDirection - $stepDirection');
                          print(
                              'exducerTurbineMetricStepA $exducerTurbineMetric');
                          print('exducerTurbineMetric $exducerTurbineMetric');
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
                              exducerTurbineMetric.toStringAsFixed(2)) >
                          (Decimal.parse(
                              kMinTurbineExducerMetric.toStringAsFixed(2))))) {
                        exducerTurbineMetric =
                            exducerTurbineMetric - stepValueCompressorTurbine;

                        trimTurbineResult =
                            calculateWithBrain.calculateTurbineTrim(
                                inducerTurbineMetric, exducerTurbineMetric);
                        pressureTurbineResult =
                            calculateWithBrain.calculateTurbinePressure(
                                inducerTurbineMetric, exducerTurbineMetric);
                        print('stepDirection - $stepDirection');
                        print(
                            'exducerTurbineMetricStepA $exducerTurbineMetric');
                        print('exducerTurbineMetric $exducerTurbineMetric');
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
                        value: exducerTurbineMetric,
                        min: kMinTurbineExducerMetric,
                        max: kMaxTurbineInducerMetric,
                        label: exducerTurbineMetric.toStringAsFixed(2),
                        inactiveColor: Color(0xFF8D8E89),
                        divisions: sliderDivisionInducerExducer,
                        onChanged: (double newExducerValue) {
                          setState(() {
                            exducerTurbineMetric = newExducerValue;
                            trimTurbineResult =
                                calculateWithBrain.calculateTurbineTrim(
                                    inducerTurbineMetric, exducerTurbineMetric);
                            pressureTurbineResult =
                                calculateWithBrain.calculateTurbinePressure(
                                    inducerTurbineMetric, exducerTurbineMetric);
                          });
                        }),
                  ),
                  Text(
                      AppLocalizations.of(context)
                          .translate('compressor_turbine_0060') //'EXDUCER',
                      ,
                      textAlign: TextAlign.left,
                      style: kLabelTextStyleLarge,
                      textScaleFactor: textScaleFactorTc),
                ],
              ),
              StepButton(
                  icon: FontAwesomeIcons.plus,
                  onStepPress: () {
                    timer =
                        Timer.periodic(Duration(milliseconds: tapTime), (t) {
                      setState(() {
                        if ((Decimal.parse(
                                exducerTurbineMetric.toStringAsFixed(2)) <
                            (Decimal.parse(kMaxTurbineExducerMetric
                                .toStringAsFixed(2))))) {
                          exducerTurbineMetric =
                              exducerTurbineMetric + stepValueCompressorTurbine;

                          trimTurbineResult =
                              calculateWithBrain.calculateTurbineTrim(
                                  inducerTurbineMetric, exducerTurbineMetric);
                          pressureTurbineResult =
                              calculateWithBrain.calculateTurbinePressure(
                                  inducerTurbineMetric, exducerTurbineMetric);
                          print('stepDirection + $stepDirection');
                          print('exducerTurbineMetric $exducerTurbineMetric');
                          print('exducerTurbineMetric $exducerTurbineMetric');
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
                              exducerTurbineMetric.toStringAsFixed(2)) <
                          (Decimal.parse(
                              kMaxTurbineExducerMetric.toStringAsFixed(2))))) {
                        exducerTurbineMetric =
                            exducerTurbineMetric + stepValueCompressorTurbine;

                        trimTurbineResult =
                            calculateWithBrain.calculateTurbineTrim(
                                inducerTurbineMetric, exducerTurbineMetric);
                        pressureTurbineResult =
                            calculateWithBrain.calculateTurbinePressure(
                                inducerTurbineMetric, exducerTurbineMetric);
                        print('stepDirection + $stepDirection');
                        print('exducerTurbineMetric $exducerTurbineMetric');
                        print('exducerTurbineMetric $exducerTurbineMetric');
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
    );
  }

  Widget turboDrawing() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: <Widget>[
            Container(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context)
                          .translate('compressor_turbine_0070') //'COMPRESSOR',
                      ,
                      style: kLabelTextStyleActive,
                      textScaleFactor: textScaleFactorTc * .9),
                  SizedBox(height: 4),
                  Text(
                      AppLocalizations.of(context)
                          .translate('compressor_turbine_0080') //'Inducer',
                      ,
                      style: kLabelTextStyle,
                      textScaleFactor: textScaleFactorTc),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //alignment: Alignment.center,
                        width: kInputNumberWidth,
                        child: Text(inducerCompressorMetric.toStringAsFixed(2),
                            style: kResultNumberStyleWhite16_600,
                            textScaleFactor: textScaleFactorTc * .9),
                      ),
                      Container(
                        //  alignment: Alignment.center,
                        width: kInputUnitWidth,
                        child: Text(unitLengthMillimeter,
                            style: kUnitTextStyleAirflow,
                            textScaleFactor: textScaleFactorTc),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.center,
                        width: kInputNumberWidth,
                        child: Text(
                            (inducerCompressorMetric *
                                    kConvertLengthMillimeterToInch)
                                .toStringAsFixed(3),
                            style: kResultNumberStyleWhite16_600,
                            textScaleFactor: textScaleFactorTc * 0.9),
                      ),
                      Container(
                          //   alignment: Alignment.center,
                          width: kResultUnitWidth,
                          child: Text(unitLengthInch,
                              style: kUnitTextStyleAirflow,
                              textScaleFactor: textScaleFactorTc)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context)
                          .translate('compressor_turbine_0090') //'Exducer',
                      ,
                      style: kLabelTextStyle,
                      textScaleFactor: textScaleFactorTc),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.center,
                        width: kInputNumberWidth,
                        child: Text(exducerCompressorMetric.toStringAsFixed(2),
                            style: kResultNumberStyleWhite16_600,
                            textScaleFactor: textScaleFactorTc * 0.9),
                      ),
                      Container(
                          // alignment: Alignment.center,
                          width: kResultUnitWidth,
                          child: Text(unitLengthMillimeter,
                              style: kUnitTextStyleAirflow,
                              textScaleFactor: textScaleFactorTc)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.center,
                        width: kInputNumberWidth,
                        child: Text(
                            (exducerCompressorMetric *
                                    kConvertLengthMillimeterToInch)
                                .toStringAsFixed(3),
                            style: kResultNumberStyleWhite16_600,
                            textScaleFactor: textScaleFactorTc * 0.9),
                      ),
                      Container(
                          //  alignment: Alignment.center,
                          width: kResultUnitWidth,
                          child: Text(unitLengthInch,
                              style: kUnitTextStyleAirflow,
                              textScaleFactor: textScaleFactorTc)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            AnimatedContainer(
              // Use the properties stored in the State class.
              width: 2,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                //borderRadius: BorderRadius.circular(5),
              ),
              // Define how long the animation should take.
              duration: Duration(seconds: 4),
              // Provide an optional curve to make the animation feel smoother.
              curve: Curves.fastLinearToSlowEaseIn,
            ),
            AnimatedContainer(
              // Use the properties stored in the State class.
              width: 2,
              height: inducerCompressorMetric * 0.70,
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
              width: 2,
              height: inducerCompressorMetric * 0.73,
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
              width: 2,
              height: inducerCompressorMetric * 0.76,
              decoration: BoxDecoration(
                color: kCompressorInducerSliderNob,
                //borderRadius: BorderRadius.circular(5),
              ),

              // Define how long the animation should take.
              duration: Duration(seconds: 4),
              // Provide an optional curve to make the animation feel smoother.
              curve: Curves.fastLinearToSlowEaseIn,
            ),
            AnimatedContainer(
              // Use the properties stored in the State class.
              width: 2,
              height: inducerCompressorMetric * 0.79,
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
              width: 2,
              height: inducerCompressorMetric * 0.82,
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
              height: 120,
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
              width: 2,
              height: exducerCompressorMetric * 0.75,
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
              width: 2,
              height: exducerCompressorMetric * 0.80,
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
              width: 2,
              height: exducerCompressorMetric * 0.85,
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
              width: 2,
              height: exducerCompressorMetric * 0.90,
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
              width: 2,
              height: exducerCompressorMetric * 0.95,
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
              width: 10,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey,
                //borderRadius: BorderRadius.circular(5),
              ),
              // Define how long the animation should take.
              duration: Duration(seconds: 4),
              // Provide an optional curve to make the animation feel smoother.
              curve: Curves.fastLinearToSlowEaseIn,
            ),
            AnimatedContainer(
              // Use the properties stored in the State class.
              width: 2,
              height: inducerTurbineMetric * 0.90,
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
              width: 2,
              height: inducerTurbineMetric * .85,
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
              width: 2,
              height: inducerTurbineMetric * 0.80,
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
              width: 2,
              height: inducerTurbineMetric * 0.75,
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
              width: 2,
              height: inducerTurbineMetric * 0.70,
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
              height: 120,
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
              width: 2,
              height: exducerTurbineMetric * 0.82,
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
              width: 2,
              height: exducerTurbineMetric * 0.79,
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
              width: 2,
              height: exducerTurbineMetric * 0.76,
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
              width: 2,
              height: exducerTurbineMetric * 0.73,
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
              width: 2,
              height: exducerTurbineMetric * 0.70,
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
              width: 2,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                //borderRadius: BorderRadius.circular(4),
              ),
              // Define how long the animation should take.
              duration: Duration(seconds: 4),
              // Provide an optional curve to make the animation feel smoother.
              curve: Curves.fastLinearToSlowEaseIn,
            ),
          ],
        ),
        SizedBox(width: 5),
        Column(
          children: <Widget>[
            Container(
              // width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context)
                          .translate('compressor_turbine_0100') //'TURBINE',
                      ,
                      style: kLabelTextStyleActive,
                      textScaleFactor: textScaleFactorTc * .9),
                  SizedBox(height: 4),
                  Text(
                      AppLocalizations.of(context)
                          .translate('compressor_turbine_0110') //'Inducer',
                      ,
                      style: kLabelTextStyle,
                      textScaleFactor: textScaleFactorTc),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //alignment: Alignment.center,
                        width: kInputNumberWidth,
                        child: Text(inducerTurbineMetric.toStringAsFixed(2),
                            style: kResultNumberStyleWhite16_600,
                            textScaleFactor: textScaleFactorTc * .9),
                      ),
                      Container(
                        // alignment: Alignment.center,
                        width: 30,
                        child: Text(unitValue,
                            style: kUnitTextStyleAirflow,
                            textScaleFactor: textScaleFactorTc),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.center,
                        width: kInputNumberWidth,
                        child: Text(
                            (inducerTurbineMetric *
                                    kConvertLengthMillimeterToInch)
                                .toStringAsFixed(3),
                            style: kResultNumberStyleWhite16_600,
                            textScaleFactor: textScaleFactorTc * 0.9),
                      ),
                      Container(
                          // alignment: Alignment.center,
                          width: 30,
                          child: Text(unitLengthInch,
                              style: kUnitTextStyleAirflow,
                              textScaleFactor: textScaleFactorTc)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              // width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context)
                          .translate('compressor_turbine_0120') //'Exducer',
                      ,
                      style: kLabelTextStyle,
                      textScaleFactor: textScaleFactorTc),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.center,
                        width: kInputNumberWidth,
                        child: Text(exducerTurbineMetric.toStringAsFixed(2),
                            style: kResultNumberStyleWhite16_600,
                            textScaleFactor: textScaleFactorTc * 0.9),
                      ),
                      Container(
                          //   alignment: Alignment.center,
                          width: 30,
                          child: Text(unitLengthMillimeter,
                              style: kUnitTextStyleAirflow,
                              textScaleFactor: textScaleFactorTc)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.center,
                        width: kInputNumberWidth,
                        child: Text(
                            (exducerTurbineMetric *
                                    kConvertLengthMillimeterToInch)
                                .toStringAsFixed(3),
                            style: kResultNumberStyleWhite16_600,
                            textScaleFactor: textScaleFactorTc * 0.9),
                      ),
                      Container(
                          // alignment: Alignment.center,
                          width: 30,
                          child: Text(unitLengthInch,
                              style: kUnitTextStyleAirflow,
                              textScaleFactor: textScaleFactorTc)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget ResultCard() {
    tableRowHeight = 17;
    return ReusableCard(
      colour: kActiveCardColourOutput,
      cardChild: Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
        child: Column(
          children: <Widget>[
            DataTable(
                horizontalMargin: horizontalMargin,
                headingRowHeight: headingRowHeight,
                columnSpacing: columnSpacing,
                dataRowHeight: tableRowHeight,
                columns: [
                  DataColumn(
                      label: Text(
                    '',
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: textScaleFactorTc,
                  )),
                  DataColumn(
                      numeric: true,
                      label: Text(
                        AppLocalizations.of(context).translate(
                            'compressor_turbine_0130') //'Compressor',
                        ,
                        style: kResultLabelStyleWhite15_600,
                        textScaleFactor: textScaleFactorTc,
                      )),
                  DataColumn(
                      numeric: true,
                      label: Text(
                        AppLocalizations.of(context)
                            .translate('compressor_turbine_0140') // 'Turbine',
                        ,
                        style: kResultLabelStyleWhite15_600,
                        textScaleFactor: textScaleFactorTc,
                      )),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(
                      AppLocalizations.of(context).translate(
                          'compressor_turbine_0150') //'Inducer size (mm)',
                      ,
                      style: kResultLabelStyleWhite15_600,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        inducerCompressorMetric.toStringAsFixed(2),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                    DataCell(
                      Text(
                        inducerTurbineMetric.toStringAsFixed(2).toString(),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(Text(
                      AppLocalizations.of(context).translate(
                          'compressor_turbine_0160') //'Inducer Size (inch)',
                      ,
                      style: kResultLabelStyleWhite15_600,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        (inducerCompressorMetric / 2.54).toStringAsFixed(3),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                    DataCell(
                      Text(
                        (inducerTurbineMetric / 2.54)
                            .toStringAsFixed(3)
                            .toString(),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(Text(
                      '',
                      style: kLabelTextStyle,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        '',
                        style: kLabelTextStyle,
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
                      AppLocalizations.of(context).translate(
                          'compressor_turbine_0170') //'Exducer size (mm)',
                      ,
                      style: kResultLabelStyleWhite15_600,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        exducerCompressorMetric.toStringAsFixed(2),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                    DataCell(
                      Text(
                        exducerTurbineMetric.toStringAsFixed(2).toString(),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(Text(
                      AppLocalizations.of(context).translate(
                          'compressor_turbine_0180') // 'Exducer Size (inch)',
                      ,
                      style: kResultLabelStyleWhite15_600,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        (exducerCompressorMetric / 2.54).toStringAsFixed(3),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                    DataCell(
                      Text(
                        (exducerTurbineMetric / 2.54)
                            .toStringAsFixed(3)
                            .toString(),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(Text(
                      '',
                      style: kLabelTextStyle,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        '',
                        style: kLabelTextStyle,
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
                          .translate('compressor_turbine_0190') // 'Trim',
                      ,
                      style: kResultLabelStyleWhite15_600,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        trimCompressorResult.toStringAsFixed(0),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                    DataCell(
                      Text(
                        trimTurbineResult.toStringAsFixed(0).toString(),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(Text(
                      '',
                      style: kLabelTextStyle,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        '',
                        style: kLabelTextStyle,
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
                      AppLocalizations.of(context).translate(
                          'compressor_turbine_0200') //'Boost pressure (bar)',
                      ,
                      style: kResultLabelStyleWhite15_600,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        pressureCompressorResult.toStringAsFixed(2),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                    DataCell(
                      Text(
                        pressureTurbineResult.toStringAsFixed(2),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(Text(
                      AppLocalizations.of(context).translate(
                          'compressor_turbine_0210') //'Boost pressure (psi)',
                      ,
                      style: kResultLabelStyleWhite15_600,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        (pressureCompressorResult * kConvertPressureBarToPsi)
                            .toStringAsFixed(2),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                    DataCell(
                      Text(
                        (pressureTurbineResult * kConvertPressureBarToPsi)
                            .toStringAsFixed(2),
                        style: kResultNumberStyleWhite16_600,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(Text(
                      '',
                      style: kLabelTextStyle,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        '',
                        style: kLabelTextStyle,
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
                      AppLocalizations.of(context).translate(
                          'compressor_turbine_0220') //  'Horsepower Gasoline',
                      ,
                      style: kResultLabelStyleWhite15_600,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        hpPetrolResult.toStringAsFixed(0) +
                            ' ' +
                            unitHorsePower,
                        style: kResultNumberStyleWhite16_600,
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
                      AppLocalizations.of(context).translate(
                          'compressor_turbine_0230') // 'Horsepower Diesel',
                      ,
                      style: kResultLabelStyleWhite15_600,
                      textScaleFactor: textScaleFactorTc,
                    )),
                    DataCell(
                      Text(
                        hpDieselResult.toStringAsFixed(0) +
                            ' ' +
                            unitHorsePower,
                        style: kResultNumberStyleWhite16_600,
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
                ]),
          ],
        ),
      ),
    );
  }

  mapTest() {
    return null;
  }

  saveCompressorInducerValue() {
    Future<int> _getIntFromSharedPref() async {
      Map<String, double> turboValues = {
        'inducerCompressorMetric': inducerCompressorMetric,
        'exducerCompressorMetric': exducerCompressorMetric,
        'inducerTurbineMetric': inducerTurbineMetric,
        'exducerTurbineMetric': exducerTurbineMetric,
      };

      final prefs = await SharedPreferences.getInstance();
      final compressorInducerStoredValue =
          prefs.getInt('compressorInducerStoredValue');

      if (compressorInducerStoredValue == null) {
        return 0;
      }
      return compressorInducerStoredValue;
    }

    /// Reset the counter in shared_preferences to 0
    Future<void> _resetCounter() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('startupNumber', 0);
    }

    /// Will Increment the startup number and store it then
    /// use setState to display in the UI
    Future<void> _incrementStartup() async {
      final prefs = await SharedPreferences.getInstance();

      int lastStartupNumber = await _getIntFromSharedPref();
      int currentStartupNumber = ++lastStartupNumber;

      await prefs.setInt('startupNumber', currentStartupNumber);

//    if (currentStartupNumber == 3) {
//      setState(() => haveStartedTimes = '$currentStartupNumber Times Completed');
//
//      // Reset only if you want to
//      await _resetCounter();
//    } else {
      setState(() => haveStartedTimes =
          'You have started this version of the app: $currentStartupNumber times');
//    }
    }
  }

  void resetValues(bool metricUnit) {
    setState(() {
      inducerCompressorMetric = 54.0;
      exducerCompressorMetric = 60.0;
      inducerTurbineMetric = 67.0;
      exducerTurbineMetric = 55.0;

      sliderDivisionInducerExducer = kMaxTurbineExducerMetric.toInt() * 10;

      hpPetrolResult =
          calculateWithBrain.calculatePetrolHp(inducerCompressorMetric);
      hpDieselResult =
          calculateWithBrain.calculateDieselHp(inducerCompressorMetric);
      trimCompressorResult = calculateWithBrain.calculateCompressorTrim(
          inducerCompressorMetric, exducerCompressorMetric);
      trimTurbineResult = calculateWithBrain.calculateTurbineTrim(
          inducerTurbineMetric, exducerTurbineMetric);
      pressureCompressorResult = calculateWithBrain.calculateCompressorPressure(
          inducerCompressorMetric, exducerCompressorMetric);
      pressureTurbineResult = calculateWithBrain.calculateTurbinePressure(
          inducerTurbineMetric, exducerTurbineMetric);
    });
  }
}
