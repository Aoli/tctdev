import 'dart:async';
import 'package:Turbocharger/components/stepbutton_close.dart';
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


class AirFlowConversion extends StatefulWidget {
  final bool metricUnit;

  AirFlowConversion({Key key, @required this.metricUnit}) : super(key: key);

  @override
  _AirFlowConversionState createState() => _AirFlowConversionState(metricUnit);
}

class _AirFlowConversionState extends State<AirFlowConversion> {
  bool metricUnit;

  _AirFlowConversionState(this.metricUnit);

  //************ END Airflow *******************************************

  // bool metricUnit = false;
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
            'Airflow calculations can be rather complicated and are dependent on many circumstances, such as temperature, ambient pressure, in addition to the inputs for the engine or your project. These factors may play a crucial role in getting proper calculations. The Airflow calculations in this app are using formulas that incorporate temperature, pressure, etc. to get the conversion between mass airflow and volume airflow as correct as possible. Many turbo airflow calculations on the internet are missing or estimated those factors and, as a result, often have less accurate outcomes.',
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

    resetValues();
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
              'AIRFLOW Conversion',
              style: kAppBarTextStyle,
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
              ReusableCard(
                cardChild: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Airflow conversion',
                              style: kLabelTextStyleActive,
                              textScaleFactor: textScaleFactorTc,
                            ),
//                            SizedBox(height: 5),
//                            Divider(height: 2),

//
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.red,
                                          width: kInputTextWidth,
                                          child: Text(
                                            'Mass Airflow',
                                            style: kLabelTextStyleActive,
                                            textAlign: TextAlign.left,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        Divider(color: Colors.white),
                                        Container(
                                          // color: Colors.red,
                                          width: kInputTextWidth,
                                          child: Text(
                                            'Pound per Minute',
                                            style: kLabelTextStyle,
                                            textAlign: TextAlign.left,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: kInputNumberWidth,
                                              // color: Colors.blue,
                                              child: Text(
                                                vAirflowPoundMinute
                                                    .toStringAsFixed(2),
                                                style: kResultNumberStyleWhite18_600,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                            Container(
                                              width: kInputUnitWidth + 10,
                                              // color: Colors.orange,
                                              child: Text(
                                                unitMassFlowRatePoundMinute,
                                                textAlign: TextAlign.center,
                                                style: kUnitTextStyleAirflow,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Container(
                                      child: Column(
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
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowPoundMinute
                                                              .toString()) >
                                                          (Decimal.parse(
                                                              kMinAirflowPoundMinute
                                                                  .toString())))) {
                                                        vAirflowPoundMinute =
                                                            vAirflowPoundMinute -
                                                                stepAirflowPoundMinute;

                                                        calcTempCelsius(
                                                            tempTemperatureFahrenheit);
                                                        calcTempFahrenheit(
                                                            tempCelsius);

                                                        calcAirflowPoundPerMinute(
                                                          vAirflowPoundMinute,
                                                          vAirflowManifoldTemp,
                                                          vAirflowPsiAmbient,
                                                          vAirflowPsiG,
                                                        );
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
                                                        vAirflowCfm
                                                            .toString()) >
                                                        (Decimal.parse(
                                                            kMinAirflowPoundMinute
                                                                .toString())))) {
                                                      vAirflowPoundMinute =
                                                          vAirflowPoundMinute -
                                                              stepAirflowPoundMinute;

                                                      calcTempCelsius(
                                                          tempTemperatureFahrenheit);
                                                      calcTempFahrenheit(
                                                          tempCelsius);

                                                      calcAirflowPoundPerMinute(
                                                        vAirflowPoundMinute,
                                                        vAirflowManifoldTemp,
                                                        vAirflowPsiAmbient,
                                                        vAirflowPsiG,
                                                      );
                                                    }
                                                  });
                                                },
                                              ),
                                              StepButtonClose(
                                                icon: FontAwesomeIcons.plus,
                                                onStepPress: () {
                                                  timer = Timer.periodic(
                                                      Duration(
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowPoundMinute
                                                              .toString()) <
                                                          (Decimal.parse(
                                                              kMaxAirflowPoundMinute
                                                                  .toString())))) {
                                                        vAirflowPoundMinute =
                                                            vAirflowPoundMinute +
                                                                stepAirflowPoundMinute;

                                                        calcTempCelsius(
                                                            tempTemperatureFahrenheit);
                                                        calcTempFahrenheit(
                                                            tempCelsius);

                                                        calcAirflowPoundPerMinute(
                                                          vAirflowPoundMinute,
                                                          vAirflowManifoldTemp,
                                                          vAirflowPsiAmbient,
                                                          vAirflowPsiG,
                                                        );
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
                                                        vAirflowPoundMinute
                                                            .toString()) <
                                                        (Decimal.parse(
                                                            kMaxAirflowPoundMinute
                                                                .toString())))) {
                                                      vAirflowPoundMinute =
                                                          vAirflowPoundMinute +
                                                              stepAirflowPoundMinute;

                                                      calcTempCelsius(
                                                          tempTemperatureFahrenheit);
                                                      calcTempFahrenheit(
                                                          tempCelsius);

                                                      calcAirflowPoundPerMinute(
                                                        vAirflowPoundMinute,
                                                        vAirflowManifoldTemp,
                                                        vAirflowPsiAmbient,
                                                        vAirflowPsiG,
                                                      );

                                                      //    calcCubicMeterPerSecond(cubicMeterPerSecondConversion);

                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ), //Minus-button

                                    //Plus-button
                                  ],
                                ),
                                //Minus-button
                              ],
                            ),

                            Divider(color: Colors.white70),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.red,
                                          width: kInputTextWidth,
                                          child: Text(
                                            'Volume Airflow',
                                            style: kLabelTextStyleActive,
                                            textAlign: TextAlign.left,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          // color: Colors.red,
                                          width: kInputTextWidth,
                                          child: Text(
                                            'Cubic Feet per Minute CFM',
                                            style: kLabelTextStyle,
                                            textAlign: TextAlign.left,
                                            textScaleFactor:
                                            textScaleFactorTc * .95,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: kInputNumberWidth + 40,
                                              // color: Colors.blue,
                                              child: Text(
                                                vAirflowCfm.toStringAsFixed(2),
                                                style: kResultNumberStyleWhite18_600,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                            Container(
                                              width: kInputUnitWidth,
                                              // color: Colors.orange,
                                              child: Text(
                                                unitVolumetricFlowRateCfm,
                                                textAlign: TextAlign.center,
                                                style: kUnitTextStyleAirflow,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Container(
                                      child: Column(
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
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowCfm
                                                              .toString()) >
                                                          (Decimal.parse(
                                                              kMinAirflowCfm
                                                                  .toString())))) {
                                                        vAirflowCfm =
                                                            vAirflowCfm -
                                                                stepCubicFeetPerMinute;

                                                        calcTempCelsius(
                                                            tempTemperatureFahrenheit);
                                                        calcTempFahrenheit(
                                                            tempCelsius);
                                                        calcAirflowCfm(
                                                          vAirflowCfm,
                                                          vAirflowManifoldTemp,
                                                          vAirflowPsiAmbient,
                                                          vAirflowPsiG,
                                                        );
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
                                                        vAirflowCfm
                                                            .toString()) >
                                                        (Decimal.parse(
                                                            kMinAirflowCfm
                                                                .toString())))) {
                                                      vAirflowCfm =
                                                          vAirflowCfm -
                                                              stepCubicFeetPerMinute;

                                                      calcTempCelsius(
                                                          tempTemperatureFahrenheit);
                                                      calcTempFahrenheit(
                                                          tempCelsius);
                                                      calcAirflowCfm(
                                                        vAirflowCfm,
                                                        vAirflowManifoldTemp,
                                                        vAirflowPsiAmbient,
                                                        vAirflowPsiG,
                                                      );
                                                    }
                                                  });
                                                },
                                              ),
                                              StepButtonClose(
                                                icon: FontAwesomeIcons.plus,
                                                onStepPress: () {
                                                  timer = Timer.periodic(
                                                      Duration(
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowCfm
                                                              .toString()) <
                                                          (Decimal.parse(
                                                              kMaxAirflowCfm
                                                                  .toString())))) {
                                                        vAirflowCfm =
                                                            vAirflowCfm +
                                                                stepCubicFeetPerMinute;

                                                        calcTempCelsius(
                                                            tempTemperatureFahrenheit);
                                                        calcTempFahrenheit(
                                                            tempCelsius);
                                                        calcAirflowCfm(
                                                          vAirflowCfm,
                                                          vAirflowManifoldTemp,
                                                          vAirflowPsiAmbient,
                                                          vAirflowPsiG,
                                                        );
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
                                                        vAirflowCfm
                                                            .toString()) <
                                                        (Decimal.parse(
                                                            kMaxAirflowCfm
                                                                .toString())))) {
                                                      vAirflowCfm =
                                                          vAirflowCfm +
                                                              stepCubicFeetPerMinute;

                                                      calcTempCelsius(
                                                          tempTemperatureFahrenheit);
                                                      calcTempFahrenheit(
                                                          tempCelsius);
                                                      calcAirflowCfm(
                                                        vAirflowCfm,
                                                        vAirflowManifoldTemp,
                                                        vAirflowPsiAmbient,
                                                        vAirflowPsiG,
                                                      );
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ), //Minus-button

                                    //Plus-button
                                  ],
                                ),
                                //Minus-button
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.red,
                                          width: kInputTextWidth,
                                          child: Text(
                                            'Cubic Meter per Minute',
                                            style: kLabelTextStyle,
                                            textAlign: TextAlign.left,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: kInputNumberWidth + 40,
                                              // color: Colors.blue,
                                              child: Text(
                                                vAirflowCubicMeterPerMinute
                                                    .toStringAsFixed(3),
                                                style: kResultNumberStyleWhite18_600,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                            Container(
                                              width: kInputUnitWidth + 20,
                                              // color: Colors.orange,
                                              child: Text(
                                                unitVolumetricCubicMeterPerMinute,
                                                textAlign: TextAlign.center,
                                                style: kUnitTextStyleAirflow,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Container(
                                      child: Column(
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
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowCubicMeterPerMinute
                                                              .toString()) >
                                                          (Decimal.parse(
                                                              kMinCubicMeterPerMinute
                                                                  .toString())))) {
                                                        vAirflowCubicMeterPerMinute =
                                                            vAirflowCubicMeterPerMinute -
                                                                stepCubicMeterPerMinute;

                                                        calcTempCelsius(
                                                            tempTemperatureFahrenheit);
                                                        calcTempFahrenheit(
                                                            tempCelsius);

                                                        calcCubicMeterPerMinute(
                                                            vAirflowCubicMeterPerMinute);
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
                                                        vAirflowCubicMeterPerMinute
                                                            .toString()) >
                                                        (Decimal.parse(
                                                            kMinCubicMeterPerMinute
                                                                .toString())))) {
                                                      vAirflowCubicMeterPerMinute =
                                                          vAirflowCubicMeterPerMinute -
                                                              stepCubicMeterPerMinute;

                                                      calcTempCelsius(
                                                          tempTemperatureFahrenheit);
                                                      calcTempFahrenheit(
                                                          tempCelsius);
                                                      calcCubicMeterPerMinute(
                                                        vAirflowCubicMeterPerMinute,
                                                      );
                                                    }
                                                  });
                                                },
                                              ),
                                              StepButtonClose(
                                                icon: FontAwesomeIcons.plus,
                                                onStepPress: () {
                                                  timer = Timer.periodic(
                                                      Duration(
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowCubicMeterPerMinute
                                                              .toString()) <
                                                          (Decimal.parse(
                                                              kMaxCubicMeterPerMinute
                                                                  .toString())))) {
                                                        vAirflowCubicMeterPerMinute =
                                                            vAirflowCubicMeterPerMinute +
                                                                stepCubicMeterPerMinute;

                                                        calcTempCelsius(
                                                            tempTemperatureFahrenheit);
                                                        calcTempFahrenheit(
                                                            tempCelsius);

                                                        calcCubicMeterPerMinute(
                                                            vAirflowCubicMeterPerMinute);
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
                                                        vAirflowCubicMeterPerMinute
                                                            .toString()) <
                                                        (Decimal.parse(
                                                            kMaxCubicMeterPerMinute
                                                                .toString())))) {
                                                      vAirflowCubicMeterPerMinute =
                                                          vAirflowCubicMeterPerMinute +
                                                              stepCubicMeterPerMinute;

                                                      calcTempCelsius(
                                                          tempTemperatureFahrenheit);
                                                      calcTempFahrenheit(
                                                          tempCelsius);

                                                      calcCubicMeterPerMinute(
                                                          vAirflowCubicMeterPerMinute);
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ), //Minus-button

                                    //Plus-button
                                  ],
                                ),
                                //Minus-button
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.red,
                                          width: kInputTextWidth,
                                          child: Text(
                                            'Cubic Meter per Second',
                                            style: kLabelTextStyle,
                                            textAlign: TextAlign.left,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: kInputNumberWidth + 40,
                                              // color: Colors.blue,
                                              child: Text(
                                                vAirflowCubicMeterPerSecond
                                                    .toStringAsFixed(4),
                                                style: kResultNumberStyleWhite18_600,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                            Container(
                                              width: kInputUnitWidth,
                                              // color: Colors.orange,
                                              child: Text(
                                                unitVolumetricCubicMeterPerSecond,
                                                textAlign: TextAlign.center,
                                                style: kUnitTextStyleAirflow,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Container(
                                      child: Column(
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
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowCubicMeterPerSecond
                                                              .toString()) >
                                                          (Decimal.parse(
                                                              kMinCubicMeterPerSecond
                                                                  .toString())))) {
                                                        vAirflowCubicMeterPerSecond =
                                                            vAirflowCubicMeterPerSecond -
                                                                stepCubicMeterPerSecond;

                                                        calcTempCelsius(
                                                            tempTemperatureFahrenheit);
                                                        calcTempFahrenheit(
                                                            tempCelsius);

                                                        calcCubicMeterPerSecond(
                                                            vAirflowCubicMeterPerSecond);
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
                                                        vAirflowCubicMeterPerSecond
                                                            .toString()) >
                                                        (Decimal.parse(
                                                            kMinCubicMeterPerSecond
                                                                .toString())))) {
                                                      vAirflowCubicMeterPerSecond =
                                                          vAirflowCubicMeterPerSecond -
                                                              stepCubicMeterPerSecond;

                                                      calcTempCelsius(
                                                          tempTemperatureFahrenheit);
                                                      calcTempFahrenheit(
                                                          tempCelsius);
                                                      calcCubicMeterPerSecond(
                                                        vAirflowCubicMeterPerSecond,
                                                      );
                                                    }
                                                  });
                                                },
                                              ),
                                              StepButtonClose(
                                                icon: FontAwesomeIcons.plus,
                                                onStepPress: () {
                                                  timer = Timer.periodic(
                                                      Duration(
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowCubicMeterPerSecond
                                                              .toString()) <
                                                          (Decimal.parse(
                                                              kMaxCubicMeterPerSecond
                                                                  .toString())))) {
                                                        vAirflowCubicMeterPerSecond =
                                                            vAirflowCubicMeterPerSecond +
                                                                stepCubicMeterPerSecond;

                                                        calcTempCelsius(
                                                            tempTemperatureFahrenheit);
                                                        calcTempFahrenheit(
                                                            tempCelsius);

                                                        calcCubicMeterPerSecond(
                                                            vAirflowCubicMeterPerSecond);
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
                                                        vAirflowCubicMeterPerSecond
                                                            .toString()) <
                                                        (Decimal.parse(
                                                            kMaxCubicMeterPerSecond
                                                                .toString())))) {
                                                      vAirflowCubicMeterPerSecond =
                                                          vAirflowCubicMeterPerSecond +
                                                              stepCubicMeterPerSecond;

                                                      calcTempCelsius(
                                                          tempTemperatureFahrenheit);
                                                      calcTempFahrenheit(
                                                          tempCelsius);

                                                      calcCubicMeterPerSecond(
                                                          vAirflowCubicMeterPerSecond);
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ), //Minus-button

                                    //Plus-button
                                  ],
                                ),
                                //Minus-button
                              ],
                            ),
