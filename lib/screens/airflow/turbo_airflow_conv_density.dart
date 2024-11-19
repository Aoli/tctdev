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


class AirflowSimple extends StatefulWidget {
  @override
  _AirflowSimpleState createState() => _AirflowSimpleState();
}

class _AirflowSimpleState extends State<AirflowSimple> {
  _AirflowSimpleState();

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
            var _analyticsParameter = {'Snackbar': 'Airflow AirDensity'};
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
            'The Density of Air Values.',
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textScaleFactor: textScaleFactorTc,
          ),
          SizedBox(height: 5.0),
          Text(
            'The density of dry air is 1.29 grams per liter (0.07967 pounds per cubic foot) at 32 degrees Fahrenheit (0 degrees Celsius) at average sea-level barometric pressure (29.92 inches of mercury or 760 millimeters).',
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textScaleFactor: textScaleFactorTc,
          ),
          SizedBox(height: 10.0),
          Text(
            'At sea level and at 15 degrees C, the density of air is 1.225 kg/m3. This is the value of the ISA (International Standard Atmosphere). In other units, this is 1225.0 g/m3, 0.0023769 slug/(cu ft), or 0.0765 lb/(cu ft).',
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textScaleFactor: textScaleFactorTc,
          ),
          SizedBox(height: 10.0),
          Text(
            '1) The IUPAC standard of temperature and pressure (0 degrees C and 100 kPa), uses a dry air density of 1.2754 kg/m3.',
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textScaleFactor: textScaleFactorTc,
          ),
          SizedBox(height: 10.0),
          Text(
            '2) NTP (Normal Temperature and Pressure): At 20 ºC and 68 ºF and 101.325 kPa = 14.72 psi, the density of dry air is 1.2041 kg/m3 equals 0.075 punds per cubic foot',
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textScaleFactor: textScaleFactorTc,
          ),
          SizedBox(height: 10.0),
          Text(
            '3) At 70 degrees F and 14.696 psi, the density of dry air is 0.074887 lbm/ft3.',
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
              AppLocalizations.of(context).translate(
                  'airflow_conv_density_0000') //'Airflow Air Density',
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
                                'airflow_conv_density_0010') //'Mass Airflow',
                            , style: kSecondSubjectTextStyle,
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
                                              .translate(
                                              'airflow_conv_density_0020')
                                          // 'Pound per minute',
                                          , style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultAirflowAirDensityPoundPerMinute
                                                .toStringAsFixed(2),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitMassFlowRatePoundMinute,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'airflow_conv_density_0030')
                                          //  'Kilogram per second',
                                          ,style: kLabelTextStyleLarge,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                        DataCell(
                                          Text(
                                            (convertResultAirflowAirDensityPoundPerMinute *
                                                kPoundPerMinuteToKilogramPerSecond)
                                                .toStringAsFixed(2),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitMassFlowRateKilogramSecond,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                    ]),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Divider(height: 15.0, color: Colors.white),
                          Text(
                            AppLocalizations.of(context).translate(
                                'airflow_conv_density_0040') //'Volume Airflow',
                            , style: kSecondSubjectTextStyle,
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
                                              .translate(
                                              'airflow_conv_density_0050')
                                          //  'Cubic feet per minute',
                                         , style: kLabelTextStyleLarge,
                                          textScaleFactor:
                                          textScaleFactorTc * .9,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultAirflowAirDensityCfm
                                                .toStringAsFixed(1),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitVolumetricFlowRateCfm,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'airflow_conv_density_0060')
                                          // 'Cubic meter per minute',
                                         , style: kLabelTextStyleLarge,
                                          textScaleFactor:
                                          textScaleFactorTc * .9,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultAirflowAirDensityCubicMeterPerMinute
                                                .toStringAsFixed(3),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitVolumetricCubicMeterPerMinute,
                                            style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                              'airflow_conv_density_0070')
                                          //  'Cubic meter per second',
                                         , style: kLabelTextStyleLarge,
                                          textScaleFactor:
                                          textScaleFactorTc * .9,
                                        )),
                                        DataCell(
                                          Text(
                                            convertResultAirflowAirDensityCubicMeterPerSecond
                                                .toStringAsFixed(4),
                                            style:
                                            kResultNumberStyleWhite18_600,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            unitVolumetricCubicMeterPerSecond,
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

                                  calculateAirflowAirDensity(
                                      convertSliderResultAirflowAirDensityAll,
                                      vAirDensityAirflow,
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
                                            debugPrint(
                                                '- convertResultTemperatureFahrenheit $convertResultTemperatureFahrenheit');
                                            calculateAirflowAirDensity(
                                                convertSliderResultAirflowAirDensityAll,
                                                vAirDensityAirflow,
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
                                          debugPrint(
                                              '- convertResultTemperatureFahrenheit $convertResultTemperatureFahrenheit');
                                          calculateAirflowAirDensity(
                                              convertSliderResultAirflowAirDensityAll,
                                              vAirDensityAirflow,
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
                                            debugPrint(
                                                '+ convertSliderResultAirflowAirDensityAll $convertSliderResultAirflowAirDensityAll');
                                            calculateAirflowAirDensity(
                                                convertSliderResultAirflowAirDensityAll,
                                                vAirDensityAirflow,
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
                                          debugPrint(
                                              '+ convertSliderResultAirflowAirDensityAll $convertSliderResultAirflowAirDensityAll');
                                          calculateAirflowAirDensity(
                                              convertSliderResultAirflowAirDensityAll,
                                              vAirDensityAirflow,
                                              radioValue);
                                        }
                                      });
                                    }),
                              ),
                            ],
                          ),
                          //Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: [
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
                                  Text(AppLocalizations.of(context).translate(
                                      'airflow_conv_density_0080')
                                      //'Mass Airflow',
                                     , style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Radio<int>(
                                        value: 1,
                                        groupValue: radioValue,
                                        activeColor: Colors.white,
                                        onChanged: handleRadioValueChanged,
                                      ),
                                      Text(AppLocalizations.of(context)
                                          .translate(
                                          'airflow_conv_density_0090') //'CFM',
                                          ,textScaleFactor: textScaleFactorTc),
                                    ],
                                  ),
                                  Text(AppLocalizations.of(context).translate(
                                      'airflow_conv_density_0100')
                                      //'Volume Airflow',
                                      ,style: kLabelTextStyle,
                                      textScaleFactor: textScaleFactorTc),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Divider(height: 10.0, color: Colors.white),

                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    // // color: Colors.red,
                                    //width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.red,
                                          width: kInputTextWidth,
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                'airflow_conv_density_0110')
                                            //'Air Density',
                                            ,style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: kInputNumberWidth,
                                              // color: Colors.blue,
                                              child: Text(
                                                vAirDensityAirflow
                                                    .toStringAsFixed(3),
                                                style:
                                                kResultNumberStyleWhite18_600,
                                                textScaleFactor:
                                                textScaleFactorTc,
                                              ),
                                            ),
                                            Container(
                                              width: kInputUnitWidth + 20,
                                              // color: Colors.orange,
                                              child: Text(
                                                unitAirDensityAirflow,
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
                                                    Duration(
                                                        milliseconds: tapTime),
                                                        (t) {
                                                      setState(() {
                                                        if ((Decimal.parse(
                                                            vAirDensityAirflow
                                                                .toStringAsFixed(
                                                                2)) >
                                                            (Decimal.parse(
                                                                kMinAirDensityAirflow
                                                                    .toStringAsFixed(
                                                                    2))))) {
                                                          vAirDensityAirflow =
                                                              vAirDensityAirflow -
                                                                  stepAirDensityAirflow;

                                                          calculateAirflowAirDensity(
                                                              convertSliderResultAirflowAirDensityAll,
                                                              vAirDensityAirflow,
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
                                                      vAirDensityAirflow
                                                          .toStringAsFixed(
                                                          2)) >
                                                      (Decimal.parse(
                                                          kMinAirDensityAirflow
                                                              .toStringAsFixed(
                                                              2))))) {
                                                    vAirDensityAirflow =
                                                        vAirDensityAirflow -
                                                            stepAirDensityAirflow;

                                                    calculateAirflowAirDensity(
                                                        convertSliderResultAirflowAirDensityAll,
                                                        vAirDensityAirflow,
                                                        radioValue);
                                                  }
                                                });
                                              },
                                            ),
                                            StepButtonClose(
                                              icon: FontAwesomeIcons.plus,
                                              onStepPress: () {
                                                timer = Timer.periodic(
                                                    Duration(
                                                        milliseconds: tapTime),
                                                        (t) {
                                                      setState(() {
                                                        if ((Decimal.parse(
                                                            vAirDensityAirflow
                                                                .toStringAsFixed(
                                                                2)) <
                                                            (Decimal.parse(
                                                                kMaxAirDensityAirflow
                                                                    .toStringAsFixed(
                                                                    2))))) {
                                                          vAirDensityAirflow =
                                                              vAirDensityAirflow +
                                                                  stepAirDensityAirflow;

                                                          calculateAirflowAirDensity(
                                                              convertSliderResultAirflowAirDensityAll,
                                                              vAirDensityAirflow,
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
                                                      vAirDensityAirflow
                                                          .toStringAsFixed(
                                                          2)) <
                                                      (Decimal.parse(
                                                          kMaxAirDensityAirflow
                                                              .toStringAsFixed(
                                                              2))))) {
                                                    vAirDensityAirflow =
                                                        vAirDensityAirflow +
                                                            stepAirDensityAirflow;

                                                    calculateAirflowAirDensity(
                                                        convertSliderResultAirflowAirDensityAll,
                                                        vAirDensityAirflow,
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
                          Divider(height: 10.0, color: Colors.white),
                        ],
                      ),
                    ), //PSI slider
                    // Divider(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  //alignment: Alignment.,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'NTP: At 68 ºF, 14.7 psi, Dry Air density is 0.075 lbs/f^3 and for 20 ºC, 1.013 bar, Dry Air density is also 0.075 lbs/f^3 ',
                        style: kBodyItalicTextStyle,
                        textScaleFactor: textScaleFactorTc * 0.8,
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'This calculation is an approximation by using "Air Density" for conversion between Mass Airflow and Volume Airflow. The formulas are most accurate at low temperature and pressure values. Please use the "Airflow Conversion with Gas Law formula" if you need a more accurate calculation.',
                        style: kBodyItalicTextStyle,
                        textScaleFactor: textScaleFactorTc * 0.8,
                      ),
                      SizedBox(
                        height: 5,
                      ),
//                      Text(
//                        '1 Standard Atm = 14.6959488 psi = 1.01325 bar = 29.92 inHg = 101.325 kpa',
//                        style: kBodyItalicTextStyle,
//                        textScaleFactor: textScaleFactorTc * 0.8,
//                      ),
                    ],
                  ),
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

          vAirflowResultDecimals = 2;

          convertSliderHeaderAirflowAirDensityTextAll =
          'Pound per Minute - lbs/min';
          unitSliderConvertAirflowAirDensityAll = 'lbs/min';
          convertSliderResultAirflowAirDensityAll =
              kResetValueAirflowAirDensityPoundPerMinute;
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
          convertResultAirflowAirDensityCubicMeterPerMinute =
              convertResultAirflowAirDensityCfm *
                  kAirflowDensityCfmToCubicMeterPerMinute;
          convertResultAirflowAirDensityCubicMeterPerSecond =
              convertResultAirflowAirDensityCfm *
                  kAirflowDensityCfmToCubicMeterPerSecond;

          print(
              '0 convertSliderResultAirflowAirDensityAll $convertSliderResultAirflowAirDensityAll');
          print(
              '0 kMinSliderConvertAirflowAirDensityAll $kMinSliderConvertAirflowAirDensityAll');
          print(
              '0 kMaxSliderConvertAirflowAirDensityAll $kMaxSliderConvertAirflowAirDensityAll');
          print(
              '0 convertSliderResultAirflowAirDensityAll $convertSliderResultAirflowAirDensityAll');
          print(
              '0 sliderSliderConvertAirflowAirDensityAll $sliderSliderConvertAirflowAirDensityAll');
          print(
              '0 stepSliderConvertAirflowAirDensityAll $stepSliderConvertAirflowAirDensityAll');
          print(
              '0 vMinSliderConvertAirflowAirDensityAllStepper $vMinSliderConvertAirflowAirDensityAllStepper');
          print(
              '0 vMaxSliderConvertAirflowAirDensityAllStepper $vMaxSliderConvertAirflowAirDensityAllStepper');
          print(
              '0 kMaxConvertAirflowAirDensityPoundPerMinute $kMaxConvertAirflowAirDensityPoundPerMinute');
          print(
              '0 kMaxConvertAirflowAirDensityCfm $kMaxConvertAirflowAirDensityCfm');
          print(
              '0 kMaxConvertAirflowAirDensityCubicCentemeter $kMaxConvertAirflowAirDensityCubicMeterPerMinute');
          print(
              '0 kMaxConvertAirflowAirDensityCubicMeterPerSecond $kMaxConvertAirflowAirDensityCubicMeterPerSecond');
          // if(convertResultAirflowAirDensityPoundPerMinute>kMaxSliderConvertAirflowAirDensityAll){
          //   convertResultAirflowAirDensityPoundPerMinute = kMaxSliderConvertAirflowAirDensityAll;
          // }

          break;

        case 1:
          labelTextStyleResult0 = kLabelTextStyle;
          labelTextStyleResult1 = kLabelTextStyleActive;
          labelTextStyleResult2 = kLabelTextStyle;
          labelTextStyleResult3 = kLabelTextStyle;

          vAirflowResultDecimals = 1;

          convertSliderHeaderAirflowAirDensityTextAll =
          'Cubic Feet per Inch - CFM';
          unitSliderConvertAirflowAirDensityAll = 'cfm';
          convertSliderResultAirflowAirDensityAll =
              kResetValueAirFlowAirDensityCFM;
          vMinSliderConvertAirflowAirDensityAllStepper =
              vMinConvertAirflowAirDensityCfm;
          vMaxSliderConvertAirflowAirDensityAllStepper =
              vMaxConvertAirflowAirDensityCfm;
          kMinSliderConvertAirflowAirDensityAll =
              kMinConvertAirflowAirDensityCfm;
          kMaxSliderConvertAirflowAirDensityAll =
              kMaxConvertAirflowAirDensityCfm;

          sliderSliderConvertAirflowAirDensityAll =
              sliderConvertAirflowAirDensityCfm;
          stepSliderConvertAirflowAirDensityAll =
              stepConvertAirflowAirDensityCfm;
          convertResultAirflowAirDensityCubicMeterPerMinute =
              convertResultAirflowAirDensityCfm *
                  kAirflowDensityCfmToCubicMeterPerMinute;
          convertResultAirflowAirDensityCubicMeterPerSecond =
              convertResultAirflowAirDensityCfm *
                  kAirflowDensityCfmToCubicMeterPerSecond;

          print(
              '1 convertSliderResultAirflowAirDensityAll $convertSliderResultAirflowAirDensityAll');
          print(
              '1 kMinSliderConvertAirflowAirDensityAll $kMinSliderConvertAirflowAirDensityAll');
          print(
              '1 kMaxSliderConvertAirflowAirDensityAll $kMaxSliderConvertAirflowAirDensityAll');
          print(
              '1 convertSliderResultAirflowAirDensityAll $convertSliderResultAirflowAirDensityAll');
          print(
              '1 sliderSliderConvertAirflowAirDensityAll $sliderSliderConvertAirflowAirDensityAll');
          print(
              '1 stepSliderConvertAirflowAirDensityAll $stepSliderConvertAirflowAirDensityAll');
          print(
              '0 vMinSliderConvertAirflowAirDensityAllStepper $vMinSliderConvertAirflowAirDensityAllStepper');
          print(
              '0 vMaxSliderConvertAirflowAirDensityAllStepper $vMaxSliderConvertAirflowAirDensityAllStepper');
          print(
              '1 kMaxConvertAirflowAirDensityPoundPerMinute $kMaxConvertAirflowAirDensityPoundPerMinute');
          print(
              '1 kMaxConvertAirflowAirDensityCfm $kMaxConvertAirflowAirDensityCfm');
          print(
              '1 kMaxConvertAirflowAirDensityCubicMeterPerMinute $kMaxConvertAirflowAirDensityCubicMeterPerMinute');
          print(
              '1 kMaxConvertAirflowAirDensityCubicMeterPerSecond $kMaxConvertAirflowAirDensityCubicMeterPerSecond');
          // if(convertResultAirflowAirDensityCfm>kMaxSliderConvertAirflowAirDensityAll){
          //   kMaxSliderConvertAirflowAirDensityAll = kMaxConvertAirflowAirDensityCfm;
          //}

          break;
      }
      print('radioValue $radioValue');
    });
  }

  calculateAirflowAirDensity(double convertSliderResultAirflowAirDensityAll,
      double vAirDensityAirflow, int radioValue) {
    setState(() {
      switch (radioValue) {
        case 0:
          convertResultAirflowAirDensityPoundPerMinute =
              convertSliderResultAirflowAirDensityAll;
          convertResultAirflowAirDensityCfm = calculate.calcAirflow(
              convertSliderResultAirflowAirDensityAll,
              vAirDensityAirflow,
              'AirflowAirDensityPoundPerMinuteToCfm');

          var cFmMinute = convertResultAirflowAirDensityCfm;
          var cFmSecond = convertResultAirflowAirDensityCfm;

          convertResultAirflowAirDensityCubicMeterPerMinute =
              cFmMinute * kAirflowDensityCfmToCubicMeterPerMinute;
          convertResultAirflowAirDensityCubicMeterPerSecond =
              cFmSecond * kAirflowDensityCfmToCubicMeterPerSecond;

          break;
        case 1:
          convertResultAirflowAirDensityCfm =
              convertSliderResultAirflowAirDensityAll;
          convertResultAirflowAirDensityPoundPerMinute = calculate.calcAirflow(
              convertSliderResultAirflowAirDensityAll,
              vAirDensityAirflow,
              'AirflowAirDensityCfmToPoundPerMinute');

          var cFmMinute = convertResultAirflowAirDensityCfm;
          var cFmSecond = convertResultAirflowAirDensityCfm;

          convertResultAirflowAirDensityCubicMeterPerMinute =
              cFmMinute * kAirflowDensityCfmToCubicMeterPerMinute;
          convertResultAirflowAirDensityCubicMeterPerSecond =
              cFmSecond * kAirflowDensityCfmToCubicMeterPerSecond;

          break;
      }
    });
  }

  void resetValues() {
    setState(() {
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

      calculateAirflowAirDensity(
          convertSliderResultAirflowAirDensityAll, vAirDensityAirflow, 0);
      convertResultAirflowAirDensityCubicMeterPerMinute =
          convertResultAirflowAirDensityCfm *
              kAirflowDensityCfmToCubicMeterPerMinute;
      convertResultAirflowAirDensityCubicMeterPerSecond =
          convertResultAirflowAirDensityCfm *
              kAirflowDensityCfmToCubicMeterPerSecond;
    });
  }
}
