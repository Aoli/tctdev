import 'dart:async';
import 'package:tct/components/analytics_event.dart';
import 'package:tct/data_models/analytics_event_type.dart';
import 'package:tct/components/stepbutton.dart';
import 'package:tct/components/stepbutton_close.dart';
import 'package:tct/globals/app_localizations.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/reusable_card.dart';
import '../../globals/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tct/globals/calculator_brain.dart';
import 'package:tct/globals/constants_ui.dart';

class AirflowPage extends StatefulWidget {
  final bool metricUnit;

  AirflowPage({required Key key, required this.metricUnit}) : super(key: key);

  @override
  _AirflowPageState createState() => _AirflowPageState(metricUnit);
}

class _AirflowPageState extends State<AirflowPage> {
  bool metricUnit;

  _AirflowPageState(this.metricUnit);

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

    resetValues(metricUnit);
  }

  Widget get submitRatingButton {
    if (true) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            // parameters
            var _analyticsParameter = {'Snackbar': 'Airflow HP RPM'};
            // Execute a function to send logEvent() to Firebase Analytics
            Analytics.analyticsLogEvent(
                AnalyticsEventType.snack_bar, _analyticsParameter);
          });
    }
    // return Text('');
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
            Text(
              'Airflow calculation - Horsepower',
              style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textScaleFactor: textScaleFactorTc,
            ),
            SizedBox(height: 10),
            Text(
              'This Airflow calculation requires many inputs like Horsepower, BSFC, and AFR, and more.  Make sure you get the correct values. The conversion between volumetric and mass airflow is based on fixed circumstances. The numbers are within the ballpark, but we will soon update the formulas for more accurate conversion (spring 2020).Please use the \"Airflow Conversion\" page for exact conversion until we have updated the formula on this page. However, the current calculation should be suitable for the majority of users.',
              style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
              textScaleFactor: textScaleFactorTc,
            ),
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
    compressorInducerSize: 0.0, // provide appropriate value
    compressorExducerSize: 0.0, // provide appropriate value
    turbineInducerSize: 0.0, // provide appropriate value
    turbineExducerSize: 0.0, // provide appropriate value
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
              AppLocalizations.of(context).translate('airflow_conv_hp_rpm_0000')
              //'AIRFLOW - Horsepower',
              ,
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
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ReusableCard(
                onPress: () {
                  // print('pressed');
                },
                colour: kActiveCardColourOutput,
                cardChild: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          AppLocalizations.of(context)
                              .translate('airflow_conv_hp_rpm_0010')
                          //'Result for Compresser Map Analysis',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc * .8),
                      SizedBox(height: 15),
                      Container(
                        // color: Colors.red,
                        width: kInputTextWidth,
                        child: Text(
                          AppLocalizations.of(context).translate(
                              'airflow_conv_hp_rpm_0020') //'Mass Airflow',
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
                              AppLocalizations.of(context)
                                  .translate('airflow_conv_hp_rpm_0030')
                              // 'Pound per Minute lbs/min',
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
//                      Row(
//                        children: <Widget>[
//                          Text('Kvot: '),
//                          Text((vAirflowPoundMinute / vAirflowCfm).toString()),
//                        ],
//                      ),
                      Divider(color: Colors.white70),
                      Container(
                        // color: Colors.red,
                        width: kInputTextWidth,
                        child: Text(
                          AppLocalizations.of(context).translate(
                              'airflow_conv_hp_rpm_0040') //'Volume Airflow',
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
                              AppLocalizations.of(context)
                                  .translate('airflow_conv_hp_rpm_0050')
                              // 'Cubic Feet per Minute CFM',
                              ,
                              style: kLabelTextStyle,
                              textScaleFactor: textScaleFactorTc * .97,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.blue,
                            width: kInputNumberWidth,
                            child: Text(
                              vAirflowCfm.toStringAsFixed(1),
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
                              AppLocalizations.of(context)
                                  .translate('airflow_conv_hp_rpm_0060')
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
                              AppLocalizations.of(context)
                                  .translate('airflow_conv_hp_rpm_0070')
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

                      Divider(color: Colors.white70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            // color: Colors.red,
                            width: kResultTextWidth,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('airflow_conv_hp_rpm_0080')
                              // 'Pressure Ratio',
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
                      Divider(color: Colors.white70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            // color: Colors.red,
                            width: kResultTextWidth,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('airflow_conv_hp_rpm_0090')
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
                              requiredAbsolutePressure.toStringAsFixed(1),
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
                              AppLocalizations.of(context)
                                  .translate('airflow_conv_hp_rpm_0100')
                              //'Resultant Manifold Pressure',
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
                              resultantManifoldPressure.toStringAsFixed(1),
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
                        AppLocalizations.of(context)
                            .translate('airflow_conv_hp_rpm_0110') //'Input',
                        ,
                        style: kSecondSubjectTextStyle,
                        textScaleFactor: textScaleFactorTc),
                    SizedBox(height: 20),
                    Column(
                      children: <Widget>[
                        //length Feet
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  width: kInputTextWidth,
                                  // color: Colors.red,
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('airflow_conv_hp_rpm_0120')
                                    // 'Horsepower Engine',
                                    ,
                                    style: kLabelTextStyleLarge,
                                    textScaleFactor: textScaleFactorTc,
                                  )),
                              Container(
                                width: kInputNumberWidth,
                                // color: Colors.blue,
                                child: Text(
                                  desiredEngineHorsepower.toStringAsFixed(0),
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
                                    unitHorsePower,
                                    style: kUnitTextStyleAirflow,
                                    textScaleFactor: textScaleFactorTc,
                                  )),
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
                                        if (Decimal.parse(
                                                desiredEngineHorsepower
                                                    .toStringAsFixed(2)) >
                                            Decimal.parse(
                                                kMinDesiredCrankHorsePower
                                                    .toStringAsFixed(2))) {
                                          desiredEngineHorsepower =
                                              desiredEngineHorsepower -
                                                  stepDesiredCrankHorsePower;

                                          calcAirflowPoundPerMinute(
                                              vAirflowManifoldTemp,
                                              vAirflowPsiAmbient,
                                              vAirflowPsiG,
                                              desiredEngineHorsepower,
                                              bSFC,
                                              desiredAFR);

                                          calcRequiredAbsolutePressure(
                                              massFlowRatePoundMinute,
                                              engineDisplacementAirflow,
                                              volumetricEfficiency,
                                              maxEngineSpeed,
                                              vAirflowManifoldTemp,
                                              gasConstant,
                                              numberOfTurbos);
                                          calcResultantManifoldPressure(
                                              requiredAbsolutePressure,
                                              vAirflowPsiAmbient);
                                          calcPressureRatio(
                                              requiredAbsolutePressure,
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
                                      if (Decimal.parse(desiredEngineHorsepower
                                              .toStringAsFixed(2)) >
                                          Decimal.parse(
                                              kMinDesiredCrankHorsePower
                                                  .toStringAsFixed(2))) {
                                        desiredEngineHorsepower =
                                            desiredEngineHorsepower -
                                                stepDesiredCrankHorsePower;

                                        calcAirflowPoundPerMinute(
                                            vAirflowManifoldTemp,
                                            vAirflowPsiAmbient,
                                            vAirflowPsiG,
                                            desiredEngineHorsepower,
                                            bSFC,
                                            desiredAFR);
                                        calcRequiredAbsolutePressure(
                                            massFlowRatePoundMinute,
                                            engineDisplacementAirflow,
                                            volumetricEfficiency,
                                            maxEngineSpeed,
                                            vAirflowManifoldTemp,
                                            gasConstant,
                                            numberOfTurbos);
                                        calcResultantManifoldPressure(
                                            requiredAbsolutePressure,
                                            vAirflowPsiAmbient);
                                        calcPressureRatio(
                                            requiredAbsolutePressure,
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
                                  value: desiredEngineHorsepower,
                                  min: kMinDesiredCrankHorsePower,
                                  max: kMaxDesiredCrankHorsePower,
                                  label: desiredEngineHorsepower
                                      .toStringAsFixed(0),
                                  inactiveColor: Color(0xFF8D8E89),
                                  divisions:
                                      sliderDivisionsDesiredCrankHorsePower,
                                  onChanged: (double sliderValue) {
                                    desiredEngineHorsepower = sliderValue;
                                    calcAirflowPoundPerMinute(
                                        vAirflowManifoldTemp,
                                        vAirflowPsiAmbient,
                                        vAirflowPsiG,
                                        desiredEngineHorsepower,
                                        bSFC,
                                        desiredAFR);

                                    calcRequiredAbsolutePressure(
                                        massFlowRatePoundMinute,
                                        engineDisplacementAirflow,
                                        volumetricEfficiency,
                                        maxEngineSpeed,
                                        vAirflowManifoldTemp,
                                        gasConstant,
                                        numberOfTurbos);
                                    calcResultantManifoldPressure(
                                        requiredAbsolutePressure,
                                        vAirflowPsiAmbient);
                                    calcPressureRatio(
                                        requiredAbsolutePressure,
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
                                        if ((Decimal.parse(
                                                desiredEngineHorsepower
                                                    .toStringAsFixed(1)) <
                                            (Decimal.parse(
                                                kMaxDesiredCrankHorsePower
                                                    .toStringAsFixed(1))))) {
                                          desiredEngineHorsepower =
                                              desiredEngineHorsepower +
                                                  stepDesiredCrankHorsePower;
                                          calcAirflowPoundPerMinute(
                                              vAirflowManifoldTemp,
                                              vAirflowPsiAmbient,
                                              vAirflowPsiG,
                                              desiredEngineHorsepower,
                                              bSFC,
                                              desiredAFR);

                                          calcRequiredAbsolutePressure(
                                              massFlowRatePoundMinute,
                                              engineDisplacementAirflow,
                                              volumetricEfficiency,
                                              maxEngineSpeed,
                                              vAirflowManifoldTemp,
                                              gasConstant,
                                              numberOfTurbos);
                                          calcResultantManifoldPressure(
                                              requiredAbsolutePressure,
                                              vAirflowPsiAmbient);
                                          calcPressureRatio(
                                              requiredAbsolutePressure,
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
                                      if ((Decimal.parse(desiredEngineHorsepower
                                              .toStringAsFixed(1)) <
                                          (Decimal.parse(
                                              kMaxDesiredCrankHorsePower
                                                  .toStringAsFixed(1))))) {
                                        desiredEngineHorsepower =
                                            desiredEngineHorsepower +
                                                stepDesiredCrankHorsePower;
                                        calcAirflowPoundPerMinute(
                                            vAirflowManifoldTemp,
                                            vAirflowPsiAmbient,
                                            vAirflowPsiG,
                                            desiredEngineHorsepower,
                                            bSFC,
                                            desiredAFR);

                                        calcRequiredAbsolutePressure(
                                            massFlowRatePoundMinute,
                                            engineDisplacementAirflow,
                                            volumetricEfficiency,
                                            maxEngineSpeed,
                                            vAirflowManifoldTemp,
                                            gasConstant,
                                            numberOfTurbos);
                                        calcResultantManifoldPressure(
                                            requiredAbsolutePressure,
                                            vAirflowPsiAmbient);
                                        calcPressureRatio(
                                            requiredAbsolutePressure,
                                            vAirflowPsiAmbient,
                                            preTurboFlowLoss,
                                            postTurboFlowLoss);
                                      }
                                    });
                                  }),
                            ),
                          ],
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      width: kInputTextWidth,
                                      // color: Colors.red,
                                      child: Text(
                                        AppLocalizations.of(context).translate(
                                            'airflow_conv_hp_rpm_0130')
                                        //'Engine speed',
                                        ,
                                        style: kLabelTextStyleLarge,
                                        textScaleFactor: textScaleFactorTc,
                                      )),
                                  Container(
                                    width: kInputNumberWidth,
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
                                      // color: Colors.green,s
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
                                          calcAirflowPoundPerMinute(
                                              vAirflowManifoldTemp,
                                              vAirflowPsiAmbient,
                                              vAirflowPsiG,
                                              desiredEngineHorsepower,
                                              bSFC,
                                              desiredAFR);
                                          calcRequiredAbsolutePressure(
                                              massFlowRatePoundMinute,
                                              engineDisplacementAirflow,
                                              volumetricEfficiency,
                                              maxEngineSpeed,
                                              vAirflowManifoldTemp,
                                              gasConstant,
                                              numberOfTurbos);
                                          calcResultantManifoldPressure(
                                              requiredAbsolutePressure,
                                              vAirflowPsiAmbient);
                                          calcPressureRatio(
                                              requiredAbsolutePressure,
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
                                        calcAirflowPoundPerMinute(
                                            vAirflowManifoldTemp,
                                            vAirflowPsiAmbient,
                                            vAirflowPsiG,
                                            desiredEngineHorsepower,
                                            bSFC,
                                            desiredAFR);

                                        calcRequiredAbsolutePressure(
                                            massFlowRatePoundMinute,
                                            engineDisplacementAirflow,
                                            volumetricEfficiency,
                                            maxEngineSpeed,
                                            vAirflowManifoldTemp,
                                            gasConstant,
                                            numberOfTurbos);
                                        calcResultantManifoldPressure(
                                            requiredAbsolutePressure,
                                            vAirflowPsiAmbient);
                                        calcPressureRatio(
                                            requiredAbsolutePressure,
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
                                    calcAirflowPoundPerMinute(
                                        vAirflowManifoldTemp,
                                        vAirflowPsiAmbient,
                                        vAirflowPsiG,
                                        desiredEngineHorsepower,
                                        bSFC,
                                        desiredAFR);

                                    calcRequiredAbsolutePressure(
                                        massFlowRatePoundMinute,
                                        engineDisplacementAirflow,
                                        volumetricEfficiency,
                                        maxEngineSpeed,
                                        vAirflowManifoldTemp,
                                        gasConstant,
                                        numberOfTurbos);
                                    calcResultantManifoldPressure(
                                        requiredAbsolutePressure,
                                        vAirflowPsiAmbient);
                                    calcPressureRatio(
                                        requiredAbsolutePressure,
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
                                        if ((Decimal.parse(maxEngineSpeed
                                                .toStringAsFixed(1)) <
                                            (Decimal.parse(kMaxMaxEngineSpeed
                                                .toStringAsFixed(1))))) {
                                          maxEngineSpeed = maxEngineSpeed +
                                              stepMaxEngineSpeed;
                                          calcAirflowPoundPerMinute(
                                              vAirflowManifoldTemp,
                                              vAirflowPsiAmbient,
                                              vAirflowPsiG,
                                              desiredEngineHorsepower,
                                              bSFC,
                                              desiredAFR);

                                          calcRequiredAbsolutePressure(
                                              massFlowRatePoundMinute,
                                              engineDisplacementAirflow,
                                              volumetricEfficiency,
                                              maxEngineSpeed,
                                              vAirflowManifoldTemp,
                                              gasConstant,
                                              numberOfTurbos);
                                          calcResultantManifoldPressure(
                                              requiredAbsolutePressure,
                                              vAirflowPsiAmbient);
                                          calcPressureRatio(
                                              requiredAbsolutePressure,
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
                                      if ((Decimal.parse(maxEngineSpeed
                                              .toStringAsFixed(1)) <
                                          (Decimal.parse(kMaxMaxEngineSpeed
                                              .toStringAsFixed(1))))) {
                                        maxEngineSpeed =
                                            maxEngineSpeed + stepMaxEngineSpeed;
                                        calcAirflowPoundPerMinute(
                                            vAirflowManifoldTemp,
                                            vAirflowPsiAmbient,
                                            vAirflowPsiG,
                                            desiredEngineHorsepower,
                                            bSFC,
                                            desiredAFR);

                                        calcRequiredAbsolutePressure(
                                            massFlowRatePoundMinute,
                                            engineDisplacementAirflow,
                                            volumetricEfficiency,
                                            maxEngineSpeed,
                                            vAirflowManifoldTemp,
                                            gasConstant,
                                            numberOfTurbos);
                                        calcResultantManifoldPressure(
                                            requiredAbsolutePressure,
                                            vAirflowPsiAmbient);
                                        calcPressureRatio(
                                            requiredAbsolutePressure,
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
                    Divider(height: 10.0, color: Colors.white),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // // color: Colors.red,
                              //width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: kInputTextWidth,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('airflow_conv_hp_rpm_0140')
                                      // 'Engine Displacement Cubic Inch',
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

                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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

                                              calcAirflowPoundPerMinute(
                                                  vAirflowManifoldTemp,
                                                  vAirflowPsiAmbient,
                                                  vAirflowPsiG,
                                                  desiredEngineHorsepower,
                                                  bSFC,
                                                  desiredAFR);
                                              calcRequiredAbsolutePressure(
                                                  massFlowRatePoundMinute,
                                                  engineDisplacementAirflow,
                                                  volumetricEfficiency,
                                                  maxEngineSpeed,
                                                  vAirflowManifoldTemp,
                                                  gasConstant,
                                                  numberOfTurbos);
                                              calcResultantManifoldPressure(
                                                  requiredAbsolutePressure,
                                                  vAirflowPsiAmbient);
                                              calcPressureRatio(
                                                  requiredAbsolutePressure,
                                                  vAirflowPsiAmbient,
                                                  preTurboFlowLoss,
                                                  postTurboFlowLoss);
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
                                              if ((Decimal.parse(
                                                      engineDisplacementCidAirflow
                                                          .toStringAsFixed(1)) <
                                                  (Decimal.parse(
                                                      kMaxCubicInchEngineDisplacement
                                                          .toStringAsFixed(
                                                              1))))) {
                                                engineDisplacementCidAirflow =
                                                    engineDisplacementCidAirflow +
                                                        stepCubicInchEngineDisplacement;

                                                calcEngineDisplacementAirflow(
                                                    engineDisplacementCidAirflow);

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);

                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                                                        .toStringAsFixed(1)) <
                                                (Decimal.parse(
                                                    kMaxCubicInchEngineDisplacement
                                                        .toStringAsFixed(
                                                            1))))) {
                                              engineDisplacementCidAirflow =
                                                  engineDisplacementCidAirflow +
                                                      stepCubicInchEngineDisplacement;

                                              calcEngineDisplacementAirflow(
                                                  engineDisplacementCidAirflow);

                                              calcEngineDisplacementCidAirflow(
                                                  engineDisplacementAirflow);

                                              calcAirflowPoundPerMinute(
                                                  vAirflowManifoldTemp,
                                                  vAirflowPsiAmbient,
                                                  vAirflowPsiG,
                                                  desiredEngineHorsepower,
                                                  bSFC,
                                                  desiredAFR);
                                              calcRequiredAbsolutePressure(
                                                  massFlowRatePoundMinute,
                                                  engineDisplacementAirflow,
                                                  volumetricEfficiency,
                                                  maxEngineSpeed,
                                                  vAirflowManifoldTemp,
                                                  gasConstant,
                                                  numberOfTurbos);
                                              calcResultantManifoldPressure(
                                                  requiredAbsolutePressure,
                                                  vAirflowPsiAmbient);
                                              calcPressureRatio(
                                                  requiredAbsolutePressure,
                                                  vAirflowPsiAmbient,
                                                  preTurboFlowLoss,
                                                  postTurboFlowLoss);
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
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // // color: Colors.red,
                              //width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: kInputTextWidth,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('airflow_conv_hp_rpm_0150')
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
                                                      engineDisplacementAirflow
                                                          .toStringAsFixed(2)) >
                                                  (Decimal.parse(
                                                      kMinEngineDisplacement
                                                          .toStringAsFixed(
                                                              2))))) {
                                                engineDisplacementAirflow =
                                                    engineDisplacementAirflow -
                                                        stepEngineDisplacement;

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                //     calcEngineDisplacementAirflow(engineDisplacementCidAirflow);

                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                                                        .toStringAsFixed(2)) >
                                                (Decimal.parse(
                                                    kMinEngineDisplacement
                                                        .toStringAsFixed(
                                                            2))))) {
                                              engineDisplacementAirflow =
                                                  engineDisplacementAirflow -
                                                      stepEngineDisplacement;

                                              calcEngineDisplacementCidAirflow(
                                                  engineDisplacementAirflow);
                                              //     calcEngineDisplacementAirflow(engineDisplacementCidAirflow);

                                              calcAirflowPoundPerMinute(
                                                  vAirflowManifoldTemp,
                                                  vAirflowPsiAmbient,
                                                  vAirflowPsiG,
                                                  desiredEngineHorsepower,
                                                  bSFC,
                                                  desiredAFR);
                                              calcRequiredAbsolutePressure(
                                                  massFlowRatePoundMinute,
                                                  engineDisplacementAirflow,
                                                  volumetricEfficiency,
                                                  maxEngineSpeed,
                                                  vAirflowManifoldTemp,
                                                  gasConstant,
                                                  numberOfTurbos);
                                              calcResultantManifoldPressure(
                                                  requiredAbsolutePressure,
                                                  vAirflowPsiAmbient);
                                              calcPressureRatio(
                                                  requiredAbsolutePressure,
                                                  vAirflowPsiAmbient,
                                                  preTurboFlowLoss,
                                                  postTurboFlowLoss);
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
                                              if ((Decimal.parse(
                                                      engineDisplacementAirflow
                                                          .toStringAsFixed(2)) <
                                                  (Decimal.parse(
                                                      kMaxEngineDisplacement
                                                          .toStringAsFixed(
                                                              2))))) {
                                                engineDisplacementAirflow =
                                                    engineDisplacementAirflow +
                                                        stepEngineDisplacement;

                                                calcEngineDisplacementCidAirflow(
                                                    engineDisplacementAirflow);
                                                //     calcEngineDisplacementAirflow(engineDisplacementCidAirflow);

                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                                                        .toStringAsFixed(2)) <
                                                (Decimal.parse(
                                                    kMaxEngineDisplacement
                                                        .toStringAsFixed(
                                                            2))))) {
                                              engineDisplacementAirflow =
                                                  engineDisplacementAirflow +
                                                      stepEngineDisplacement;

                                              calcEngineDisplacementCidAirflow(
                                                  engineDisplacementAirflow);
                                              //     calcEngineDisplacementAirflow(engineDisplacementCidAirflow);

                                              calcAirflowPoundPerMinute(
                                                  vAirflowManifoldTemp,
                                                  vAirflowPsiAmbient,
                                                  vAirflowPsiG,
                                                  desiredEngineHorsepower,
                                                  bSFC,
                                                  desiredAFR);
                                              calcRequiredAbsolutePressure(
                                                  massFlowRatePoundMinute,
                                                  engineDisplacementAirflow,
                                                  volumetricEfficiency,
                                                  maxEngineSpeed,
                                                  vAirflowManifoldTemp,
                                                  gasConstant,
                                                  numberOfTurbos);
                                              calcResultantManifoldPressure(
                                                  requiredAbsolutePressure,
                                                  vAirflowPsiAmbient);
                                              calcPressureRatio(
                                                  requiredAbsolutePressure,
                                                  vAirflowPsiAmbient,
                                                  preTurboFlowLoss,
                                                  postTurboFlowLoss);
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
                    Divider(height: 10.0, color: Colors.white),
//Engine Displacement
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              //width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: kInputTextWidth,
                                    child: Text(
                                      AppLocalizations.of(context).translate(
                                          'airflow_conv_hp_rpm_0160') //'BSFC',
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
                                          bSFC.toStringAsFixed(2),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                        width: kInputUnitWidth,
                                        // color: Colors.orange,
                                        child: Text(
                                          unitBSFC,
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
                                                if ((Decimal.parse(bSFC
                                                        .toStringAsFixed(2)) >
                                                    (Decimal.parse(kMinBsfc
                                                        .toStringAsFixed(
                                                            2))))) {
                                                  bSFC = bSFC - stepBsfc;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                      bSFC.toStringAsFixed(2)) >
                                                  (Decimal.parse(kMinBsfc
                                                      .toStringAsFixed(2))))) {
                                                bSFC = bSFC - stepBsfc;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                                                if ((Decimal.parse(bSFC
                                                        .toStringAsFixed(2)) <
                                                    (Decimal.parse(kMaxBsfc
                                                        .toStringAsFixed(
                                                            2))))) {
                                                  bSFC = bSFC + stepBsfc;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                      bSFC.toStringAsFixed(2)) <
                                                  (Decimal.parse(kMaxBsfc
                                                      .toStringAsFixed(2))))) {
                                                bSFC = bSFC + stepBsfc;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                    ), //BSFC
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              //width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: kInputTextWidth,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('airflow_conv_hp_rpm_0170')
                                      // 'Volumetric Efficiency',
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
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                    ), // Volumetric Efficiency
                    //Max Engine
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              //width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: kInputTextWidth,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('airflow_conv_hp_rpm_0180')
                                      //  'Desired AFR',
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
                                          desiredAFR.toStringAsFixed(1),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                      ),
                                      Container(
                                          width: kInputUnitWidth,
                                          // color: Colors.orange,
                                          child: Text(
                                            ':1',
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
                                                if ((Decimal.parse(desiredAFR
                                                        .toStringAsFixed(2)) >
                                                    (Decimal.parse(
                                                        kMinDesiredAFR
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  desiredAFR = desiredAFR -
                                                      stepDesiredAFR;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                              if ((Decimal.parse(desiredAFR
                                                      .toStringAsFixed(2)) >
                                                  (Decimal.parse(kMinDesiredAFR
                                                      .toStringAsFixed(2))))) {
                                                desiredAFR =
                                                    desiredAFR - stepDesiredAFR;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                                                if ((Decimal.parse(desiredAFR
                                                        .toStringAsFixed(2)) <
                                                    (Decimal.parse(
                                                        kMaxDesiredAFR
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  desiredAFR = desiredAFR +
                                                      stepDesiredAFR;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                              if ((Decimal.parse(desiredAFR
                                                      .toStringAsFixed(2)) <
                                                  (Decimal.parse(kMaxDesiredAFR
                                                      .toStringAsFixed(2))))) {
                                                desiredAFR =
                                                    desiredAFR + stepDesiredAFR;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                    ), //Desired AFR
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              //width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: kInputTextWidth,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('airflow_conv_hp_rpm_0190')
                                      // 'Intake Temp @ Valve',
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
                                                        vAirflowManifoldTemp
                                                            .toStringAsFixed(
                                                                2)) >
                                                    (Decimal.parse(
                                                        kMinAirflowManifoldTemp
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  vAirflowManifoldTemp =
                                                      vAirflowManifoldTemp -
                                                          stepAirflowManifoldTemp;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                          .toStringAsFixed(2)) >
                                                  (Decimal.parse(
                                                      kMinAirflowManifoldTemp
                                                          .toStringAsFixed(
                                                              2))))) {
                                                vAirflowManifoldTemp =
                                                    vAirflowManifoldTemp -
                                                        stepAirflowManifoldTemp;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                                                                2)) <
                                                    (Decimal.parse(
                                                        kMaxAirflowManifoldTemp
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  vAirflowManifoldTemp =
                                                      vAirflowManifoldTemp +
                                                          stepAirflowManifoldTemp;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                          .toStringAsFixed(2)) <
                                                  (Decimal.parse(
                                                      kMaxAirflowManifoldTemp
                                                          .toStringAsFixed(
                                                              2))))) {
                                                vAirflowManifoldTemp =
                                                    vAirflowManifoldTemp +
                                                        stepAirflowManifoldTemp;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                    ), //Intake Temp @ Valve
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              //width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: kInputTextWidth,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('airflow_conv_hp_rpm_0200')
                                      //  'Atmospheric Pressure',
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
                                                        vAirflowPsiAmbient
                                                            .toStringAsFixed(
                                                                2)) >
                                                    (Decimal.parse(
                                                        kMinAirflowPsiAmbient
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  vAirflowPsiAmbient =
                                                      vAirflowPsiAmbient -
                                                          stepAirflowPsiAmbient;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                          .toStringAsFixed(2)) >
                                                  (Decimal.parse(
                                                      kMinAirflowPsiAmbient
                                                          .toStringAsFixed(
                                                              2))))) {
                                                vAirflowPsiAmbient =
                                                    vAirflowPsiAmbient -
                                                        stepAirflowPsiAmbient;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                                                                2)) <
                                                    (Decimal.parse(
                                                        kMaxAirflowPsiAmbient
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  vAirflowPsiAmbient =
                                                      vAirflowPsiAmbient +
                                                          stepAirflowPsiAmbient;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                          .toStringAsFixed(2)) <
                                                  (Decimal.parse(
                                                      kMaxAirflowPsiAmbient
                                                          .toStringAsFixed(
                                                              2))))) {
                                                vAirflowPsiAmbient =
                                                    vAirflowPsiAmbient +
                                                        stepAirflowPsiAmbient;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                    ), //Atmospheric Pressure
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              //width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: kInputTextWidth,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('airflow_conv_hp_rpm_0210')
                                      //  'Pre-Turbo Flow Loss',
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
                                                                2)) >
                                                    (Decimal.parse(
                                                        kMinPreTurboFlowLoss
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  preTurboFlowLoss =
                                                      preTurboFlowLoss -
                                                          stepPreTurboFlowLoss;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                          .toStringAsFixed(2)) >
                                                  (Decimal.parse(
                                                      kMinPreTurboFlowLoss
                                                          .toStringAsFixed(
                                                              2))))) {
                                                preTurboFlowLoss =
                                                    preTurboFlowLoss -
                                                        stepPreTurboFlowLoss;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                                                                2)) <
                                                    (Decimal.parse(
                                                        kMaxPreTurboFlowLoss
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  preTurboFlowLoss =
                                                      preTurboFlowLoss +
                                                          stepPreTurboFlowLoss;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                          .toStringAsFixed(2)) <
                                                  (Decimal.parse(
                                                      kMaxPreTurboFlowLoss
                                                          .toStringAsFixed(
                                                              2))))) {
                                                preTurboFlowLoss =
                                                    preTurboFlowLoss +
                                                        stepPreTurboFlowLoss;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                    ), //Pre-Turbo Flow Loss
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              //width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: kInputTextWidth,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('airflow_conv_hp_rpm_0220')
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
                                                                2)) >
                                                    (Decimal.parse(
                                                        kMinPostTurboFlowLoss
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  postTurboFlowLoss =
                                                      postTurboFlowLoss -
                                                          stepPostTurboFlowLoss;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                          .toStringAsFixed(2)) >
                                                  (Decimal.parse(
                                                      kMinPostTurboFlowLoss
                                                          .toStringAsFixed(
                                                              2))))) {
                                                postTurboFlowLoss =
                                                    postTurboFlowLoss -
                                                        stepPostTurboFlowLoss;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                                                                2)) <
                                                    (Decimal.parse(
                                                        kMaxPostTurboFlowLoss
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  postTurboFlowLoss =
                                                      postTurboFlowLoss +
                                                          stepPostTurboFlowLoss;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                          .toStringAsFixed(2)) <
                                                  (Decimal.parse(
                                                      kMaxPostTurboFlowLoss
                                                          .toStringAsFixed(
                                                              2))))) {
                                                postTurboFlowLoss =
                                                    postTurboFlowLoss +
                                                        stepPostTurboFlowLoss;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                    ), //Post-Turbo Flow Loss
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // color: Colors.red,
                              //width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    width: kInputTextWidth,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('airflow_conv_hp_rpm_0230')
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
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'airflow_conv_hp_rpm_0240')
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
                                                                2)) >
                                                    (Decimal.parse(
                                                        kMinNumberOfTurbos
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  numberOfTurbos =
                                                      numberOfTurbos -
                                                          stepNumberOfTurbos;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                      .toStringAsFixed(2)) >
                                                  (Decimal.parse(
                                                      kMinNumberOfTurbos
                                                          .toStringAsFixed(
                                                              2))))) {
                                                numberOfTurbos =
                                                    numberOfTurbos -
                                                        stepNumberOfTurbos;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                                                                2)) <
                                                    (Decimal.parse(
                                                        kMaxNumberOfTurbos
                                                            .toStringAsFixed(
                                                                2))))) {
                                                  numberOfTurbos =
                                                      numberOfTurbos +
                                                          stepNumberOfTurbos;
                                                  calcAirflowPoundPerMinute(
                                                      vAirflowManifoldTemp,
                                                      vAirflowPsiAmbient,
                                                      vAirflowPsiG,
                                                      desiredEngineHorsepower,
                                                      bSFC,
                                                      desiredAFR);
                                                  calcRequiredAbsolutePressure(
                                                      massFlowRatePoundMinute,
                                                      engineDisplacementAirflow,
                                                      volumetricEfficiency,
                                                      maxEngineSpeed,
                                                      vAirflowManifoldTemp,
                                                      gasConstant,
                                                      numberOfTurbos);
                                                  calcResultantManifoldPressure(
                                                      requiredAbsolutePressure,
                                                      vAirflowPsiAmbient);
                                                  calcPressureRatio(
                                                      requiredAbsolutePressure,
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
                                                      .toStringAsFixed(2)) <
                                                  (Decimal.parse(
                                                      kMaxNumberOfTurbos
                                                          .toStringAsFixed(
                                                              2))))) {
                                                numberOfTurbos =
                                                    numberOfTurbos +
                                                        stepNumberOfTurbos;
                                                calcAirflowPoundPerMinute(
                                                    vAirflowManifoldTemp,
                                                    vAirflowPsiAmbient,
                                                    vAirflowPsiG,
                                                    desiredEngineHorsepower,
                                                    bSFC,
                                                    desiredAFR);
                                                calcRequiredAbsolutePressure(
                                                    massFlowRatePoundMinute,
                                                    engineDisplacementAirflow,
                                                    volumetricEfficiency,
                                                    maxEngineSpeed,
                                                    vAirflowManifoldTemp,
                                                    gasConstant,
                                                    numberOfTurbos);
                                                calcResultantManifoldPressure(
                                                    requiredAbsolutePressure,
                                                    vAirflowPsiAmbient);
                                                calcPressureRatio(
                                                    requiredAbsolutePressure,
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
                    ), //Number of Turbos
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

  void calcRequiredAbsolutePressure(
      double massFlowRatePoundMinute,
      double engineDisplacement,
      double volumetricEfficiency,
      double maxEngineSpeed,
      double vAirflowManifoldTemp,
      double gasConstant,
      double numberOfTurbos) {
    setState(() {
      requiredAbsolutePressure = calculate.calcRequiredAbsolutePressure(
          massFlowRatePoundMinute,
          engineDisplacement,
          volumetricEfficiency,
          maxEngineSpeed,
          vAirflowManifoldTemp,
          gasConstant,
          numberOfTurbos);
    });
  }

  void calcResultantManifoldPressure(
      double requiredAbsolutePressure, double vAirflowPsiAmbient) {
    setState(() {
      resultantManifoldPressure = calculate.calcResultantManifoldPressure(
          requiredAbsolutePressure, vAirflowPsiAmbient);
    });
  }

  void calcPressureRatio(
      double requiredAbsolutePressure,
      double vAirflowPsiAmbient,
      double preTurboFlowLoss,
      double postTurboFlowLoss) {
    setState(() {
      pressureRatio = calculate.calcPressureRatio(requiredAbsolutePressure,
          vAirflowPsiAmbient, preTurboFlowLoss, postTurboFlowLoss);
    });
  }

//  void calcVolumetricFlowRateCfm(double volumetricFlowRate) {
//    setState(() {
//      volumetricFlowRateCfm =
//          calculate.calcCubicFeetPerMinute(volumetricFlowRate);
//    });
//  }

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

  void calcAirflowPoundPerMinute(
      double vAirflowManifoldTemp,
      double vAirflowPsiAmbient,
      double vAirflowPsiG,
      double desiredEngineHorsepower,
      double bSFC,
      double desiredAFR) {
    setState(() {
      vAirflowPoundMinute = calculate.calcMassFlowRatePoundMinute(
          desiredEngineHorsepower, bSFC, desiredAFR);

      var vTempAirflowPoundMinute = vAirflowPoundMinute;

      vAirflowCfm = calculate.calcCubicFeetPerMinuteExact(
          vTempAirflowPoundMinute,
          vAirflowManifoldTemp,
          vAirflowPsiAmbient,
          vAirflowPsiG);
      var vTempAirflowCfm = vAirflowCfm;

      vAirflowCubicMeterPerSecond =
          vTempAirflowCfm * kCubicFeetPerMinuteToCubicMeterPerSecond;
      var vTempAirflowCubicMeterPerSecond = vAirflowCubicMeterPerSecond;
      vAirflowCubicMeterPerMinute = vTempAirflowCubicMeterPerSecond * 60;

      print('Första vAirflowPoundMinute $vAirflowPoundMinute');
      print(
          'Första cubicMeterPerSecondConversion $vAirflowCubicMeterPerSecond');
      print('Första vAirflowCfm $vAirflowCfm');
    });
  }

  void resetValues(bool metricUnit) {
    setState(() {
      metricUnit = false;
      if (metricUnit) {
        unitValue = unitLengthMillimeter;
        pressureUnitValue = unitPressureBar;
      } else {
        unitValue = unitLengthInch;
        pressureUnitValue = unitPressurePsi;

        vAirflowCfm = 669.89;
        vAirflowManifoldTemp = 14.7;
        vAirflowPsiAmbient = 14.7;
        vAirflowPsiG = 0;
        desiredEngineHorsepower = 350;
        bSFC = 0.55;
        desiredAFR = 11;
        vAirflowManifoldTemp = 110;
        gasConstant = 639.6;
        numberOfTurbos = 1;
        engineDisplacementAirflow = 3.7;
        // engineDisplacementCidAirflow=308;

        calcAirflowPoundPerMinute(vAirflowManifoldTemp, vAirflowPsiAmbient,
            vAirflowPsiG, desiredEngineHorsepower, bSFC, desiredAFR);
        calcRequiredAbsolutePressure(
            massFlowRatePoundMinute,
            engineDisplacementAirflow,
            volumetricEfficiency,
            maxEngineSpeed,
            vAirflowManifoldTemp,
            gasConstant,
            numberOfTurbos);
        calcResultantManifoldPressure(
            requiredAbsolutePressure, vAirflowPsiAmbient);
        calcPressureRatio(requiredAbsolutePressure, vAirflowPsiAmbient,
            preTurboFlowLoss, postTurboFlowLoss);

//        calcEngineDisplacementAirflow(
//            engineDisplacementCidAirflow);

        calcEngineDisplacementCidAirflow(engineDisplacementAirflow);
      }
    });
  }
}