//                            Divider(color: Colors.white70),
//
//                            Column(
//                              children: <Widget>[
//                                Row(
//                                  mainAxisAlignment:
//                                  MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Column(
//                                      crossAxisAlignment:
//                                      CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Container(
//                                          // color: Colors.red,
//                                          width: kInputTextWidth,
//                                          child: Text(
//                                            'Pressure Ratio',
//                                            style: kLabelTextStyle,
//                                            textAlign: TextAlign.left,
//                                            textScaleFactor: textScaleFactorTc,
//                                          ),
//                                        ),
//                                        Row(
//                                          mainAxisAlignment:
//                                          MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Container(
//                                              width: kInputNumberWidth,
//                                              // color: Colors.blue,
//                                              child: Text(
//                                                pressureRatio
//                                                    .toStringAsFixed(2),
//                                                style: kResultNumberStyle,
//                                                textScaleFactor:
//                                                textScaleFactorTc,
//                                              ),
//                                            ),
//                                            Container(
//                                              width: kInputUnitWidth,
//                                              // color: Colors.orange,
//                                              child: Text(
//                                                unitPressureRatio,
//                                                textAlign: TextAlign.center,
//                                                style: kUnitTextStyleAirflow,
//                                                textScaleFactor:
//                                                textScaleFactorTc,
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ],
//                                    ),
//
//                                    Container(
//                                      width: 100,
//                                    ), //Minus-button
//
//                                    //Plus-button
//                                  ],
//                                ),
//                                //Minus-button
//                              ],
//                            ),
//                            SizedBox(height: 5,),
                            //CFM
                            //vAirflowPoundMinute
