import 'package:tct//globals/constant.dart';
import 'package:tct//globals/global_variables.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/settings_provider.dart';
import '../../data_models/turbo_db.dart';
import 'package:tct//globals/constants_ui.dart';

class TurboPageMapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TurboDb> reports = Provider.of<List<TurboDb>>(context);
    SettingsNotifier settings =
        Provider.of<SettingsNotifier>(context, listen: false);

    return Scaffold(
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
              'TCT selection tool',
              style: kAppBarTextStyle,
              textScaleFactor: textScaleFactorTc,
            ),
            SizedBox(width: 30.0),
          ])),
      body: Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) => Container(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    settings.selectedTurbo.aaBrandName.toString(),
                    style: kSecondSubjectTextStyleActive,
                  ),
                  Text(
                    settings.selectedTurbo.aaTurboModel.toString(),
                    style: kSecondSubjectTextStyleActive,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FlipCard(
                direction: FlipDirection.HORIZONTAL,
                speed: 1500,
                onFlipDone: (status) {
                  print(status);
                },
                front: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              color: Colors.white70,
                              width: MediaQuery.of(context).size.width / 2,
                              height: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Series:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              settings.selectedTurbo
                                                  .aaTurboBranchModel
                                                  .toString(),
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
//                                mainAxisAlignment:
//                                MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Horsepower:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              settings.selectedTurbo.hpMin
                                                      .toString() +
                                                  unitHorsePower +
                                                  '  -  ',
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                            Text(
                                              settings.selectedTurbo.hpMax
                                                      .toString() +
                                                  unitHorsePower,
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Compressor Inducer:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              ((settings.selectedTurbo
                                                              .compressorInducer) /
                                                          10)
                                                      .toString() +
                                                  ' ' +
                                                  unitLengthMillimeter,
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Compressor Exducer:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                              .compressorExducer /
                                                          10)
                                                      .toString() +
                                                  ' ' +
                                                  unitLengthMillimeter,
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Turbine Inducer:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                              .turbineInducer /
                                                          10)
                                                      .toString() +
                                                  ' ' +
                                                  unitLengthMillimeter,
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Turbine Exducer:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                              .turbineExducer /
                                                          10)
                                                      .toString() +
                                                  ' ' +
                                                  unitLengthMillimeter,
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'A/R Compressor:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                      .arCompressor)
                                                  .toString(),
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'A/R Turbine:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo.arTurbine)
                                                  .toString(),
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'SC:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                      .mapStatusCompressor)
                                                  .toString(),
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'ST:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                      .mapStatusTurbine)
                                                  .toString(),
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Inlet Temperature:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              settings.selectedTurbo
                                                      .inletTempCelsius
                                                      .toString() +
                                                  ' ' +
                                                  settings.selectedTurbo
                                                      .inletTempUnit,
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Inlet Preassure:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                          .inletPressure)
                                                      .toString() +
                                                  ' ' +
                                                  settings.selectedTurbo
                                                      .inletPressureUnit,
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Compressor Trim:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                      .compressorTrim)
                                                  .toString(),
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Turbine Exducer:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                      .turbineTrim)
                                                  .toString(),
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Displacement Min:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                          .displacementMin)
                                                      .toString() +
                                                  ' ' +
                                                  unitVolumeLiter,
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    //***********************************************************
                                    Divider(color: Colors.white),
                                    Column(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Features:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                      .keyFeaturesText)
                                                  .toString(),
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    //***********************************************************
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Country HQ:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                      .countryCompany)
                                                  .toString(),
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'Adress:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              'Adress text x 5',
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                child: Text(
                                                  'City:',
                                                  style: kLabelTextStyleBlack,
                                                  textScaleFactor:
                                                      textScaleFactorTc,
                                                )),
                                            Text(
                                              (settings.selectedTurbo
                                                          .displacementMax)
                                                      .toString() +
                                                  ' ' +
                                                  unitVolumeLiter,
                                              style: kLabelTextStyleBlack,
                                              textScaleFactor:
                                                  textScaleFactorTc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                color: Color(0xFF006666),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: Image.network(
                                '${settings.selectedTurbo.imgTurboPic}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Image.network(
                            '${settings.selectedTurbo.imgBrandLogo}',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.white70,
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Series:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      settings.selectedTurbo.aaTurboBranchModel
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
//                                mainAxisAlignment:
//                                MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Horsepower:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      settings.selectedTurbo.hpMin.toString() +
                                          unitHorsePower +
                                          '  -  ',
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                    Text(
                                      settings.selectedTurbo.hpMax.toString() +
                                          unitHorsePower,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Compressor Inducer:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      ((settings.selectedTurbo
                                                      .compressorInducer) /
                                                  10)
                                              .toString() +
                                          ' ' +
                                          unitLengthMillimeter,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Compressor Exducer:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo
                                                      .compressorExducer /
                                                  10)
                                              .toString() +
                                          ' ' +
                                          unitLengthMillimeter,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Turbine Inducer:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo.turbineInducer /
                                                  10)
                                              .toString() +
                                          ' ' +
                                          unitLengthMillimeter,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Turbine Exducer:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo.turbineExducer /
                                                  10)
                                              .toString() +
                                          ' ' +
                                          unitLengthMillimeter,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'A/R Compressor:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo.arCompressor)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'A/R Turbine:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo.arTurbine)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'SC:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo
                                              .mapStatusCompressor)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'ST:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo.mapStatusTurbine)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        child: Text(
                                      'Inlet Temperature:',
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    )),
                                    Text(
                                      settings.selectedTurbo.inletTempCelsius
                                              .toString() +
                                          ' ' +
                                          settings.selectedTurbo.inletTempUnit,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Inlet Preassure:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo.inletPressure)
                                              .toString() +
                                          ' ' +
                                          settings
                                              .selectedTurbo.inletPressureUnit,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Compressor Trim:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo.compressorTrim)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Turbine Exducer:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo.turbineTrim)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Displacement Min:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo.displacementMin)
                                              .toString() +
                                          ' ' +
                                          unitVolumeLiter,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            //***********************************************************
                            Divider(color: Colors.white),
                            Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Features:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo.keyFeaturesText)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            //***********************************************************
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Country HQ:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo.countryCompany)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'Adress:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      'Adress text x 5',
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        child: Text(
                                          'City:',
                                          style: kLabelTextStyleBlack,
                                          textScaleFactor: textScaleFactorTc,
                                        )),
                                    Text(
                                      (settings.selectedTurbo.displacementMax)
                                              .toString() +
                                          ' ' +
                                          unitVolumeLiter,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                back: Container(
                  child: Image.network(
                    '${settings.selectedTurbo.imgCompressorMap}',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          )),
          itemCount: 1,
        ),
      ),
    );
  }
}
