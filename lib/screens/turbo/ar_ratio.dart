import 'dart:async';
import 'package:Turbocharger/data_models/analytics_event_type.dart';
import 'package:Turbocharger/components/analytics_event.dart';
import 'package:Turbocharger/components/stepbutton_close.dart';
import 'package:Turbocharger/data_models/MapSave_ArRatio.dart';
import 'package:Turbocharger/globals/app_localizations.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals/calculator_brain.dart';
import '../../components/reusable_card.dart';
import '../../globals/constant.dart';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:Turbocharger/globals/constants_ui.dart';
import 'package:Turbocharger/provider/settings_provider.dart';

class ArRatioPage extends StatefulWidget {
  final bool metricUnit;

  ArRatioPage({Key key, @required this.metricUnit, RouteSettings settings})
      : super(key: key);

  @override
  _ArRatioPageState createState() => _ArRatioPageState(metricUnit);
}

class _ArRatioPageState extends State<ArRatioPage> {
  bool metricUnit;

  String MapArResult_Ratio_Inch;

  _ArRatioPageState(this.metricUnit);

  bool snackbarEnable = true;
  CalculatorBrain calculate = CalculatorBrain();

  // get saveArRatioMap => _ArRatioPageState;

  void _onChangedUnitSwitch(bool value) {
    setState(() {
      // print('Anders');

      metricUnit = value;
      resetValues(metricUnit);

      if (metricUnit) {
        _getMapFromSharedPref();
        // parameters
        var _analyticsParameter = {'Unit_AR': 'AR-Millimeter'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.unit_type, _analyticsParameter);
      } else {
        _getMapFromSharedPref();
        // parameters
        var _analyticsParameter = {'Unit_AR': 'AR-inch'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.unit_type, _analyticsParameter);
      }
      //resetValues(metricUnit);
    });
  }