//
                          ],
                        ),
                      ),
//                      Divider(height: 2),
                    ],
                  ),
                ),
                colour: kActiveCardColourOutput,
              ),
              ReusableCard(
                cardChild: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
//                            Container(
//                              alignment: Alignment.centerLeft,
//                              child: FlatButton(
//                                // color: Colors.blueGrey,
//                                splashColor: Color(0xFF4c8c4a),
//                                textColor: Colors.white38,
//                                child: Text('Calculate',
//                                    textScaleFactor: textScaleFactorTc * 0.8),
//                                onPressed: () {
//                                  calcCalculate();
//                                },
//                              ),
//                            ),
                            Text(
                              'Manifold Temperature and Pressure',
                              style: kLabelTextStyleActive,
                              textScaleFactor: textScaleFactorTc,
                            ),
                            SizedBox(height: 5),
//                            Divider(height: 2),

                            //CFM
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.red,
                                          width: kInputTextWidth,
                                          child: Text(
                                            'ManiFold Temperature',
                                            style: kLabelTextStyle,
                                            textAlign: TextAlign.left,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: kInputNumberWidth,
                                              // color: Colors.blue,
                                              child: Text(
                                                vAirflowManifoldTemp
                                                    .toStringAsFixed(0),
                                                style: kResultNumberStyleWhite18_600,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                            Container(
                                              width: kInputUnitWidth,
                                              // color: Colors.orange,
                                              child: Text(
                                                unitFahrenheit,
                                                textAlign: TextAlign.center,
                                                style: kUnitTextStyleAirflow,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Container(
                                      child: Column(
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
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowManifoldTemp
                                                              .toString()) >
                                                          (Decimal.parse(
                                                              kMinAirflowManifoldTemp
                                                                  .toString())))) {
                                                        vAirflowManifoldTemp =
                                                            vAirflowManifoldTemp -
                                                                stepAirflowManifoldTemp;

                                                        calcTempAndPressure(
                                                            vAirflowManifoldTemp,
                                                            vAirflowPsiAmbient,
                                                            vAirflowPsiG);
                                                      }
                                                      calcAirflowCfm(
                                                        vAirflowCfm,
                                                        vAirflowManifoldTemp,
                                                        vAirflowPsiAmbient,
                                                        vAirflowPsiG,
                                                      );
                                                      calcAirflowPoundPerMinute(
                                                        vAirflowPoundMinute,
                                                        vAirflowManifoldTemp,
                                                        vAirflowPsiAmbient,
                                                        vAirflowPsiG,
                                                      );
                                                    });
                                                  });
                                                },
                                                onPressEnd: () {
                                                  timer.cancel();
                                                },
                                                onStep: () {
                                                  setState(() {
                                                    if ((Decimal.parse(
                                                        vAirflowManifoldTemp
                                                            .toString()) >
                                                        (Decimal.parse(
                                                            kMinAirflowManifoldTemp
                                                                .toString())))) {
                                                      vAirflowManifoldTemp =
                                                          vAirflowManifoldTemp -
                                                              stepAirflowManifoldTemp;

                                                      calcTempAndPressure(
                                                          vAirflowManifoldTemp,
                                                          vAirflowPsiAmbient,
                                                          vAirflowPsiG);
                                                      calcAirflowCfm(
                                                        vAirflowCfm,
                                                        vAirflowManifoldTemp,
                                                        vAirflowPsiAmbient,
                                                        vAirflowPsiG,
                                                      );
                                                      calcAirflowPoundPerMinute(
                                                        vAirflowPoundMinute,
                                                        vAirflowManifoldTemp,
                                                        vAirflowPsiAmbient,
                                                        vAirflowPsiG,
                                                      );
//
                                                    }
                                                  });
                                                },
                                              ),
                                              StepButtonClose(
                                                icon: FontAwesomeIcons.plus,
                                                onStepPress: () {
                                                  timer = Timer.periodic(
                                                      Duration(
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowManifoldTemp
                                                              .toString()) <
                                                          (Decimal.parse(
                                                              kMaxAirflowManifoldTemp
                                                                  .toString())))) {
                                                        vAirflowManifoldTemp =
                                                            vAirflowManifoldTemp +
                                                                stepAirflowManifoldTemp;

                                                        calcTempAndPressure(
                                                            vAirflowManifoldTemp,
                                                            vAirflowPsiAmbient,
                                                            vAirflowPsiG);
                                                        calcAirflowCfm(
                                                          vAirflowCfm,
                                                          vAirflowManifoldTemp,
                                                          vAirflowPsiAmbient,
                                                          vAirflowPsiG,
                                                        );
                                                        calcAirflowPoundPerMinute(
                                                          vAirflowPoundMinute,
                                                          vAirflowManifoldTemp,
                                                          vAirflowPsiAmbient,
                                                          vAirflowPsiG,
                                                        );
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
                                                        vAirflowManifoldTemp
                                                            .toString()) <
                                                        (Decimal.parse(
                                                            kMaxAirflowManifoldTemp
                                                                .toString())))) {
                                                      vAirflowManifoldTemp =
                                                          vAirflowManifoldTemp +
                                                              stepAirflowManifoldTemp;

                                                      calcTempAndPressure(
                                                          vAirflowManifoldTemp,
                                                          vAirflowPsiAmbient,
                                                          vAirflowPsiG);
                                                      calcAirflowCfm(
                                                        vAirflowCfm,
                                                        vAirflowManifoldTemp,
                                                        vAirflowPsiAmbient,
                                                        vAirflowPsiG,
                                                      );
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ), //Minus-button

                                    //Plus-button
                                  ],
                                ),
                                //Minus-button
                              ],
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            //vAirflowManifoldTemp
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.red,
                                          width: kInputTextWidth + 80,
                                          child: Text(
                                            'Required Absolute Manifold Pressure',
                                            style: kLabelTextStyle,
                                            textAlign: TextAlign.left,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: kInputNumberWidth,
                                              // color: Colors.blue,
                                              child: Text(
                                                vAirflowPsiTotal
                                                    .toStringAsFixed(2),
                                                style: kResultNumberStyleWhite18_600,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                            Container(
                                              width: kInputUnitWidth,
                                              // color: Colors.orange,
                                              child: Text(
                                                unitPressurePsi,
                                                textAlign: TextAlign.center,
                                                style: kUnitTextStyleAirflow,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: <Widget>[],
                                          ),
                                        ],
                                      ),
                                    ), //Minus-button

                                    //Plus-button
                                  ],
                                ),
                                //Minus-button
                              ],
                            ),

                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.red,
                                          width: kInputTextWidth + 35,
                                          child: Text(
                                            'Required Gauge Manifold Pressure',
                                            style: kLabelTextStyle,
                                            textAlign: TextAlign.left,
                                            textScaleFactor:
                                            textScaleFactorTc * 0.9,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: kInputNumberWidth,
                                              // color: Colors.blue,
                                              child: Text(
                                                vAirflowPsiG.toStringAsFixed(2),
                                                style: kResultNumberStyleWhite18_600,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                            Container(
                                              width: kInputUnitWidth,
                                              // color: Colors.orange,
                                              child: Text(
                                                unitPressurePsi,
                                                textAlign: TextAlign.center,
                                                style: kUnitTextStyleAirflow,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Container(
                                      child: Column(
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
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowPsiG
                                                              .toString()) >
                                                          (Decimal.parse(
                                                              kMinAirflowPsiG
                                                                  .toString())))) {
                                                        vAirflowPsiG =
                                                            vAirflowPsiG -
                                                                stepAirflowPsiG;

                                                        if (vAirflowPsiG < 0) {
                                                          vAirflowPsiG = 0.0;
                                                        }

                                                        calcTempAndPressure(
                                                            vAirflowManifoldTemp,
                                                            vAirflowPsiAmbient,
                                                            vAirflowPsiG);
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
                                                        vAirflowPsiG
                                                            .toString()) >
                                                        (Decimal.parse(
                                                            kMinAirflowPsiG
                                                                .toString())))) {
                                                      vAirflowPsiG =
                                                          vAirflowPsiG -
                                                              stepAirflowPsiG;

                                                      if (vAirflowPsiG < 0) {
                                                        vAirflowPsiG = 0.0;
                                                      }

                                                      calcTempAndPressure(
                                                          vAirflowManifoldTemp,
                                                          vAirflowPsiAmbient,
                                                          vAirflowPsiG);
                                                    }
                                                  });
                                                },
                                              ),
                                              StepButtonClose(
                                                icon: FontAwesomeIcons.plus,
                                                onStepPress: () {
                                                  timer = Timer.periodic(
                                                      Duration(
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowPsiG
                                                              .toString()) <
                                                          (Decimal.parse(
                                                              kMaxAirflowPsiG
                                                                  .toString())))) {
                                                        vAirflowPsiG =
                                                            vAirflowPsiG +
                                                                stepAirflowPsiG;

                                                        if (vAirflowPsiG < 0) {
                                                          vAirflowPsiG = 0.0;
                                                        }

                                                        calcTempAndPressure(
                                                            vAirflowManifoldTemp,
                                                            vAirflowPsiAmbient,
                                                            vAirflowPsiG);
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
                                                        vAirflowPsiG
                                                            .toString()) <
                                                        (Decimal.parse(
                                                            kMaxAirflowPsiG
                                                                .toString())))) {
                                                      vAirflowPsiG =
                                                          vAirflowPsiG +
                                                              stepAirflowPsiG;

                                                      if (vAirflowPsiG < 0) {
                                                        vAirflowPsiG = 0.0;
                                                      }

                                                      calcTempAndPressure(
                                                          vAirflowManifoldTemp,
                                                          vAirflowPsiAmbient,
                                                          vAirflowPsiG);
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ), //Minus-button

                                    //Plus-button
                                  ],
                                ),
                                //Minus-button
                              ],
                            ),
                            //vAirflowPsiG
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.red,
                                          width: kInputTextWidth + 20,
                                          child: Text(
                                            'Operating Barometric Pressure',
                                            style: kLabelTextStyle,
                                            textAlign: TextAlign.left,
                                            textScaleFactor:
                                            textScaleFactorTc * 0.9,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: kInputNumberWidth,
                                              // color: Colors.blue,
                                              child: Text(
                                                vAirflowPsiAmbient
                                                    .toStringAsFixed(2),
                                                style: kResultNumberStyleWhite18_600,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                            Container(
                                              width: kInputUnitWidth,
                                              // color: Colors.orange,
                                              child: Text(
                                                unitPressurePsi,
                                                textAlign: TextAlign.center,
                                                style: kUnitTextStyleAirflow,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Container(
                                      child: Column(
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
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowPsiAmbient
                                                              .toString()) >
                                                          (Decimal.parse(
                                                              kMinAirflowPsiAmbient
                                                                  .toString())))) {
                                                        vAirflowPsiAmbient =
                                                            vAirflowPsiAmbient -
                                                                stepAirflowPsiAmbient;

                                                        if (vAirflowPsiAmbient <
                                                            0.01) {
                                                          vAirflowPsiAmbient =
                                                          0.01;
                                                        }

                                                        calcTempAndPressure(
                                                            vAirflowManifoldTemp,
                                                            vAirflowPsiAmbient,
                                                            vAirflowPsiG);
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
                                                        vAirflowPsiAmbient
                                                            .toString()) >
                                                        (Decimal.parse(
                                                            kMinAirflowPsiAmbient
                                                                .toString())))) {
                                                      vAirflowPsiAmbient =
                                                          vAirflowPsiAmbient -
                                                              stepAirflowPsiAmbient;

                                                      if (vAirflowPsiAmbient <
                                                          0.01) {
                                                        vAirflowPsiAmbient =
                                                        0.01;
                                                      }

                                                      calcTempAndPressure(
                                                          vAirflowManifoldTemp,
                                                          vAirflowPsiAmbient,
                                                          vAirflowPsiG);
                                                    }
                                                  });
                                                },
                                              ),
                                              StepButtonClose(
                                                icon: FontAwesomeIcons.plus,
                                                onStepPress: () {
                                                  timer = Timer.periodic(
                                                      Duration(
                                                          milliseconds:
                                                          tapTime), (t) {
                                                    setState(() {
                                                      if ((Decimal.parse(
                                                          vAirflowPsiAmbient
                                                              .toString()) <
                                                          (Decimal.parse(
                                                              kMaxAirflowPsiAmbient
                                                                  .toString())))) {
                                                        vAirflowPsiAmbient =
                                                            vAirflowPsiAmbient +
                                                                stepAirflowPsiAmbient;

                                                        if (vAirflowPsiAmbient <
                                                            0.01) {
                                                          vAirflowPsiAmbient =
                                                          0.01;
                                                        }

                                                        calcTempAndPressure(
                                                            vAirflowManifoldTemp,
                                                            vAirflowPsiAmbient,
                                                            vAirflowPsiG);
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
                                                        vAirflowPsiAmbient
                                                            .toString()) <
                                                        (Decimal.parse(
                                                            kMaxAirflowPsiAmbient
                                                                .toString())))) {
                                                      vAirflowPsiAmbient =
                                                          vAirflowPsiAmbient +
                                                              stepAirflowPsiAmbient;

                                                      if (vAirflowPsiAmbient <
                                                          0.01) {
                                                        vAirflowPsiAmbient =
                                                        0.01;
                                                      }

//                                                      vAirflowCfm = calculate.calcCubicFeetPerMinuteManifoldTemp(
//                                                          vAirflowManifoldTemp, vAirflowPsiAmbient, vAirflowPsiG);
//                                                      vAirflowPoundMinute = calculate.calcCubicPoundMinuteManiFoldTemp(
//                                                          vAirflowManifoldTemp, vAirflowPsiAmbient, vAirflowPsiG);
//                                                      cubicMeterPerSecondConversion =
//                                                          vAirflowCfm * kCubicFeetPerMinuteToCubicMeterPerSecond;
//                                                      vAirflowPsiAmbientA = vAirflowPsiAmbient + vAirflowPsiG;

                                                      calcTempAndPressure(
                                                          vAirflowManifoldTemp,
                                                          vAirflowPsiAmbient,
                                                          vAirflowPsiG);
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ), //Minus-button

                                    //Plus-button
                                  ],
                                ),
                                //Minus-button
                              ],
                            ),
