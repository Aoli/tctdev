import 'dart:async';
import 'package:tct/components/analytics_event.dart';
import 'package:tct/data_models/analytics_event_type.dart';
import 'package:tct/components/stepbutton_close.dart';
import 'package:tct/globals/app_localizations.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../globals/calculator_brain.dart';
import '../../components/reusable_card.dart';
import '../../globals/constant.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:tct/globals/constants_ui.dart';

class TorquePage extends StatefulWidget {
  bool metricUnit;

  TorquePage({Key key, @required this.metricUnit}) : super(key: key);

  @override
  _TorquePageState createState() => _TorquePageState(metricUnit);
}

class _TorquePageState extends State<TorquePage> {
  bool metricUnit;

  double resultTorque = 100;

  _TorquePageState(this.metricUnit);

  //************ END Airflow *******************************************

  // bool metricUnit = false;
  bool snackBarEnable = true;

  Widget get submitRatingButton {
    if (snackBarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState.showSnackBar(snackBar);

            // parameters
            var _analyticsParameter = {'Snackbar': 'Torque'};
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
            'Calculate Torque (Engine Displacement) by input torqueRpm, torqueHp, and the number of cylinders.\n\nYou can locally change the unit-setting for this calculation by the switch (inch and mm). All results may be affected by small rounding errors.',
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14,
                fontWeight: FontWeight.normal),
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

    resetAll();
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
                AppLocalizations.of(context).translate('tuning_torque_0000')
                //'TORQUE',
                ,
                style: kAppBarTextStyle,
                textScaleFactor: textScaleFactorTc),
            Container(width: 30.0, child: submitRatingButton),
          ],
        ),
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ReusableCard(
                colour: kActiveCardColourOutput,
                cardChild: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: kActiveCardColourOutput),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DataTable(
                                horizontalMargin: 0,
                                headingRowHeight: 10,
                                columnSpacing: 30,
                                dataRowHeight: tableRowHeight,
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    '',
                                    style: TextStyle(color: Colors.white),
                                    textScaleFactor: textScaleFactorTc * 1.3,
                                  )),
                                  DataColumn(
                                      numeric: true,
                                      label: Text(
                                        '',
                                        style: kLabelTextStyleActive,
                                        textScaleFactor:
                                            textScaleFactorTc * 1.3,
                                      )),
                                  DataColumn(
                                      numeric: true,
                                      label: Text(
                                        '',
                                        style: kLabelTextStyleActive,
                                        textScaleFactor:
                                            textScaleFactorTc * 1.3,
                                      )),
                                ],
                                rows: [
                                  DataRow(cells: [
                                    DataCell(Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('tuning_torque_0010')
                                          //'Torque',
                                          ,
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('tuning_torque_0020')
                                          //' - Imperial'
                                          ,
                                          style: kLabelTextStyle,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ],
                                    )),
                                    DataCell(
                                      Text(
                                        resultTorque.toStringAsFixed(0),
                                        style: kResultNumberStyleWhite18_600,
                                        textScaleFactor: textScaleFactorTc,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        unitTorque,
                                        style: kLabelTextStyle,
                                        textScaleFactor: textScaleFactorTc,
                                      ),
                                    ),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(
                                      Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('tuning_torque_0030')
                                            // 'Torque',
                                            ,
                                            style: kLabelTextStyleLarge,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('tuning_torque_0040')
                                            //' - Metric', style: kLabelTextStyle,
                                            ,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ],
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        (resultTorque * 1.35582)
                                            .toStringAsFixed(0),
                                        style: kResultNumberStyleWhite18_600,
                                        textScaleFactor: textScaleFactorTc,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        AppLocalizations.of(context).translate(
                                            'tuning_torque_0050') //'Nm',
                                        ,
                                        style: kLabelTextStyle,
                                        textScaleFactor: textScaleFactorTc,
                                      ),
                                    ),
                                  ]),
                                ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              ReusableCard(
                colour: kActiveCardColourInput,
                cardChild: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  AppLocalizations.of(context).translate(
                                      'tuning_torque_0060') //'Horsepower',
                                  ,
                                  style: kLabelTextStyleLarge,
                                  textScaleFactor: textScaleFactorTc),
                            ),

                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white,
                                thumbColor: kTurbineInducerSliderNob,
                                overlayColor: kTurbineSliderOverlayColor,
                                valueIndicatorColor: kTurbineInducerSliderNob,
                                inactiveTrackColor: kInactiveSlideColour,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: kNobThumbShapeLarge),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: kNobOverlayShapeLarge),
                              ),
                              child: Slider(
                                  value: torqueHpInput,
                                  min: vMinTorqueHpInput,
                                  max: vMaxTorqueHpInput,
                                  label: torqueHpInput.toStringAsFixed(0),
                                  inactiveColor: Color(0xFF8D8E89),
                                  divisions: sliderSliderTorqueHp,
                                  onChanged: (double sliderValue) {
                                    torqueHpInput = sliderValue;
                                    debugPrint(
                                        'SLIDE torqueHpInput $torqueHpInput');

                                    calcTorqueCalc(
                                        torqueHpInput, torqueRpmInput);
                                  }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,

                                  width: kInputNumberWidth + 30,
                                  // color: Colors.blue,
                                  child: Text(torqueHpInput.toStringAsFixed(0),
                                      style: kResultNumberStyleWhite18_600,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                                Container(
                                  alignment: Alignment.center,

                                  width: kInputUnitWidth,
                                  // color: Colors.orange,
                                  child: Text(unitHorsePower,
                                      style: kUnitTextStyleAirflow,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    StepButtonClose(
                                      icon: FontAwesomeIcons.minus,
                                      onStepPress: () {
                                        setState(() {
                                          timer = Timer.periodic(
                                              Duration(milliseconds: tapTime),
                                              (t) {
                                            print('- press');

                                            if ((Decimal.parse(torqueHpInput
                                                    .toStringAsFixed(0)) >
                                                (Decimal.parse(
                                                    (vMinTorqueHpInput)
                                                        .toStringAsFixed(
                                                            0))))) {
                                              torqueHpInput = torqueHpInput -
                                                  stepTorqueHpInput;

                                              calcTorqueCalc(torqueHpInput,
                                                  torqueRpmInput);
                                            }
                                          });
                                        });
                                      },
                                      onPressEnd: () {
                                        timer.cancel();
                                      },
                                      onStep: () {
                                        setState(() {
                                          if ((Decimal.parse(torqueHpInput
                                                  .toStringAsFixed(0)) >
                                              (Decimal.parse((vMinTorqueHpInput)
                                                  .toStringAsFixed(0))))) {
                                            torqueHpInput = torqueHpInput -
                                                stepTorqueHpInput;

                                            calcTorqueCalc(
                                                torqueHpInput, torqueRpmInput);
                                          }
                                        });
                                      },
                                    ),
                                    StepButtonClose(
                                      icon: FontAwesomeIcons.plus,
                                      onStepPress: () {
                                        setState(() {
                                          timer = Timer.periodic(
                                              Duration(milliseconds: tapTime),
                                              (t) {
                                            print('+ press');
                                            print(
                                                'torqueHpInput $torqueHpInput');
                                            print(
                                                'kMaxTorqueHpInput $vMaxTorqueHpInput');
                                            if ((Decimal.parse(torqueHpInput
                                                    .toStringAsFixed(3)) <
                                                (Decimal.parse(
                                                    (vMaxTorqueHpInput)
                                                        .toStringAsFixed(
                                                            3))))) {
                                              torqueHpInput = torqueHpInput +
                                                  stepTorqueHpInput;

                                              calcTorqueCalc(torqueHpInput,
                                                  torqueRpmInput);
                                            }
                                          });
                                        });
                                      },
                                      onPressEnd: () {
                                        timer.cancel();
                                      },
                                      onStep: () {
                                        setState(() {
                                          if ((Decimal.parse(torqueHpInput
                                                  .toStringAsFixed(3)) <
                                              (Decimal.parse((vMaxTorqueHpInput)
                                                  .toStringAsFixed(3))))) {
                                            torqueHpInput = torqueHpInput +
                                                stepTorqueHpInput;

                                            calcTorqueCalc(
                                                torqueHpInput, torqueRpmInput);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.white70,
                            ),
                            // SizedBox(height: 5),
                            Column(
                              children: <Widget>[
                                //Divider(),
                                //   SizedBox(height: 5),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                      AppLocalizations.of(context).translate(
                                          'tuning_torque_0070') //'RPM',
                                      ,
                                      style: kLabelTextStyleLarge,
                                      textScaleFactor: textScaleFactorTc),
                                ),

                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Colors.white,
                                    thumbColor: kTurbineInducerSliderNob,
                                    overlayColor: kTurbineSliderOverlayColor,
                                    valueIndicatorColor:
                                        kTurbineInducerSliderNob,
                                    inactiveTrackColor: kInactiveSlideColour,
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius:
                                            kNobThumbShapeLarge),
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: kNobOverlayShapeLarge),
                                  ),
                                  child: Slider(
                                      value: torqueRpmInput,
                                      min: vMinTorqueRpmInput,
                                      max: vMaxTorqueRpmInput,
                                      label: torqueRpmInput.toStringAsFixed(0),
                                      inactiveColor: Color(0xFF8D8E89),
                                      divisions: sliderSliderTorqueRpm,
                                      onChanged: (double sliderValue) {
                                        torqueRpmInput = sliderValue;
                                        debugPrint(
                                            'SLIDE torqueRpmInputSlide $torqueRpmInput');

                                        calcTorqueCalc(
                                            torqueHpInput, torqueRpmInput);
                                      }),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,

                                      width: kInputNumberWidth + 30,
                                      // color: Colors.blue,
                                      child: Text(
                                          torqueRpmInput.toStringAsFixed(0),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc),
                                    ),
                                    Container(
                                      alignment: Alignment.center,

                                      width: kInputUnitWidth,
                                      // color: Colors.orange,
                                      child: Text(unitRpm,
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
                                                setState(() {
                                                  timer = Timer.periodic(
                                                      Duration(
                                                          milliseconds:
                                                              tapTime), (t) {
                                                    print('- press');

                                                    if ((Decimal.parse(
                                                            torqueRpmInput
                                                                .toStringAsFixed(
                                                                    0)) >
                                                        (Decimal.parse(
                                                            vMinTorqueRpmInput
                                                                .toStringAsFixed(
                                                                    0))))) {
                                                      torqueRpmInput =
                                                          torqueRpmInput -
                                                              stepTorqueRpmInput;

                                                      calcTorqueCalc(
                                                          torqueHpInput,
                                                          torqueRpmInput);
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
                                                          torqueRpmInput
                                                              .toStringAsFixed(
                                                                  0)) >
                                                      (Decimal.parse(
                                                          vMinTorqueRpmInput
                                                              .toStringAsFixed(
                                                                  0))))) {
                                                    torqueRpmInput =
                                                        torqueRpmInput -
                                                            stepTorqueRpmInput;

                                                    calcTorqueCalc(
                                                        torqueHpInput,
                                                        torqueRpmInput);
                                                  }
                                                });
                                              },
                                            ),
                                            StepButtonClose(
                                              icon: FontAwesomeIcons.plus,
                                              onStepPress: () {
                                                setState(() {
                                                  timer = Timer.periodic(
                                                      Duration(
                                                          milliseconds:
                                                              tapTime), (t) {
                                                    print('+ press');
                                                    print(
                                                        'torqueRpmInput $torqueRpmInput');
                                                    print(
                                                        'kMaxTorqueRpmInput $vMaxTorqueRpmInput');
                                                    if ((Decimal.parse(
                                                            torqueRpmInput
                                                                .toStringAsFixed(
                                                                    0)) <
                                                        (Decimal.parse(
                                                            vMaxTorqueRpmInput
                                                                .toStringAsFixed(
                                                                    0))))) {
                                                      torqueRpmInput =
                                                          torqueRpmInput +
                                                              stepTorqueRpmInput;

                                                      calcTorqueCalc(
                                                          torqueHpInput,
                                                          torqueRpmInput);
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
                                                          torqueRpmInput
                                                              .toStringAsFixed(
                                                                  0)) <
                                                      (Decimal.parse(
                                                          vMaxTorqueRpmInput
                                                              .toStringAsFixed(
                                                                  0))))) {
                                                    torqueRpmInput =
                                                        torqueRpmInput +
                                                            stepTorqueRpmInput;

                                                    calcTorqueCalc(
                                                        torqueHpInput,
                                                        torqueRpmInput);
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Fuel (Hp)
            ],
          ),
        );
      }),
    );
  }

  calcTorqueCalc(double torqueHpInput, double torqueRpmInput) {
    // metricUnit = true;
    setState(() {
      resultTorque = calculate.calculateTorque(torqueHpInput, torqueRpmInput);
    });
  }

  resetAll() {
    setState(() {
      resultTorque = 97.6;

      torqueRpmInput = 5252;
      torqueHpInput = 250;

      vMinTorqueRpmInput = 0;
      vMaxTorqueRpmInput = 15000;
      vMinTorqueHpInput = 0;
      vMaxTorqueHpInput = 1500;
      stepTorqueHpInput = 1.0;
      stepTorqueRpmInput = 1.0;

      resultTorque = calculate.calculateTorque(torqueHpInput, torqueRpmInput);

      unitTorque = 'ft-lbs';
    });
  }
}