  Widget get submitRatingButton {
    if (snackbarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            _scaffoldCompressorKey.currentState
                .showSnackBar(snackBarCompressor);

            // parameters
            var _analyticsParameter = {'Snackbar': 'AR-ratio'};
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
            height: 20.0,
          ),
          Text(
            'A/R Ratio calculations',
            textScaleFactor: textScaleFactorTc,
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 12,
                fontWeight: FontWeight.bold),
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

  @override
  void initState() {
    super.initState();
    metricUnit = true;

//    areaArCalculationDisplay = '0.5';
//    radiusArCalculationDisplay = '45.0';
//    arRatioResultDisplay = '90.0';

    areaArCalculation = 0.5;
    radiusArCalculation = 45.0;
    arRatioCalculation = 90.0;
   // metricUnit = saveArRatioMap['mapArUnitSwitchValue'];
    saveArRatioMap['mapArUnitSwitchValue'] = metricUnit;
    saveArRatioMap['mapArResultRatioMm'] = 0.5;
    print('init1');

    saveArRatioMap['mapArInputAreaMm'] = 45.0;
    print('init2');

    saveArRatioMap['mapArInputRadiusMm'] = 90.0;
    print('init3');

    saveArRatioMap['mapArResultRatioInch'] = 0.5;
    print('init4');

    saveArRatioMap['mapArInputAreaInch'] = 2.80;
    print('init5');

    saveArRatioMap['mapArInputRadiusInch'] = 5.60;
    print('init6');

    saveArRatioMap['mapArUnitSwitchValue'] = metricUnit;
    print('init7');

   // _getMapFromSharedPref();

    resetValues(metricUnit);

    labelTextStyleResult0 = kLabelTextStyleActive;
    labelTextStyleResult1 = kLabelTextStyle;
    labelTextStyleResult2 = kLabelTextStyle;
    labelTextStyleResult3 = kLabelTextStyle;
    // parameters
    var _analyticsParameter = {'Unit_AR': 'AR-Millimeter'};
    // Execute a function to send logEvent() to Firebase Analytics
    Analytics.analyticsLogEvent(
        AnalyticsEventType.unit_type, _analyticsParameter);

//    _getMapFromSharedPref();
//    print('Map-data');
//    print(saveArRatioMap.length);
//    print(saveArRatioMap);
  }

 // @override
 // void setState(fn) {
 //   super.setState(fn);
 // }

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
              AppLocalizations.of(context).translate('ar_ratio_0000')
              //'A/R RATIO',
              ,
              style: kAppBarTextStyle,
              textScaleFactor: textScaleFactorTc,
            ),
            submitRatingButton,
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
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('ar_ratio_0010') // 'A/R ratio',
                              ,
                              style: kSecondSubjectTextStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          // Divider(height: 15.0, color: Colors.white),
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
                                              .translate('ar_ratio_0020')
                                          // 'A/R ratio',
                                          ,
                                          style: kLabelTextStyleActive,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            arRatioResultDisplay,
                                            style:
                                                kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitArRatio,
                                            style: kUnitTextStyleAirflow,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                    ]),
                              ),
                            ),
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
                                    AppLocalizations.of(context)
                                        .translate('ar_ratio_0030')
                                    //'Input: Area and Radius',
                                    ,
                                    style: kSecondSubjectTextStyle,
                                    textScaleFactor: textScaleFactorTc),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          // Divider(color: Colors.white),
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
                                    dataRowHeight: 50,
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
                                        DataCell(
                                          Column(
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'ar_ratio_0040')
                                                  //'Area',
                                                  ,
                                                  style: kLabelTextStyle,
                                                  textScaleFactor:
                                                      textScaleFactorTc),
                                              Text(areaArCalculationDisplay,
                                                  style:
                                                      kResultNumberStyleWhite18_600,
                                                  textScaleFactor:
                                                      textScaleFactorTc),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitAreaArRatioDisplay,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  StepButtonClose(
                                                    icon:
                                                        FontAwesomeIcons.minus,
                                                    onStepPress: () {
                                                      timer = Timer.periodic(
                                                          Duration(
                                                              milliseconds:
                                                                  tapTime),
                                                          (t) {
                                                        setState(() {
                                                          if ((Decimal.parse(
                                                                  areaArCalculation
                                                                      .toStringAsFixed(
                                                                          2)) >
                                                              (Decimal.parse(
                                                                  kMinAreaArCalculation
                                                                      .toStringAsFixed(
                                                                          2))))) {
                                                            areaArCalculation =
                                                                areaArCalculation -
                                                                    stepValueAreaArCalculation;

                                                            compressorOrTurbine =
                                                                true;

                                                            calcArRatio(
                                                                areaArCalculation,
                                                                radiusArCalculation,
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
                                                        if ((Decimal.parse(
                                                                areaArCalculation
                                                                    .toStringAsFixed(
                                                                        2)) >
                                                            (Decimal.parse(
                                                                kMinAreaArCalculation
                                                                    .toStringAsFixed(
                                                                        2))))) {
                                                          areaArCalculation =
                                                              areaArCalculation -
                                                                  stepValueAreaArCalculation;

                                                          compressorOrTurbine =
                                                              true;

                                                          calcArRatio(
                                                              areaArCalculation,
                                                              radiusArCalculation,
                                                              metricUnit);
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
                                                                  tapTime),
                                                          (t) {
                                                        setState(() {
                                                          if ((Decimal.parse(
                                                                  areaArCalculation
                                                                      .toStringAsFixed(
                                                                          2)) <
                                                              (Decimal.parse(
                                                                  kMaxAreaArCalculation
                                                                      .toStringAsFixed(
                                                                          2))))) {
                                                            areaArCalculation =
                                                                areaArCalculation +
                                                                    stepValueAreaArCalculation;

                                                            compressorOrTurbine =
                                                                true;

                                                            calcArRatio(
                                                                areaArCalculation,
                                                                radiusArCalculation,
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
                                                        print('Nullplace 505 areaArCalculation $areaArCalculation');
                                                        if ((Decimal.parse(
                                                                areaArCalculation
                                                                    .toStringAsFixed(
                                                                        2)) <
                                                            (Decimal.parse(
                                                                kMaxAreaArCalculation
                                                                    .toStringAsFixed(
                                                                        2))))) {
                                                          areaArCalculation =
                                                              areaArCalculation +
                                                                  stepValueAreaArCalculation;

                                                          compressorOrTurbine =
                                                              true;

                                                          calcArRatio(
                                                              areaArCalculation,
                                                              radiusArCalculation,
                                                              metricUnit);
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Column(
                                          children: [
                                            Text(AppLocalizations.of(context).translate('ar_ratio_0050')//'Radius',
                                               , style: kLabelTextStyle,
                                                textScaleFactor:
                                                    textScaleFactorTc),
                                            Text(
                                              radiusArCalculationDisplay,
                                              style:
                                                  kResultNumberStyleWhite18_600,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        )),
                                        DataCell(
                                          Text(
                                            unitRadiusArRatioDisplay,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
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
                                                              radiusArCalculation
                                                                  .toString()) >
                                                          (Decimal.parse(
                                                              kMinRadiusArCalculation
                                                                  .toString())))) {
                                                        radiusArCalculation =
                                                            radiusArCalculation -
                                                                stepValueRadiusArCalculation;

                                                        compressorOrTurbine =
                                                            true;

                                                        calcArRatio(
                                                            areaArCalculation,
                                                            radiusArCalculation,
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
                                                    if ((Decimal.parse(
                                                            radiusArCalculation
                                                                .toStringAsFixed(
                                                                    2)) >
                                                        (Decimal.parse(
                                                            kMinRadiusArCalculation
                                                                .toStringAsFixed(
                                                                    2))))) {
                                                      radiusArCalculation =
                                                          radiusArCalculation -
                                                              stepValueRadiusArCalculation;

                                                      compressorOrTurbine =
                                                          true;

                                                      calcArRatio(
                                                          areaArCalculation,
                                                          radiusArCalculation,
                                                          metricUnit);
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
                                                              radiusArCalculation
                                                                  .toString()) <
                                                          (Decimal.parse(
                                                              kMaxRadiusArCalculation
                                                                  .toString())))) {
                                                        radiusArCalculation =
                                                            radiusArCalculation +
                                                                stepValueRadiusArCalculation;

                                                        compressorOrTurbine =
                                                            true;

                                                        calcArRatio(
                                                            areaArCalculation,
                                                            radiusArCalculation,
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
                                                    if ((Decimal.parse(
                                                            radiusArCalculation
                                                                .toStringAsFixed(
                                                                    2)) <
                                                        (Decimal.parse(
                                                            kMaxRadiusArCalculation
                                                                .toStringAsFixed(
                                                                    2))))) {
                                                      radiusArCalculation =
                                                          radiusArCalculation +
                                                              stepValueRadiusArCalculation;

                                                      compressorOrTurbine =
                                                          true;

                                                      calcArRatio(
                                                          areaArCalculation,
                                                          radiusArCalculation,
                                                          metricUnit);
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ]),
                              ),
                            ),
                          ),

                          // Divider(), //Vikten (ton)

                          //Center(
                          // child: Image(
                          //   image: AssetImage('images/turbo_picture.jpg'),
                          // ),
                          //)
                        ],
                      ),
                    ), //PSI slider
                    // Divider(),
                  ],
                ),
              ),
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
                              Text(
                                AppLocalizations.of(context).translate('ar_ratio_0060')//'Inch',
                                ,style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc,
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
                              Text(
                                AppLocalizations.of(context).translate('ar_ratio_0070')// 'mm',
                               , style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).translate('ar_ratio_0080')// '(Switch will reset the values to default)',
                               , style: kBodyItalicTextStyle,
                                textScaleFactor: textScaleFactorTc * 0.8,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              ),

              // Speed

              // Kilometer
              // Mile

              //Fuel (Hp)
            ],
          ),
        );
      }),
    );
  }

 int radioValue = 0;