//                            Divider(
//                              color: Colors.white,
//                            ),
                            //vAirflowPsiAmbientA

                            //vAirflowPoundMinute
//                            Divider(),
//                            Column(
//                              children: <Widget>[
//                                Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Column(
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Container(
//                                          // color: Colors.red,
//                                          width: kInputTextWidth,
//                                          child: Text(
//                                            'Temperature ºC',
//                                            style: kLabelTextStyle,
//                                            textAlign: TextAlign.left,
//                                            textScaleFactor: textScaleFactorTc,
//                                          ),
//                                        ),
//                                        Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Container(
//                                              width: kInputNumberWidth,
//                                              // color: Colors.blue,
//                                              child: Text(
//                                                tempCelsius.toStringAsFixed(1),
//                                                style: kResultNumberStyle,
//                                                textScaleFactor:
//                                                textScaleFactorTc,
//                                              ),
//                                            ),
//                                            Container(
//                                              width: kInputUnitWidth,
//                                              // color: Colors.orange,
//                                              child: Text(
//                                                unitCelsius,
//                                                textAlign: TextAlign.center,
//                                                style: kUnitTextStyleAirflow,
//                                                textScaleFactor:
//                                                textScaleFactorTc,
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ],
//                                    ),
//
//                                    Container(
//                                      child: Column(
//                                        children: <Widget>[
//                                          Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.end,
//                                            children: <Widget>[
//                                              StepButtonClose(
//                                                icon: FontAwesomeIcons.minus,
//                                                onStepPress: () {
//                                                  setState(() {
//                                                    if ((Decimal.parse(
//                                                        tempCelsius
//                                                            .toStringAsFixed(
//                                                            1)) >
//                                                        (Decimal.parse(
//                                                            kMinTempCelsius
//                                                                .toStringAsFixed(
//                                                                2))))) {
//                                                      tempCelsius =
//                                                          ((Decimal.parse(
//                                                              tempCelsius
//                                                                  .toStringAsFixed(
//                                                                  1))))
//                                                              .toDouble() -
//                                                              stepConvertTempCelsius;
//
//                                                      tempCelsius = ((Decimal
//                                                          .parse(tempCelsius
//                                                          .toStringAsFixed(
//                                                          1))))
//                                                          .toDouble();
//                                                      // calcTempCelsius(tempFahrenheit);
//                                                      print(
//                                                          'tempCelsius at minus: $tempCelsius');
//                                                      print(
//                                                          'tempFahrenheit at minus: $tempTemperatureFahrenheit');
//                                                      calcTempFahrenheit(
//                                                          tempCelsius);
//                                                    }
//                                                  });
//                                                },
//                                              ),
//                                              StepButtonClose(
//                                                icon: FontAwesomeIcons.plus,
//                                                onStepPress: () {
//                                                  setState(() {
//                                                    if ((Decimal.parse(
//                                                        tempCelsius
//                                                            .toStringAsFixed(
//                                                            1)) <
//                                                        (Decimal.parse(
//                                                            kMaxTempCelsius
//                                                                .toStringAsFixed(
//                                                                2))))) {
//                                                      tempCelsius =
//                                                          ((Decimal.parse(
//                                                              tempCelsius
//                                                                  .toStringAsFixed(
//                                                                  1))))
//                                                              .toDouble() +
//                                                              stepConvertTempCelsius;
//
//                                                      // calcTempCelsius(tempFahrenheit);
//                                                      calcTempFahrenheit(
//                                                          tempCelsius);
//                                                    }
//                                                  });
//                                                },
//                                              ),
//                                            ],
//                                          ),
//                                        ],
//                                      ),
//                                    ), //Minus-button
//
//                                    //Plus-button
//                                  ],
//                                ),
//                                //Minus-button
//                              ],
//                            ),
//                            Column(
//                              children: <Widget>[
//                                Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Column(
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Container(
//                                          // color: Colors.red,
//                                          width: kInputTextWidth,
//                                          child: Text(
//                                            'Temperature ºF',
//                                            style: kLabelTextStyle,
//                                            textAlign: TextAlign.left,
//                                            textScaleFactor: textScaleFactorTc,
//                                          ),
//                                        ),
//                                        Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Container(
//                                              width: kInputNumberWidth,
//                                              // color: Colors.blue,
//                                              child: Text(
//                                                tempTemperatureFahrenheit
//                                                    .toStringAsFixed(1),
//                                                style: kResultNumberStyle,
//                                                textScaleFactor:
//                                                textScaleFactorTc,
//                                              ),
//                                            ),
//                                            Container(
//                                              width: kInputUnitWidth,
//                                              // color: Colors.orange,
//                                              child: Text(
//                                                unitFahrenheit,
//                                                textAlign: TextAlign.center,
//                                                style: kUnitTextStyleAirflow,
//                                                textScaleFactor:
//                                                textScaleFactorTc,
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ],
//                                    ),
//
//                                    Container(
//                                      // width: 96,
//                                      child: Column(
//                                        children: <Widget>[
//                                          Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.end,
//                                            children: <Widget>[
//                                              StepButtonClose(
//                                                icon: FontAwesomeIcons.minus,
//                                                onStepPress: () {
//                                                  setState(() {
//                                                    if ((Decimal.parse(
//                                                        tempTemperatureFahrenheit
//                                                            .toStringAsFixed(
//                                                            1)) >
//                                                        (Decimal.parse(
//                                                            kMinTempFahrenheit
//                                                                .toStringAsFixed(
//                                                                1))))) {
//                                                      tempTemperatureFahrenheit =
//                                                          ((Decimal.parse(
//                                                              tempTemperatureFahrenheit
//                                                                  .toStringAsFixed(
//                                                                  1))))
//                                                              .toDouble() -
//                                                              stepConvertTempFahrenheit;
//
//                                                      calcTempCelsius(
//                                                          tempTemperatureFahrenheit);
//                                                      calcTempFahrenheit(
//                                                          tempCelsius);
//
//
//                                                    }
//                                                  });
//                                                },
//                                              ),
//                                              StepButtonClose(
//                                                icon: FontAwesomeIcons.plus,
//                                                onStepPress: () {
//                                                  setState(() {
//                                                    if ((Decimal.parse(
//                                                        tempTemperatureFahrenheit
//                                                            .toStringAsFixed(
//                                                            1)) <
//                                                        (Decimal.parse(
//                                                            kMaxTempFahrenheit
//                                                                .toStringAsFixed(
//                                                                2))))) {
//                                                      tempTemperatureFahrenheit =
//                                                          ((Decimal.parse(
//                                                              tempTemperatureFahrenheit
//                                                                  .toStringAsFixed(
//                                                                  1))))
//                                                              .toDouble() +
//                                                              stepConvertTempFahrenheit;
//
//                                                      calcTempCelsius(
//                                                          tempTemperatureFahrenheit);
//                                                      calcTempFahrenheit(
//                                                          tempCelsius);
//
//
//                                                    }
//                                                  });
//                                                },
//                                              ),
//                                            ],
//                                          ),
//                                        ],
//                                      ),
//                                    ), //Minus-button
//
//                                    //Plus-button
//                                  ],
//                                ),
//                                //Minus-button
//                              ],
//                            ),
                          ],
                        ),
                      ),
