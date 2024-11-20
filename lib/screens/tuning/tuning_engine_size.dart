import 'dart:async';
import 'dart:io';

import 'package:tct/components/analytics_event.dart';
import 'package:tct/data_models/analytics_event_type.dart';
import 'package:tct/components/stepbutton_close.dart';
import 'package:tct/globals/app_localizations.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../globals/calculator_brain.dart';
import '../../components/reusable_card.dart';
import '../../globals/constant.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:tct/globals/constants_ui.dart';

class EngineSizePage extends StatefulWidget {
  bool metricUnit;

  EngineSizePage({required Key key, required this.metricUnit})
      : super(key: key);

  @override
  _EngineSizePageState createState() => _EngineSizePageState(metricUnit);
}

class _EngineSizePageState extends State<EngineSizePage> {
  bool metricUnit;

  _EngineSizePageState(this.metricUnit);

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
            var _analyticsParameter = {'Snackbar': 'EngineSize'};
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
            'Calculate Engine Size (Engine Displacement) by input Stroke, Bore, and the number of cylinders.\n\nYou can locally change the unit-setting for this calculation by the switch (inch and mm). All results may be affected by small rounding errors.',
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

  void _onChangedUnitSwitch(bool value) {
    setState(() {
      resetAll(metricUnit);
      metricUnit = value;

      if (metricUnit) {
        vMinStrokeInput = vMinStrokeInputMillimeter + 25.4;
        vMaxStrokeInput = vMaxStrokeInputMillimeter;
        vMinBoreInput = vMinBoreInputMillimeter + 25.4;
        vMaxBoreInput = vMaxBoreInputMillimeter;

//        boreInput = boreInputMillimeter;
        boreInput = boreInputInch * kConvertLengthInchToMillimeter;
        boreInputMillimeter = boreInput;
        boreInputDisplay = boreInputMillimeter.toStringAsFixed(3);
//        strokeInput=strokeInputMillimeter;
        strokeInput = strokeInputInch * kConvertLengthInchToMillimeter;
        strokeInputMillimeter = strokeInput;
        boreInputDisplay = boreInputMillimeter.toStringAsFixed(3);
        strokeInputDisplay = strokeInputMillimeter.toStringAsFixed(3);

        // parameters
        var _analyticsParameter = {'Unit_EngineSize': 'EngineSize-Millimeter'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.unit_type, _analyticsParameter);
      } else {
        vMinStrokeInput = vMinStrokeInputInch + 1.0;
        vMaxStrokeInput = vMaxStrokeInputInch;
        vMinBoreInput = vMinBoreInputInch + 1.0;
        vMaxBoreInput = vMaxBoreInputInch;
        boreInput = boreInputMillimeter * kConvertLengthMillimeterToInch;
        boreInputInch = boreInput;
        strokeInput = strokeInputMillimeter * kConvertLengthMillimeterToInch;
        strokeInputInch = strokeInput;
        boreInputDisplay = boreInputInch.toStringAsFixed(3);
        strokeInputDisplay = strokeInputInch.toStringAsFixed(3);

        // parameters
        var _analyticsParameter = {'Unit_EngineSize': 'EngineSize-Inch'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.unit_type, _analyticsParameter);
      }
      resetAll(metricUnit);
    });
  }

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      print('iOS');
      vEngineSizeSwitchActiveColor = kEngineSizeInchSwitchActiveColorIos;
      vEngineSizeSwitchInActiveThumbColor =
          kEngineSizeInchSwitchInActiveThumbColorIos;
      vEngineSizeSwitchActiveTrackColor =
          kEngineSizeInchSwitchActiveTrackColorIos;
      vEngineSizeSwitchInActiveTrackColor =
          kEngineSizeInchSwitchInActiveTrackColorIos;
    } else {
      print('Android');
      vEngineSizeSwitchActiveColor = kEngineSizeInchSwitchActiveColorAndroid;
      vEngineSizeSwitchInActiveThumbColor =
          kEngineSizeInchSwitchInActiveColorAndroid;
      vEngineSizeSwitchActiveTrackColor =
          kEngineSizeInchSwitchInActiveColorAndroid;
      vEngineSizeSwitchInActiveTrackColor =
          kEngineSizeInchSwitchInActiveTrackColorAndroid;
    }

    print('Init metricUnit: $metricUnit');
    resetAll(metricUnit);
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
                    .translate('tuning_engine_size_0000') //'ENGINE SIZE',
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
                onPress: () {},
                colour: kActiveCardColourOutput,
                cardChild: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                              AppLocalizations.of(context)
                                  .translate('tuning_engine_size_0010')
                              //'Engine Displacement',
                              ,
                              style: kSecondSubjectTextStyle,
                              textScaleFactor: textScaleFactorTc),
                          SizedBox(height: 10),
                          Center(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  dividerColor: kActiveCardColourOutput),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DataTable(
                                    horizontalMargin: 0,
                                    headingRowHeight: 0,
                                    columnSpacing: 30,
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
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'tuning_engine_size_0020')
                                          //'Cubic Inch',
                                          ,
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            resultEngineCid.toStringAsFixed(3),
                                            style:
                                                kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitVolumeCubicInch,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'tuning_engine_size_0030')
                                          //'Liter/Litre',
                                          ,
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            resultEngineLiter
                                                .toStringAsFixed(3),
                                            style:
                                                kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitVolumeLiter,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'tuning_engine_size_0040')
                                          // 'Cubic Centimeter',
                                          ,
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            resultEngineCubicCentimeter
                                                .toStringAsFixed(0),
                                            style:
                                                kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitVolumeCubicCentimeter,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                    ]),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.white70,
                          ),
                          Column(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('tuning_engine_size_0050')
                                //'Bore and Stroke Ratio',
                                ,
                                style: kSecondSubjectTextStyle,
                                textScaleFactor: textScaleFactorTc,
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: kActiveCardColourOutput),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DataTable(
                                        horizontalMargin: 0,
                                        headingRowHeight: 0,
                                        columnSpacing: 30,
                                        dataRowHeight: tableRowHeight,
                                        columns: [
                                          DataColumn(
                                              label: Text(
                                            '',
                                            style:
                                                TextStyle(color: Colors.white),
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
                                            DataCell(Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      'tuning_engine_size_0060')
                                              // 'Bore/Stroke',
                                              ,
                                              style: kLabelTextStyleLarge,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            )),
                                            DataCell(
                                              Row(
                                                children: <Widget>[
                                                  Container(
//                                                        alignment: Alignment.centerLeft,
                                                    // color: Colors.blue,
                                                    child: Text(
                                                        boreStrokeRatioDisplay,
                                                        style:
                                                            kResultNumberStyleWhite18_600,
                                                        textScaleFactor:
                                                            textScaleFactorTc),
                                                  ),
                                                  Container(
//                                                        alignment: Alignment.centerLeft,
                                                    // color: Colors.green,
                                                    child: Text(':1',
                                                        style:
                                                            kResultNumberStyleWhite18_600,
                                                        textScaleFactor:
                                                            textScaleFactorTc),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        'tuning_engine_size_0070')
                                                // 'B/S',
                                                ,
                                                style: kLabelTextStyle,
                                                textScaleFactor:
                                                    textScaleFactorTc,
                                              ),
                                            ),
                                          ]),
                                        ]),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    boreStrokeRatioSquareDisplay,
                                    style: kUnitTextStyleAirflow,
                                    textScaleFactor: textScaleFactorTc,
                                  ),
                                ],
                              ),
                            ],
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
                                      'tuning_engine_size_0080') //'Bore',
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
                                  value: boreInput,
                                  min: vMinBoreInput,
                                  max: vMaxBoreInput,
                                  label: boreInput.toStringAsFixed(1),
                                  inactiveColor: Color(0xFF8D8E89),
                                  divisions: sliderSliderConvertVolumeAll,
                                  onChanged: (double sliderValue) {
                                    boreInput = sliderValue;
                                    debugPrint('SLIDE boreInput $boreInput');

                                    calcEngineSize(boreInput, strokeInput,
                                        cylinderInput, metricUnit);
                                  }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,

                                  width: kInputNumberWidth + 30,
                                  // color: Colors.blue,
                                  child: Text(boreInputDisplay,
                                      style: kResultNumberStyleWhite18_600,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                                Container(
                                  alignment: Alignment.center,

                                  width: kInputUnitWidth,
                                  // color: Colors.orange,
                                  child: Text(unitEngineSizeBoreInput,
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

                                            if ((Decimal.parse(boreInput
                                                    .toStringAsFixed(0)) >
                                                (Decimal.parse((vMinBoreInput)
                                                    .toStringAsFixed(0))))) {
                                              boreInput =
                                                  boreInput - stepBoreInput;

                                              calcEngineSize(
                                                  boreInput,
                                                  strokeInput,
                                                  cylinderInput,
                                                  metricUnit);
                                            }
                                          });
                                        });
                                      },
                                      onPressEnd: () {
                                        timer.cancel();
                                      },
                                      onStep: () {
                                        setState(() {
                                          if ((Decimal.parse(boreInput
                                                  .toStringAsFixed(0)) >
                                              (Decimal.parse((vMinBoreInput)
                                                  .toStringAsFixed(0))))) {
                                            boreInput =
                                                boreInput - stepBoreInput;

                                            calcEngineSize(
                                                boreInput,
                                                strokeInput,
                                                cylinderInput,
                                                metricUnit);
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
                                            print('boreInput $boreInput');
                                            print(
                                                'kMaxBoreInput $vMaxBoreInput');
                                            if ((Decimal.parse(boreInput
                                                    .toStringAsFixed(3)) <
                                                (Decimal.parse((vMaxBoreInput)
                                                    .toStringAsFixed(3))))) {
                                              boreInput =
                                                  boreInput + stepBoreInput;

                                              calcEngineSize(
                                                  boreInput,
                                                  strokeInput,
                                                  cylinderInput,
                                                  metricUnit);
                                            }
                                          });
                                        });
                                      },
                                      onPressEnd: () {
                                        timer.cancel();
                                      },
                                      onStep: () {
                                        setState(() {
                                          if ((Decimal.parse(boreInput
                                                  .toStringAsFixed(3)) <
                                              (Decimal.parse((vMaxBoreInput)
                                                  .toStringAsFixed(3))))) {
                                            boreInput =
                                                boreInput + stepBoreInput;

                                            calcEngineSize(
                                                boreInput,
                                                strokeInput,
                                                cylinderInput,
                                                metricUnit);
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
                                          'tuning_engine_size_0090') //'Stroke',
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
                                      value: strokeInput,
                                      min: vMinStrokeInput,
                                      max: vMaxStrokeInput,
                                      label: strokeInput.toStringAsFixed(1),
                                      inactiveColor: Color(0xFF8D8E89),
                                      divisions: sliderSliderConvertVolumeAll,
                                      onChanged: (double sliderValue) {
                                        strokeInput = sliderValue;
                                        debugPrint(
                                            'SLIDE strokeInputSlide $strokeInput');

                                        calcEngineSize(boreInput, strokeInput,
                                            cylinderInput, metricUnit);
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
                                      child: Text(strokeInputDisplay,
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc),
                                    ),
                                    Container(
                                      alignment: Alignment.center,

                                      width: kInputUnitWidth,
                                      // color: Colors.orange,
                                      child: Text(unitEngineSizeStrokeInput,
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
                                                            strokeInput
                                                                .toStringAsFixed(
                                                                    0)) >
                                                        (Decimal.parse(
                                                            vMinStrokeInput
                                                                .toStringAsFixed(
                                                                    0))))) {
                                                      strokeInput =
                                                          strokeInput -
                                                              stepStrokeInput;

                                                      calcEngineSize(
                                                          boreInput,
                                                          strokeInput,
                                                          cylinderInput,
                                                          metricUnit);
                                                    }
                                                  });
                                                });
                                              },
                                              onPressEnd: () {
                                                timer.cancel();
                                              },
                                              onStep: () {
                                                setState(() {
                                                  if ((Decimal.parse(strokeInput
                                                          .toStringAsFixed(0)) >
                                                      (Decimal.parse(
                                                          vMinStrokeInput
                                                              .toStringAsFixed(
                                                                  0))))) {
                                                    strokeInput = strokeInput -
                                                        stepStrokeInput;

                                                    calcEngineSize(
                                                        boreInput,
                                                        strokeInput,
                                                        cylinderInput,
                                                        metricUnit);
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
                                                        'strokeInput $strokeInput');
                                                    print(
                                                        'kMaxStrokeInput $vMaxStrokeInput');
                                                    if ((Decimal.parse(
                                                            strokeInput
                                                                .toStringAsFixed(
                                                                    0)) <
                                                        (Decimal.parse(
                                                            vMaxStrokeInput
                                                                .toStringAsFixed(
                                                                    0))))) {
                                                      strokeInput =
                                                          strokeInput +
                                                              stepStrokeInput;

                                                      calcEngineSize(
                                                          boreInput,
                                                          strokeInput,
                                                          cylinderInput,
                                                          metricUnit);
                                                    }
                                                  });
                                                });
                                              },
                                              onPressEnd: () {
                                                timer.cancel();
                                              },
                                              onStep: () {
                                                setState(() {
                                                  if ((Decimal.parse(strokeInput
                                                          .toStringAsFixed(0)) <
                                                      (Decimal.parse(
                                                          vMaxStrokeInput
                                                              .toStringAsFixed(
                                                                  0))))) {
                                                    strokeInput = strokeInput +
                                                        stepStrokeInput;

                                                    calcEngineSize(
                                                        boreInput,
                                                        strokeInput,
                                                        cylinderInput,
                                                        metricUnit);
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
                                Divider(
                                  color: Colors.white70,
                                ),
                                //Divider(),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('tuning_engine_size_0100')
                                      //'Cylinders',
                                      ,
                                      style: kLabelTextStyleLarge,
                                      textScaleFactor: textScaleFactorTc),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      width: kInputNumberWidth + 30,
                                      child: Text(cylinderInput.toString(),
                                          style: kResultNumberStyleWhite18_600,
                                          textScaleFactor: textScaleFactorTc),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: kInputUnitWidth,
                                      child: Text(unitNrCylinders,
                                          textAlign: TextAlign.center,
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
                                                  Duration(
                                                      milliseconds: tapTime),
                                                  (t) {
                                                print('- press');

                                                if ((Decimal.parse(cylinderInput
                                                        .toString()) >
                                                    (Decimal.parse(
                                                        kMinNrCylinder
                                                            .toString())))) {
                                                  cylinderInput =
                                                      cylinderInput -
                                                          stepNrCylinder;

                                                  calcEngineSize(
                                                      boreInput,
                                                      strokeInput,
                                                      cylinderInput,
                                                      metricUnit);
                                                }
                                              });
                                            });
                                          },
                                          onPressEnd: () {
                                            timer.cancel();
                                          },
                                          onStep: () {
                                            setState(() {
                                              if ((Decimal.parse(cylinderInput
                                                      .toStringAsFixed(3)) >
                                                  (Decimal.parse(kMinNrCylinder
                                                      .toStringAsFixed(3))))) {
                                                cylinderInput = cylinderInput -
                                                    stepNrCylinder;

                                                calcEngineSize(
                                                    boreInput,
                                                    strokeInput,
                                                    cylinderInput,
                                                    metricUnit);
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
                                                      milliseconds: tapTime),
                                                  (t) {
                                                print('+ press');
                                                print(
                                                    'cylinderInput $cylinderInput');
                                                print(
                                                    'kMaxNrCylinder $kMaxNrCylinder');
                                                if ((Decimal.parse(cylinderInput
                                                        .toString()) <
                                                    (Decimal.parse(
                                                        kMaxNrCylinder
                                                            .toString())))) {
                                                  cylinderInput =
                                                      cylinderInput +
                                                          stepNrCylinder;

                                                  calcEngineSize(
                                                      boreInput,
                                                      strokeInput,
                                                      cylinderInput,
                                                      metricUnit);
                                                }
                                              });
                                            });
                                          },
                                          onPressEnd: () {
                                            timer.cancel();
                                          },
                                          onStep: () {
                                            setState(() {
                                              if ((Decimal.parse(cylinderInput
                                                      .toStringAsFixed(3)) <
                                                  (Decimal.parse(kMaxNrCylinder
                                                      .toStringAsFixed(3))))) {
                                                cylinderInput = cylinderInput +
                                                    stepNrCylinder;

                                                calcEngineSize(
                                                    boreInput,
                                                    strokeInput,
                                                    cylinderInput,
                                                    metricUnit);
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
                            Divider(
                              color: Colors.white70,
                            ),
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'tuning_engine_size_0110')
                                          //'Inch',
                                          ,
                                          style: kLabelTextStyle,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                        SizedBox(width: 6),
                                        Container(
                                          child: Switch.adaptive(
                                            value: metricUnit,
                                            activeColor:
                                                vEngineSizeSwitchActiveColor,
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
                                        Text(
                                          'mm',
                                          style: kLabelTextStyle,
                                          textScaleFactor: textScaleFactorTc,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'tuning_engine_size_0120')
                                          //'(Switch will reset the values to default)',
                                          ,
                                          style: kBodyItalicTextStyle,
                                          textScaleFactor:
                                              textScaleFactorTc * 0.8,
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

  calcEngineSize(double boreInput, double strokeInput, int cylinderInput,
      bool metricUnit) {
    // metricUnit = true;
    setState(() {
//      resultEngineDisplacement = calculate.resultEngineDisplacement(
//          boreInput, strokeInput, cylinderInput, metricUnit);
      if (metricUnit) {
        boreInputMillimeter = boreInput;
        strokeInputMillimeter = strokeInput;
        boreStrokeRatio = boreInput / strokeInput;

        if ((Decimal.parse(boreInput.toStringAsFixed(3)) >
            (Decimal.parse((strokeInput).toStringAsFixed(3))))) {
          boreStrokeRatioSquareDisplay = 'Over-Square';
        } else if ((Decimal.parse(boreInput.toStringAsFixed(3)) <
            (Decimal.parse((strokeInput).toStringAsFixed(3))))) {
          boreStrokeRatioSquareDisplay = 'Under-Square';
        } else {
          boreStrokeRatioSquareDisplay = 'Square';
        }

        boreInputInch = boreInputMillimeter * kConvertLengthMillimeterToInch;
        strokeInputInch =
            strokeInputMillimeter * kConvertLengthMillimeterToInch;
        boreInputDisplay = boreInputMillimeter.toStringAsFixed(3);
        strokeInputDisplay = strokeInputMillimeter.toStringAsFixed(3);
        boreStrokeRatioDisplay = boreStrokeRatio.toStringAsFixed(3);

        resultEngineLiter = calculate.calculateEngineLiter(boreInputMillimeter,
            strokeInputMillimeter, cylinderInput, metricUnit);
        resultEngineCubicCentimeter = calculate.calculateEngineCubicCentimeter(
            boreInputMillimeter,
            strokeInputMillimeter,
            cylinderInput,
            metricUnit);
        resultEngineCid = calculate.calculateEngineCubicInch(
            boreInputInch, strokeInputInch, cylinderInput, metricUnit);

        unitEngineSizeBoreInput = unitLengthMillimeter;
        unitEngineSizeStrokeInput = unitLengthMillimeter;
        stepStrokeInput = stepStrokeInputMillimeter;
        stepBoreInput = stepBoreInputMillimeter;

        vMinStrokeInput = vMinStrokeInputMillimeter;
        vMaxStrokeInput = vMaxStrokeInputMillimeter;
        vMinBoreInput = vMinBoreInputMillimeter;
        vMaxBoreInput = vMaxBoreInputMillimeter;
      } else {
        boreInputInch = boreInput;
        strokeInputInch = strokeInput;
        boreStrokeRatio = boreInput / strokeInput;
        if ((Decimal.parse(boreInput.toStringAsFixed(3)) >
            (Decimal.parse((strokeInput).toStringAsFixed(3))))) {
          boreStrokeRatioSquareDisplay = 'Over-Square';
        } else if ((Decimal.parse(boreInput.toStringAsFixed(3)) <
            (Decimal.parse((strokeInput).toStringAsFixed(3))))) {
          boreStrokeRatioSquareDisplay = 'Under-Square';
        } else {
          boreStrokeRatioSquareDisplay = 'Square';
        }

        boreInputMillimeter = boreInputInch * kConvertLengthInchToMillimeter;
        strokeInputMillimeter =
            strokeInputInch * kConvertLengthInchToMillimeter;
        boreInputDisplay = boreInputInch.toStringAsFixed(3);
        strokeInputDisplay = strokeInputInch.toStringAsFixed(3);
        boreStrokeRatioDisplay = boreStrokeRatio.toStringAsFixed(3);

        resultEngineLiter = calculate.calculateEngineLiter(boreInputMillimeter,
            strokeInputMillimeter, cylinderInput, metricUnit);
        resultEngineCubicCentimeter = calculate.calculateEngineCubicCentimeter(
            boreInputMillimeter,
            strokeInputMillimeter,
            cylinderInput,
            metricUnit);
        resultEngineCid = calculate.calculateEngineCubicInch(
            boreInputInch, strokeInputInch, cylinderInput, metricUnit);

        unitEngineSizeBoreInput = unitLengthInch;
        unitEngineSizeStrokeInput = unitLengthInch;
        stepStrokeInput = stepStrokeInputInch;
        stepBoreInput = stepBoreInputInch;

        vMinStrokeInput = vMinStrokeInputInch;
        vMaxStrokeInput = vMaxStrokeInputInch;
        vMinBoreInput = vMinBoreInputInch;
        vMaxBoreInput = vMaxBoreInputInch;
      }
    });
  }

  resetAll(bool metricUnit) {
    setState(() {
      resultEngineCid = 97.6;

//      resultEngineDisplacement = 666.0;
//      resultEngineDisplacement = calculate.resultEngineDisplacement(
//          boreInput, strokeInput, cylinderInput, metricUnit);

      if (metricUnit) {
        strokeInputMillimeter =
            strokeInputInch * kConvertLengthInchToMillimeter;
        boreInputMillimeter = boreInputInch * kConvertLengthInchToMillimeter;

        boreInput = boreInputMillimeter;
        strokeInput = strokeInputMillimeter;

        vMinStrokeInput = vMinStrokeInputMillimeter;
        vMaxStrokeInput = vMaxStrokeInputMillimeter;
        vMinBoreInput = vMinBoreInputMillimeter;
        vMaxBoreInput = vMaxBoreInputMillimeter;
        stepBoreInput = stepBoreInputMillimeter;
        stepStrokeInput = stepStrokeInputMillimeter;

        boreInputMillimeter = boreInput;
        strokeInputMillimeter = strokeInput;
        boreStrokeRatio = boreInput / strokeInput;
        if ((Decimal.parse(boreInput.toStringAsFixed(3)) >
            (Decimal.parse((strokeInput).toStringAsFixed(3))))) {
          boreStrokeRatioSquareDisplay = 'Over-Square';
        } else if ((Decimal.parse(boreInput.toStringAsFixed(3)) <
            (Decimal.parse((strokeInput).toStringAsFixed(3))))) {
          boreStrokeRatioSquareDisplay = 'Under-Square';
        } else {
          boreStrokeRatioSquareDisplay = 'Square';
        }

        boreInputDisplay = boreInputMillimeter.toStringAsFixed(3);
        strokeInputDisplay = strokeInputMillimeter.toStringAsFixed(3);
        boreStrokeRatioDisplay = boreStrokeRatio.toStringAsFixed(3);

        resultEngineLiter = calculate.calculateEngineLiter(boreInputMillimeter,
            strokeInputMillimeter, cylinderInput, metricUnit);
        resultEngineCubicCentimeter = calculate.calculateEngineCubicCentimeter(
            boreInputMillimeter,
            strokeInputMillimeter,
            cylinderInput,
            metricUnit);
        resultEngineCid = calculate.calculateEngineCubicInch(
            boreInputInch, strokeInputInch, cylinderInput, metricUnit);

        unitEngineSizeBoreInput = unitLengthMillimeter;
        unitEngineSizeStrokeInput = unitLengthMillimeter;
        stepStrokeInput = stepStrokeInputMillimeter;
        stepBoreInput = stepBoreInputMillimeter;

        vMinStrokeInput = vMinStrokeInputMillimeter;
        vMaxStrokeInput = vMaxStrokeInputMillimeter;
        vMinBoreInput = vMinBoreInputMillimeter;
        vMaxBoreInput = vMaxBoreInputMillimeter;
      } else {
        strokeInputInch = 4.5;
        boreInputInch = 4.125;

        boreInput = boreInputInch;
        strokeInput = strokeInputInch;
        boreStrokeRatio = boreInput / strokeInput;

        if ((Decimal.parse(boreInput.toStringAsFixed(3)) >
            (Decimal.parse((strokeInput).toStringAsFixed(3))))) {
          boreStrokeRatioSquareDisplay = 'Over-Square';
        } else if ((Decimal.parse(boreInput.toStringAsFixed(3)) <
            (Decimal.parse((strokeInput).toStringAsFixed(3))))) {
          boreStrokeRatioSquareDisplay = 'Under-Square';
        } else {
          boreStrokeRatioSquareDisplay = 'Square';
        }

        vMinStrokeInput = vMinStrokeInputInch;
        vMaxStrokeInput = vMaxStrokeInputInch;
        vMinBoreInput = vMinBoreInputInch;
        vMaxBoreInput = vMaxBoreInputInch;
        stepBoreInput = stepBoreInputInch;
        stepStrokeInput = stepStrokeInputInch;

        boreInputDisplay = boreInputInch.toStringAsFixed(3);
        strokeInputDisplay = strokeInputInch.toStringAsFixed(3);
        boreStrokeRatioDisplay = boreStrokeRatio.toStringAsFixed(3);

        resultEngineLiter = calculate.calculateEngineLiter(boreInputMillimeter,
            strokeInputMillimeter, cylinderInput, metricUnit);
        resultEngineCubicCentimeter = calculate.calculateEngineCubicCentimeter(
            boreInputMillimeter,
            strokeInputMillimeter,
            cylinderInput,
            metricUnit);
        resultEngineCid = calculate.calculateEngineCubicInch(
            boreInputInch, strokeInputInch, cylinderInput, metricUnit);

        unitEngineSizeBoreInput = unitLengthInch;
        unitEngineSizeStrokeInput = unitLengthInch;
        stepStrokeInput = stepStrokeInputInch;
        stepBoreInput = stepBoreInputInch;

        vMinStrokeInput = vMinStrokeInputInch;
        vMaxStrokeInput = vMaxStrokeInputInch;
        vMinBoreInput = vMinBoreInputInch;
        vMaxBoreInput = vMaxBoreInputInch;
      }
    });
  }
}
