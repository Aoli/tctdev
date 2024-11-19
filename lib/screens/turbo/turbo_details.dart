import 'dart:async';
import 'package:Turbocharger/components/analytics_event.dart';
import 'package:Turbocharger/data_models/analytics_event_type.dart';
import 'package:Turbocharger/components/turbocharger_icons_icons.dart';
import 'package:Turbocharger/globals/app_localizations.dart';
import 'package:Turbocharger/globals/constant.dart';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../provider/settings_provider.dart';
import 'package:Turbocharger/globals/constants_ui.dart';

class TurboInfoPage extends StatefulWidget {
  @override
  _TurboInfoPageState createState() => _TurboInfoPageState();
}

class _TurboInfoPageState extends State<TurboInfoPage> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    List<Report> reports = Provider.of<List<Report>>(context);
    SettingsNotifier settings =
        Provider.of<SettingsNotifier>(context, listen: false);

    //  List<TurbineDb> turbineData = Provider.of<List<TurbineDb>>(context);
//    reports =  Provider.of<List<TurbineDb>>(context).where((list) => settingsProvider.brandNameList.contains(list.turboModel)).toList() ?? Provider.of<List<TurbineDb>>(context);

    //  print(turbineData.length);
    String turboAnalyticsBrand = settings.selectedTurbo.aaBrandName;
    String turboAnalyticsModel = settings.selectedTurbo.aaTurboModel;
    turboModel = turboAnalyticsModel;

    String turboAnalytics = turboAnalyticsBrand + ' ' + turboAnalyticsModel;

    var flag = settings.selectedTurbo.countryCompany.toLowerCase() + '.png';
//    var feedBackLink = settings.selectedTurbo.zTctFeedbackLink;
//    var addTurbos =
//        'https://docs.google.com/forms/d/e/1FAIpQLSeiV8Q0U-7uCUpEYOJrOiTDhRIYuGP_4rhvvg477jCk4eQwVw/viewform?usp=sf_link';

    final Completer<WebViewController> _controller =
        Completer<WebViewController>();

    final controller = PageController(
      initialPage: 1,
    );