//  void handleRadioValueChanged(int value) {
//    setState(() {
//      radioValue = value;
//      resetValues(metricUnit);
//    });
//  }

  void resetValues(bool metricUnit) {
    setState(() {
      //radioValue = 0;
      saveArRatioMap['mapArUnitSwitchValue'] = metricUnit;
      print('Get_function');
      _getMapFromSharedPref();
      // calcArRatio(areaArCalculation,radiusArCalculation, metricUnit);

      print('Get Metric/Inch');
      print('saveArRatioMap Mm1 $saveArRatioMap');
      print('Print after fetch  $metricUnit');

      if (metricUnit) {
        // calcArRatio(areaArCalculation,radiusArCalculation, metricUnit);
//        arRatioCalculation = saveArRatioMap['mapArResultRatioMm'];
//        print('G1');
//
        areaArCalculation = saveArRatioMap['mapArInputAreaMm'];
        print('G2 $areaArCalculation');
//
//        radiusArCalculation = saveArRatioMap['mapArInputRadiusMm'];
//        print('G3');

        unitAreaArRatioDisplay = unitAreaArRatioMillimeter;
        unitRadiusArRatioDisplay = unitRadiusArRatioMillimeter;
        print('unitAreaArRatioDisplay Mm $unitAreaArRatioDisplay');
        print('saveArRatioMap Mm2 $saveArRatioMap');

        //  arRatioResultCompressorMillimeter = 45.0;
        //  arRatioResultTurbineMillimeter = 45.0;
        // arRatioResultCompressorInch = 5.6;
        // arRatioResultTurbineInch = 5.6;
        //compressorOrTurbine = true;

        kMinAreaArCalculation = kMinAreaArCalculationMillimeter;
        kMaxAreaArCalculation = kMaxAreaArCalculationMillimeter;
        stepValueAreaArCalculation = stepValueAreaArCalculationMillimeter;

        kMinRadiusArCalculation = kMinRadiusArCalculationMillimeter;
        kMaxRadiusArCalculation = kMaxRadiusArCalculationMillimeter;
        stepValueRadiusArCalculation = stepValueRadiusArCalculationMillimeter;

        areaArCalculationDisplay = areaArCalculation?.toStringAsFixed(2);
        radiusArCalculationDisplay = radiusArCalculation?.toStringAsFixed(2);
        arRatioResultDisplay = arRatioCalculation?.toStringAsFixed(2);
      } else {
        // calcArRatio(areaArCalculation,radiusArCalculation, metricUnit);
//        arRatioCalculation = saveArRatioMap['mapArResultRatioInch'];
//        print('G4');
//
//        areaArCalculation = saveArRatioMap['mapArInputAreaInch'];
//        print('G5');
//
//        radiusArCalculation = saveArRatioMap['mapArInputRadiusInch'];
//        print('G6');

        unitAreaArRatioDisplay = unitAreaArRatioInch;
        unitRadiusArRatioDisplay = unitRadiusArRatioInch;
        print('unitAreaArRatioDisplay Inch $unitAreaArRatioDisplay');

//        arRatioResultCompressorInch = 2.8;
//        arRatioResultTurbineInch = 2.8;
//        arRatioCalculation = 0.50;
//        areaArCalculation = 2.8;
//        radiusArCalculation = 5.6;
//        compressorOrTurbine = true;

        kMinAreaArCalculation = kMinAreaArCalculationInch;
        kMaxAreaArCalculation = kMaxAreaArCalculationInch;
        stepValueAreaArCalculation = stepValueAreaArCalculationInch;

        kMinRadiusArCalculation = kMinRadiusArCalculationInch;
        kMaxRadiusArCalculation = kMaxRadiusArCalculationInch;
        stepValueRadiusArCalculation = stepValueRadiusArCalculationInch;

        areaArCalculationDisplay = areaArCalculation.toStringAsFixed(2);
        radiusArCalculationDisplay = radiusArCalculation.toStringAsFixed(2);
        arRatioResultDisplay = arRatioCalculation.toStringAsFixed(2);
      }
    });
  }

  void calcArRatio(
      double areaArCalculation, double radiusArCalculation, bool metricUnit) {
    setState(() {
      if (metricUnit) {
        ArResultRatioMm =
            calculate.calcArRatioCalc(areaArCalculation, radiusArCalculation);
        areaArCalculationDisplay = areaArCalculation.toStringAsFixed(2);
        radiusArCalculationDisplay = radiusArCalculation.toStringAsFixed(2);
        arRatioResultDisplay = ArResultRatioMm.toStringAsFixed(2);

        print('Anders');
        saveArRatioMap['mapArResultRatioMm'] = ArResultRatioMm;
        print('1');

        saveArRatioMap['mapArInputAreaMm'] = areaArCalculation;
        print('2');

        saveArRatioMap['mapArInputRadiusMm'] = radiusArCalculation;
        print('3');

        saveArRatioMap['mapArUnitSwitchValue'] = metricUnit;
        print('4');

        _setMapFromSharedPref();

        print('Map-data');
        print(saveArRatioMap.length);
        print('saveArRatioMap Mm $saveArRatioMap');
      } else {
        arRatioCalculation =
            calculate.calcArRatioCalc(areaArCalculation, radiusArCalculation);
        areaArCalculationDisplay = areaArCalculation.toStringAsFixed(2);
        radiusArCalculationDisplay = radiusArCalculation.toStringAsFixed(2);
        arRatioResultDisplay = arRatioCalculation.toStringAsFixed(2);

        print('Anders');
        saveArRatioMap['mapArResultRatioInch'] = arRatioCalculation;
        print('1');

        saveArRatioMap['mapArInputAreaInch'] = areaArCalculation;
        print('2');

        saveArRatioMap['mapArInputRadiusInch'] = radiusArCalculation;
        print('3');
        saveArRatioMap['mapArUnitSwitchValue'] = metricUnit;
        print('4');

        _setMapFromSharedPref();
        // _setMapFromSharedPref();
        print('Map-data Inch');
        print(saveArRatioMap.length);
        print('saveArRatioMap Inch $saveArRatioMap');
      }
    });
  }

  /// Will get the startupnumber from shared_preferences
  /// will return 0 if null
  Future<Map> _getMapFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    print('Try loading ...');
