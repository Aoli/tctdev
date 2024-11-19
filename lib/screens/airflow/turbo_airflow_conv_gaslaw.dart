import 'dart:async';
import 'package:Turbocharger/components/analytics_event.dart';
import 'package:Turbocharger/data_models/analytics_event_type.dart';
import 'package:Turbocharger/components/stepbutton.dart';
import 'package:Turbocharger/components/stepbutton_close.dart';
import 'package:Turbocharger/globals/app_localizations.dart';
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


class AirflowGasLawConv extends StatefulWidget {
  @override
  _AirflowGasLawConvState createState() => _AirflowGasLawConvState();
}

class _AirflowGasLawConvState extends State<AirflowGasLawConv> {
  _AirflowGasLawConvState();

  //bool metricUnit = false;
  bool snackbarEnable = true;

  Widget get submitRatingButton {
    if (snackbarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            _scaffoldCompressorKey.currentState
                .showSnackBar(snackBarCompressor);

            // parameters
            var _analyticsParameter = {'Snackbar': 'Airflow GasLaw'};
            // Execute a function to send logEvent() to Firebase Analytics
            Analytics.analyticsLogEvent(
                AnalyticsEventType.snack_bar, _analyticsParameter);
          });
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
            height: 15.0,
          ),
          Text(
            'Gas Law Conversion',
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textScaleFactor: textScaleFactorTc,
          ),
          SizedBox(height: 5.0),
          Text(
            'We are using the "Gas Flow Law formulas here but still with some approximations. However, this calculation is more accurate than using the air density formula.',
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

    convertResultLengthInch = 1.0;
    convertResultLengthMillimeter = 25.4;

    convertResultTemperatureCelsius = 20.0;
    convertResultTemperatureFahrenheit = 68.0;

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
              AppLocalizations.of(context).translate('airflow_conv_gaslaw_0000')
              // 'Airflow Conv Gas Law',
              , style: kAppBarTextStyle,
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
              // ETA
              ReusableCard(
                colour: kActiveCardColourOutput,
                cardChild: Container(
                  height: 260,
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: 95,
                            child: Column(
                              children: <Widget>[
                                Text(AppLocalizations.of(context).translate(
                                    'airflow_conv_gaslaw_0010')
                                  //'Mass Airflow',
                                  , style: labelTextStyleResultTitle0,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
//                              Container(
//                                // color: Colors.red,
//                                width: kWidthResultTextContainer,
//                                height: kHeightResultTextHeight,
//                                child: Text(
//                                  'US liquid gallon',
//                                  style: labelTextStyleActive0,
//                                  textScaleFactor: textScaleFactorTc,
//                                ),
//                              ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      // color: Colors.blue,
                                      width: kResultNumberBigWidth,
//                                height: kHeightResultTextHeight,
                                      child: Text(
                                        vAirflowPoundMinute.toStringAsFixed(2),
                                        style: labelTextStyleResult0,
                                        textScaleFactor: textScaleFactorTc,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      // color: Colors.green,
                                      width: kResultUnitWidth + 15,
//                                height: kHeightResultTextHeight,
                                      child: Text(
                                        unitMassFlowRatePoundMinute,
                                        style: labelTextStyleResultUnit0,
                                        textScaleFactor: textScaleFactorTc,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
//                              Container(
//                                // color: Colors.red,
//                                width: kWidthResultTextContainer,
//                                height: kHeightResultTextHeight,
//                                child: Text(
//                                  'US liquid gallon',
//                                  style: labelTextStyleResult0,
//                                  textScaleFactor: textScaleFactorTc,
//                                ),
//                              ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      // color: Colors.blue,
                                      width: kResultNumberBigWidth,
//                                height: kHeightResultTextHeight,
                                      child: Text(
                                        (convertResultAirflowAirDensityPoundPerMinute *
                                            kPoundPerMinuteToKilogramPerSecond)
                                            .toStringAsFixed(2),
                                        style: labelTextStyleResult0,
                                        textScaleFactor: textScaleFactorTc,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      // color: Colors.green,
                                      width: kResultUnitWidth + 15,
//                                height: kHeightResultTextHeight,
                                      child: Text(
                                        unitMassFlowRateKilogramSecond,
                                        style: labelTextStyleResultUnit0,
                                        textScaleFactor: textScaleFactorTc,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 15.0, color: Colors.white),

                          Text(AppLocalizations.of(context).translate(
                              'airflow_conv_gaslaw_0020') //'Volume Airflow',
                            , style: labelTextStyleResultTitle1,
                            textScaleFactor: textScaleFactorTc,
                          ),
                          SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
//                              Container(
//                                // color: Colors.red,
//                                width: kResultNumberBigWidth,
////                                height: kHeightResultTextHeight,
//                                child: Text(
//                                  'Liter',
//                                  style: labelTextStyleActive1,
//                                  textScaleFactor: textScaleFactorTc,
//                                ),
//                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.blue,
                                width: kResultNumberBigWidth,
//                                height: kHeightResultTextHeight,
                                child: Text(
                                  vAirflowCfm.toStringAsFixed(1),
                                  style: labelTextStyleResult1,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.green,
                                width: kResultUnitWidth + 15,
//                                height: kHeightResultTextHeight,
                                child: Text(
                                  unitVolumetricFlowRateCfm,
                                  style: labelTextStyleResultUnit1,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                            ],
                          ),
                          //SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
//                              Container(
//                                // color: Colors.red,
//                                width: kResultNumberBigWidth,
//                                height: kHeightResultTextHeight,
//                                child: Text(
//                                  'Cubic Centimeter',
//                                  style: labelTextStyleActive2,
//                                  textScaleFactor: textScaleFactorTc,
//                                ),
//                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.blue,
                                width: kResultNumberBigWidth,
//                                height: kHeightResultTextHeight,
                                child: Text(
                                  vAirflowCubicMeterPerMinute
                                      .toStringAsFixed(3),
                                  style: labelTextStyleResult1,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.green,
                                width: kResultUnitWidth + 15,
//                                height: kHeightResultTextHeight,
                                child: Text(
                                  unitVolumetricCubicMeterPerMinute,
                                  style: labelTextStyleResultUnit1,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
//                              Container(
//                                // color: Colors.red,
//                                width: kWidthResultTextContainer,
//                                height: kHeightResultTextHeight,
//                                child: Text(
//                                  'Cubic Inch',
//                                  style: labelTextStyleActive3,
//                                  textScaleFactor: textScaleFactorTc,
//                                ),
//                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.blue,
                                width: kResultNumberBigWidth,
//                                height: kHeightResultTextHeight,
                                child: Text(
                                  vAirflowCubicMeterPerSecond
                                      .toStringAsFixed(4),
                                  style: labelTextStyleResult1,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.green,
                                width: kResultUnitWidth + 15,
//                                height: kHeightResultTextHeight,
                                child: Text(
                                  unitVolumetricCubicMeterPerSecond,
                                  style: labelTextStyleResultUnit1,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 15.0, color: Colors.white),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
//                              Container(
//                                // color: Colors.red,
//                                width: kWidthResultTextContainer,
//                                height: kHeightResultTextHeight,
//                                child: Text(
//                                  'Cubic Inch',
//                                  style: labelTextStyleActive3,
//                                  textScaleFactor: textScaleFactorTc,
//                                ),
//                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      AppLocalizations.of(context).translate(
                                          'airflow_conv_gaslaw_0030')
                                      //'Calc. Air density:',
                                      , style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                // color: Colors.blue,
                                width: kResultNumberBigWidth,
//                                height: kHeightResultTextHeight,
                                child: Text(
                                  (vAirflowPoundMinute / vAirflowCfm)
                                      .toStringAsFixed(3),
                                  style: kLabelTextStyleActive,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.green,
                                width: kResultUnitWidth + 15,
//                                height: kHeightResultTextHeight,
                                child: Text(
                                  'Lbs/f^3',
                                  style: kUnitTextStyleAirflowActive,
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
                                child: Text(
                                    convertSliderHeaderAirflowAirDensityTextAll,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                    kMinSliderConvertAirflowAirDensityAll
                                        .toStringAsFixed(0),
                                    style: TextStyle(color: Colors.white30),
                                    textScaleFactor: textScaleFactorTc),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Text(
                                  kMaxSliderConvertAirflowAirDensityAll
                                      .toStringAsFixed(0),
                                  style: TextStyle(color: Colors.white30),
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.white,
                              thumbColor: kConversionSliderNob,
                              overlayColor: kConversionSliderOverlayColor,
                              valueIndicatorColor: kConversionSliderLabelColor,
                              inactiveTrackColor: kInactiveSlideColour,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: kNobThumbShapeLarge),
                              overlayShape: RoundSliderOverlayShape(
                                  overlayRadius: kNobOverlayShapeLarge),
                            ),
                            child: Slider(
                                value: convertSliderResultAirflowAirDensityAll,
                                min: kMinSliderConvertAirflowAirDensityAll,
                                max: kMaxSliderConvertAirflowAirDensityAll,
                                label: convertSliderResultAirflowAirDensityAll
                                    .toStringAsFixed(0),
                                inactiveColor: Color(0xFF8D8E89),
                                divisions:
                                sliderSliderConvertAirflowAirDensityAll,
                                onChanged: (double sliderValue) {
                                  convertSliderResultAirflowAirDensityAll =
                                      sliderValue;
                                  debugPrint(
                                      'SLIDE convertSliderResultAirflowAirDensityAll $convertSliderResultAirflowAirDensityAll');
                                  debugPrint(
                                      'SLIDE convertResultTemperatureCelsius $convertResultTemperatureCelsius');

                                  calcAirflowCfm(
                                      convertSliderResultAirflowAirDensityAll,
                                      convertSliderResultAirflowAirDensityAll,
                                      vAirflowManifoldTemp,
                                      vAirflowPsiAmbient,
                                      vAirflowPsiG,
                                      radioValue);
                                }),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 0),
                                child: StepButton(
                                    icon: FontAwesomeIcons.minus,
                                    onStepPress: () {
                                      timer = Timer.periodic(
                                          Duration(milliseconds: tapTime), (t) {
                                        setState(() {
                                          if (Decimal.parse(
                                              convertSliderResultAirflowAirDensityAll
                                                  .toStringAsFixed(1)) >
                                              Decimal.parse(
                                                  vMinSliderConvertAirflowAirDensityAllStepper
                                                      .toStringAsFixed(1))) {
                                            convertSliderResultAirflowAirDensityAll =
                                                convertSliderResultAirflowAirDensityAll -
                                                    stepSliderConvertAirflowAirDensityAll;
                                            calcAirflowCfm(
                                                convertSliderResultAirflowAirDensityAll,
                                                convertSliderResultAirflowAirDensityAll,
                                                vAirflowManifoldTemp,
                                                vAirflowPsiAmbient,
                                                vAirflowPsiG,
                                                radioValue);
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
                                            convertSliderResultAirflowAirDensityAll
                                                .toStringAsFixed(1)) >
                                            Decimal.parse(
                                                vMinSliderConvertAirflowAirDensityAllStepper
                                                    .toStringAsFixed(1))) {
                                          convertSliderResultAirflowAirDensityAll =
                                              convertSliderResultAirflowAirDensityAll -
                                                  stepSliderConvertAirflowAirDensityAll;
                                          calcAirflowCfm(
                                              convertSliderResultAirflowAirDensityAll,
                                              convertSliderResultAirflowAirDensityAll,
                                              vAirflowManifoldTemp,
                                              vAirflowPsiAmbient,
                                              vAirflowPsiG,
                                              radioValue);
                                        }
                                      });
                                    }),
                              ),
                              Container(
                                width: kInputNumberBigWidth,
                                child: Text(
                                    convertSliderResultAirflowAirDensityAll
                                        .toStringAsFixed(
                                        vAirflowResultDecimals),
                                    style: kResultNumberStyleWhite18_600,
                                    textScaleFactor: textScaleFactorTc),
                              ),
                              Container(
                                width: kInputUnitWidth + 20,
                                child: Text(
                                    unitSliderConvertAirflowAirDensityAll,
                                    style: kUnitTextStyleAirflow,
                                    textScaleFactor: textScaleFactorTc),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 0),
                                child: StepButton(
                                    icon: FontAwesomeIcons.plus,
                                    onStepPress: () {
                                      timer = Timer.periodic(
                                          Duration(milliseconds: tapTime), (t) {
                                        setState(() {
                                          if ((Decimal.parse(
                                              convertSliderResultAirflowAirDensityAll
                                                  .toStringAsFixed(1)) <
                                              (Decimal.parse(
                                                  vMaxSliderConvertAirflowAirDensityAllStepper
                                                      .toStringAsFixed(1))))) {
                                            convertSliderResultAirflowAirDensityAll =
                                                convertSliderResultAirflowAirDensityAll +
                                                    stepSliderConvertAirflowAirDensityAll;
                                            calcAirflowCfm(
                                                convertSliderResultAirflowAirDensityAll,
                                                convertSliderResultAirflowAirDensityAll,
                                                vAirflowManifoldTemp,
                                                vAirflowPsiAmbient,
                                                vAirflowPsiG,
                                                radioValue);
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
                                            convertSliderResultAirflowAirDensityAll
                                                .toStringAsFixed(1)) <
                                            (Decimal.parse(
                                                vMaxSliderConvertAirflowAirDensityAllStepper
                                                    .toStringAsFixed(1))))) {
                                          convertSliderResultAirflowAirDensityAll =
                                              convertSliderResultAirflowAirDensityAll +
                                                  stepSliderConvertAirflowAirDensityAll;
                                          calcAirflowCfm(
                                              convertSliderResultAirflowAirDensityAll,
                                              convertSliderResultAirflowAirDensityAll,
                                              vAirflowManifoldTemp,
                                              vAirflowPsiAmbient,
                                              vAirflowPsiG,
                                              radioValue);
                                        }
                                      });
                                    }),
                              ),
                            ],
                          ),
                          Divider(),
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
                                  Text('lbs/min',
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
                                  Text('CFM',
                                      textScaleFactor: textScaleFactorTc),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.white70,
                          ),
                          Column(
                            children: <Widget>[
                              // Text('Anders'),
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
                                    Text(AppLocalizations.of(context).translate(
                                        'airflow_conv_gaslaw_0040')
                                      //'Manifold Temperature and Pressure',
                                      , style: kLabelTextStyle,
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
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'airflow_conv_gaslaw_0050')
                                                    //'ManiFold Temperature',
                                                    , style: kLabelTextStyle,
                                                    textAlign: TextAlign.left,
                                                    textScaleFactor:
                                                    textScaleFactorTc,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width: kInputNumberWidth,
                                                      // color: Colors.blue,
                                                      child: Text(
                                                        vAirflowManifoldTemp
                                                            .toStringAsFixed(0),
                                                        style:
                                                        kResultNumberStyleWhite18_600,
                                                        textScaleFactor:
                                                        textScaleFactorTc,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: kInputUnitWidth,
                                                      // color: Colors.orange,
                                                      child: Text(
                                                        unitFahrenheit,
                                                        textAlign:
                                                        TextAlign.center,
                                                        style:
                                                        kUnitTextStyleAirflow,
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
                                                        icon: FontAwesomeIcons
                                                            .minus,
                                                        onStepPress: () {
                                                          timer =
                                                              Timer.periodic(
                                                                  Duration(
                                                                      milliseconds:
                                                                      tapTime),
                                                                      (t) {
                                                                    setState(() {
                                                                      if ((Decimal
                                                                          .parse(
                                                                          vAirflowManifoldTemp
                                                                              .toString()) >
                                                                          (Decimal
                                                                              .parse(
                                                                              kMinAirflowManifoldTemp
                                                                                  .toString())))) {
                                                                        vAirflowManifoldTemp =
                                                                            vAirflowManifoldTemp -
                                                                                stepAirflowManifoldTemp;

                                                                        calcAirflowCfm(
                                                                            vAirflowCfm,
                                                                            vAirflowPoundMinute,
                                                                            vAirflowManifoldTemp,
                                                                            vAirflowPsiAmbient,
                                                                            vAirflowPsiG,
                                                                            radioValue);
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
                                                                    .toString()) >
                                                                (Decimal.parse(
                                                                    kMinAirflowManifoldTemp
                                                                        .toString())))) {
                                                              vAirflowManifoldTemp =
                                                                  vAirflowManifoldTemp -
                                                                      stepAirflowManifoldTemp;

                                                              calcAirflowCfm(
                                                                  vAirflowCfm,
                                                                  vAirflowPoundMinute,
                                                                  vAirflowManifoldTemp,
                                                                  vAirflowPsiAmbient,
                                                                  vAirflowPsiG,
                                                                  radioValue);
//
                                                            }
                                                          });
                                                        },
                                                      ),
                                                      StepButtonClose(
                                                        icon: FontAwesomeIcons
                                                            .plus,
                                                        onStepPress: () {
                                                          timer =
                                                              Timer.periodic(
                                                                  Duration(
                                                                      milliseconds:
                                                                      tapTime),
                                                                      (t) {
                                                                    setState(() {
                                                                      if ((Decimal
                                                                          .parse(
                                                                          vAirflowManifoldTemp
                                                                              .toString()) <
                                                                          (Decimal
                                                                              .parse(
                                                                              kMaxAirflowManifoldTemp
                                                                                  .toString())))) {
                                                                        vAirflowManifoldTemp =
                                                                            vAirflowManifoldTemp +
                                                                                stepAirflowManifoldTemp;

                                                                        calcAirflowCfm(
                                                                            vAirflowCfm,
                                                                            vAirflowPoundMinute,
                                                                            vAirflowManifoldTemp,
                                                                            vAirflowPsiAmbient,
                                                                            vAirflowPsiG,
                                                                            radioValue);
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

                                                              calcAirflowCfm(
                                                                  vAirflowCfm,
                                                                  vAirflowPoundMinute,
                                                                  vAirflowManifoldTemp,
                                                                  vAirflowPsiAmbient,
                                                                  vAirflowPsiG,
                                                                  radioValue);
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
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'airflow_conv_gaslaw_0060')
                                                    //'Required Absolute Manifold Pressure',
                                                    , style: kLabelTextStyle,
                                                    textAlign: TextAlign.left,
                                                    textScaleFactor:
                                                    textScaleFactorTc,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width: kInputNumberWidth,
                                                      // color: Colors.blue,
                                                      child: Text(
                                                        vAirflowPsiTotal
                                                            .toStringAsFixed(2),
                                                        style:
                                                        kResultNumberStyleWhite18_600,
                                                        textScaleFactor:
                                                        textScaleFactorTc,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: kInputUnitWidth,
                                                      // color: Colors.orange,
                                                      child: Text(
                                                        unitPressurePsi,
                                                        textAlign:
                                                        TextAlign.center,
                                                        style:
                                                        kUnitTextStyleAirflow,
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
                                                  width: kInputTextWidth,
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'airflow_conv_gaslaw_0070')
                                                    //'Req. Gauge Manifold Pressure',
                                                    , style: kLabelTextStyle,
                                                    textAlign: TextAlign.left,
                                                    textScaleFactor:
                                                    textScaleFactorTc *
                                                        0.85,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width: kInputNumberWidth,
                                                      // color: Colors.blue,
                                                      child: Text(
                                                        vAirflowPsiG
                                                            .toStringAsFixed(2),
                                                        style:
                                                        kResultNumberStyleWhite18_600,
                                                        textScaleFactor:
                                                        textScaleFactorTc,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: kInputUnitWidth,
                                                      // color: Colors.orange,
                                                      child: Text(
                                                        unitPressurePsi,
                                                        textAlign:
                                                        TextAlign.center,
                                                        style:
                                                        kUnitTextStyleAirflow,
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
                                                        icon: FontAwesomeIcons
                                                            .minus,
                                                        onStepPress: () {
                                                          timer =
                                                              Timer.periodic(
                                                                  Duration(
                                                                      milliseconds:
                                                                      tapTime),
                                                                      (t) {
                                                                    setState(() {
                                                                      if ((Decimal
                                                                          .parse(
                                                                          vAirflowPsiG
                                                                              .toString()) >
                                                                          (Decimal
                                                                              .parse(
                                                                              kMinAirflowPsiG
                                                                                  .toString())))) {
                                                                        vAirflowPsiG =
                                                                            vAirflowPsiG -
                                                                                stepAirflowPsiG;

                                                                        if (vAirflowPsiG <
                                                                            0) {
                                                                          vAirflowPsiG =
                                                                          0.0;
                                                                        }

                                                                        calcAirflowCfm(
                                                                            vAirflowCfm,
                                                                            vAirflowPoundMinute,
                                                                            vAirflowManifoldTemp,
                                                                            vAirflowPsiAmbient,
                                                                            vAirflowPsiG,
                                                                            radioValue);
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

                                                              if (vAirflowPsiG <
                                                                  0) {
                                                                vAirflowPsiG =
                                                                0.0;
                                                              }

                                                              calcAirflowCfm(
                                                                  vAirflowCfm,
                                                                  vAirflowPoundMinute,
                                                                  vAirflowManifoldTemp,
                                                                  vAirflowPsiAmbient,
                                                                  vAirflowPsiG,
                                                                  radioValue);
                                                            }
                                                          });
                                                        },
                                                      ),
                                                      StepButtonClose(
                                                        icon: FontAwesomeIcons
                                                            .plus,
                                                        onStepPress: () {
                                                          timer =
                                                              Timer.periodic(
                                                                  Duration(
                                                                      milliseconds:
                                                                      tapTime),
                                                                      (t) {
                                                                    setState(() {
                                                                      if ((Decimal
                                                                          .parse(
                                                                          vAirflowPsiG
                                                                              .toString()) <
                                                                          (Decimal
                                                                              .parse(
                                                                              kMaxAirflowPsiG
                                                                                  .toString())))) {
                                                                        vAirflowPsiG =
                                                                            vAirflowPsiG +
                                                                                stepAirflowPsiG;

                                                                        if (vAirflowPsiG <
                                                                            0) {
                                                                          vAirflowPsiG =
                                                                          0.0;
                                                                        }

                                                                        calcAirflowCfm(
                                                                            vAirflowCfm,
                                                                            vAirflowPoundMinute,
                                                                            vAirflowManifoldTemp,
                                                                            vAirflowPsiAmbient,
                                                                            vAirflowPsiG,
                                                                            radioValue);
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

                                                              if (vAirflowPsiG <
                                                                  0) {
                                                                vAirflowPsiG =
                                                                0.0;
                                                              }

                                                              calcAirflowCfm(
                                                                  vAirflowCfm,
                                                                  vAirflowPoundMinute,
                                                                  vAirflowManifoldTemp,
                                                                  vAirflowPsiAmbient,
                                                                  vAirflowPsiG,
                                                                  radioValue);
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
                                                  width: kInputTextWidth,
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                        'airflow_conv_gaslaw_0080')
                                                    //'Operating Barometric Pressure',
                                                    , style: kLabelTextStyle,
                                                    textAlign: TextAlign.left,
                                                    textScaleFactor:
                                                    textScaleFactorTc *
                                                        0.85,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width: kInputNumberWidth,
                                                      // color: Colors.blue,
                                                      child: Text(
                                                        vAirflowPsiAmbient
                                                            .toStringAsFixed(2),
                                                        style:
                                                        kResultNumberStyleWhite18_600,
                                                        textScaleFactor:
                                                        textScaleFactorTc,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: kInputUnitWidth,
                                                      // color: Colors.orange,
                                                      child: Text(
                                                        unitPressurePsi,
                                                        textAlign:
                                                        TextAlign.center,
                                                        style:
                                                        kUnitTextStyleAirflow,
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
                                                        icon: FontAwesomeIcons
                                                            .minus,
                                                        onStepPress: () {
                                                          timer =
                                                              Timer.periodic(
                                                                  Duration(
                                                                      milliseconds:
                                                                      tapTime),
                                                                      (t) {
                                                                    setState(() {
                                                                      if ((Decimal
                                                                          .parse(
                                                                          vAirflowPsiAmbient
                                                                              .toString()) >
                                                                          (Decimal
                                                                              .parse(
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

                                                                        calcAirflowCfm(
                                                                            vAirflowCfm,
                                                                            vAirflowPoundMinute,
                                                                            vAirflowManifoldTemp,
                                                                            vAirflowPsiAmbient,
                                                                            vAirflowPsiG,
                                                                            radioValue);
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

                                                              calcAirflowCfm(
                                                                  vAirflowCfm,
                                                                  vAirflowPoundMinute,
                                                                  vAirflowManifoldTemp,
                                                                  vAirflowPsiAmbient,
                                                                  vAirflowPsiG,
                                                                  radioValue);
                                                            }
                                                          });
                                                        },
                                                      ),
                                                      StepButtonClose(
                                                        icon: FontAwesomeIcons
                                                            .plus,
                                                        onStepPress: () {
                                                          timer =
                                                              Timer.periodic(
                                                                  Duration(
                                                                      milliseconds:
                                                                      tapTime),
                                                                      (t) {
                                                                    setState(() {
                                                                      if ((Decimal
                                                                          .parse(
                                                                          vAirflowPsiAmbient
                                                                              .toString()) <
                                                                          (Decimal
                                                                              .parse(
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

                                                                        calcAirflowCfm(
                                                                            vAirflowCfm,
                                                                            vAirflowPoundMinute,
                                                                            vAirflowManifoldTemp,
                                                                            vAirflowPsiAmbient,
                                                                            vAirflowPsiG,
                                                                            radioValue);
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

                                                              calcAirflowCfm(
                                                                  vAirflowCfm,
                                                                  vAirflowPoundMinute,
                                                                  vAirflowManifoldTemp,
                                                                  vAirflowPsiAmbient,
                                                                  vAirflowPsiG,
                                                                  radioValue);
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ), //PSI slider
                    // Divider(),
                  ],
                ),
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
                Container(
                alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context).translate(
                        'airflow_conv_gaslaw_0090') //'Fixed values:',
                    , style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.white70),
                    textScaleFactor: textScaleFactorTc * 0.9,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context).translate(
                      'airflow_conv_gaslaw_0100')
                    //'- Gas Flow Constant = 1545/28.964 = 53.34',
                    , style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.white70),
                    textScaleFactor: textScaleFactorTc * 0.8,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context).translate(
                      'airflow_conv_gaslaw_0110')
                    //'- Compressability factor = 1.0',
                    , style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.white70),
                    textScaleFactor: textScaleFactorTc * 0.8,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context).translate(
                      'airflow_conv_gaslaw_0120')
                      //'Let us know if you  need to change the "compressibility factor" and the "gas flow constant", via the "feedback form" on the "Info tab". These values are rarely changed',
                    ,  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.white70),
                  textScaleFactor: textScaleFactorTc * 0.8,
                ),
              ),
            ],
          ),
        ),

        // Speed

        // Kilometer
        // Mile

        //Fuel (Hp)
        ]
        ,
        )
        ,
        );
      }),
    );
  }

  int radioValue = 0;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      //resetValues();

      switch (radioValue) {
        case 0:
          labelTextStyleResult0 = kLabelTextStyleInActive;
          labelTextStyleResultTitle0 = kSecondSubjectTextStyleInActive;
          labelTextStyleResultUnit0 = kUnitTextStyleAirflowInActive;

          labelTextStyleResult1 = kLabelTextStyleActive;
          labelTextStyleResultTitle1 = kSecondSubjectTextStyleActive;
          labelTextStyleResultUnit1 = kUnitTextStyleAirflowActive;

          vAirflowResultDecimals = 2;

          convertSliderHeaderAirflowAirDensityTextAll =
          'Pound per Minute - lbs/min';
          unitSliderConvertAirflowAirDensityAll = 'lbs/min';

          convertSliderResultAirflowAirDensityAll = vAirflowPoundMinute;
          kMinSliderConvertAirflowAirDensityAll =
              kMinConvertAirflowAirDensityPoundPerMinute;
          kMaxSliderConvertAirflowAirDensityAll =
              kMaxConvertAirflowAirDensityPoundPerMinute;
          vMinSliderConvertAirflowAirDensityAllStepper =
              vMinConvertAirflowAirDensityPoundPerMinute;
          vMaxSliderConvertAirflowAirDensityAllStepper =
              vMaxConvertAirflowAirDensityPoundPerMinute;

          sliderSliderConvertAirflowAirDensityAll =
              sliderConvertAirflowAirDensityPoundPerMinute;
          stepSliderConvertAirflowAirDensityAll =
              stepConvertAirflowAirDensityPoundPerMinute;

          calcAirflowCfm(vAirflowCfm, vAirflowPoundMinute, vAirflowManifoldTemp,
              vAirflowPsiAmbient, vAirflowPsiG, radioValue);

          convertResultAirflowAirDensityCubicMeterPerMinute =
              convertResultAirflowAirDensityCfm *
                  kAirflowDensityCfmToCubicMeterPerMinute;
          convertResultAirflowAirDensityCubicMeterPerSecond =
              convertResultAirflowAirDensityCfm *
                  kAirflowDensityCfmToCubicMeterPerSecond;

          break;

        case 1:
          labelTextStyleResult0 = kLabelTextStyleActive;
          labelTextStyleResultTitle0 = kSecondSubjectTextStyleActive;
          labelTextStyleResultUnit0 = kUnitTextStyleAirflowActive;

          labelTextStyleResult1 = kLabelTextStyleInActive;
          labelTextStyleResultTitle1 = kSecondSubjectTextStyleInActive;
          labelTextStyleResultUnit1 = kUnitTextStyleAirflowInActive;

          vAirflowResultDecimals = 1;

          convertSliderHeaderAirflowAirDensityTextAll =
          'Cubic Feet per Inch - CFM';
          unitSliderConvertAirflowAirDensityAll = 'cfm';

          vAirflowPoundMinute = convertSliderResultAirflowAirDensityAll;
          convertSliderResultAirflowAirDensityAll = vAirflowCfm;

          vMinSliderConvertAirflowAirDensityAllStepper =
              vMinConvertAirflowAirDensityCfm;
          vMaxSliderConvertAirflowAirDensityAllStepper =
              vMaxConvertAirflowAirDensityCfm;
          kMinSliderConvertAirflowAirDensityAll =
              kMinConvertAirflowAirDensityCfm;
          kMaxSliderConvertAirflowAirDensityAll =
              kMaxConvertAirflowAirDensityCfm;

          vAirflowPoundMinute = convertSliderResultAirflowAirDensityAll;
          convertSliderResultAirflowAirDensityAll = vAirflowCfm;

          sliderSliderConvertAirflowAirDensityAll =
              sliderConvertAirflowAirDensityCfm;
          stepSliderConvertAirflowAirDensityAll =
              stepConvertAirflowAirDensityCfm;

          calcAirflowCfm(vAirflowCfm, vAirflowPoundMinute, vAirflowManifoldTemp,
              vAirflowPsiAmbient, vAirflowPsiG, radioValue);

          convertResultAirflowAirDensityCubicMeterPerMinute =
              convertResultAirflowAirDensityCfm *
                  kAirflowDensityCfmToCubicMeterPerMinute;
          convertResultAirflowAirDensityCubicMeterPerSecond =
              convertResultAirflowAirDensityCfm *
                  kAirflowDensityCfmToCubicMeterPerSecond;

          break;
      }
      print('radioValue $radioValue');
    });
  }

  void calcAirflowCfm(double vAirflowCfmIn,
      double vAirflowPoundMinuteIn,
      double vAirflowManifoldTemp,
      double vAirflowPsiAmbient,
      double vAirflowPsiG,
      int radioValue) {
    setState(() {
      switch (radioValue) {
        case 0:
          var vTempAirflowPoundMinute = vAirflowPoundMinuteIn;

          vAirflowPoundMinute = vAirflowPoundMinuteIn;

          vAirflowCfm = calculate.calcCubicFeetPerMinuteExact(
              vTempAirflowPoundMinute,
              vAirflowManifoldTemp,
              vAirflowPsiAmbient,
              vAirflowPsiG);

          vAirflowCubicMeterPerSecond =
              vAirflowCfm * kCubicFeetPerMinuteToCubicMeterPerSecond;
          vAirflowCubicMeterPerMinute = vAirflowCubicMeterPerSecond * 60;

          vAirflowPsiTotal = vAirflowPsiAmbient + vAirflowPsiG;
          pressureRatio =
              (vAirflowPsiAmbient + vAirflowPsiG) / vAirflowPsiAmbient;
          break;

        case 1:
          var vTempAirflowCfm = vAirflowCfmIn;
          vAirflowCfm = vAirflowCfmIn;

          vAirflowCubicMeterPerSecond =
              vAirflowCfm * kCubicFeetPerMinuteToCubicMeterPerSecond;
          vAirflowCubicMeterPerMinute = vAirflowCubicMeterPerSecond * 60;

          vAirflowPoundMinute = calculate.calcCubicPoundMinute(vTempAirflowCfm,
              vAirflowManifoldTemp, vAirflowPsiAmbient, vAirflowPsiG);

          vAirflowPsiTotal = vAirflowPsiAmbient + vAirflowPsiG;
          pressureRatio =
              (vAirflowPsiAmbient + vAirflowPsiG) / vAirflowPsiAmbient;
          break;
      }
    });
  }

  void resetValues() {
    setState(() {
      vAirflowCfm = 669.9;
      vAirflowPoundMinute = 52.33;
      vAirflowManifoldTemp = 68;
      vAirflowPsiAmbient = 14.70;
      vAirflowPsiG = 0.0;
      radioValue = 0;

      labelTextStyleResult0 = kLabelTextStyleInActive;
      labelTextStyleResultTitle0 = kSecondSubjectTextStyleInActive;
      labelTextStyleResultUnit0 = kUnitTextStyleAirflowInActive;

      labelTextStyleResult1 = kLabelTextStyleActive;
      labelTextStyleResultTitle1 = kSecondSubjectTextStyleActive;
      labelTextStyleResultUnit1 = kUnitTextStyleAirflowActive;

      //radioValue = 0;
      kMinSliderConvertAirflowAirDensityAll =
          kMinConvertAirflowAirDensityPoundPerMinute;
      kMaxSliderConvertAirflowAirDensityAll =
          kMaxConvertAirflowAirDensityPoundPerMinute;
      stepSliderConvertAirflowAirDensityAll =
          stepConvertAirflowAirDensityPoundPerMinute;
      sliderSliderConvertAirflowAirDensityAll =
          sliderConvertAirflowAirDensityPoundPerMinute;
      convertResultAirflowAirDensityCfm = kResetValueAirFlowAirDensityCFM;
      convertResultAirflowAirDensityPoundPerMinute =
          kResetValueAirflowAirDensityPoundPerMinute;

      convertResultAirflowAirDensityCubicMeterPerMinute =
          kResetValueCubicCentiMeter;
      convertResultAirflowAirDensityCubicMeterPerSecond = kResetValueCubicInch;
      convertSliderResultAirflowAirDensityAll =
          kResetValueAirflowAirDensityPoundPerMinute;

      vMinSliderConvertAirflowAirDensityAllStepper =
          vMinConvertAirflowAirDensityPoundPerMinute;
      vMaxSliderConvertAirflowAirDensityAllStepper =
          vMaxConvertAirflowAirDensityPoundPerMinute;
      vAirflowResultDecimals = 2;

      convertResultAirflowAirDensityCubicMeterPerMinute =
          convertResultAirflowAirDensityCfm *
              kAirflowDensityCfmToCubicMeterPerMinute;
      convertResultAirflowAirDensityCubicMeterPerSecond =
          convertResultAirflowAirDensityCfm *
              kAirflowDensityCfmToCubicMeterPerSecond;

      calcAirflowCfm(vAirflowCfm, vAirflowPoundMinute, vAirflowManifoldTemp,
          vAirflowPsiAmbient, vAirflowPsiG, radioValue);
    });
  }
}
