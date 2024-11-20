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

class HpBasedOnTorquePage extends StatefulWidget {
  bool metricUnit;

  HpBasedOnTorquePage({required Key key, required this.metricUnit})
      : super(key: key);

  @override
  _HpBasedOnTorquePageState createState() =>
      _HpBasedOnTorquePageState(metricUnit);
}

class _HpBasedOnTorquePageState extends State<HpBasedOnTorquePage> {
  bool metricUnit;

  late double resultTorque;

  _HpBasedOnTorquePageState(this.metricUnit) {
    resultTorque = 0.0; // Initialize resultTorque
  }

  //************ END Airflow *******************************************

  // bool metricUnit = false;
  bool snackBarEnable = true;

  Widget get submitRatingButton {
    if (snackBarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(snackBarCompressor);

            // parameters
            var _analyticsParameter = {'Snackbar': 'HP-Torque'};
            // Execute a function to send logEvent() to Firebase Analytics
            Analytics.analyticsLogEvent(
                AnalyticsEventType.snack_bar, _analyticsParameter);
          });
    }
    return Container();
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

  CalculatorBrain calculate = CalculatorBrain(
    compressorInducerSize: 0.0,
    compressorExducerSize: 0.0,
    turbineInducerSize: 0.0,
    turbineExducerSize: 0.0,
  );

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
                AppLocalizations.of(context)
                    .translate('tuning_hp_torque_0000') //'HP based on TORQUE',
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
                onPress: () {
                  setState(() {
                    resetAll();
                  });
                },
                colour: kActiveCardColourOutput,
                cardChild: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          Center(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  dividerColor: kActiveCardColourOutput),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DataTable(
                                    horizontalMargin: 0,
                                    headingRowHeight: 8,
                                    columnSpacing: 30,
                                    dataRowHeight: tableRowHeight,
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        '',
                                        style: TextStyle(color: Colors.white),
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
                                                  .translate(
                                                      'tuning_hp_torque_0010') //'Horsepower',
                                              ,
                                              style: kLabelTextStyleLarge,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        )),
                                        DataCell(
                                          Text(
                                            resultHpTorque.toStringAsFixed(0),
                                            style:
                                                kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitHorsePower,
                                            style: kLabelTextStyle,
                                            textScaleFactor:
                                                textScaleFactorTc * 1.3,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(
                                          Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        'tuning_hp_torque_0020') // 'Kilowatt',
                                                ,
                                                style: kLabelTextStyleLarge,
                                                textScaleFactor:
                                                    textScaleFactorTc,
                                              ),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            (resultHpTorque * 0.745699872)
                                                .toStringAsFixed(0),
                                            style:
                                                kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            AppLocalizations.of(context).translate(
                                                'tuning_hp_torque_0030') // 'Kw',
                                            ,
                                            style: kLabelTextStyle,
                                            textScaleFactor:
                                                textScaleFactorTc * 1.3,
                                          ),
                                        ),
                                      ]),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              ReusableCard(
                onPress: () {},
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
                                      'tuning_hp_torque_0040') //'Torque',
                                  ,
                                  style: kLabelTextStyleLarge,
                                  textScaleFactor: textScaleFactorTc),
                            ),
                            //Text('hpTorqueTorque  $hpTorqueTorque'),

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
                                  value: hpTorqueTorque,
                                  min: vMinHpTorqueTorque,
                                  max: vMaxHpTorqueTorque,
                                  label: hpTorqueTorque.toStringAsFixed(0),
                                  inactiveColor: Color(0xFF8D8E89),
                                  divisions: sliderSliderHpTorqueTorque,
                                  onChanged: (double sliderValue) {
                                    hpTorqueTorque = sliderValue;
                                    debugPrint(
                                        'SLIDE hpTorqueTorque $hpTorqueTorque');

                                    calculateHpTorque(
                                        hpTorqueTorque, hpTorqueRpm);
                                  }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,

                                  width: kInputNumberWidth + 30,
                                  // color: Colors.blue,
                                  child: Text(hpTorqueTorque.toStringAsFixed(0),
                                      style: kResultNumberStyleWhite18_600,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                                Container(
                                  alignment: Alignment.center,

                                  width: kInputUnitWidth,
                                  // color: Colors.orange,
                                  child: Text(unitTorque,
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

                                            if ((Decimal.parse(hpTorqueTorque
                                                    .toStringAsFixed(0)) >
                                                (Decimal.parse(
                                                    (vMinHpTorqueTorque)
                                                        .toStringAsFixed(
                                                            0))))) {
                                              hpTorqueTorque = hpTorqueTorque -
                                                  stepHpTorqueTorque;

                                              calculateHpTorque(
                                                  hpTorqueTorque, hpTorqueRpm);
                                            }
                                          });
                                        });
                                      },
                                      onPressEnd: () {
                                        timer.cancel();
                                      },
                                      onStep: () {
                                        setState(() {
                                          if ((Decimal.parse(hpTorqueTorque
                                                  .toStringAsFixed(0)) >
                                              (Decimal.parse(
                                                  (vMinHpTorqueTorque)
                                                      .toStringAsFixed(0))))) {
                                            hpTorqueTorque = hpTorqueTorque -
                                                stepHpTorqueTorque;

                                            calculateHpTorque(
                                                hpTorqueTorque, hpTorqueRpm);
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
                                                'hpTorqueTorque $hpTorqueTorque');
                                            print(
                                                'kMaxhpTorqueTorque $vMaxHpTorqueTorque');
                                            if ((Decimal.parse(hpTorqueTorque
                                                    .toStringAsFixed(3)) <
                                                (Decimal.parse(
                                                    (vMaxHpTorqueTorque)
                                                        .toStringAsFixed(
                                                            3))))) {
                                              hpTorqueTorque = hpTorqueTorque +
                                                  stepHpTorqueTorque;

                                              calculateHpTorque(
                                                  hpTorqueTorque, hpTorqueRpm);
                                            }
                                          });
                                        });
                                      },
                                      onPressEnd: () {
                                        timer.cancel();
                                      },
                                      onStep: () {
                                        setState(() {
                                          if ((Decimal.parse(hpTorqueTorque
                                                  .toStringAsFixed(3)) <
                                              (Decimal.parse(
                                                  (vMaxHpTorqueTorque)
                                                      .toStringAsFixed(3))))) {
                                            hpTorqueTorque = hpTorqueTorque +
                                                stepHpTorqueTorque;

                                            calculateHpTorque(
                                                hpTorqueTorque, hpTorqueRpm);
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
                                          'tuning_hp_torque_0050') //'RPM',
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
                                      value: hpTorqueRpm,
                                      min: vMinHpTorqueRpm,
                                      max: vMaxHpTorqueRpm,
                                      label: hpTorqueRpm.toStringAsFixed(0),
                                      inactiveColor: Color(0xFF8D8E89),
                                      divisions: sliderSliderHpTorqueRpm,
                                      onChanged: (double value) {
                                        hpTorqueRpm = value;
                                        debugPrint(
                                            'SLIDE hpTorqueRpmSlide $hpTorqueRpm');

                                        calculateHpTorque(
                                            hpTorqueTorque, hpTorqueRpm);
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
                                          hpTorqueRpm.toStringAsFixed(0),
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
                                                            hpTorqueRpm
                                                                .toStringAsFixed(
                                                                    0)) >
                                                        (Decimal.parse(
                                                            vMinHpTorqueRpm
                                                                .toStringAsFixed(
                                                                    0))))) {
                                                      hpTorqueRpm =
                                                          hpTorqueRpm -
                                                              stepHpTorqueRpm;

                                                      calculateHpTorque(
                                                          hpTorqueTorque,
                                                          hpTorqueRpm);
                                                    }
                                                  });
                                                });
                                              },
                                              onPressEnd: () {
                                                timer.cancel();
                                              },
                                              onStep: () {
                                                setState(() {
                                                  if ((Decimal.parse(hpTorqueRpm
                                                          .toStringAsFixed(0)) >
                                                      (Decimal.parse(
                                                          vMinHpTorqueRpm
                                                              .toStringAsFixed(
                                                                  0))))) {
                                                    hpTorqueRpm = hpTorqueRpm -
                                                        stepHpTorqueRpm;

                                                    calculateHpTorque(
                                                        hpTorqueTorque,
                                                        hpTorqueRpm);
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
                                                        'hpTorqueRpm $hpTorqueRpm');
                                                    print(
                                                        'kMaxhpTorqueRpm $vMaxHpTorqueRpm');
                                                    if ((Decimal.parse(
                                                            hpTorqueRpm
                                                                .toStringAsFixed(
                                                                    0)) <
                                                        (Decimal.parse(
                                                            vMaxHpTorqueRpm
                                                                .toStringAsFixed(
                                                                    0))))) {
                                                      hpTorqueRpm =
                                                          hpTorqueRpm +
                                                              stepHpTorqueRpm;

                                                      calculateHpTorque(
                                                          hpTorqueTorque,
                                                          hpTorqueRpm);
                                                    }
                                                  });
                                                });
                                              },
                                              onPressEnd: () {
                                                timer.cancel();
                                              },
                                              onStep: () {
                                                setState(() {
                                                  if ((Decimal.parse(hpTorqueRpm
                                                          .toStringAsFixed(0)) <
                                                      (Decimal.parse(
                                                          vMaxHpTorqueRpm
                                                              .toStringAsFixed(
                                                                  0))))) {
                                                    hpTorqueRpm = hpTorqueRpm +
                                                        stepHpTorqueRpm;

                                                    calculateHpTorque(
                                                        hpTorqueTorque,
                                                        hpTorqueRpm);
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

  calculateHpTorque(double hpTorqueTorque, double hpTorqueRpm) {
    // metricUnit = true;
    setState(() {
      resultHpTorque = calculate.calculateHpTorque(hpTorqueTorque, hpTorqueRpm);
    });
  }

  resetAll() {
    setState(() {
      resultTorque = 250;

      hpTorqueRpm = 5252;
      hpTorqueTorque = 250;

      vMinHpTorqueRpm = 0;
      vMaxHpTorqueRpm = 15000;
      vMinHpTorqueTorque = 0;
      vMaxHpTorqueTorque = 3000;
      stepHpTorqueTorque = 1.0;
      stepHpTorqueRpm = 1.0;

      sliderSliderHpTorqueTorque = (vMaxHpTorqueTorque ~/ 10).toInt();
      sliderSliderHpTorqueRpm = (vMaxHpTorqueRpm ~/ 100).toInt();

      resultHpTorque = calculate.calculateHpTorque(hpTorqueTorque, hpTorqueRpm);

      unitTorque = 'ft-lbs';

      debugPrint('SLIDE hpTorqueTorque $hpTorqueTorque');
    });
  }
}