//    Map saveArRatioMap = prefs.get('saveArRatioMap');
    if (metricUnit == true) {
      print('Try loading ... mm');
      arRatioCalculation = prefs.getDouble('mapArResultRatioMm');
      print('GET arRatioCalculation $arRatioCalculation');
      areaArCalculation = prefs.getDouble('mapArInputAreaMm');
      print('GET areaArCalculation $areaArCalculation');
      radiusArCalculation = prefs.getDouble('mapArInputRadiusMm');
      print('GET radiusArCalculation $radiusArCalculation');

    } else {
      print('Try loading ... inch');
      arRatioCalculation = prefs.getDouble('mapArResultRatioInch');
      areaArCalculation = prefs.getDouble('mapArInputAreaInch');
      radiusArCalculation = prefs.getDouble('mapArInputRadiusInch');
    }

//    if (saveArRatioMap == null) {
//      print('No Load values');
//
//      return null;
//    }
//    arRatioCalculation = saveArRatioMap['mapArResultRatioMm'];
//    print('G1');
//
//    areaArCalculation = saveArRatioMap['mapArInputAreaMm'];
//    print('G2');
//
//    radiusArCalculation = saveArRatioMap['mapArInputRadiusMm'];
//    print('G3');
//
//    arRatioCalculation = saveArRatioMap['mapArResultRatioInch'];
//    print('G4');
//
//    areaArCalculation = saveArRatioMap['mapArInputAreaInch'];
//    print('G5');
//
//    radiusArCalculation = saveArRatioMap['mapArInputRadiusInch'];
//    print('G6');
//
//    metricUnit = saveArRatioMap['mapArUnitSwitchValue'];
//    print('Load values');

    return saveArRatioMap;
  }