//                      Divider(height: 2),
                    ],
                  ),
                ),
                colour: kActiveCardColourOutput,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
//                    Text(
//                      'Airflow calculations can be very complicated and are dependent on your particular situation. For example, temperature, pressure, humidity, and other factors are crucial inputs to get proper estimates. Many turbo airflow calculations on the internet can be arbitrary and may not reflect your case at all. Similarly, for the above calculation because it depends on the circumstances in your case. However, formulas used in this app may work as an approximate value. The TCT team will explore this further and develop alternative tools for more accurate airflow calculations. We are aiming to make these available in the app in the future. However, precise airflow calculations require more inputs and will get more complicated for the user.',
//                      style: TextStyle(
//                          fontStyle: FontStyle.italic, color: Colors.white70),
//                      textScaleFactor: textScaleFactorTc * 0.8,
//                    ),
                    SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Fixed values:',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white70),
                        textScaleFactor: textScaleFactorTc * 0.9,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '- Gas Flow Constant = 53.34 (1545 ft lbf/(lb mol)(ºR))/(28.964 lb/lb mol))',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white70),
                        textScaleFactor: textScaleFactorTc * 0.8,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '- Compressability factor = 1.0',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white70),
                        textScaleFactor: textScaleFactorTc * 0.8,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'The "compressibility factor" and the "gas flow constant" are rarely altered. But if you need a calculation where you can change these values, please contact us via the "feedback form" on the "Info tab".',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white70),
                        textScaleFactor: textScaleFactorTc * 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              //Fuel (Hp)
            ],
          ),
        );
      }),
    );
  }

