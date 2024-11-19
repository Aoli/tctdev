import 'package:Turbocharger/components/analytics_event.dart';
import 'package:Turbocharger/data_models/analytics_event_type.dart';
import 'package:Turbocharger/components/reusable_card.dart';
import 'package:Turbocharger/components/turbocharger_icons_icons.dart';
import 'package:Turbocharger/globals/app_localizations.dart';
import 'package:Turbocharger/globals/constant.dart';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/settings_provider.dart';
import '../../data_models/turboDb.dart';
import 'package:Turbocharger/globals/constants_ui.dart';


class TurboSelection extends StatefulWidget {
  bool routeSetting;

  TurboSelection({Key key, @required this.routeSetting}) : super(key: key);

  @override
  _TurboSelectionState createState() => _TurboSelectionState(routeSetting);
}

class _TurboSelectionState extends State<TurboSelection> {
  bool routeSetting;

  _TurboSelectionState(this.routeSetting);

  ScrollController _controller;

  var list = true;
  var nrTurbo;

  @override
  Widget build(BuildContext context) {

    SettingsNotifier settingsProvider = Provider.of<SettingsNotifier>(context);
//    reports =  Provider.of<List<Report>>(context)
//        .where((list) => settingsProvider.brandNameList.contains(list.aaBrandName)).toList() ?? Provider.of<List<Report>>(context);

    List<TurboDb> reports = Provider.of<List<TurboDb>>(context);
    ScrollController _controller;
    _controller = ScrollController();

    _controller.addListener(_scrollListener);

//    var feedBackLink =
//        'https://docs.google.com/forms/d/e/1FAIpQLSeiV8Q0U-7uCUpEYOJrOiTDhRIYuGP_4rhvvg477jCk4eQwVw/viewform?usp=sf_link';

    return Scaffold(
      appBar: AppBar(
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
                AppLocalizations.of(context).translate('turbo_selection_0000')// 'TCT Turbo register'
               , style: kAppBarTextStyle,
                textScaleFactor: textScaleFactorTc * 0.9,
              ),
              Container(width: 30),
            ]),
        // actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.settings),
//            onPressed: () {
//              Navigator.of(context)
//                  .push(MaterialPageRoute(builder: (context) => Settings()));
//
//              const RouteSettings(name: 'Settings');
//            },
//          )
        // ],
      ),
      body: (settingsProvider == null)
          ? Center(child: CircularProgressIndicator())
          : (reports == null)
          ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    _searchBar(settingsProvider, context),
                    Divider(
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          //  itemExtent: 115.0,

                          itemCount: reports?.length == null
                              ? Container()
                              : reports?.length,
//                          controller: _controller,
                          itemBuilder: (context, index) {
//                            Report report = reports[index];
                            reports = Provider.of<List<TurboDb>>(context)
                                .where((report) =>
                                settingsProvider
                                    .brandNameList
                                    .contains(report.aaBrandName))
                            // .where((report) => settingsProvider.aaDataStatus == 'Published')
                                .toList();

                            //   print('index $index');
                            //   print('itemCount' + (reports?.length).toString());

                            nrTurbo = reports?.length;

                            return Column(
                              children: <Widget>[
                                index == 0
                                    ? Column(
                                  children: <Widget>[
                                    reports?.length != 0
                                        ? Container()
                                        : Column(
//
                                      children: <Widget>[
                                        Center(
                                            heightFactor: 1.2,
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  TurbochargerIcons
                                                      .iconturbo2048px,
                                                  color: Colors.red,
                                                  size: 48.0,
                                                  semanticLabel:
                                                  'Turbo-icon',
                                                ),
                                                SizedBox(
                                                    height: 30),
                                                Text(
                                                  AppLocalizations.of(context).translate('turbo_selection_0010') // 'No data?',
                                                  ,style:
                                                  kLabelTextStyleActive,
                                                  textScaleFactor:
                                                  textScaleFactorTc,
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                    AppLocalizations.of(context).translate('turbo_selection_0020')//'Please change your selections',
                                                    ,style:
                                                    kLabelTextStyle,
                                                    textScaleFactor:
                                                    textScaleFactorTc *
                                                        1.1),
                                                SizedBox(height: 8),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left:
                                                      20.0,
                                                      top: 0,
                                                      right: 20,
                                                      bottom:
                                                      5),
                                                  child: Column(
                                                    children: <
                                                        Widget>[
                                                      Divider(
                                                          color: Colors
                                                              .white),
                                                      Opacity(
                                                        opacity:
                                                        0.7,
                                                        child: Text(
                                                            AppLocalizations.of(context).translate('turbo_selection_0030')// 'We are continuously adding more turbos to the turbo register.\n\nHowever, if you are missing a particular turbo-brand or turbo, please fill in the form to suggest a new turbo for the turbo register.',
                                                           , style:
                                                            kBodyItalicTextStyle,
                                                            textScaleFactor:
                                                            textScaleFactorTc *
                                                                0.9),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left:
                                                      20.0,
                                                      top: 0,
                                                      right: 20,
                                                      bottom:
                                                      5),
                                                  child: Column(
                                                    children: <
                                                        Widget>[
                                                      RaisedButton(
                                                        color:
                                                        kActiveCardColourOutput,
                                                        splashColor:
                                                        Colors
                                                            .blue,
                                                        elevation:
                                                        8,
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          new BorderRadius
                                                              .circular(
                                                              8.0),
                                                          side: BorderSide(
                                                              color:
                                                              Colors.blue),
                                                        ),
                                                        onPressed:
                                                            () {
//                                                          Navigator.of(
//                                                              context)
//                                                              .push(
//                                                              MaterialPageRoute(
//                                                                  builder: (
//                                                                      context) =>
//                                                                      TurboSelectorFeedback(
//                                                                          feedbackLink: feedBackLink)));
                                                          //String turboAddAnalytics = settingsProvider.selectedTurbo.aaBrandName.toString() + ' ' + settingsProvider.selectedTurbo.aaTurboBranchModel.toString();

                                                          var _analyticsParameter = {
                                                            'TurboAdd': 'Turbo Selection'
                                                          };
                                                          // Execute a function to send logEvent() to Firebase Analytics
                                                          Analytics
                                                              .analyticsLogEvent(
                                                              AnalyticsEventType
                                                                  .turbo_add_analytics,
                                                              _analyticsParameter);

                                                          Navigator.of(context)
                                                              .pushNamed(
                                                              "turbo_add",
                                                              arguments:
                                                              metricUnit);
                                                        },
                                                        child:
                                                        Container(
                                                          child:
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: <
                                                                Widget>[
                                                              Icon(
                                                                TurbochargerIcons
                                                                    .iconturbo2048px,
                                                                color:
                                                                Colors.white,
                                                                size:
                                                                20.0,
                                                                semanticLabel:
                                                                'Feedback',
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              Text(
                                                                AppLocalizations.of(context).translate('turbo_selection_0040')//'Suggest a missing turbo',
                                                                ,style:
                                                                kLabelTextStyle,
                                                                textScaleFactor:
                                                                textScaleFactorTc,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left:
                                                      20.0,
                                                      top: 0,
                                                      right: 20,
                                                      bottom:
                                                      10),
                                                  child: Opacity(
                                                    opacity: 0.7,
                                                    child: Text(
                                                        AppLocalizations.of(context).translate('turbo_selection_0050')// 'All turbos are added manually by the TCT-team after evaluating your input.',
                                                        ,style:
                                                        kBodyItalicTextStyle,
                                                        textScaleFactor:
                                                        textScaleFactorTc *
                                                            0.9),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ],
                                )
                                    : Container(),
                                Container(
                                    child: index >= reports?.length
                                        ? Container()
                                        : _listItem(settingsProvider, index,
                                        reports, context)),
                              ],
                            );
                          },
//                          itemCount: reports.length-1,
                        ),
                      ),
                    ),
                  ],
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        onPressed: () {
//          _db.addReport();
//        },
//      ),
    );
  }

  _listItem(settingsProvider, index, reports, context) {
    nrTurbo = reports.length;
    var flag = reports[index].countryCompany.toLowerCase() + '.png';
    return ReusableCard(
      onPress: () {
        String turboAnalyticsBrand = reports[index].aaBrandName;

        turboBradAnalytics = 'T: ' + turboAnalyticsBrand;

        print('turboAndModel $turboBradAnalytics');

        settingsProvider.selectedTurbo = reports[index];
//        Navigator.of(context)
//            .push(MaterialPageRoute(builder: (context) => TurboInfoPage()));
//        RouteSettings(name: turboAnalytics);

        Navigator.of(context).pushNamed("turbo_details",
            arguments: metricUnit);

      },
      colour: kActiveCardColourOutput,
      cardChild: Column(
        children: <Widget>[
          Container(
//        height: 100,turbo_details
            child: ListTile(
              leading: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2.7,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
//                  Text('List index $index'),
                        Container(
// width: MediaQuery.of(context).size.width/3.0,
                            child: Text(reports[index]?.aaBrandName,
                                style: kSecondSubjectTextStyleActive,
                                textScaleFactor: textScaleFactorTc)),
                        SizedBox(height: 4),

                        Text(
                          reports[index]?.aaTurboModel,
                          textScaleFactor: textScaleFactorTc,
                          style: kLabelTextStyle,
                        ),
                        reports[index]?.turbineAR == 0
                            ? Container()
                            : Row(
                          children: <Widget>[
                            Opacity(
                              opacity: 0.5,
                              child: Text(
                                AppLocalizations.of(context).translate('turbo_selection_0060')// 'Turbine A/R: ',
                               , style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc,
                              ),
                            ),
                            Text(
                              (reports[index].turbineAR / 100).toString(),
                              style: kLabelTextStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//
                  reports[index]?.hpMax == 0
                      ? Container()
                      : Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Opacity(
                            opacity: 0.5,
                            child: Text(
                              AppLocalizations.of(context).translate('turbo_selection_0070')// 'Horsepower',
                             , style: kLabelTextStyle,
                              textScaleFactor: textScaleFactorTc,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              reports[index]?.hpMin == 0
                                  ? Container()
                                  : Text(
                                reports[index]?.hpMin?.toString(),
                                style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc,
                              ),
                              reports[index]?.hpMin == 0
                                  ? Container()
                                  : Text(
                                ' - ',
                                style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc,
                              ),
                              Text(
                                // ignore: null_aware_before_operator
                                reports[index]?.hpMax?.toString() + ' Hp',
                                style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 4),

                  reports[index]?.compressorInducer == 0
                      ? Container()
                      : Column(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          AppLocalizations.of(context).translate('turbo_selection_0080')// 'Comp Ind',
                         , style: kLabelTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                      ),
                      Container(
                        child: reports[index]?.compressorInducer == 0
                            ? Text(kNotApplicable,
                            textScaleFactor: textScaleFactorTc)
                            : Text(
                          // ignore: null_aware_before_operator
                          (reports[index]?.compressorInducer / 100)
                              ?.toString() +
                              ' mm',
                          style: kLabelTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                children: <Widget>[],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                      image: AssetImage(
                        'images/flags/$flag',
                      ),
                      width: 25,
//                      height: 40,
                      fit: BoxFit.fill),
//                  SizedBox(height: 2),
//                  Opacity(
//                    opacity: 0.5,
//                    child: Text(
//                      reports[index].countryCompany,
//                      style: kLabelTextStyle,
//                      textScaleFactor: textScaleFactorTc,
//                    ),
//                  ),
                  SizedBox(height: 8),
                  reports[index].mapStatusCompressor == false
                      ? Text(kNotApplicable, textScaleFactor: textScaleFactorTc)
                      : Container(
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: kActiveCardColourOutput,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('CM',
                                style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc * .8),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(1.0), // borde width
                      decoration: new BoxDecoration(
                        color: const Color(0xFFFFFFFF), // border color
                        shape: BoxShape.circle,
                      )),
                ],
              ),
              isThreeLine: true,
            ),
          ),
        ],
      ),
    );
  }

  _searchBar(settingsProvider, context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Container(
            child: Wrap(
//                verticalDirection: VerticalDirection.down,
              spacing: 10.0,
              runSpacing: 2.0,
              children: <Widget>[
                FilterChip(
                  shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                  // checkmarkColor: Colors.white,
                  selectedColor: kSelectedTurboFlipCardColor,
                  backgroundColor: kActiveCardColourInput,
                  showCheckmark: false,
                  // labelStyle: TextStyle(color: Colors.black12),
                  label: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 4.6,
                    child: Center(
                      child: Text(
                        'Garrett',
                        style: kLabelTextStyle,
                        textScaleFactor: textScaleFactorTc * 1.1,
                      ),
                    ),
                  ),
                  // ignore: null_aware_in_condition
                  selected:
                  (settingsProvider.brandNameList.contains('Garrett'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settingsProvider.addBrandNameList('Garrett');
                    } else {
                      settingsProvider.removeBrandNameList('Garrett');
                    }
                  },
                ),
                FilterChip(
                  // avatar: CircleAvatar(child: Text('AO',style: TextStyle( fontSize: 8.0))),
                  shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                  // checkmarkColor: Colors.white,
                  selectedColor: kSelectedTurboFlipCardColor,
                  backgroundColor: kActiveCardColourInput,
                  showCheckmark: false,
                  // labelStyle: TextStyle(color: Colors.black12),
                  label: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 4.6,
                    child: Center(
                      child: Text(
                        'Borg Warner',
                        style: kLabelTextStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ),
                  // ignore: null_aware_in_condition
                  selected:
                  (settingsProvider.brandNameList.contains('Borg Warner'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settingsProvider.addBrandNameList('Borg Warner');
                    } else {
                      settingsProvider.removeBrandNameList('Borg Warner');
                    }
                  },
                ),
                FilterChip(
                  // avatar: CircleAvatar(child: Text('AO',style: TextStyle( fontSize: 8.0))),
                  shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                  // checkmarkColor: Colors.white,
                  selectedColor: kSelectedTurboFlipCardColor,
                  backgroundColor: kActiveCardColourInput,
                  showCheckmark: false,
                  // labelStyle: TextStyle(color: Colors.black12),
                  label: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 4.6,
                    child: Center(
                      child: Text(
                        'Precision',
                        style: kLabelTextStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ),
                  // ignore: null_aware_in_condition
                  selected:
                  (settingsProvider.brandNameList.contains('Precision'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settingsProvider.addBrandNameList('Precision');
                    } else {
                      settingsProvider.removeBrandNameList('Precision');
                    }
                  },
                ),
                FilterChip(
                  // avatar: CircleAvatar(child: Text('AO',style: TextStyle( fontSize: 8.0))),
                  shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                  // checkmarkColor: Colors.white,
                  selectedColor: kSelectedTurboFlipCardColor,
                  backgroundColor: kActiveCardColourInput,
                  showCheckmark: false,
                  // labelStyle: TextStyle(color: Colors.black12),
                  label: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 4.6,
                    child: Center(
                      child: Text(
                        'Holset',
                        style: kLabelTextStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ),
                  // ignore: null_aware_in_condition
                  selected: (settingsProvider.brandNameList?.contains('Holset'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settingsProvider.addBrandNameList('Holset');
                    } else {
                      settingsProvider.removeBrandNameList('Holset');
                    }
                  },
                ),
                FilterChip(
                  // avatar: CircleAvatar(child: Text('AO',style: TextStyle( fontSize: 8.0))),
                  shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                  // checkmarkColor: Colors.white,
                  selectedColor: kSelectedTurboFlipCardColor,
                  backgroundColor: kActiveCardColourInput,
                  showCheckmark: false,
                  // labelStyle: TextStyle(color: Colors.black12),
                  label: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 4.6,
                    child: Center(
                      child: Text(
                        'Turbonetics',
                        style: kLabelTextStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ),
                  // ignore: null_aware_in_condition
                  selected:
                  (settingsProvider.brandNameList.contains('Turbonetics'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settingsProvider.addBrandNameList('Turbonetics');
                    } else {
                      settingsProvider.removeBrandNameList('Turbonetics');
                    }
                  },
                ),
                FilterChip(
                  // avatar: CircleAvatar(child: Text('AO',style: TextStyle( fontSize: 8.0))),
                  shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                  // checkmarkColor: Colors.white,
                  selectedColor: kSelectedTurboFlipCardColor,
                  backgroundColor: kActiveCardColourInput,
                  showCheckmark: false,
                  // labelStyle: TextStyle(color: Colors.black12),
                  label: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 4.6,
                    child: Center(
                      child: Text(
                        'Mitsubishi',
                        style: kLabelTextStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ),
                  // ignore: null_aware_in_condition
                  selected:
                  (settingsProvider.brandNameList.contains('Mitsubishi'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settingsProvider.addBrandNameList('Mitsubishi');
                    } else {
                      settingsProvider.removeBrandNameList('Mitsubishi');
                    }
                  },
                ),
                FilterChip(
                  // avatar: CircleAvatar(child: Text('AO',style: TextStyle( fontSize: 8.0))),
                  shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                  // checkmarkColor: Colors.white,
                  selectedColor: kSelectedTurboFlipCardColor,
                  backgroundColor: kActiveCardColourInput,
                  showCheckmark: false,
                  // labelStyle: TextStyle(color: Colors.black12),
                  label: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 4.6,
                    child: Center(
                      child: Text(
                        'Xona',
                        style: kLabelTextStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ),
                  // ignore: null_aware_in_condition
                  selected: (settingsProvider.brandNameList?.contains('Xona'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settingsProvider.addBrandNameList('Xona');
                    } else {
                      settingsProvider.removeBrandNameList('Xona');
                    }
                  },
                ),
                FilterChip(
                  // avatar: CircleAvatar(child: Text('AO',style: TextStyle( fontSize: 8.0))),
                  shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                  // checkmarkColor: Colors.white,
                  selectedColor: kSelectedTurboFlipCardColor,
                  backgroundColor: kActiveCardColourInput,
                  showCheckmark: false,
                  // labelStyle: TextStyle(color: Colors.black12),
                  label: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 4.6,
                    child: Center(
                      child: Text(
                        'Bullseye',
                        style: kLabelTextStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ),
                  // ignore: null_aware_in_condition
                  selected:
                  (settingsProvider.brandNameList.contains('Bullseye'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settingsProvider.addBrandNameList('Bullseye');
                    } else {
                      settingsProvider.removeBrandNameList('Bullseye');
                    }
                  },
                ),
                FilterChip(
                  // avatar: CircleAvatar(child: Text('AO',style: TextStyle( fontSize: 8.0))),
                  shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                  // checkmarkColor: Colors.white,
                  selectedColor: kSelectedTurboFlipCardColor,
                  backgroundColor: kActiveCardColourInput,
                  showCheckmark: false,
                  // labelStyle: TextStyle(color: Colors.black12),
                  label: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 4.6,
                    child: Center(
                      child: Text(
                        'IHI',
                        style: kLabelTextStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ),
                  // ignore: null_aware_in_condition
                  selected: (settingsProvider.brandNameList?.contains('IHI'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settingsProvider.addBrandNameList('IHI');
                    } else {
                      settingsProvider.removeBrandNameList('IHI');
                    }
                  },
                ),
              ],
            ),
          ),
        ),

//        Container(
//          child: Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: TextField(
//              decoration: InputDecoration(hintText: 'Search...'),
//              onChanged: (text) {
//                text = text.toLowerCase();
//
////                reports = _notes.where((note) {
////                  var noteTitle = note.title.toLowerCase();
////                  return noteTitle.contains(text);
////                }).toList();
////                notifyListeners();
//              },
//            ),
//          ),
//        ),
      ],
    );
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {}
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      Text(
        AppLocalizations.of(context).translate('turbo_selection_0090')//'End  of Scroll',
       , textScaleFactor: textScaleFactorTc,
      );
    }
  }
}