//  /// Reset the counter in shared_preferences to 0
//  Future<void> _resetCounter() async {
//    final prefs = await SharedPreferences.getInstance();
//    await prefs.setInt('startupNumber', 0);
//  }

  /// Will store the "saveArRatioMap" then
  /// use setState to display in the UI
  Future<void> _setMapFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
        'mapArResultRatioMm', saveArRatioMap[mapArResultRatioMm.toString()]);
    await prefs.setString(
        'mapArInputAreaMm', saveArRatioMap[mapArInputAreaMm.toString()]);
    await prefs.setString(
        'mapArInputRadiusMm', saveArRatioMap[mapArInputRadiusMm.toString()]);

    await prefs.setString('mapArResultRatioInch',
        saveArRatioMap[mapArResultRatioInch.toString()]);
    await prefs.setString(
        'mapArInputAreaInch', saveArRatioMap[mapArInputAreaInch.toString()]);
    await prefs.setString('mapArInputRadiusInch',
        saveArRatioMap[mapArInputRadiusInch.toString()]);
    await prefs.setBool(
        'mapArUnitSwitchValue', saveArRatioMap[mapArUnitSwitchValue]);

    print('Save values');
//    if (currentStartupNumber == 3) {
//      setState(() => haveStartedTimes = '$currentStartupNumber Times Completed');
//
//      // Reset only if you want to
//      await _resetCounter();
//    } else {
//    setState(() => haveStartedTimes =
//    'You have started this app: $currentStartupNumber times');
//    }
  }
}
