import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tct/components/analytics_event.dart';
import 'package:tct/data_models/analytics_event_type.dart';
import 'package:tct/components/stepbutton.dart';
import 'package:tct/components/stepbutton_close.dart';
import 'package:tct/globals/app_localizations.dart';
import 'package:decimal/decimal.dart';
import '../../components/reusable_card.dart';
import '../../globals/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tct/globals/calculator_brain.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:tct/globals/constants_ui.dart';

class AirflowTbpPage extends StatefulWidget {
  final bool metricUnit;

  AirflowTbpPage({required Key key, required this.metricUnit})
      : super(key: key);

  @override
  _AirflowTbpPageState createState() => _AirflowTbpPageState(metricUnit);
}

class _AirflowTbpPageState extends State<AirflowTbpPage> {
  bool metricUnit;
  bool snackBarEnable = true;

  _AirflowTbpPageState(this.metricUnit);

  @override
  void setState(fn) {
    super.setState(fn);
    // print('metricUnit turbine: $metricUnit');
    if (metricUnit) {
    } else {}
  }

  @override
  void initState() {
    super.initState();

    if (metricUnit) {
    } else {}
  }

  Widget get infoButton {
    if (snackBarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            // parameters
            var _analyticsParameter = {'Snackbar': 'Airflow Target Boost'};
            // Execute a function to send logEvent() to Firebase Analytics
            Analytics.analyticsLogEvent(
                AnalyticsEventType.snack_bar, _analyticsParameter);
          });
    }
    snackBarEnable = true;
    return SizedBox.shrink();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
    content: Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text('Airflow calculation - Target Boost Pressure',
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                textScaleFactor: textScaleFactorTc),
            SizedBox(height: 10),
            Text(
                'The conversion between volumetric and mass airflow is based on fixed circumstances. The numbers are within the ballpark, but we will soon update the formulas for more accurate conversion (spring 2020). Please use the \"Airflow Conversion\" page for exact conversion until we have updated the formula on this page. However, the current calculation should be suitable for the majority of users.',
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textScaleFactor: textScaleFactorTc),
            SizedBox(height: 10),
            Text(
              'The default values on this page in the app are set from an example and were used together with a compressor map with Garrett GTX3582R, among other compressor maps. Use your own inputs, get your result and find appropriate compressor map for your needs.',
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

  CalculatorBrain calculate = CalculatorBrain(
    compressorInducerSize: 0.0, // replace with actual value
    compressorExducerSize: 0.0, // replace with actual value
    turbineInducerSize: 0.0, // replace with actual value
    turbineExducerSize: 0.0, // replace with actual value
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
            Text(
                AppLocalizations.of(context)
                    .translate('airflow_target_boost_pressure_0000')
                //'AIRFLOW - Boost Pressure',
                ,
                style: kAppBarTextStyle,
                textScaleFactor: textScaleFactorTc - 0.2),
            Container(width: 30.0, child: infoButton),
          ],
        ),
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ReusableCard(
                onPress: () {
                  // print('pressed');
                },
                colour: kActiveCardColourOutput,
                cardChild: Container(
                  // margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          AppLocalizations.of(context)
                              .translate('airflow_target_boost_pressure_0010')
                          //'Result for Compresser Map Analysis',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc * .8),
                      SizedBox(height: 15),
                      Container(
                        // color: Colors.red,
                        width: kInputTextWidth,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('airflow_target_boost_pressure_0020')
                          //'Mass Airflow',
                          ,
                          style: kLabelTextStyleActive,
                          textAlign: TextAlign.left,
                          textScaleFactor: textScaleFactorTc,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            // color: Colors.red,
                            width: kResultTextWidth,
                            child: Text(
                              AppLocalizations.of(context).translate(
                                  'airflow_target_boost_pressure_0020')
                              //'Pound per Minute lbs/min',
                              ,
                              style: kLabelTextStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.blue,
                            width: kInputNumberWidth,
                            child: Text(
                              vAirflowPoundMinute.toStringAsFixed(2),
                              style: kResultNumberStyleWhite18_600,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.green,
                            width: kResultUnitWidth,
                            child: Text(
                              unitMassFlowRatePoundMinute,
                              style: kUnitTextStyleAirflow,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white70),
                      Container(
                        // color: Colors.red,
                        width: kInputTextWidth,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('airflow_target_boost_pressure_0030')
                          //'Volume Airflow',
                          ,
                          style: kLabelTextStyleActive,
                          textAlign: TextAlign.left,
                          textScaleFactor: textScaleFactorTc,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            // color: Colors.red,
                            width: kResultTextWidth,
                            child: Text(
                              AppLocalizations.of(context).translate(
                                  'airflow_target_boost_pressure_0040')
                              // 'Cubic Feet per Minute CFM',
                              ,
                              style: kLabelTextStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.blue,
                            width: kInputNumberWidth,
                            child: Text(
                              vAirflowCfm.toStringAsFixed(4),
                              style: kResultNumberStyleWhite18_600,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.green,
                            width: kResultUnitWidth,
                            child: Text(
                              unitVolumetricFlowRateCfm,
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
                            width: kResultTextWidth,
                            child: Text(
                              AppLocalizations.of(context).translate(
                                  'airflow_target_boost_pressure_0050')
                              // 'Cubic Meter per Minute',
                              ,
                              style: kLabelTextStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.blue,
                            width: kInputNumberWidth,
                            child: Text(
                              vAirflowCubicMeterPerMinute.toStringAsFixed(3),
                              style: kResultNumberStyleWhite18_600,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.green,
                            width: kResultUnitWidth,
                            child: Text(
                              unitVolumetricCubicMeterPerMinute,
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
                            width: kResultTextWidth,
                            child: Text(
                              AppLocalizations.of(context).translate(
                                  'airflow_target_boost_pressure_0060')
                              //'Cubic Meter per Second ',
                              ,
                              style: kLabelTextStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.blue,
                            width: kInputNumberWidth,
                            child: Text(
                              vAirflowCubicMeterPerSecond.toStringAsFixed(4),
                              style: kResultNumberStyleWhite18_600,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.green,
                            width: kResultUnitWidth,
                            child: Text(
                              unitVolumetricCubicMeterPerSecond,
                              style: kUnitTextStyleAirflow,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            // color: Colors.red,
                            width: kResultTextWidth,
                            child: Text(
                              AppLocalizations.of(context).translate(
                                  'airflow_target_boost_pressure_0070')
                              //'Pressure Ratio',
                              ,
                              style: kLabelTextStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.blue,
                            width: kInputNumberWidth,
                            child: Text(
                              pressureRatio.toStringAsFixed(2),
                              style: kResultNumberStyleWhite18_600,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.green,
                            width: kResultUnitWidth,
                            child: Text(
                              unitPressureRatio,
                              style: kUnitTextStyleAirflow,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            // color: Colors.red,
                            width: kResultTextWidth,
                            child: Text(
                              AppLocalizations.of(context).translate(
                                  'airflow_target_boost_pressure_0080')
                              // 'Required Absolute Pressure',
                              ,
                              style: kLabelTextStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.blue,
                            width: kInputNumberWidth,
                            child: Text(
                              vAirflowPsiTotal.toStringAsFixed(2),
                              style: kResultNumberStyleWhite18_600,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.green,
                            width: kResultUnitWidth,
                            child: Text(
                              unitRequiredAbsolutePressure,
                              style: kUnitTextStyleAirflow,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            // color: Colors.red,
                            width: kResultTextWidth,
                            child: Text(
                              AppLocalizations.of(context).translate(
                                  'airflow_target_boost_pressure_0090')
                              // 'Resultant Manifold Pressure',
                              ,
                              style: kLabelTextStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.blue,
                            width: kInputNumberWidth,
                            child: Text(
                              vAirflowPsiG.toStringAsFixed(2),
                              style: kResultNumberStyleWhite18_600,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.green,
                            width: kResultUnitWidth,
                            child: Text(
                              unitResultantManifoldPressure,
                              style: kUnitTextStyleAirflow,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // **************************** Buttons ***********************
              ReusableCard(
                onPress: () {
                  // print('pressed');
                },
                colour: kActiveCardColourInput,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate(
                          'airflow_target_boost_pressure_0100') // 'Input',
                      ,
                      style: kSecondSubjectTextStyle,
                      textScaleFactor: textScaleFactorTc,
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        //length Feet
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //SizedBox(width: 10),
                            ],
                          ),
                        ),

                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      width: 130,
                                      // color: Colors.red,
                                      child: Text(
                                        AppLocalizations.of(context).translate(
                                            'airflow_target_boost_pressure_0110')
                                        // 'Engine speed',
                                        ,
                                        style: kLabelTextStyle,
                                      )),
                                  Container(
                                    width: 70,
                                    // color: Colors.blue,
                                    child: Text(
                                      maxEngineSpeed.toStringAsFixed(0),
                                      style: kResultNumberStyleWhite18_600,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ),

                                  //SizedBox(width: 10),
                                  Container(
                                      alignment: Alignment.center,
                                      width: kInputUnitWidth,
                                      // color: Colors.green,
                                      child: Text(
                                        unitMaxEngineSpeed,
                                        style: kUnitTextStyleAirflow,
                                        textScaleFactor: textScaleFactorTc,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: StepButton(
                                  icon: FontAwesomeIcons.minus,
                                  onStepPress: () {
                                    timer = Timer.periodic(
                                        Duration(milliseconds: tapTime), (t) {
                                      setState(() {
                                        if (Decimal.parse(maxEngineSpeed
                                                .toStringAsFixed(2)) >
                                            Decimal.parse(kMinMaxEngineSpeed
                                                .toStringAsFixed(2))) {
                                          maxEngineSpeed = maxEngineSpeed -
                                              stepMaxEngineSpeed;

                                          calcEngineDisplacementAirflow(
                                              engineDisplacementCidAirflow);

                                          calcEngineDisplacementCidAirflow(
                                              engineDisplacementAirflow);

                                          calcMassFlowRatePoundMinuteTbp(
                                              vAirflowPsiG,
                                              engineDisplacementAirflow,
                                              volumetricEfficiency,
                                              maxEngineSpeed,
                                              vAirflowManifoldTemp,
                                              vAirflowPsiAmbient,
                                              numberOfTurbos);

                                          calcAirflowCfm(
                                              vAirflowPoundMinute,
                                              vAirflowManifoldTemp,
                                              vAirflowPsiAmbient,
                                              vAirflowPsiG);

                                          calcAirflowPsiTotal(
                                              vAirflowPsiG,
                                              vAirflowPsiAmbient,
                                              preTurboFlowLoss,
                                              postTurboFlowLoss);

                                          calcPressureRatio(
                                              vAirflowPsiG,
                                              vAirflowPsiAmbient,
                                              preTurboFlowLoss,
                                              postTurboFlowLoss);
                                        }
                                      });
                                    });
                                  },
                                  onPressEnd: () {
                                    timer.cancel();
                                  },
                                  onStep: () {
                                    setState(() {
                                      if (Decimal.parse(maxEngineSpeed
                                              .toStringAsFixed(2)) >
                                          Decimal.parse(kMinMaxEngineSpeed
                                              .toStringAsFixed(2))) {
                                        maxEngineSpeed =
                                            maxEngineSpeed - stepMaxEngineSpeed;

                                        calcEngineDisplacementAirflow(
                                            engineDisplacementCidAirflow);

                                        calcEngineDisplacementCidAirflow(
                                            engineDisplacementAirflow);

                                        calcMassFlowRatePoundMinuteTbp(
                                            vAirflowPsiG,
                                            engineDisplacementAirflow,
                                            volumetricEfficiency,
                                            maxEngineSpeed,
                                            vAirflowManifoldTemp,
                                            vAirflowPsiAmbient,
                                            numberOfTurbos);

                                        calcAirflowCfm(
                                            vAirflowPoundMinute,
                                            vAirflowManifoldTemp,
                                            vAirflowPsiAmbient,
                                            vAirflowPsiG);

                                        calcAirflowPsiTotal(
                                            vAirflowPsiG,
                                            vAirflowPsiAmbient,
                                            preTurboFlowLoss,
                                            postTurboFlowLoss);

                                        calcPressureRatio(
                                            vAirflowPsiG,
                                            vAirflowPsiAmbient,
                                            preTurboFlowLoss,
                                            postTurboFlowLoss);
                                      }
                                    });
                                  }),
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white,
                                thumbColor: kCompressorInducerSliderNob,
                                valueIndicatorColor:
                                    kCompressorExducerSliderNob,
                                overlayColor: kCompressorSliderOverlayColor,
                                inactiveTrackColor: kInactiveSlideColour,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: kNobThumbShapeLarge),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: kNobOverlayShapeLarge),
                              ),
                              child: Slider(
                                  value: maxEngineSpeed,
                                  min: kMinMaxEngineSpeed,
                                  max: kMaxMaxEngineSpeed,
                                  label: maxEngineSpeed.toStringAsFixed(0),
                                  inactiveColor: Color(0xFF8D8E89),
                                  divisions: sliderDivisionsMaxEngineSpeed,
                                  onChanged: (double mxesliderValue) {
                                    maxEngineSpeed = mxesliderValue;

                                    calcEngineDisplacementAirflow(
                                        engineDisplacementCidAirflow);

                                    calcEngineDisplacementCidAirflow(
                                        engineDisplacementAirflow);

                                    calcMassFlowRatePoundMinuteTbp(
                                        vAirflowPsiG,
                                        engineDisplacementAirflow,
                                        volumetricEfficiency,
                                        maxEngineSpeed,
                                        vAirflowManifoldTemp,
                                        vAirflowPsiAmbient,
                                        numberOfTurbos);

                                    calcAirflowCfm(
                                        vAirflowPoundMinute,
                                        vAirflowManifoldTemp,
                                        vAirflowPsiAmbient,
                                        vAirflowPsiG);

                                    calcAirflowPsiTotal(
                                        vAirflowPsiG,
                                        vAirflowPsiAmbient,
                                        preTurboFlowLoss,
                                        postTurboFlowLoss);

                                    calcPressureRatio(
                                        vAirflowPsiG,
                                        vAirflowPsiAmbient,
                                        preTurboFlowLoss,
                                        postTurboFlowLoss);
                                  }),
                            ),
                            Container(
                              child: StepButton(
                                  icon: FontAwesomeIcons.plus,
                                  onStepPress: () {
                                    timer = Timer.periodic(
                                        Duration(milliseconds: tapTime), (t) {
                                      setState(() {
                                        if (Decimal.parse(maxEngineSpeed
                                                .toStringAsFixed(2)) <
                                            Decimal.parse(kMaxMaxEngineSpeed
                                                .toStringAsFixed(2))) {
                                          maxEngineSpeed = maxEngineSpeed +
                                              stepMaxEngineSpeed;

                                          calcEngineDisplacementAirflow(
                                              engineDisplacementCidAirflow);

                                          calcEngineDisplacementCidAirflow(
                                              engineDisplacementAirflow);

                                          calcMassFlowRatePoundMinuteTbp(
                                              vAirflowPsiG,
                                              engineDisplacementAirflow,
                                              volumetricEfficiency,
                                              maxEngineSpeed,
                                              vAirflowManifoldTemp,
                                              vAirflowPsiAmbient,
                                              numberOfTurbos);

                                          calcAirflowCfm(
                                              vAirflowPoundMinute,
                                              vAirflowManifoldTemp,
                                              vAirflowPsiAmbient,
                                              vAirflowPsiG);

                                          calcAirflowPsiTotal(
                                              vAirflowPsiG,
                                              vAirflowPsiAmbient,
                                              preTurboFlowLoss,
                                              postTurboFlowLoss);

                                          calcPressureRatio(
                                              vAirflowPsiG,
                                              vAirflowPsiAmbient,
                                              preTurboFlowLoss,
                                              postTurboFlowLoss);
                                        }
                                      });
                                    });
                                  },
                                  onPressEnd: () {
                                    timer.cancel();
                                  },
                                  onStep: () {
                                    setState(() {
                                      if (Decimal.parse(maxEngineSpeed
                                              .toStringAsFixed(2)) <
                                          Decimal.parse(kMaxMaxEngineSpeed
                                              .toStringAsFixed(2))) {
                                        maxEngineSpeed =
                                            maxEngineSpeed + stepMaxEngineSpeed;

                                        calcEngineDisplacementAirflow(
                                            engineDisplacementCidAirflow);

                                        calcEngineDisplacementCidAirflow(
                                            engineDisplacementAirflow);

                                        calcMassFlowRatePoundMinuteTbp(
                                            vAirflowPsiG,
                                            engineDisplacementAirflow,
                                            volumetricEfficiency,
                                            maxEngineSpeed,
                                            vAirflowManifoldTemp,
                                            vAirflowPsiAmbient,
                                            numberOfTurbos);

                                        calcAirflowCfm(
                                            vAirflowPoundMinute,
                                            vAirflowManifoldTemp,
                                            vAirflowPsiAmbient,
                                            vAirflowPsiG);

                                        calcAirflowPsiTotal(
                                            vAirflowPsiG,
                                            vAirflowPsiAmbient,
                                            preTurboFlowLoss,
                                            postTurboFlowLoss);

                                        calcPressureRatio(
                                            vAirflowPsiG,
                                            vAirflowPsiAmbient,
                                            preTurboFlowLoss,
                                            postTurboFlowLoss);
                                      }
                                    });
                                  }),
                            ),
                          ],
                        ),
                        //Divider(thickness: 3, color: Colors.grey),

                        // Divider(),
                      ],
                    ),

                    SizedBox(height: 10),

                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: kInputTextWidth,
                                    child: Text(
                                        AppLocalizations.of(context).translate(
                                            'airflow_target_boost_pressure_0120')
                                        //'Target Boost Pressure',
                                        ,
                                        style: kLabelTextStyle,
                                        textScaleFactor: textScaleFactorTc),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: kInputNumberWidth,
                                        // color: Colors.blue,
                                        child: Text(
                                          vAirflowPsiG.toStringAsFixed(2),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                        width: kInputUnitWidth,
                                        // color: Colors.orange,
                                        child: Text(unitPressurePsi,
                                            textAlign: TextAlign.center,
                                            style: kUnitTextStyleAirflow,
                                            textScaleFactor: textScaleFactorTc),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.minus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(vAirflowPsiG
                                                        .toStringAsFixed(2)) >
                                                    (Decimal.parse(
                                                        kMinAirflowPsiG
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  vAirflowPsiG = vAirflowPsiG -
                                                      stepAirflowPsiG;

//                                                  print('Target kMinAirflowPsiG $kMinAirflowPsiG');

                                                  var vTempAirflowPoundMinute =
                                                      vAirflowPoundMinute;

                                                  var vTempAirflowPsiG =
                                                      vAirflowPsiG;

                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vTempAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vTempAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vTempAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
                                                }
                                              });
                                            });
                                          },
                                          onPressEnd: () {
                                            timer.cancel();
                                          },
                                          onStep: () {
                                            setState(() {
                                              if ((Decimal.parse(vAirflowPsiG
                                                      .toStringAsFixed(2)) >
                                                  (Decimal.parse(kMinAirflowPsiG
                                                      .toStringAsFixed(2))))) {
                                                vAirflowPsiG = vAirflowPsiG -
                                                    stepAirflowPsiG;

//                                                print('Target kMinAirflowPsiG $kMinAirflowPsiG');

                                                var vTempAirflowPoundMinute =
                                                    vAirflowPoundMinute;

                                                var vTempAirflowPsiG =
                                                    vAirflowPsiG;

                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vTempAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vTempAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vTempAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.plus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(vAirflowPsiG
                                                        .toStringAsFixed(2)) <
                                                    (Decimal.parse(
                                                        kMaxAirflowPsiG
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  vAirflowPsiG = vAirflowPsiG +
                                                      stepAirflowPsiG;

//                                                  print('Target kMaxAirflowPsiG $kMaxAirflowPsiG');

                                                  var vTempAirflowPoundMinute =
                                                      vAirflowPoundMinute;

                                                  var vTempAirflowPsiG =
                                                      vAirflowPsiG;

                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vTempAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vTempAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vTempAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
                                                }
                                              });
                                            });
                                          },
                                          onPressEnd: () {
                                            timer.cancel();
                                          },
                                          onStep: () {
                                            setState(() {
                                              if ((Decimal.parse(vAirflowPsiG
                                                      .toStringAsFixed(2)) <
                                                  (Decimal.parse(kMaxAirflowPsiG
                                                      .toStringAsFixed(2))))) {
                                                vAirflowPsiG = vAirflowPsiG +
                                                    stepAirflowPsiG;

//                                                print('Target kMaxAirflowPsiG $kMaxAirflowPsiG');

                                                var vTempAirflowPoundMinute =
                                                    vAirflowPoundMinute;

                                                var vTempAirflowPsiG =
                                                    vAirflowPsiG;

                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vTempAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vTempAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vTempAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              width: kInputTextWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: 200,
                                    child: Text(
                                      AppLocalizations.of(context).translate(
                                          'airflow_target_boost_pressure_0130')
                                      //'Atmospheric Pressure',
                                      ,
                                      style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: kInputNumberWidth,
                                        // color: Colors.blue,
                                        child: Text(
                                          vAirflowPsiAmbient.toStringAsFixed(2),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                          width: kInputUnitWidth,
                                          // color: Colors.orange,
                                          child: Text(
                                            unitPressurePsi,
                                            textAlign: TextAlign.center,
                                            style: kUnitTextStyleAirflow,
                                            textScaleFactor: textScaleFactorTc,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.minus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        vAirflowPsiAmbient
                                                            .toStringAsFixed(
                                                                1)) >
                                                    (Decimal.parse(
                                                        kMinAirflowPsiAmbient
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  vAirflowPsiAmbient =
                                                      vAirflowPsiAmbient -
                                                          stepAirflowPsiAmbient;
                                                  var vTempAirflowPoundMinute =
                                                      vAirflowPoundMinute;

                                                  var vTempAirflowPsiG =
                                                      vAirflowPsiG;

                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vTempAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vTempAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vTempAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                          .toStringAsFixed(1)) >
                                                  (Decimal.parse(
                                                      kMinAirflowPsiAmbient
                                                          .toStringAsFixed(
                                                              2))))) {
                                                vAirflowPsiAmbient =
                                                    vAirflowPsiAmbient -
                                                        stepAirflowPsiAmbient;
                                                var vTempAirflowPoundMinute =
                                                    vAirflowPoundMinute;

                                                var vTempAirflowPsiG =
                                                    vAirflowPsiG;

                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vTempAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vTempAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vTempAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.plus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        vAirflowPsiAmbient
                                                            .toStringAsFixed(
                                                                1)) <
                                                    (Decimal.parse(
                                                        kMaxAirflowPsiAmbient
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  vAirflowPsiAmbient =
                                                      vAirflowPsiAmbient +
                                                          stepAirflowPsiAmbient;
                                                  var vTempAirflowPoundMinute =
                                                      vAirflowPoundMinute;

                                                  var vTempAirflowPsiG =
                                                      vAirflowPsiG;

                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vTempAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vTempAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vTempAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                          .toStringAsFixed(1)) <
                                                  (Decimal.parse(
                                                      kMaxAirflowPsiAmbient
                                                          .toStringAsFixed(
                                                              2))))) {
                                                vAirflowPsiAmbient =
                                                    vAirflowPsiAmbient +
                                                        stepAirflowPsiAmbient;
                                                var vTempAirflowPoundMinute =
                                                    vAirflowPoundMinute;

                                                var vTempAirflowPsiG =
                                                    vAirflowPsiG;

                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vTempAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vTempAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vTempAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
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
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              width: kInputTextWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: 200,
                                    child: Text(
                                      AppLocalizations.of(context).translate(
                                          'airflow_target_boost_pressure_0140')
                                      //'Pre-Turbo Flow Loss',
                                      ,
                                      style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: kInputNumberWidth,
                                        // color: Colors.blue,
                                        child: Text(
                                          preTurboFlowLoss.toStringAsFixed(1),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                        width: kInputUnitWidth,
                                        // color: Colors.orange,
                                        child: Text(
                                          unitPressurePsi,
                                          textAlign: TextAlign.center,
                                          style: kUnitTextStyleAirflow,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.minus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        preTurboFlowLoss
                                                            .toStringAsFixed(
                                                                1)) >
                                                    (Decimal.parse(
                                                        kMinPreTurboFlowLoss
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  preTurboFlowLoss =
                                                      preTurboFlowLoss -
                                                          stepPreTurboFlowLoss;
                                                  var vTempAirflowPoundMinute =
                                                      vAirflowPoundMinute;

                                                  var vTempAirflowPsiG =
                                                      vAirflowPsiG;

                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vTempAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vTempAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vTempAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      preTurboFlowLoss
                                                          .toStringAsFixed(1)) >
                                                  (Decimal.parse(
                                                      kMinPreTurboFlowLoss
                                                          .toStringAsFixed(
                                                              2))))) {
                                                preTurboFlowLoss =
                                                    preTurboFlowLoss -
                                                        stepPreTurboFlowLoss;
                                                var vTempAirflowPoundMinute =
                                                    vAirflowPoundMinute;

                                                var vTempAirflowPsiG =
                                                    vAirflowPsiG;

                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vTempAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vTempAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vTempAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.plus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        preTurboFlowLoss
                                                            .toStringAsFixed(
                                                                1)) <
                                                    (Decimal.parse(
                                                        kMaxPreTurboFlowLoss
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  preTurboFlowLoss =
                                                      preTurboFlowLoss +
                                                          stepPreTurboFlowLoss;

                                                  var vTempAirflowPoundMinute =
                                                      vAirflowPoundMinute;

                                                  var vTempAirflowPsiG =
                                                      vAirflowPsiG;

                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vTempAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vTempAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vTempAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      preTurboFlowLoss
                                                          .toStringAsFixed(1)) <
                                                  (Decimal.parse(
                                                      kMaxPreTurboFlowLoss
                                                          .toStringAsFixed(
                                                              2))))) {
                                                preTurboFlowLoss =
                                                    preTurboFlowLoss +
                                                        stepPreTurboFlowLoss;
                                                var vTempAirflowPoundMinute =
                                                    vAirflowPoundMinute;

                                                var vTempAirflowPsiG =
                                                    vAirflowPsiG;

                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vTempAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vTempAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vTempAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
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
                    //Pre-Turbo Flow Loss
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              width: kInputTextWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: 200,
                                    child: Text(
                                      AppLocalizations.of(context).translate(
                                          'airflow_target_boost_pressure_0150')
                                      //'Post-Turbo Flow Loss',
                                      ,
                                      style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: kInputNumberWidth,
                                        // color: Colors.blue,
                                        child: Text(
                                          postTurboFlowLoss.toStringAsFixed(1),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                        width: kInputUnitWidth,
                                        // color: Colors.orange,
                                        child: Text(
                                          unitPressurePsi,
                                          textAlign: TextAlign.center,
                                          style: kUnitTextStyleAirflow,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.minus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        postTurboFlowLoss
                                                            .toStringAsFixed(
                                                                1)) >
                                                    (Decimal.parse(
                                                        kMinPostTurboFlowLoss
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  postTurboFlowLoss =
                                                      postTurboFlowLoss -
                                                          stepPostTurboFlowLoss;
                                                  var vTempAirflowPoundMinute =
                                                      vAirflowPoundMinute;

                                                  var vTempAirflowPsiG =
                                                      vAirflowPsiG;

                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vTempAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vTempAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vTempAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      postTurboFlowLoss
                                                          .toStringAsFixed(1)) >
                                                  (Decimal.parse(
                                                      kMinPostTurboFlowLoss
                                                          .toStringAsFixed(
                                                              2))))) {
                                                postTurboFlowLoss =
                                                    postTurboFlowLoss -
                                                        stepPostTurboFlowLoss;
                                                var vTempAirflowPoundMinute =
                                                    vAirflowPoundMinute;

                                                var vTempAirflowPsiG =
                                                    vAirflowPsiG;

                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vTempAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vTempAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vTempAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.plus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        postTurboFlowLoss
                                                            .toStringAsFixed(
                                                                1)) <
                                                    (Decimal.parse(
                                                        kMaxPostTurboFlowLoss
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  postTurboFlowLoss =
                                                      postTurboFlowLoss +
                                                          stepPostTurboFlowLoss;
                                                  var vTempAirflowPoundMinute =
                                                      vAirflowPoundMinute;

                                                  var vTempAirflowPsiG =
                                                      vAirflowPsiG;

                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vTempAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vTempAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vTempAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      postTurboFlowLoss
                                                          .toStringAsFixed(1)) <
                                                  (Decimal.parse(
                                                      kMaxPostTurboFlowLoss
                                                          .toStringAsFixed(
                                                              2))))) {
                                                postTurboFlowLoss =
                                                    postTurboFlowLoss +
                                                        stepPostTurboFlowLoss;
                                                var vTempAirflowPoundMinute =
                                                    vAirflowPoundMinute;

                                                var vTempAirflowPsiG =
                                                    vAirflowPsiG;

                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vTempAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vTempAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vTempAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
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
                    //Post-Turbo Flow Loss
                    //Divider(
                    //  thickness: 1, color: Colors.white30), //Wheel Horsepower
                    //Divider(height: 10, color: Colors.white),
                    Divider(height: 10, color: Colors.white),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // // color: Colors.red,
                              width: kInputTextWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: 200,
                                    child: Text(
                                      AppLocalizations.of(context).translate(
                                          'airflow_target_boost_pressure_0160')
                                      // 'Engine Displacement - Cubic inch',
                                      ,
                                      style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: kInputNumberWidth,
                                        // color: Colors.blue,
                                        child: Text(
                                          engineDisplacementCidAirflow
                                              .toStringAsFixed(0),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                          width: kInputUnitWidth,
                                          // color: Colors.orange,
                                          child: Text(
                                            unitVolumeCid,
                                            textAlign: TextAlign.center,
                                            style: kUnitTextStyleAirflow,
                                            textScaleFactor: textScaleFactorTc,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.minus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        engineDisplacementCidAirflow
                                                            .toStringAsFixed(
                                                                1)) >
                                                    (Decimal.parse(
                                                        kMinCubicInchEngineDisplacement
                                                            .toStringAsFixed(
                                                                1))))) {
                                                  engineDisplacementCidAirflow =
                                                      engineDisplacementCidAirflow -
                                                          stepCubicInchEngineDisplacement;

                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);

                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      engineDisplacementCidAirflow
                                                          .toStringAsFixed(1)) >
                                                  (Decimal.parse(
                                                      kMinCubicInchEngineDisplacement
                                                          .toStringAsFixed(
                                                              1))))) {
                                                engineDisplacementCidAirflow =
                                                    engineDisplacementCidAirflow -
                                                        stepCubicInchEngineDisplacement;

                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);

                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.plus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if (engineDisplacementCidAirflow <
                                                    kMaxCubicInchEngineDisplacement) {
                                                  engineDisplacementCidAirflow =
                                                      engineDisplacementCidAirflow +
                                                          stepCubicInchEngineDisplacement;

                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);

                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
                                                }
                                              });
                                            });
                                          },
                                          onPressEnd: () {
                                            timer.cancel();
                                          },
                                          onStep: () {
                                            setState(() {
                                              if (engineDisplacementCidAirflow <
                                                  kMaxCubicInchEngineDisplacement) {
                                                engineDisplacementCidAirflow =
                                                    engineDisplacementCidAirflow +
                                                        stepCubicInchEngineDisplacement;

                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);

                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
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
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // // color: Colors.red,
                              width: kInputTextWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: 200,
                                    child: Text(
                                      AppLocalizations.of(context).translate(
                                          'airflow_target_boost_pressure_0170')
                                      //'Engine Displacement - liter',
                                      ,
                                      style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: kInputNumberWidth,
                                        // color: Colors.blue,
                                        child: Text(
                                          engineDisplacementAirflow
                                              .toStringAsFixed(2),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                          width: kInputUnitWidth,
                                          // color: Colors.orange,
                                          child: Text(
                                            unitEngineDisplacement,
                                            textAlign: TextAlign.center,
                                            style: kUnitTextStyleAirflow,
                                            textScaleFactor: textScaleFactorTc,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.minus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        engineDisplacementAirflow
                                                            .toStringAsFixed(
                                                                1)) >
                                                    (Decimal.parse(
                                                        kMinEngineDisplacement
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  engineDisplacementAirflow =
                                                      engineDisplacementAirflow -
                                                          stepEngineDisplacement;

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);
//nja
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      engineDisplacementAirflow
                                                          .toStringAsFixed(1)) >
                                                  (Decimal.parse(
                                                      kMinEngineDisplacement
                                                          .toStringAsFixed(
                                                              2))))) {
                                                engineDisplacementAirflow =
                                                    engineDisplacementAirflow -
                                                        stepEngineDisplacement;

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);
//nja
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.plus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        engineDisplacementAirflow
                                                            .toStringAsFixed(
                                                                1)) <
                                                    (Decimal.parse(
                                                        kMaxEngineDisplacement
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  engineDisplacementAirflow =
                                                      engineDisplacementAirflow +
                                                          stepEngineDisplacement;

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);
//nja
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      engineDisplacementAirflow
                                                          .toStringAsFixed(1)) <
                                                  (Decimal.parse(
                                                      kMaxEngineDisplacement
                                                          .toStringAsFixed(
                                                              2))))) {
                                                engineDisplacementAirflow =
                                                    engineDisplacementAirflow +
                                                        stepEngineDisplacement;

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);
//nja
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
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
                    Divider(height: 10, color: Colors.white),
                    //Engine Displacement

                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              width: kInputTextWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: 200,
                                    child: Text(
                                      AppLocalizations.of(context).translate(
                                          'airflow_target_boost_pressure_0180')
                                      //'Volumetric Efficiency',
                                      ,
                                      style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        // color: Colors.blue,
                                        width: kInputNumberWidth,
                                        child: Text(
                                          volumetricEfficiency
                                              .toStringAsFixed(0),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                          // color: Colors.orange,
                                          width: kInputUnitWidth,
                                          child: Text(
                                            unitProcent,
                                            textAlign: TextAlign.center,
                                            style: kUnitTextStyleAirflow,
                                            textScaleFactor: textScaleFactorTc,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.minus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        volumetricEfficiency
                                                            .toStringAsFixed(
                                                                2)) >
                                                    (Decimal.parse(
                                                        kMinVolumetricEfficiency
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  volumetricEfficiency =
                                                      volumetricEfficiency -
                                                          stepVolumetricEfficiency;
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      volumetricEfficiency
                                                          .toStringAsFixed(2)) >
                                                  (Decimal.parse(
                                                      kMinVolumetricEfficiency
                                                          .toStringAsFixed(
                                                              2))))) {
                                                volumetricEfficiency =
                                                    volumetricEfficiency -
                                                        stepVolumetricEfficiency;
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.plus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        volumetricEfficiency
                                                            .toStringAsFixed(
                                                                2)) <
                                                    (Decimal.parse(
                                                        kMaxVolumetricEfficiency
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  volumetricEfficiency =
                                                      volumetricEfficiency +
                                                          stepVolumetricEfficiency;
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      volumetricEfficiency
                                                          .toStringAsFixed(2)) <
                                                  (Decimal.parse(
                                                      kMaxVolumetricEfficiency
                                                          .toStringAsFixed(
                                                              2))))) {
                                                volumetricEfficiency =
                                                    volumetricEfficiency +
                                                        stepVolumetricEfficiency;
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
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
                    // Volumetric Efficiency
                    //Max Engine Speed

                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              width: kInputTextWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: 200,
                                    child: Text(
                                      AppLocalizations.of(context).translate(
                                          'airflow_target_boost_pressure_0190')
                                      //'Intake Temp @ Valve',
                                      ,
                                      style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: kInputNumberWidth,
                                        // color: Colors.blue,
                                        child: Text(
                                          vAirflowManifoldTemp
                                              .toStringAsFixed(0),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                          width: kInputUnitWidth,
                                          // color: Colors.orange,
                                          child: Text(
                                            unitFahrenheit,
                                            textAlign: TextAlign.center,
                                            style: kUnitTextStyleAirflow,
                                            textScaleFactor: textScaleFactorTc,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.minus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        vAirflowManifoldTemp
                                                            .toStringAsFixed(
                                                                1)) >
                                                    (Decimal.parse(
                                                        kMinAirflowManifoldTemp
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  vAirflowManifoldTemp =
                                                      vAirflowManifoldTemp -
                                                          stepAirflowManifoldTemp;
                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                          .toStringAsFixed(1)) >
                                                  (Decimal.parse(
                                                      kMinAirflowManifoldTemp
                                                          .toStringAsFixed(
                                                              2))))) {
                                                vAirflowManifoldTemp =
                                                    vAirflowManifoldTemp -
                                                        stepAirflowManifoldTemp;
                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.plus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        vAirflowManifoldTemp
                                                            .toStringAsFixed(
                                                                1)) <
                                                    (Decimal.parse(
                                                        kMaxAirflowManifoldTemp
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  vAirflowManifoldTemp =
                                                      vAirflowManifoldTemp +
                                                          stepAirflowManifoldTemp;
                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                          .toStringAsFixed(1)) <
                                                  (Decimal.parse(
                                                      kMaxAirflowManifoldTemp
                                                          .toStringAsFixed(
                                                              2))))) {
                                                vAirflowManifoldTemp =
                                                    vAirflowManifoldTemp +
                                                        stepAirflowManifoldTemp;
                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
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
                    //Intake Temp @ Valve

                    //Atmospheric Pressure
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              width: kInputTextWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: 200,
                                    child: Text(
                                      AppLocalizations.of(context).translate(
                                          'airflow_target_boost_pressure_0200')
                                      //'Pre-Turbo Flow Loss',
                                      ,
                                      style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: kInputNumberWidth,
                                        // color: Colors.blue,
                                        child: Text(
                                          preTurboFlowLoss.toStringAsFixed(1),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                        width: kInputUnitWidth,
                                        // color: Colors.orange,
                                        child: Text(
                                          unitPressurePsi,
                                          textAlign: TextAlign.center,
                                          style: kUnitTextStyleAirflow,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.minus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        preTurboFlowLoss
                                                            .toStringAsFixed(
                                                                1)) >
                                                    (Decimal.parse(
                                                        kMinPreTurboFlowLoss
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  preTurboFlowLoss =
                                                      preTurboFlowLoss -
                                                          stepPreTurboFlowLoss;
                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      preTurboFlowLoss
                                                          .toStringAsFixed(1)) >
                                                  (Decimal.parse(
                                                      kMinPreTurboFlowLoss
                                                          .toStringAsFixed(
                                                              2))))) {
                                                preTurboFlowLoss =
                                                    preTurboFlowLoss -
                                                        stepPreTurboFlowLoss;
                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.plus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        preTurboFlowLoss
                                                            .toStringAsFixed(
                                                                1)) <
                                                    (Decimal.parse(
                                                        kMaxPreTurboFlowLoss
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  preTurboFlowLoss =
                                                      preTurboFlowLoss +
                                                          stepPreTurboFlowLoss;
                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      preTurboFlowLoss
                                                          .toStringAsFixed(1)) >
                                                  (Decimal.parse(
                                                      kMaxPreTurboFlowLoss
                                                          .toStringAsFixed(
                                                              2))))) {
                                                preTurboFlowLoss =
                                                    preTurboFlowLoss +
                                                        stepPreTurboFlowLoss;
                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
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
                    //Pre-Turbo Flow Loss
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              width: kInputTextWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: 200,
                                    child: Text(
                                      AppLocalizations.of(context).translate(
                                          'airflow_target_boost_pressure_0210')
                                      // 'Post-Turbo Flow Loss',
                                      ,
                                      style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: kInputNumberWidth,
                                        // color: Colors.blue,
                                        child: Text(
                                          postTurboFlowLoss.toStringAsFixed(1),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                        width: kInputUnitWidth,
                                        // color: Colors.orange,
                                        child: Text(
                                          unitPressurePsi,
                                          textAlign: TextAlign.center,
                                          style: kUnitTextStyleAirflow,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.minus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        postTurboFlowLoss
                                                            .toStringAsFixed(
                                                                1)) >
                                                    (Decimal.parse(
                                                        kMinPostTurboFlowLoss
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  postTurboFlowLoss =
                                                      postTurboFlowLoss -
                                                          stepPostTurboFlowLoss;
                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      postTurboFlowLoss
                                                          .toStringAsFixed(1)) >
                                                  (Decimal.parse(
                                                      kMinPostTurboFlowLoss
                                                          .toStringAsFixed(
                                                              2))))) {
                                                postTurboFlowLoss =
                                                    postTurboFlowLoss -
                                                        stepPostTurboFlowLoss;
                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.plus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        postTurboFlowLoss
                                                            .toStringAsFixed(
                                                                1)) <
                                                    (Decimal.parse(
                                                        kMaxPostTurboFlowLoss
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  postTurboFlowLoss =
                                                      postTurboFlowLoss +
                                                          stepPostTurboFlowLoss;
                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
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
                                                      postTurboFlowLoss
                                                          .toStringAsFixed(1)) <
                                                  (Decimal.parse(
                                                      kMaxPostTurboFlowLoss
                                                          .toStringAsFixed(
                                                              2))))) {
                                                postTurboFlowLoss =
                                                    postTurboFlowLoss +
                                                        stepPostTurboFlowLoss;
                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
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
                    //Post-Turbo Flow Loss

                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              width: kInputTextWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: kInputTextWidth,
                                    child: Text(
                                      AppLocalizations.of(context).translate(
                                          'airflow_target_boost_pressure_0220')
                                      //'Number of Turbos',
                                      ,
                                      style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: kInputNumberWidth,
                                        // color: Colors.blue,
                                        child: Text(
                                          numberOfTurbos.toStringAsFixed(0),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                        width: kInputUnitWidth,
                                        // color: Colors.orange,
                                        child: Text(
                                          AppLocalizations.of(context).translate(
                                              'airflow_target_boost_pressure_0230')
                                          // 'turbo',
                                          ,
                                          style: kUnitTextStyleAirflow,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.minus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        numberOfTurbos
                                                            .toStringAsFixed(
                                                                1)) >
                                                    (Decimal.parse(
                                                        kMinNumberOfTurbos
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  numberOfTurbos =
                                                      numberOfTurbos -
                                                          stepNumberOfTurbos;
                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
                                                }
                                              });
                                            });
                                          },
                                          onPressEnd: () {
                                            timer.cancel();
                                          },
                                          onStep: () {
                                            setState(() {
                                              if ((Decimal.parse(numberOfTurbos
                                                      .toStringAsFixed(1)) >
                                                  (Decimal.parse(
                                                      kMinNumberOfTurbos
                                                          .toStringAsFixed(
                                                              2))))) {
                                                numberOfTurbos =
                                                    numberOfTurbos -
                                                        stepNumberOfTurbos;
                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
                                      StepButtonClose(
                                          icon: FontAwesomeIcons.plus,
                                          onStepPress: () {
                                            timer = Timer.periodic(
                                                Duration(milliseconds: tapTime),
                                                (t) {
                                              setState(() {
                                                if ((Decimal.parse(
                                                        numberOfTurbos
                                                            .toStringAsFixed(
                                                                1)) <
                                                    (Decimal.parse(
                                                        kMaxNumberOfTurbos
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  numberOfTurbos =
                                                      numberOfTurbos +
                                                          stepNumberOfTurbos;
                                                  calcEngineDisplacementAirflow(
                                                      engineDisplacementCidAirflow);

                                                  calcEngineDisplacementCidAirflow(
                                                      engineDisplacementAirflow);
                                                  calcMassFlowRatePoundMinuteTbp(
                                                      vAirflowPsiG,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      numberOfTurbos);

                                                  calcAirflowCfm(
                                                      vAirflowPoundMinute,
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG);

                                                  calcAirflowPsiTotal(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);

                                                  calcPressureRatio(
                                                      vAirflowPsiG,
                                                      vAirflowPsiAmbient,
                                                      preTurboFlowLoss,
                                                      postTurboFlowLoss);
                                                }
                                              });
                                            });
                                          },
                                          onPressEnd: () {
                                            timer.cancel();
                                          },
                                          onStep: () {
                                            setState(() {
                                              if ((Decimal.parse(numberOfTurbos
                                                      .toStringAsFixed(1)) <
                                                  (Decimal.parse(
                                                      kMaxNumberOfTurbos
                                                          .toStringAsFixed(
                                                              2))))) {
                                                numberOfTurbos =
                                                    numberOfTurbos +
                                                        stepNumberOfTurbos;
                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                calcMassFlowRatePoundMinuteTbp(
                                                    vAirflowPsiG,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    numberOfTurbos);

                                                calcAirflowCfm(
                                                    vAirflowPoundMinute,
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG);

                                                calcAirflowPsiTotal(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);

                                                calcPressureRatio(
                                                    vAirflowPsiG,
                                                    vAirflowPsiAmbient,
                                                    preTurboFlowLoss,
                                                    postTurboFlowLoss);
                                              }
                                            });
                                          }),
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
                    //Number of Turbos
                  ],
                ),
              ), //Turbo-Size

              //Inch and Info
            ],
          ),
        );
      }),
    );
  }

  void calcMassFlowRatePoundMinuteTbp(
      double vAirflowPsiG,
      double engineDisplacement,
      double volumetricEfficiency,
      double maxEngineSpeed,
      double vAirflowManifoldTemp,
      double vAirflowPsiAmbient,
      double numberOfTurbos) {
    var vTempAirflowPoundMinute = vAirflowPoundMinute;

    setState(() {
      print('A vAirflowPoundMinute $vAirflowPoundMinute');

      vAirflowPoundMinute = calculate.calcMassFlowRatePoundMinuteTbp(
          vAirflowPsiG,
          engineDisplacement,
          volumetricEfficiency,
          maxEngineSpeed,
          vAirflowManifoldTemp,
          vAirflowPsiAmbient,
          numberOfTurbos);

      print('B vAirflowPoundMinute $vAirflowPoundMinute');

//      vAirflowCfm = calculate.calcCubicFeetPerMinuteExact(
//          vAirflowPoundMinute, vAirflowManifoldTemp, vAirflowPsiAmbient, vAirflowPsiG);
//
//      vAirflowCubicMeterPerSecond =
//          vAirflowCfm * kCubicFeetPerMinuteToCubicMeterPerSecond;
//
//      vAirflowCubicMeterPerMinute = vAirflowCubicMeterPerSecond * 60;

      print('B2 vAirflowPoundMinute $vAirflowPoundMinute');
      print('D cubicMeterPerSecondConversion $vAirflowCubicMeterPerSecond');
    });
  }

//  void calcVolumetricFlowRate(double massFlowRatePoundMinute) {
//    setState(() {
//      volumetricFlowRate =
//          calculate.calcCubicMeterPerSecond(massFlowRatePoundMinute);
//    });
//  }

  void calcAirflowPsiTotal(double vAirflowPsiG, double vAirflowPsiAmbient,
      double preTurboFlowLoss, double postTurboFlowLoss) {
    setState(() {
      vAirflowPsiTotal = vAirflowPsiAmbient + vAirflowPsiG;
    });
  }

  void calcPressureRatio(double vAirflowPsiG, double vAirflowPsiAmbient,
      double preTurboFlowLoss, double postTurboFlowLoss) {
    setState(() {
      pressureRatio = calculate.calcPressureRatio(vAirflowPsiG,
          vAirflowPsiAmbient, preTurboFlowLoss, postTurboFlowLoss);
    });
  }

  void calcEngineDisplacementCidAirflow(double engineDisplacementAirflow) {
    setState(() {
      engineDisplacementCidAirflow =
          calculate.calcEngineDisplacementCidAirflow(engineDisplacementAirflow);
    });
  }

  void calcEngineDisplacementAirflow(double engineDisplacementCidAirflow) {
    setState(() {
      engineDisplacementAirflow =
          calculate.calcEngineDisplacementAirflow(engineDisplacementCidAirflow);
    });
  }

  void calcAirflowCfm(double vAirflowPoundMinute, double vAirflowManifoldTemp,
      double vAirflowPsiAmbient, double vAirflowPsiG) {
    var vTempAirflowPoundMinute = vAirflowPoundMinute;
    var vTempAirflowPsiG = vAirflowPsiG;

    setState(() {
      vAirflowCfm = calculate.calcCubicFeetPerMinuteExact(
          vTempAirflowPoundMinute,
          vAirflowManifoldTemp,
          vAirflowPsiAmbient,
          vTempAirflowPsiG);

      vAirflowCubicMeterPerSecond =
          vAirflowCfm * kCubicFeetPerMinuteToCubicMeterPerSecond;

      vAirflowCubicMeterPerMinute = vAirflowCubicMeterPerSecond * 60;
    });
    print('C vAirflowCfm $vAirflowCfm');
    print('C1 vTempAirflowPoundMinute $vTempAirflowPoundMinute');
    print('C2 vAirflowManifoldTemp $vAirflowManifoldTemp');
    print('C3 vAirflowPsiAmbient $vAirflowPsiAmbient');
    print('C4 vAirflowPsiG $vAirflowPsiG');
  }
}
