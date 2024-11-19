import 'dart:async';
import 'package:tct/components/analytics_event.dart';
import 'package:tct/data_models/analytics_event_type.dart';
import 'package:tct/components/stepbutton.dart';
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

class VolumePage extends StatefulWidget {
  @override
  _VolumePageState createState() => _VolumePageState();
}

class _VolumePageState extends State<VolumePage> {
  _VolumePageState();

  //bool metricUnit = false;
  bool snackbarEnable = true;

  Widget get submitRatingButton {
    if (snackbarEnable) {
      return IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState.showSnackBar(snackBar);

            // parameters
            var _analyticsParameter = {'Snackbar': 'Conv Volume'};
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
            'Volume conversions',
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

    //convertResultVolumeUsLiquidGallon = 10.0;
    //convertResultVolumeLitre = 37.9;
    //convertResultVolumeCubicCentimeter = 37854.1;
    //convertResultVolumeCubicInch = 2310.0;
    resetValues();
    labelTextStyleResult0 = kLabelTextStyleActive;
    labelTextStyleResult1 = kLabelTextStyle;
    labelTextStyleResult2 = kLabelTextStyle;
    labelTextStyleResult3 = kLabelTextStyle;
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
              AppLocalizations.of(context).translate('convert_volume_0000')
              //'VOLUME Conversion',
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
                          Text(
                            AppLocalizations.of(context)
                                .translate('convert_volume_0010') //'Volume',
                            ,
                            style: kSecondSubjectTextStyle,
                            textScaleFactor: textScaleFactorTc,
                          ),
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
                                        style: kLabelTextStyleActive,
                                        textScaleFactor: textScaleFactorTc,
                                      )),
                                      DataColumn(
                                          numeric: true,
                                          label: Text(
                                            '',
                                            style: kLabelTextStyleActive,
                                            textScaleFactor: textScaleFactorTc,
                                          )),
                                      DataColumn(
                                          numeric: true,
                                          label: Text(
                                            '',
                                            style: kLabelTextStyleActive,
                                            textScaleFactor: textScaleFactorTc,
                                          )),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_volume_0020')
                                          // 'US Gallon',
                                          ,
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultVolumeUsLiquidGallon
                                                .toStringAsFixed(2),
                                            style:
                                                kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitVolumeUsGallon,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_volume_0030')
                                          // 'Liter',
                                          ,
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultVolumeLitre
                                                .toStringAsFixed(2),
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
                                              .translate('convert_volume_0040')
                                          //  'Cubic Centemeter',
                                          ,
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultVolumeCubicCentimeter
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
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_volume_0050')
                                          // 'Cubic Inch',
                                          ,
                                          style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultVolumeCubicInch
                                                .toStringAsFixed(0),
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
                                child: Text(convertSliderHeaderVolumeTextAll,
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
                                    kMinSliderConvertVolumeAll
                                        .toStringAsFixed(0),
                                    style: TextStyle(color: Colors.white30),
                                    textScaleFactor: textScaleFactorTc),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Text(
                                  kMaxSliderConvertVolumeAll.toStringAsFixed(0),
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
                                value: convertSliderResultVolumeAll,
                                min: kMinSliderConvertVolumeAll,
                                max: kMaxSliderConvertVolumeAll,
                                label: convertSliderResultVolumeAll
                                    .toStringAsFixed(0),
                                inactiveColor: Color(0xFF8D8E89),
                                divisions: sliderSliderConvertVolumeAll,
                                onChanged: (double sliderValue) {
                                  convertSliderResultVolumeAll = sliderValue;
                                  debugPrint(
                                      'SLIDE convertSliderResultVolumeAll $convertSliderResultVolumeAll');
                                  debugPrint(
                                      'SLIDE convertResultTemperatureCelsius $convertResultTemperatureCelsius');

                                  calculateVolume(
                                      convertSliderResultVolumeAll, radioValue);
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
                                                  convertSliderResultVolumeAll
                                                      .toStringAsFixed(1)) >
                                              Decimal.parse(
                                                  vMinSliderConvertVolumeAllStepper
                                                      .toStringAsFixed(1))) {
                                            convertSliderResultVolumeAll =
                                                convertSliderResultVolumeAll -
                                                    stepSliderConvertVolumeAll;
                                            debugPrint(
                                                '- convertResultTemperatureFahrenheit $convertResultTemperatureFahrenheit');
                                            calculateVolume(
                                                convertSliderResultVolumeAll,
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
                                                convertSliderResultVolumeAll
                                                    .toStringAsFixed(1)) >
                                            Decimal.parse(
                                                vMinSliderConvertVolumeAllStepper
                                                    .toStringAsFixed(1))) {
                                          convertSliderResultVolumeAll =
                                              convertSliderResultVolumeAll -
                                                  stepSliderConvertVolumeAll;
                                          debugPrint(
                                              '- convertResultTemperatureFahrenheit $convertResultTemperatureFahrenheit');
                                          calculateVolume(
                                              convertSliderResultVolumeAll,
                                              radioValue);
                                        }
                                      });
                                    }),
                              ),
                              Container(
                                width: kInputNumberBigWidth,
                                child: Text(
                                    convertSliderResultVolumeAll
                                        .toStringAsFixed(1),
                                    style: kResultNumberStyleWhite18_600,
                                    textScaleFactor: textScaleFactorTc),
                              ),
                              Container(
                                width: kInputUnitWidth,
                                child: Text(unitSliderConvertVolumeAll,
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
                                                  convertSliderResultVolumeAll
                                                      .toStringAsFixed(1)) <
                                              (Decimal.parse(
                                                  vMaxSliderConvertVolumeAllStepper
                                                      .toStringAsFixed(1))))) {
                                            convertSliderResultVolumeAll =
                                                convertSliderResultVolumeAll +
                                                    stepSliderConvertVolumeAll;
                                            debugPrint(
                                                '+ convertSliderResultVolumeAll $convertSliderResultVolumeAll');
                                            calculateVolume(
                                                convertSliderResultVolumeAll,
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
                                                convertSliderResultVolumeAll
                                                    .toStringAsFixed(1)) <
                                            (Decimal.parse(
                                                vMaxSliderConvertVolumeAllStepper
                                                    .toStringAsFixed(1))))) {
                                          convertSliderResultVolumeAll =
                                              convertSliderResultVolumeAll +
                                                  stepSliderConvertVolumeAll;
                                          debugPrint(
                                              '+ convertSliderResultVolumeAll $convertSliderResultVolumeAll');
                                          calculateVolume(
                                              convertSliderResultVolumeAll,
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
                                  Text(
                                      AppLocalizations.of(context).translate(
                                          'convert_volume_0060') //'US Gal',
                                      ,
                                      style: kUnitTextStyles,
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
                                  Text(
                                      AppLocalizations.of(context).translate(
                                          'convert_volume_0070') //'Liter',
                                      ,
                                      style: kUnitTextStyles,
                                      textScaleFactor: textScaleFactorTc),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Radio<int>(
                                    value: 2,
                                    groupValue: radioValue,
                                    activeColor: Colors.white,
                                    onChanged: handleRadioValueChanged,
                                  ),
                                  Text(
                                      AppLocalizations.of(context).translate(
                                          'convert_volume_0080') //'CC',
                                      ,
                                      style: kUnitTextStyles,
                                      textScaleFactor: textScaleFactorTc),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Radio<int>(
                                    value: 3,
                                    groupValue: radioValue,
                                    activeColor: Colors.white,
                                    onChanged: handleRadioValueChanged,
                                  ),
                                  Text(
                                      AppLocalizations.of(context).translate(
                                          'convert_volume_0090') //'Cid',
                                      ,
                                      style: kUnitTextStyles,
                                      textScaleFactor: textScaleFactorTc),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ), //PSI slider
                    // Divider(),
                  ],
                ),
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

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      resetValues();

      switch (radioValue) {
        case 0:
          labelTextStyleResult0 = kLabelTextStyleActive;
          labelTextStyleResult1 = kLabelTextStyle;
          labelTextStyleResult2 = kLabelTextStyle;
          labelTextStyleResult3 = kLabelTextStyle;

          convertSliderHeaderVolumeTextAll = 'US Gallon';
          unitSliderConvertVolumeAll = 'Us Gal';
          convertSliderResultVolumeAll = kResetValueUsLiquidGallon;
          kMinSliderConvertVolumeAll = kMinConvertVolumeUsLiquidGallon;
          kMaxSliderConvertVolumeAll = kMaxConvertVolumeUsLiquidGallon;
          vMinSliderConvertVolumeAllStepper = vMinConvertVolumeUsLiquidGallon;
          vMaxSliderConvertVolumeAllStepper = vMaxConvertVolumeUsLiquidGallon;

          sliderSliderConvertVolumeAll = sliderConvertVolumeUsLiquidGallon;
          stepSliderConvertVolumeAll = stepConvertVolumeUsLiquidGallon;

          print('0 convertSliderResultVolumeAll $convertSliderResultVolumeAll');
          print('0 kMinSliderConvertVolumeAll $kMinSliderConvertVolumeAll');
          print('0 kMaxSliderConvertVolumeAll $kMaxSliderConvertVolumeAll');
          print('0 convertSliderResultVolumeAll $convertSliderResultVolumeAll');
          print('0 sliderSliderConvertVolumeAll $sliderSliderConvertVolumeAll');
          print('0 stepSliderConvertVolumeAll $stepSliderConvertVolumeAll');
          print(
              '0 vMinSliderConvertVolumeAllStepper $vMinSliderConvertVolumeAllStepper');
          print(
              '0 vMaxSliderConvertVolumeAllStepper $vMaxSliderConvertVolumeAllStepper');
          print(
              '0 kMaxConvertVolumeUsLiquidGallon $kMaxConvertVolumeUsLiquidGallon');
          print('0 kMaxConvertVolumeLiter $kMaxConvertVolumeLiter');
          print(
              '0 kMaxConvertVolumeCubicCentemeter $kMaxConvertVolumeCubicCentimeter');
          print('0 kMaxConvertVolumeCubicInch $kMaxConvertVolumeCubicInch');
          // if(convertResultVolumeUsLiquidGallon>kMaxSliderConvertVolumeAll){
          //   convertResultVolumeUsLiquidGallon = kMaxSliderConvertVolumeAll;
          // }

          break;
        case 1:
          labelTextStyleResult0 = kLabelTextStyle;
          labelTextStyleResult1 = kLabelTextStyleActive;
          labelTextStyleResult2 = kLabelTextStyle;
          labelTextStyleResult3 = kLabelTextStyle;

          convertSliderHeaderVolumeTextAll = 'Liter';
          unitSliderConvertVolumeAll = 'Liter';
          convertSliderResultVolumeAll = kResetValueLiter;
          vMinSliderConvertVolumeAllStepper = vMinConvertVolumeLiter;
          vMaxSliderConvertVolumeAllStepper = vMaxConvertVolumeLiter;
          kMinSliderConvertVolumeAll = kMinConvertVolumeLiter;
          kMaxSliderConvertVolumeAll = kMaxConvertVolumeLiter;

          sliderSliderConvertVolumeAll = sliderConvertVolumeLiter;
          stepSliderConvertVolumeAll = stepConvertVolumeLiter;

          print('1 convertSliderResultVolumeAll $convertSliderResultVolumeAll');
          print('1 kMinSliderConvertVolumeAll $kMinSliderConvertVolumeAll');
          print('1 kMaxSliderConvertVolumeAll $kMaxSliderConvertVolumeAll');
          print('1 convertSliderResultVolumeAll $convertSliderResultVolumeAll');
          print('1 sliderSliderConvertVolumeAll $sliderSliderConvertVolumeAll');
          print('1 stepSliderConvertVolumeAll $stepSliderConvertVolumeAll');
          print(
              '0 vMinSliderConvertVolumeAllStepper $vMinSliderConvertVolumeAllStepper');
          print(
              '0 vMaxSliderConvertVolumeAllStepper $vMaxSliderConvertVolumeAllStepper');
          print(
              '1 kMaxConvertVolumeUsLiquidGallon $kMaxConvertVolumeUsLiquidGallon');
          print('1 kMaxConvertVolumeLiter $kMaxConvertVolumeLiter');
          print(
              '1 kMaxConvertVolumeCubicCentemeter $kMaxConvertVolumeCubicCentimeter');
          print('1 kMaxConvertVolumeCubicInch $kMaxConvertVolumeCubicInch');
          // if(convertResultVolumeLitre>kMaxSliderConvertVolumeAll){
          //   kMaxSliderConvertVolumeAll = kMaxConvertVolumeLiter;
          //}

          break;
        case 2:
          labelTextStyleResult0 = kLabelTextStyle;
          labelTextStyleResult1 = kLabelTextStyle;
          labelTextStyleResult2 = kLabelTextStyleActive;
          labelTextStyleResult3 = kLabelTextStyle;

          convertSliderHeaderVolumeTextAll = 'Cubic Centermeter';
          unitSliderConvertVolumeAll = 'CC';
          convertSliderResultVolumeAll = kResetValueCubicCentiMeter;
          kMinSliderConvertVolumeAll = kMinConvertVolumeCubicCentimeter;
          kMaxSliderConvertVolumeAll = kMaxConvertVolumeCubicCentimeter;
          vMinSliderConvertVolumeAllStepper = vMinConvertVolumeCubicCentimeter;
          vMaxSliderConvertVolumeAllStepper = vMaxConvertVolumeCubicCentimeter;

          sliderSliderConvertVolumeAll = sliderConvertVolumeCubicCentimeter;
          stepSliderConvertVolumeAll = stepConvertVolumeCubicCentimeter;

          print('2 convertSliderResultVolumeAll $convertSliderResultVolumeAll');
          print('2 kMinSliderConvertVolumeAll $kMinSliderConvertVolumeAll');
          print('2 kMaxSliderConvertVolumeAll $kMaxSliderConvertVolumeAll');
          print('2 convertSliderResultVolumeAll $convertSliderResultVolumeAll');
          print('2 sliderSliderConvertVolumeAll $sliderSliderConvertVolumeAll');
          print('2 stepSliderConvertVolumeAll $stepSliderConvertVolumeAll');
          print(
              '2 vMinSliderConvertVolumeAllStepper $vMinSliderConvertVolumeAllStepper');
          print(
              '2 vMaxSliderConvertVolumeAllStepper $vMaxSliderConvertVolumeAllStepper');
          print(
              '2 kMaxConvertVolumeUsLiquidGallon $kMaxConvertVolumeUsLiquidGallon');
          print('2 kMaxConvertVolumeLiter $kMaxConvertVolumeLiter');
          print(
              '2 kMaxConvertVolumeCubicCentemeter $kMaxConvertVolumeCubicCentimeter');
          print('2 kMaxConvertVolumeCubicInch $kMaxConvertVolumeCubicInch');
          // if(convertResultVolumeCubicCentimeter>kMaxSliderConvertVolumeAll){
          //   convertResultVolumeCubicCentimeter = kMaxSliderConvertVolumeAll;
          // }

          break;
        case 3:
          labelTextStyleResult0 = kLabelTextStyle;
          labelTextStyleResult1 = kLabelTextStyle;
          labelTextStyleResult2 = kLabelTextStyle;
          labelTextStyleResult3 = kLabelTextStyleActive;

          convertSliderHeaderVolumeTextAll = 'Cubic Inch';
          unitSliderConvertVolumeAll = 'Cid';
          convertSliderResultVolumeAll = kResetValueCubicInch;
          kMinSliderConvertVolumeAll = kMinConvertVolumeCubicInch;
          kMaxSliderConvertVolumeAll = kMaxConvertVolumeCubicInch;
          vMinSliderConvertVolumeAllStepper = vMinConvertVolumeCubicInch;
          vMaxSliderConvertVolumeAllStepper = vMaxConvertVolumeCubicInch;

          sliderSliderConvertVolumeAll = sliderConvertVolumeCubicInch;
          stepSliderConvertVolumeAll = stepConvertVolumeCubicInch;

          print('3 convertSliderResultVolumeAll $convertSliderResultVolumeAll');
          print('3 kMinSliderConvertVolumeAll $kMinSliderConvertVolumeAll');
          print('3 kMaxSliderConvertVolumeAll $kMaxSliderConvertVolumeAll');
          print(
              '3 vMinSliderConvertVolumeAllStepper $vMinSliderConvertVolumeAllStepper');
          print(
              '3 vMaxSliderConvertVolumeAllStepper $vMaxSliderConvertVolumeAllStepper');

          print('3 convertSliderResultVolumeAll $convertSliderResultVolumeAll');
          print('3 sliderSliderConvertVolumeAll $sliderSliderConvertVolumeAll');
          print('3 stepSliderConvertVolumeAll $stepSliderConvertVolumeAll');

          print(
              '3 kMaxConvertVolumeUsLiquidGallon $kMaxConvertVolumeUsLiquidGallon');
          print('3 kMaxConvertVolumeLiter $kMaxConvertVolumeLiter');
          print(
              '3 kMaxConvertVolumeCubicCentemeter $kMaxConvertVolumeCubicCentimeter');
          print('3 kMaxConvertVolumeCubicInch $kMaxConvertVolumeCubicInch');
          // if(convertResultVolumeCubicInch>kMaxSliderConvertVolumeAll){
          //   convertResultVolumeCubicInch = kMaxSliderConvertVolumeAll;
          // }

          break;
      }
      print('radioValue $radioValue');
    });
  }

  calculateVolume(double convertSliderResultVolumeAll, int radioValue) {
    setState(() {
      switch (radioValue) {
        case 0:
          convertResultVolumeUsLiquidGallon = convertSliderResultVolumeAll;
          convertResultVolumeLitre = calculate.conversionCalc(
              convertSliderResultVolumeAll, 'VolumeUsLiquidGallonToLiter');
          convertResultVolumeCubicCentimeter = calculate.conversionCalc(
              convertSliderResultVolumeAll,
              'VolumeUsLiquidGallonToCubicCentimeter');
          convertResultVolumeCubicInch = calculate.conversionCalc(
              convertSliderResultVolumeAll, 'VolumeUsLiquidGallonToCubicInch');
          break;
        case 1:
          convertResultVolumeLitre = convertSliderResultVolumeAll;
          convertResultVolumeUsLiquidGallon = calculate.conversionCalc(
              convertSliderResultVolumeAll, 'VolumeLiterToUsLiquidGallon');
          convertResultVolumeCubicCentimeter = calculate.conversionCalc(
              convertSliderResultVolumeAll, 'VolumeLiterToCubicCentimeter');
          convertResultVolumeCubicInch = calculate.conversionCalc(
              convertSliderResultVolumeAll, 'VolumeLiterToCubicInch');
          break;
        case 2:
          convertResultVolumeCubicCentimeter = convertSliderResultVolumeAll;
          convertResultVolumeUsLiquidGallon = calculate.conversionCalc(
              convertSliderResultVolumeAll,
              'VolumeCubicCentimeterToUsLiquidGallon');
          convertResultVolumeLitre = calculate.conversionCalc(
              convertSliderResultVolumeAll, 'VolumeCubicCentimeterToLiter');
          convertResultVolumeCubicInch = calculate.conversionCalc(
              convertSliderResultVolumeAll, 'VolumeCubicCentimeterToCubicInch');
          break;
        case 3:
          convertResultVolumeCubicInch = convertSliderResultVolumeAll;
          convertResultVolumeUsLiquidGallon = calculate.conversionCalc(
              convertSliderResultVolumeAll, 'VolumeCubicInchToUsLiquidGallon');
          convertResultVolumeLitre = calculate.conversionCalc(
              convertSliderResultVolumeAll, 'VolumeCubicInchToLiter');
          convertResultVolumeCubicCentimeter = calculate.conversionCalc(
              convertSliderResultVolumeAll, 'VolumeCubicInchToCubicCentimeter');
          break;
      }
    });
  }

  void resetValues() {
    setState(() {
      //radioValue = 0;
      kMinSliderConvertVolumeAll = kMinConvertVolumeUsLiquidGallon;
      kMaxSliderConvertVolumeAll = kMaxConvertVolumeUsLiquidGallon;
      stepSliderConvertVolumeAll = stepConvertVolumeUsLiquidGallon;
      sliderSliderConvertVolumeAll = sliderConvertVolumeUsLiquidGallon;
      convertResultVolumeLitre = kResetValueLiter;
      convertResultVolumeUsLiquidGallon = kResetValueUsLiquidGallon;
      convertResultVolumeCubicCentimeter = kResetValueCubicCentiMeter;
      convertResultVolumeCubicInch = kResetValueCubicInch;
      convertSliderResultVolumeAll = kResetValueUsLiquidGallon;

      vMinSliderConvertVolumeAllStepper = vMinConvertVolumeUsLiquidGallon;
      vMaxSliderConvertVolumeAllStepper = vMaxConvertVolumeUsLiquidGallon;

      calculateVolume(convertSliderResultVolumeAll, 0);
    });
  }
}