//    Final pageView = PageView(
//      controller: controller,
//      children: [
//        MyPage1Widget(),
//        MyPage1Widget(),
//      ],
//    );

    horsepowerSizeToAnalytics(settings);

    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
          // backgroundColor: Colors.white,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              settings.selectedTurbo.aaBrandName.toString(),
              style: kSecondSubjectTextStyle,
              textScaleFactor: textScaleFactorTc * .9,
            ),

            Text(
              settings.selectedTurbo.aaTurboModel.toString(),
              style: kSecondSubjectTextStyle,
              textScaleFactor: textScaleFactorTc * .9,
            ),
            //SizedBox(width: 30.0),
          ])),
      body: Center(
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.white),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  FlipCard(
                    key: cardKey,
                    direction: FlipDirection.HORIZONTAL,
                    flipOnTouch: false,
                    speed: 800,
//                              onFlipDone: (status) {
//                                print(status);
//                              },
                    front: frontSide(context, settings, tableRowHeight, flag,
                        feedBackLink, turboAnalytics, addTurbos),
                    back: backSide(context, settings),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget frontSide(context, settings, tableRowHeight, flag, feedBackLink,
      turboAnalytics, addTurbos) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: Image.network(
                        '${settings?.selectedTurbo?.imgBrandLogo}',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      settings.selectedTurbo.aaTurboBranchModel.toString(),
                      style: kSecondSubjectTextStyleActiveBlack,
                      textScaleFactor: textScaleFactorTc,
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.network(
                    '${settings?.selectedTurbo?.imgTurboPic}',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
//            Text(
//              turbineData.selectedTurbo.aaTurboModel
//                  .toString(),
//              style: kSecondSubjectTextStyleActiveBlack,
//              textScaleFactor: textScaleFactorTc,
//            ),
//            Text(
//              turbineData.selectedTurbo.divided
//                  .toString(),
//              style: kSecondSubjectTextStyleActiveBlack,
//              textScaleFactor: textScaleFactorTc,
//            ),
            Divider(
              thickness: 0.2,
              color: Colors.black45,
            ),
            Container(
              //   color: Color(0xFFFFFFFF),
              //color: Colors.white,
              width: MediaQuery.of(context).size.width,
              //  height: MediaQuery.of(context).size.longestSide,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Divider(color: Colors.blue),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        horizontalMargin: 0,
                        headingRowHeight: 25,
                        columnSpacing: 30,
                        dataRowHeight: tableRowHeight,
                        columns: [
                          DataColumn(
                              label: Text(
                                AppLocalizations.of(context).translate('turbo_details_0000')// 'Compressor',
                           , style: TextStyle(color: Colors.white),
                            textScaleFactor: textScaleFactorTc * 1.3,
                          )),
                          DataColumn(
                              numeric: true,
                              label: Text(
                                AppLocalizations.of(context).translate('turbo_details_0010')//'Min',
                               , style: kLabelTextStyleBlackBold,
                                textScaleFactor: textScaleFactorTc * 1.3,
                              )),
                          DataColumn(
                              numeric: true,
                              label: Text(
                                AppLocalizations.of(context).translate('turbo_details_0020')// 'Max',
                                ,style: kLabelTextStyleBlackBold,
                                textScaleFactor: textScaleFactorTc * 1.3,
                              )),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(settings.selectedTurbo.hpMax == 0
                                ? Container()
                                : Text(
                              AppLocalizations.of(context).translate('turbo_details_0030')//'Horsepower',
                                   , style: kLabelTextStyleBlackBold,
                                    textScaleFactor: textScaleFactorTc,
                                  )),
                            DataCell(
                              settings.selectedTurbo.hpMin == 0
                                  ? Container()
                                  : Text(
                                      settings.selectedTurbo.hpMin.toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                            DataCell(
                              settings.selectedTurbo.hpMax == 0
                                  ? Container()
                                  : Text(
                                      settings.selectedTurbo.hpMax.toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(settings.selectedTurbo.displacementMax == 0
                                ? Container()
                                : Text(
                              AppLocalizations.of(context).translate('turbo_details_0040')// 'Displacement',
                                    ,style: kLabelTextStyleBlackBold,
                                    textScaleFactor: textScaleFactorTc,
                                  )),
                            DataCell(
                              settings.selectedTurbo.displacementMax == 0
                                  ? Container()
                                  : Text(
                                      (settings.selectedTurbo.displacementMin /
                                                  100)
                                              .toString() +
                                          ' ' +
                                          unitVolumeLiter,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                            DataCell(
                              settings.selectedTurbo.displacementMax == 0
                                  ? Container()
                                  : Text(
                                      (settings.selectedTurbo.displacementMax /
                                                  100)
                                              .toString() +
                                          ' ' +
                                          unitVolumeLiter,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              '',
                              style: kLabelTextStyleBlackBold,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              settings.selectedTurbo.displacementMin == 0
                                  ? Container()
                                  : Text(
                                      ((settings.selectedTurbo.displacementMin /
                                                      100) *
                                                  kConvertVolumeLiterToCubicInch)
                                              .toStringAsFixed(0)
                                              .toString() +
                                          ' ' +
                                          unitVolumeCubicInch,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                            DataCell(
                              settings.selectedTurbo.displacementMax == 0
                                  ? Container()
                                  : Text(
                                      ((settings.selectedTurbo.displacementMax /
                                                      100) *
                                                  kConvertVolumeLiterToCubicInch)
                                              .toStringAsFixed(0) +
                                          ' ' +
                                          unitVolumeCubicInch,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                          ]),
                        ]),
                  ),
                  // Divider(color: Colors.red),
                  settings.selectedTurbo.mapStatusCompressor == false
                      ? Container(
                          child: Divider(
                            thickness: 0.2,
                            color: Colors.black45,
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            SizedBox(height: 8),
                            Column(
                              children: <Widget>[
                                Container(
                                  child: RaisedButton(
                                    color: kActiveCardColourOutput,
                                    splashColor: Colors.blue,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0),
                                      side: BorderSide(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        var compressorTurboBrand = settings
                                            .selectedTurbo.aaBrandName
                                            .toString();

                                        var compressorTurboSeries = settings
                                            .selectedTurbo.aaTurboBranchModel
                                            .toString();

                                        var compressorMapBrandModel =
                                            compressorTurboBrand +
                                                ' ' +
                                                compressorTurboSeries;

                                        var _analyticsParameter = {
                                          'TurboRegCompMap':
                                              compressorMapBrandModel
                                        };
                                        // Execute a function to send logEvent() to Firebase Analytics
                                        Analytics.analyticsLogEvent(
                                            AnalyticsEventType.compressor_map,
                                            _analyticsParameter);

                                        print('compressorMapBrandModel $compressorMapBrandModel');

                                        cardKey.currentState.toggleCard();
                                      });
                                    },
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              child: CircleAvatar(
                                                radius: 10,
                                                backgroundColor:
                                                    kActiveCardColourOutput,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text('CM',
                                                        style: kLabelTextStyle,
                                                        textScaleFactor:
                                                            textScaleFactorTc *
                                                                .8),
                                                  ],
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              // borde width
                                              decoration: new BoxDecoration(
                                                color: const Color(0xFFFFFFFF),
                                                // border color
                                                shape: BoxShape.circle,
                                              )),
                                          SizedBox(width: 10),
                                          Text(
                                            AppLocalizations.of(context).translate('turbo_details_0050')//  'Compressor Map',
                                           , style: kLabelTextStyle,
                                            textScaleFactor: textScaleFactorTc,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        headingRowHeight: 25,
                        columnSpacing: 15,
                        dataRowHeight: tableRowHeight,
                        columns: [
                          DataColumn(
                              label: Text(
                            'Sort',
                            style: TextStyle(color: Colors.white),
                            textScaleFactor: textScaleFactorTc,
                          )),
                          DataColumn(
                              numeric: true,
                              label: Text(
                                AppLocalizations.of(context).translate('turbo_details_0060')//'Compressor',
                               , style: kLabelTextStyleBlackBold,
                                textScaleFactor: textScaleFactorTc * 1.3,
                              )),
                          DataColumn(
                              numeric: true,
                              label: Text(
                                AppLocalizations.of(context).translate('turbo_details_0070')// 'Turbine',
                               , style: kLabelTextStyleBlackBold,
                                textScaleFactor: textScaleFactorTc * 1.3,
                              )),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(
                              AppLocalizations.of(context).translate('turbo_details_0080')//  'Inducer',
                             , style: kLabelTextStyleBlackBold,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              settings.selectedTurbo.compressorInducer == 0
                                  ? Text(
                                      kNotApplicable,
                                      textScaleFactor: textScaleFactorTc,
                                    )
                                  : Text(
                                      ((settings.selectedTurbo
                                                      .compressorInducer) /
                                                  100)
                                              .toString() +
                                          ' ' +
                                          unitLengthMillimeter,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                            DataCell(
                              settings.selectedTurbo.turbineInducer == 0
                                  ? Container()
                                  : Text(
                                      (settings.selectedTurbo.turbineInducer /
                                                  100)
                                              .toString() +
                                          ' ' +
                                          unitLengthMillimeter,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                          ]),
                          DataRow(selected: false, cells: [
                            DataCell(Text(
                              '',
                              style: kLabelTextStyleBlack,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              settings.selectedTurbo.compressorInducer == 0
                                  ? Text(
                                      kNotApplicable,
                                      textScaleFactor: textScaleFactorTc,
                                    )
                                  : Text(
                                      (((settings.selectedTurbo
                                                          .compressorInducer) /
                                                      100) *
                                                  kConvertLengthMillimeterToInch)
                                              .toStringAsFixed(2) +
                                          ' ' +
                                          unitLengthInch,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                            DataCell(
                              settings.selectedTurbo.turbineInducer == 0
                                  ? Container()
                                  : Text(
                                      ((settings.selectedTurbo.turbineInducer /
                                                      100) *
                                                  kConvertLengthMillimeterToInch)
                                              .toStringAsFixed(2) +
                                          ' ' +
                                          unitLengthInch,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              '',
                              style: kLabelTextStyleBlackBold,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              Text(
                                '',
                                style: kLabelTextStyleBlack,
                                textScaleFactor: textScaleFactorTc,
                              ),
                            ),
                            DataCell(
                              Text(
                                '',
                                style: kLabelTextStyleBlack,
                                textScaleFactor: textScaleFactorTc,
                              ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              AppLocalizations.of(context).translate('turbo_details_0090')// 'Exducer',
                            ,  style: kLabelTextStyleBlackBold,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              settings.selectedTurbo.compressorExducer == 0
                                  ? Text(
                                      kNotApplicable,
                                      textScaleFactor: textScaleFactorTc,
                                    )
                                  : Text(
                                      (settings.selectedTurbo
                                                      .compressorExducer /
                                                  100)
                                              .toString() +
                                          ' ' +
                                          unitLengthMillimeter,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                            DataCell(
                              settings.selectedTurbo.turbineExducer == 0
                                  ? Container()
                                  : Text(
                                      (settings.selectedTurbo.turbineExducer /
                                                  100)
                                              .toString() +
                                          ' ' +
                                          unitLengthMillimeter,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              '',
                              style: kLabelTextStyleBlack,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              settings.selectedTurbo.compressorExducer == 0
                                  ? Container()
                                  : Text(
                                      ((settings.selectedTurbo
                                                          .compressorExducer /
                                                      100) *
                                                  kConvertLengthMillimeterToInch)
                                              .toStringAsFixed(2) +
                                          ' ' +
                                          unitLengthInch,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                            DataCell(
                              settings.selectedTurbo.turbineExducer == 0
                                  ? Container()
                                  : Text(
                                      ((settings.selectedTurbo.turbineExducer /
                                                      100) *
                                                  kConvertLengthMillimeterToInch)
                                              .toStringAsFixed(2) +
                                          ' ' +
                                          unitLengthInch,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              '',
                              style: kLabelTextStyleBlackBold,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              Text(
                                '',
                                style: kLabelTextStyleBlack,
                                textScaleFactor: textScaleFactorTc,
                              ),
                            ),
                            DataCell(
                              Text(
                                '',
                                style: kLabelTextStyleBlack,
                                textScaleFactor: textScaleFactorTc,
                              ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              AppLocalizations.of(context).translate('turbo_details_0100')// 'Trim',
                            ,  style: kLabelTextStyleBlackBold,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              settings.selectedTurbo.compressorTrim == 0
                                  ? Text(
                                      kNotApplicable,
                                      textScaleFactor: textScaleFactorTc,
                                    )
                                  : Text(
                                      (settings.selectedTurbo.compressorTrim)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                            DataCell(
                              settings.selectedTurbo.turbineTrim == 0
                                  ? Text(
                                      kNotApplicable,
                                      textScaleFactor: textScaleFactorTc,
                                    )
                                  : Text(
                                      (settings.selectedTurbo.turbineTrim)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              AppLocalizations.of(context).translate('turbo_details_0110')// 'A/R',
                            ,  style: kLabelTextStyleBlackBold,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              settings.selectedTurbo.compressorAR == 0
                                  ? Text(
                                      kNotApplicable,
                                      textScaleFactor: textScaleFactorTc,
                                    )
                                  : Text(
                                      (settings.selectedTurbo.compressorAR /
                                              100)
                                          .toStringAsFixed(2),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                            DataCell(
                              settings.selectedTurbo.turbineAR == 0
                                  ? Text(
                                      kNotApplicable,
                                      textScaleFactor: textScaleFactorTc,
                                    )
                                  : Text(
                                      (settings.selectedTurbo.turbineAR / 100)
                                          .toStringAsFixed(2),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              '',
                              style: kLabelTextStyleBlackBold,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              Text(
                                '',
                                style: kLabelTextStyleBlack,
                                textScaleFactor: textScaleFactorTc,
                              ),
                            ),
                            DataCell(
                              Text(
                                '',
                                style: kLabelTextStyleBlack,
                                textScaleFactor: textScaleFactorTc,
                              ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              AppLocalizations.of(context).translate('turbo_details_0120')// 'Inlet',
                             , style: kLabelTextStyleBlackBold,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(Text(
                              '',
                              style: kLabelTextStyleBlack,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              settings.selectedTurbo.turbineInlet == ""
                                  ? Text(
                                      kNotApplicable,
                                      textScaleFactor: textScaleFactorTc,
                                    )
                                  : Text(
                                      settings.selectedTurbo.turbineInlet,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              AppLocalizations.of(context).translate('turbo_details_0130')// 'Outlet',
                            ,  style: kLabelTextStyleBlackBold,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(Text(
                              '',
                              style: kLabelTextStyleBlack,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(Text(
                              '',
                              style: kLabelTextStyleBlack,
                              textScaleFactor: textScaleFactorTc,
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              AppLocalizations.of(context).translate('turbo_details_0140')//  'Scroll',
                           ,   style: kLabelTextStyleBlackBold,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(Text(
                              '',
                              style: kLabelTextStyleBlack,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              settings.selectedTurbo.turbineScroll == ""
                                  ? Text(
                                      kNotApplicable,
                                      textScaleFactor: textScaleFactorTc,
                                    )
                                  : Text(
                                      settings.selectedTurbo.turbineScroll,
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              AppLocalizations.of(context).translate('turbo_details_0150')//  'Wastegate',
                             , style: kLabelTextStyleBlackBold,
                              textScaleFactor: textScaleFactorTc,
                            )),
                            DataCell(
                              settings.selectedTurbo.turbineWastegate == ""
                                  ? Text(
                                      kNotApplicable,
                                      textScaleFactor: textScaleFactorTc,
                                    )
                                  : Text(
                                      '',
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc,
                                    ),
                            ),
                            DataCell(Text(
                              settings.selectedTurbo.turbineWastegate,
                              style: kLabelTextStyleBlack,
                              textScaleFactor: textScaleFactorTc,
                            )),
                          ]),
                        ]),
                  ),
//                            Divider(color: Colors.grey),
                  //Divider(color: Colors.white),

                  Divider(color: Colors.grey),

                  settings.selectedTurbo.keyFeature_0 == ""
                      ? Container()
                      : Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5),
                            SizedBox(height: 5),
                            settings.selectedTurbo.keyFeature_0 == ""
                                ? Container()
                                : ListTile(
                                    leading: Icon(
                                      TurbochargerIcons.iconturbo2048px,
                                      color: Colors.black54,
                                      size: 17,
                                    ),
                                    title: Text(
                                      (settings.selectedTurbo.keyFeature_0)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc * 0.85,
                                    ),
                                  ),
                            settings.selectedTurbo.keyFeature_1 == ""
                                ? Container()
                                : ListTile(
                                    leading: Icon(
                                      TurbochargerIcons.iconturbo2048px,
                                      color: Colors.black54,
                                      size: 17,
                                    ),
                                    title: Text(
                                      (settings.selectedTurbo.keyFeature_1)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc * 0.85,
                                    ),
                                  ),
                            settings.selectedTurbo.keyFeature_2 == ""
                                ? Container()
                                : ListTile(
                                    leading: Icon(
                                      TurbochargerIcons.iconturbo2048px,
                                      color: Colors.black54,
                                      size: 17,
                                    ),
                                    title: Text(
                                      (settings.selectedTurbo.keyFeature_2)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc * 0.85,
                                    ),
                                  ),
                            settings.selectedTurbo.keyFeature_3 == ""
                                ? Container()
                                : ListTile(
                                    leading: Icon(
                                      TurbochargerIcons.iconturbo2048px,
                                      color: Colors.black54,
                                      size: 17,
                                    ),
                                    title: Text(
                                      (settings.selectedTurbo.keyFeature_3)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc * 0.85,
                                    ),
                                  ),
                            settings.selectedTurbo.keyFeature_4 == ""
                                ? Container()
                                : ListTile(
                                    leading: Icon(
                                      TurbochargerIcons.iconturbo2048px,
                                      color: Colors.black54,
                                      size: 17,
                                    ),
                                    title: Text(
                                      (settings.selectedTurbo.keyFeature_4)
                                          .toString(),
                                      style: kLabelTextStyleBlack,
                                      textScaleFactor: textScaleFactorTc * 0.85,
                                    ),
                                  ),
                          ],
                        ),
                ],
              ),
            ),
            settings.selectedTurbo.keyFeaturesText == ""
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
//                Text(
//                  'Features:',
//                  style: kLabelTextStyleBlackBold,
//                  textScaleFactor: textScaleFactorTc,
//                ),
                      SizedBox(height: 10),
                      Text(
                        settings.selectedTurbo.keyFeaturesText,
                        style: kLabelTextStyleBlack,
                        textScaleFactor: textScaleFactorTc * 0.85,
                      ),
                    ],
                  ),
            Divider(color: Colors.grey),

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      settings.selectedTurbo.tctInfoSource == ""
                          ? Container()
                          : Row(
                              children: <Widget>[
                                Text(AppLocalizations.of(context).translate('turbo_details_0160')//Info Source:,
                                   , style: kLabelTextStyleBlackBold,
                                    textScaleFactor: textScaleFactorTc),
                                Text(
                                  settings.selectedTurbo.tctInfoSource,
                                  style: kLabelTextStyleBlack,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                                SizedBox(height: 8),
                                Divider(color: Colors.black45),
                              ],
                            ),
                      Container(
                        //width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Image.network(
                                  '${settings.selectedTurbo.imgBrandLogo}',
                                  // fit: BoxFit.fitWidth,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage(
                                        'images/flags/$flag',
                                      ),
                                      fit: BoxFit.scaleDown,
//                                                width: MediaQuery.of(context).size.width/2,
//                      height: 40,
                                    ),
                                    Opacity(
                                      opacity: 0.5,
                                      child: Text(
                                        settings.selectedTurbo.countryCompany,
                                        style: kLabelTextStyleBlack,
                                        textScaleFactor: textScaleFactorTc,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(color: Colors.black45),
                      settings.selectedTurbo.zTurboCompanyReferenceLink == ""
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context).translate('turbo_details_0170')//'More info:',
                                ,  style: kLabelTextStyleBlack,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                                Opacity(
                                  opacity: 0.7,
                                  child: Text(
                                    settings.selectedTurbo
                                        .zTurboCompanyReferenceLink,
                                    style: kLabelTextStyleBlack,
                                    textScaleFactor: textScaleFactorTc,
                                  ),
                                ),
                              ],
                            ),
                      Divider(color: Colors.black45),
                      settings.selectedTurbo.tctComment == ""
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(AppLocalizations.of(context).translate('turbo_details_0180')//'Note: ',
                                   , style: kLabelTextStyleBlack,
                                    textScaleFactor: textScaleFactorTc),
                                Text(
                                  settings.selectedTurbo.tctComment,
                                  style: kBodyItalicTextStyleBlack,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                                Divider(color: Colors.black45),
                              ],
                            ),
                      Column(
                        children: <Widget>[
                          RaisedButton(
                            color: kActiveCardColourOutput,
                            splashColor: Colors.blue,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.blue),
                            ),
                            onPressed: () {
                              String turboAddAnalytics = settings
                                      .selectedTurbo.aaBrandName
                                      .toString() +
                                  ' ' +
                                  settings.selectedTurbo.aaTurboModel
                                      .toString();

                              var _analyticsParameter = {
                                'TurboErrorAdd': turboAddAnalytics
                              };
                              // Execute a function to send logEvent() to Firebase Analytics
                              Analytics.analyticsLogEvent(
                                  AnalyticsEventType.turbo_error_analytics,
                                  _analyticsParameter);

                              Navigator.of(context).pushNamed(
                                  "turbo_register_feedback",
                                  arguments: metricUnit);
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.bug_report,
                                    color: Colors.white,
                                    size: 20.0,
                                    semanticLabel: 'Report error button',
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    AppLocalizations.of(context).translate('turbo_details_0190')// 'Report errors or add info',
                                   , style: kLabelTextStyle,
                                    textScaleFactor: textScaleFactorTc,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          RaisedButton(
                            color: kActiveCardColourOutput,
                            splashColor: Colors.blue,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.blue),
                            ),
                            onPressed: () {
//                              Navigator.of(context)
//                                  .push(
//                                  MaterialPageRoute(
//                                      builder: (
//                                          context) =>
//                                          TurboSelectorFeedback(
//                                              feedbackLink:
//                                              addTurbos)));
                              String turboAddAnalytics = settings
                                      .selectedTurbo.aaBrandName
                                      .toString() +
                                  ' ' +
                                  settings.selectedTurbo.aaTurboModel
                                      .toString();

                              var _analyticsParameter = {
                                'TurboAdd': turboAddAnalytics
                              };
                              // Execute a function to send logEvent() to Firebase Analytics
                              Analytics.analyticsLogEvent(
                                  AnalyticsEventType.turbo_add_analytics,
                                  _analyticsParameter);

                              Navigator.of(context).pushNamed("turbo_add",
                                  arguments: metricUnit);
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    TurbochargerIcons.iconturbo2048px,
                                    color: Colors.white,
                                    size: 20.0,
                                    semanticLabel: 'Suggest a new turbo button',
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    AppLocalizations.of(context).translate('turbo_details_0200')// 'Suggest a missing turbo',
                                   , style: kLabelTextStyle,
                                    textScaleFactor: textScaleFactorTc,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      settings.selectedTurbo.zTctDisclaimer == ""
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context).translate('turbo_details_0210')// 'TCT Disclaimer:',
                                 , style: kLabelTextStyleBlack,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                                Text(
                                  AppLocalizations.of(context).translate('turbo_details_0220')// settings.selectedTurbo.zTctDisclaimer,
                                 , style: kBodyItalicTextStyleBlack,
                                  textScaleFactor: textScaleFactorTc,
                                ),
                              ],
                            ),
                      Divider(color: Colors.black45),
                      Text(
                        AppLocalizations.of(context).translate('turbo_details_0230')// settings.selectedTurbo.zTurboCompanyIntellectualPropertyDisclaimer,
                       , style: kBodyItalicTextStyleBlack,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget backSide(context, settings) {
    return Container(
      width: MediaQuery.of(context).size.width,
//      height:
//      MediaQuery
//          .of(context)
//          .size
//          .longestSide,
      child: Column(
        children: [
          Container(
            child: Image.network(
              '${settings.selectedTurbo.imgCompressorMap}',
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 8.0),
          Column(
            //  crossAxisAlignment:
            // CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  child: RaisedButton(
                    color: kActiveCardColourOutput,
                    splashColor: Colors.blue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.blue),
                    ),
                    onPressed: () => cardKey.currentState.toggleCard(),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20.0,
                            semanticLabel: 'Go back to details page',
                          ),
                          SizedBox(width: 10),
                          Text(
                            AppLocalizations.of(context).translate('turbo_details_0240')//  'Go back to details page',
                          ,  style: kLabelTextStyle,
                            textScaleFactor: textScaleFactorTc,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 5, right: 10, bottom: 15),
              child: Column(
                children: <Widget>[
                  Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate('turbo_details_0250')// 'Inlet Temperature:',
                       , style: kLabelTextStyleBlackBold,
                        textScaleFactor: textScaleFactorTc,
                      ),
                      Text(
                        settings.selectedTurbo.inletTempCelsius.toString() +
                            ' ' +
                            unitCelsius,
                        style: kLabelTextStyleBlack,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        ' ',
                        style: kLabelTextStyleBlackBold,
                        textScaleFactor: textScaleFactorTc,
                      ),
                      Text(
                        (settings.selectedTurbo.inletTempCelsius * 9 / 5 + 32)
                                .toStringAsFixed(0) +
                            ' ' +
                            unitFahrenheit,
                        style: kLabelTextStyleBlack,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  horsepowerSizeToAnalytics(settings) {
    setState(() {
      //******************************** Turbo Brand
      String turboBrand = settings.selectedTurbo.aaBrandName.toString();

      var _analyticsParameterTurboBrand = {'TurboRegBrand': turboBrand};
      // Execute a function to send logEvent() to Firebase Analytics
      Analytics.analyticsLogEvent(
          AnalyticsEventType.turbo_reg_brand, _analyticsParameterTurboBrand);

      //******************************** Turbo Series
      String turboSeries = settings.selectedTurbo.aaTurboBranchModel.toString();
      var turboBrandSeries = turboBrand + ' ' + turboSeries;

      var _analyticsParameterTurboSeries = {'TurboRegSeries': turboBrandSeries};
      // Execute a function to send logEvent() to Firebase Analytics
      Analytics.analyticsLogEvent(
          AnalyticsEventType.turbo_reg_series, _analyticsParameterTurboSeries);

      //******************************** Turbo Exact
      String turboModel = settings.selectedTurbo.aaTurboModel.toString();
      var turboExactTurbo = turboBrand + ' ' + turboModel;

      var _analyticsParameterTurboExact = {'TurboModel': turboExactTurbo};
      // Execute a function to send logEvent() to Firebase Analytics
      Analytics.analyticsLogEvent(AnalyticsEventType.turbo_reg_exact_turbo,
          _analyticsParameterTurboExact);

      //******************************** Turbo CompressorSize Number
      double turboCompressorInducerSize =
          settings.selectedTurbo.compressorInducer / 100;

      var _analyticsParameterTurboCompIndSize = {
        'TurboCompIndSize': turboCompressorInducerSize
      };
      // Execute a function to send logEvent() to Firebase Analytics
      Analytics.analyticsLogEvent(AnalyticsEventType.turbo_comp_ind_size_nr,
          _analyticsParameterTurboCompIndSize);

      //******************************** Turbo MaxHorsepower Number
      int turboHpMax = settings.selectedTurbo.hpMax;

      var _analyticsParameterTurboHpMaxNr = {'TurboHpMax': turboHpMax};
      // Execute a function to send logEvent() to Firebase Analytics
      Analytics.analyticsLogEvent(
          AnalyticsEventType.turbo_hp_max_nr, _analyticsParameterTurboHpMaxNr);

      //******************************** Turbo CompressorSize Text

      String turboCompressorInducerSizeText =
      (settings.selectedTurbo.compressorInducer / 100).toString();

      var _analyticsParameterTurboCompIndSizeText = {
        'TurboCompIndSizeText': turboCompressorInducerSizeText
      };
      // Execute a function to send logEvent() to Firebase Analytics
      Analytics.analyticsLogEvent(AnalyticsEventType.turbo_comp_ind_size_txt,
          _analyticsParameterTurboCompIndSizeText);

      //******************************** Turbo MaxHorsepower Text
      String turboHpMaxTxt = (settings.selectedTurbo.hpMax).toString();

      var _analyticsParameterTurboHpMaxText = {'TurboHpMaxText': turboHpMaxTxt};
      // Execute a function to send logEvent() to Firebase Analytics
      Analytics.analyticsLogEvent(
          AnalyticsEventType.turbo_hp_max_txt, _analyticsParameterTurboHpMaxText);

      //***********************************************************************

      print('Hp: ' + (settings.selectedTurbo.hpMax).toString());
      if (settings.selectedTurbo.hpMax < 1) {
        return null;
      } else if (settings.selectedTurbo.hpMax < 201) {
        var _analyticsParameter = {'TurboRegHp': '1 - 200 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
        print(settings.selectedTurbo.hpMax);
      } else if (settings.selectedTurbo.hpMax < 301) {
        var _analyticsParameter = {'TurboRegHp': '201 - 300 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
        print('201-400hp');
      } else if (settings.selectedTurbo.hpMax < 401) {
        var _analyticsParameter = {'TurboRegHp': '301 - 400 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
        print('600hp');
      } else if (settings.selectedTurbo.hpMax < 501) {
        var _analyticsParameter = {'TurboRegHp': '401 - 500 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
        print('800hp');
      } else if (settings.selectedTurbo.hpMax < 601) {
        var _analyticsParameter = {'TurboRegHp': '501 - 600 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
        print('1000hp');
      } else if (settings.selectedTurbo.hpMax < 701) {
        var _analyticsParameter = {'TurboRegHp': '601 - 700 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
        print('1200hp');
      } else if (settings.selectedTurbo.hpMax < 801) {
        var _analyticsParameter = {'TurboRegHp': '701 - 800 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
        print('1500hp');
      } else if (settings.selectedTurbo.hpMax < 901) {
        var _analyticsParameter = {'TurboRegHp': '801 - 900 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
        print('2000hp');
      } else if (settings.selectedTurbo.hpMax < 1001) {
        var _analyticsParameter = {'TurboRegHp': '901 - 1000 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
      } else if (settings.selectedTurbo.hpMax < 1201) {
        var _analyticsParameter = {'TurboRegHp': '1001 - 1200 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
      } else if (settings.selectedTurbo.hpMax < 1401) {
        var _analyticsParameter = {'TurboRegHp': '1201 - 1400 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
      } else if (settings.selectedTurbo.hpMax < 1601) {
        var _analyticsParameter = {'TurboRegHp': '1401 - 1600 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
      } else if (settings.selectedTurbo.hpMax < 2001) {
        var _analyticsParameter = {'TurboRegHp': '1601 - 2000 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
      } else if (settings.selectedTurbo.hpMax < 2501) {
        var _analyticsParameter = {'TurboRegHp': '2001 - 2500 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
      } else if (settings.selectedTurbo.hpMax < 3001) {
        var _analyticsParameter = {'TurboRegHp': '2501 - 3000 Hp'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
      } else if (settings.selectedTurbo.hpMax > 3001) {
        var _analyticsParameter = {'TurboRegHp': '3001 Hp and more'};
        // Execute a function to send logEvent() to Firebase Analytics
        Analytics.analyticsLogEvent(
            AnalyticsEventType.turbo_reg_horsepower, _analyticsParameter);
        print('3000hp');
      }
    });
  }
}
