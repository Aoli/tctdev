import 'dart:async';
import 'package:Turbocharger/components/analytics_event.dart';
import 'package:Turbocharger/data_models/analytics_event_type.dart';
import 'package:Turbocharger/components/stepbutton.dart';
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


class MassPage extends StatefulWidget {
  @override
  _MassPageState createState() => _MassPageState();
}

class _MassPageState extends State<MassPage> {
  _MassPageState();

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
            var _analyticsParameter = {'Snackbar': 'Conv Weight'};
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
            'Mass conversions',
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

  CalculatorBrain calculate = CalculatorBrain();

  @override
  void initState() {
    super.initState();
    print('radioValue $radioValue');

    convertResultLengthInch = 1.0;
    convertResultLengthMillimeter = 25.4;

    convertResultTemperatureCelsius = 20.0;
    convertResultTemperatureFahrenheit = 68.0;

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
            Text(AppLocalizations.of(context).translate('convert_weight_0000')
              //'MASS Conversion',
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
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).translate(
                                'convert_weight_0010') //'Mass',
                            ,style: kSecondSubjectTextStyle,
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
                                              .translate('convert_weight_0020')
                                          //'US Pound',
                                         , style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultMassPound
                                                .toStringAsFixed(2),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitMassUsPound,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_weight_0030')
                                          // 'Kilogram',
                                         , style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultMassKilogram
                                                .toStringAsFixed(2),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitWeightKilogram,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_weight_0040')
                                          //'Gram',
                                         , style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultMassGram
                                                .toStringAsFixed(0),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitMassGram,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(
                                          Divider(color: Colors.white70),
                                        ),
                                        DataCell(
                                          Divider(color: Colors.white70),
                                        ),
                                        DataCell(
                                          Divider(color: Colors.white70),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_weight_0050')
                                          //  'Ounce',
                                         , style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            (convertResultMassPound * 16)
                                                .toStringAsFixed(2),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                'convert_weight_0060') //'oz',
                                           , style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate('convert_weight_0070')
                                          //'Stone',
                                        ,  style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            (convertResultMassKilogram *
                                                0.15747)
                                                .toStringAsFixed(3),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                'convert_weight_0080') // 'st',
                                            ,style: kLabelTextStyle,
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
                                child: Text(convertSliderHeaderMassTextAll,
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
                                    kMinSliderConvertMassAll.toStringAsFixed(0),
                                    style: TextStyle(color: Colors.white30),
                                    textScaleFactor: textScaleFactorTc),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Text(
                                  kMaxSliderConvertMassAll.toStringAsFixed(0),
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
                                value: convertSliderResultMassAll,
                                min: kMinSliderConvertMassAll,
                                max: kMaxSliderConvertMassAll,
                                label: convertSliderResultMassAll
                                    .toStringAsFixed(0),
                                inactiveColor: Color(0xFF8D8E89),
                                divisions: sliderSliderConvertMassAll,
                                onChanged: (double sliderValue) {
                                  convertSliderResultMassAll = sliderValue;
                                  debugPrint(
                                      'SLIDE convertSliderResultMassAll $convertSliderResultMassAll');
                                  debugPrint(
                                      'SLIDE convertResultTemperatureCelsius $convertResultTemperatureCelsius');

                                  calculateMass(
                                      convertSliderResultMassAll, radioValue);
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
                                              convertSliderResultMassAll
                                                  .toStringAsFixed(1)) >
                                              Decimal.parse(
                                                  vMinSliderConvertVolumeAllStepper
                                                      .toStringAsFixed(1))) {
                                            convertSliderResultMassAll =
                                                convertSliderResultMassAll -
                                                    stepSliderConvertMassAll;
                                            debugPrint(
                                                '- convertSliderResultMassAll $convertSliderResultMassAll');
                                            calculateMass(
                                                convertSliderResultMassAll,
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
                                            convertSliderResultMassAll
                                                .toStringAsFixed(1)) >
                                            Decimal.parse(
                                                vMinSliderConvertVolumeAllStepper
                                                    .toStringAsFixed(1))) {
                                          convertSliderResultMassAll =
                                              convertSliderResultMassAll -
                                                  stepSliderConvertMassAll;
                                          debugPrint(
                                              '- convertSliderResultMassAll $convertSliderResultMassAll');
                                          calculateMass(
                                              convertSliderResultMassAll,
                                              radioValue);
                                        }
                                      });
                                    }),
                              ),
                              Container(
                                width: kInputNumberBigWidth,
                                child: Text(
                                    convertSliderResultMassAll
                                        .toStringAsFixed(1),
                                    style: kResultNumberStyleWhite18_600,
                                    textScaleFactor: textScaleFactorTc),
                              ),
                              Container(
                                child: Text(unitSliderConvertMassAll,
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
                                              convertSliderResultMassAll
                                                  .toStringAsFixed(1)) <
                                              (Decimal.parse(
                                                  vMaxSliderConvertVolumeAllStepper
                                                      .toStringAsFixed(1))))) {
                                            convertSliderResultMassAll =
                                                convertSliderResultMassAll +
                                                    stepSliderConvertMassAll;
                                            debugPrint(
                                                '+ convertSliderResultMassAll $convertSliderResultMassAll');
                                            calculateMass(
                                                convertSliderResultMassAll,
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
                                            convertSliderResultMassAll
                                                .toStringAsFixed(1)) <
                                            (Decimal.parse(
                                                vMaxSliderConvertVolumeAllStepper
                                                    .toStringAsFixed(1))))) {
                                          convertSliderResultMassAll =
                                              convertSliderResultMassAll +
                                                  stepSliderConvertMassAll;
                                          debugPrint(
                                              '+ convertSliderResultMassAll $convertSliderResultMassAll');
                                          calculateMass(
                                              convertSliderResultMassAll,
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
                                  Text(AppLocalizations.of(context).translate(
                                      'convert_weight_0090') //'Pound',
                                      , style: kUnitTextStyles,
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
                                  Text(AppLocalizations.of(context).translate(
                                      'convert_weight_0090') //'Kilogram',
                                      , style: kUnitTextStyles,
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
                                  Text(AppLocalizations.of(context).translate(
                                      'convert_weight_0100') //'Gram',
                                      , style: kUnitTextStyles,
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
          print('0 convertSliderResultMassAll $convertSliderResultMassAll');
          print('0 kMinSliderConvertMassAll $kMinSliderConvertMassAll');
          print('0 kMaxSliderConvertMassAll $kMaxSliderConvertMassAll');
          print('0 convertSliderResultMassAll $convertSliderResultMassAll');
          print('0 sliderSliderConvertMassAll $sliderSliderConvertMassAll');
          print('0 stepSliderConvertMassAll $stepSliderConvertMassAll');
          print('0 kMaxConvertMassPound $kMaxConvertMassPound');
          print('0 kMaxConvertMassGram $kMaxConvertMassGram');
          print('0 kMaxConvertMassKilogram $kMaxConvertMassKilogram');
          // if(convertResultMassPound>kMaxSliderConvertMassAll){
          //   convertResultMassPound = kMaxSliderConvertMassAll;
          // }
          labelTextStyleResult0 = kLabelTextStyleActive;
          labelTextStyleResult1 = kLabelTextStyle;
          labelTextStyleResult2 = kLabelTextStyle;
          labelTextStyleResult3 = kLabelTextStyle;

          convertSliderHeaderMassTextAll = 'Pound';
          unitSliderConvertMassAll = 'lb';
          convertSliderResultMassAll = kResetValuePound;
          kMinSliderConvertMassAll = kMinConvertMassPound;
          kMaxSliderConvertMassAll = kMaxConvertMassPound;
          sliderSliderConvertMassAll = sliderConvertMassPound;
          stepSliderConvertMassAll = stepConvertMassPound;
          vMinSliderConvertVolumeAllStepper = kMinConvertMassPound * 1.05;
          vMaxSliderConvertVolumeAllStepper = kMaxConvertMassPound * 0.95;

          break;

        case 1:
          labelTextStyleResult0 = kLabelTextStyle;
          labelTextStyleResult1 = kLabelTextStyle;
          labelTextStyleResult2 = kLabelTextStyleActive;
          labelTextStyleResult3 = kLabelTextStyle;
          print('2 convertSliderResultMassAll $convertSliderResultMassAll');
          print('2 kMinSliderConvertMassAll $kMinSliderConvertMassAll');
          print('2 kMaxSliderConvertMassAll $kMaxSliderConvertMassAll');
          print('2 convertSliderResultMassAll $convertSliderResultMassAll');
          print('2 sliderSliderConvertMassAll $sliderSliderConvertMassAll');
          print('2 stepSliderConvertMassAll $stepSliderConvertMassAll');
          print('2 kMaxConvertMassPound $kMaxConvertMassPound');
          print('2 kMaxConvertMassGram $kMaxConvertMassGram');
          print('2 kMaxConvertMassKilogram $kMaxConvertMassKilogram');
          // if(convertResultMassKilogram>kMaxSliderConvertMassAll){
          //   convertResultMassKilogram = kMaxSliderConvertMassAll;
          // }
          convertSliderHeaderMassTextAll = 'Kilogram';
          unitSliderConvertMassAll = 'Kg';
          convertSliderResultMassAll = kResetValueKilogram;
          kMinSliderConvertMassAll = kMinConvertMassKilogram;
          kMaxSliderConvertMassAll = kMaxConvertMassKilogram;
          sliderSliderConvertMassAll = sliderConvertMassKilogram;
          stepSliderConvertMassAll = stepConvertMassKilogram;
          vMinSliderConvertVolumeAllStepper = kMinConvertMassKilogram * 1.05;
          vMaxSliderConvertVolumeAllStepper = kMaxConvertMassKilogram * 0.95;

          break;
        case 2:
          labelTextStyleResult0 = kLabelTextStyle;
          labelTextStyleResult1 = kLabelTextStyleActive;
          labelTextStyleResult2 = kLabelTextStyle;
          labelTextStyleResult3 = kLabelTextStyle;
          print('1 convertSliderResultMassAll $convertSliderResultMassAll');
          print('1 kMinSliderConvertMassAll $kMinSliderConvertMassAll');
          print('1 kMaxSliderConvertMassAll $kMaxSliderConvertMassAll');
          print('1 convertSliderResultMassAll $convertSliderResultMassAll');
          print('1 sliderSliderConvertMassAll $sliderSliderConvertMassAll');
          print('1 stepSliderConvertMassAll $stepSliderConvertMassAll');
          print('1 kMaxConvertMassPound $kMaxConvertMassPound');
          print('1 kMaxConvertMassLiter $kMaxConvertMassGram');
          print('1 kMaxConvertMassKilogram $kMaxConvertMassKilogram');
          // if(convertResultMassLitre>kMaxSliderConvertMassAll){
          //   kMaxSliderConvertMassAll = kMaxConvertMassLiter;
          //}
          convertSliderHeaderMassTextAll = 'Gram';
          unitSliderConvertMassAll = 'g';
          convertSliderResultMassAll = kResetValueGram;
          kMinSliderConvertMassAll = kMinConvertMassGram;
          kMaxSliderConvertMassAll = kMaxConvertMassGram;
          sliderSliderConvertMassAll = sliderConvertMassGram;
          stepSliderConvertMassAll = stepConvertMassGram;
          vMinSliderConvertVolumeAllStepper = kMinConvertMassGram * 1.05;
          vMaxSliderConvertVolumeAllStepper = kMaxConvertMassGram * 0.95;
          break;
      }
      print('radioValue $radioValue');
    });
  }

  calculateMass(double convertSliderResultMassAll, int radioValue) {
    setState(() {
      switch (radioValue) {
        case 0:
          convertResultMassPound = convertSliderResultMassAll;
          convertResultMassGram = calculate.conversionCalc(
              convertSliderResultMassAll, 'MassPoundToGram');
          convertResultMassKilogram = calculate.conversionCalc(
              convertSliderResultMassAll, 'MassPoundToKilogram');
          break;

        case 1:
          convertResultMassKilogram = convertSliderResultMassAll;
          convertResultMassPound = calculate.conversionCalc(
              convertSliderResultMassAll, 'MassKilogramToPound');
          convertResultMassGram = calculate.conversionCalc(
              convertSliderResultMassAll, 'MassKilogramToGram');
          break;
        case 2:
          convertResultMassGram = convertSliderResultMassAll;
          convertResultMassPound = calculate.conversionCalc(
              convertSliderResultMassAll, 'MassGramToPound');
          convertResultMassKilogram = calculate.conversionCalc(
              convertSliderResultMassAll, 'MassGramToKilogram');
          break;
      }
    });
  }

  void resetValues() {
    setState(() {
      //radioValue = 0;
      kMinSliderConvertMassAll = kMinConvertMassPound;
      kMaxSliderConvertMassAll = kMaxConvertMassPound;
      vMinSliderConvertVolumeAllStepper = kMinConvertMassPound * 1.05;
      vMaxSliderConvertVolumeAllStepper = kMaxConvertMassPound * 0.95;

      stepSliderConvertMassAll = stepConvertMassPound;
      sliderSliderConvertMassAll = sliderConvertMassPound;
      convertResultMassGram = kResetValueGram;
      convertResultMassPound = kResetValuePound;
      convertResultMassKilogram = kResetValueKilogram;
      convertSliderResultMassAll = kResetValuePound;
      calculateMass(convertSliderResultMassAll, 0);
    });
  }
}