//  calcPoundPerMinuteConversion(double poundPerMinuteConversion) {
//    setState(() {
//      cubicMeterPerSecondConversion =
//          poundPerMinuteConversion * kPoundPerMinuteToCubicMeterPerSecond;
//      cubicFeetPerMinuteConversion =
//          poundPerMinuteConversion * kPoundPerMinuteToCubicFeetPerMinute;
//
//      print(poundPerMinuteConversion);
//      print(cubicMeterPerSecondConversion);
//      print(poundPerMinuteConversion);
//      print(cubicFeetPerMinuteConversion);
//      print(poundPerMinuteConversion / cubicFeetPerMinuteConversion);
//    });
//  }

  void calcCubicMeterPerSecond(double cubicMeterPerSecondConversion) {
    setState(() {
      vAirflowCfm = cubicMeterPerSecondConversion *
          kCubicMeterPerSecondToCubicFeetPerMinute;
      vAirflowPoundMinute = calculate.calcCubicPoundMinute(
          vAirflowCfm, vAirflowManifoldTemp, vAirflowPsiAmbient, vAirflowPsiG);
      vAirflowCubicMeterPerMinute = cubicMeterPerSecondConversion * 60;

//
      vAirflowPsiTotal = vAirflowPsiAmbient + vAirflowPsiG;
      pressureRatio = (vAirflowPsiAmbient + vAirflowPsiG) / vAirflowPsiAmbient;

      print(cubicMeterPerSecondConversion);
      print(vAirflowPoundMinute);
    });
  }

  void calcCubicMeterPerMinute(double cubicMeterPerMinuteConversion) {
    setState(() {
      vAirflowCubicMeterPerSecond = cubicMeterPerMinuteConversion / 60;
      vAirflowCfm = vAirflowCubicMeterPerSecond *
          kCubicMeterPerSecondToCubicFeetPerMinute;
      vAirflowPoundMinute = calculate.calcCubicPoundMinute(
          vAirflowCfm, vAirflowManifoldTemp, vAirflowPsiAmbient, vAirflowPsiG);
      cubicMeterPerMinuteConversion = vAirflowCubicMeterPerSecond * 60;

//
      vAirflowPsiTotal = vAirflowPsiAmbient + vAirflowPsiG;
      pressureRatio = (vAirflowPsiAmbient + vAirflowPsiG) / vAirflowPsiAmbient;

      print(vAirflowCubicMeterPerSecond);
      print(vAirflowPoundMinute);
    });
  }

  void calcAirflowPoundPerMinute(double vAirflowPoundMinuteIn,
      double vAirflowManifoldTemp,
      double vAirflowPsiAmbient,
      double vAirflowPsiG) {
    setState(() {
      var vTempAirflowPoundMinute = vAirflowPoundMinuteIn;
      vAirflowCfm = calculate.calcCubicFeetPerMinuteExact(
          vTempAirflowPoundMinute,
          vAirflowManifoldTemp,
          vAirflowPsiAmbient,
          vAirflowPsiG);
      vAirflowCubicMeterPerSecond =
          vAirflowCfm * kCubicFeetPerMinuteToCubicMeterPerSecond;
      vAirflowCubicMeterPerMinute = vAirflowCubicMeterPerSecond * 60;

      vAirflowPoundMinute = calculate.calcCubicPoundMinute(
          vAirflowCfm, vAirflowManifoldTemp, vAirflowPsiAmbient, vAirflowPsiG);

      vAirflowPsiTotal = vAirflowPsiAmbient + vAirflowPsiG;
      pressureRatio = (vAirflowPsiAmbient + vAirflowPsiG) / vAirflowPsiAmbient;

      print('Första vAirflowPoundMinute $vAirflowPoundMinute');
      print(
          'Första cubicMeterPerSecondConversion $vAirflowCubicMeterPerSecond');
      print('Första vAirflowCfm $vAirflowCfm');
    });
  }

  void calcAirflowCfm(double vAirflowCfmIn, double vAirflowManifoldTemp,
      double vAirflowPsiAmbient, double vAirflowPsiG) {
    setState(() {
      var vTempAirflowCfm = vAirflowCfmIn;
      vAirflowPoundMinute = calculate.calcCubicPoundMinute(vTempAirflowCfm,
          vAirflowManifoldTemp, vAirflowPsiAmbient, vAirflowPsiG);
      vAirflowCubicMeterPerSecond =
          vTempAirflowCfm * kCubicFeetPerMinuteToCubicMeterPerSecond;
      vAirflowCubicMeterPerMinute = vAirflowCubicMeterPerSecond * 60;
      vAirflowCfm = calculate.calcCubicFeetPerMinuteExact(vAirflowPoundMinute,
          vAirflowManifoldTemp, vAirflowPsiAmbient, vAirflowPsiG);

      print('Andra vAirflowPoundMinute $vAirflowPoundMinute');
      print('Andra cubicMeterPerSecondConversion $vAirflowCubicMeterPerSecond');
      print('Andra vAirflowCfm $vAirflowCfm');
      vAirflowPsiTotal = vAirflowPsiAmbient + vAirflowPsiG;
      pressureRatio = (vAirflowPsiAmbient + vAirflowPsiG) / vAirflowPsiAmbient;
    });
  }

  void calcTempAndPressure(double vAirflowManifoldTemp,
      double vAirflowPsiAmbient, double vAirflowPsiG) {
    setState(() {
      var vTempAirflowPoundMinute = vAirflowPoundMinute;

      vAirflowCfm = calculate.calcCubicFeetPerMinuteManifoldTemp(
          vTempAirflowPoundMinute,
          vAirflowManifoldTemp,
          vAirflowPsiAmbient,
          vAirflowPsiG);
      vAirflowPoundMinute = calculate.calcCubicPoundMinuteManiFoldTemp(
          vAirflowCfm, vAirflowManifoldTemp, vAirflowPsiAmbient, vAirflowPsiG);

      var vTempAirflowCfm = vAirflowCfm;

      vAirflowCubicMeterPerSecond =
          vTempAirflowCfm * kCubicFeetPerMinuteToCubicMeterPerSecond;
      vAirflowCubicMeterPerMinute = vAirflowCubicMeterPerSecond * 60;

      vAirflowPsiTotal = vAirflowPsiAmbient + vAirflowPsiG;
      pressureRatio = (vAirflowPsiAmbient + vAirflowPsiG) / vAirflowPsiAmbient;

      print('TempPressureCFM vAirflowCfm $vAirflowCfm');
      print('TempPressureCFM vAirflowPoundMinute $vAirflowPoundMinute');
      print(
          'TempPressureCFM cubicMeterPerSecondConversion $vAirflowCubicMeterPerSecond');
    });
  }

  void calcTempCelsius(double tempFahrenheit) {
    setState(() {
      tempCelsius = calculate.calcTempCelsius(tempFahrenheit);
      print('tempFahrenheit tuning func $tempFahrenheit');
    });
  }

  void calcTempFahrenheit(double tempCelsius) {
    setState(() {
      tempTemperatureFahrenheit = calculate.calcTempFahrenheit(tempCelsius);
      print('tempCelsius tuning func $tempCelsius');
    });
  }

  void resetValues() {
    setState(() {
      //radioValue = 0;

      vAirflowPsiG = 0.0;
      vAirflowPsiAmbient = 14.7;
      vAirflowPsiTotal = 14.7;
      vAirflowCfm = 500.0;
      vAirflowPoundMinute = 52.33;
      vAirflowManifoldTemp = 68.0;

      vAirflowCfm = calculate.calcCubicFeetPerMinuteExact(vAirflowPoundMinute,
          vAirflowManifoldTemp, vAirflowPsiAmbient, vAirflowPsiG);
      vAirflowCubicMeterPerSecond =
          vAirflowCfm * kCubicFeetPerMinuteToCubicMeterPerSecond;
      pressureRatio = (vAirflowPsiAmbient + vAirflowPsiG) / vAirflowPsiAmbient;
    });
  }
}
