import 'dart:io' show Platform;
import 'package:tct/data_models/Map_iphone_models.dart';
import 'package:tct/globals/app_localizations.dart';
import 'package:tct/provider/settings_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/analytics_event.dart';
import '../data_models/analytics_event_type.dart';
import '../components/reusable_card.dart';
import '../globals/constant.dart';
import 'package:tct/globals/calculator_brain.dart';
import 'package:tct/components/turbocharger_icons_icons.dart';
import 'package:tct/globals/constants_ui.dart';

class MenuPage extends StatefulWidget {
  bool metricUnit;

  MenuPage({required Set key, required this.metricUnit}) : super(ey: key);

  _MenuPageState createState() => _MenuPageState(metricUnit);
}

class _MenuPageState extends State<MenuPage> {
  bool metricUnit;

  _MenuPageState(this.metricUnit);

  bool tapTimeSwitch = true;
  int turboTabCount = 0;

  void _onStepSpeed(bool value) {
    setState(() {
      tapTimeSwitch = value;
      if (tapTimeSwitch) {
        print(value);
        tapTime = tapTimeFast;
        // const RouteSettings(name: 'StepFast');
      } else {
        tapTime = tapTimeSlow;
        // const RouteSettings(name: 'StepSlow');
      }
    });
  }

  bool snackbarEnable = true;

  void setState(fn) {
    setState(fn);

    if (metricUnit) {
      unitValue = unitLengthMillimeter;
      inducerCompressorMetric = inducerCompressorValue;
      sliderDivisionInducerExducer = 130;
    }
  }

  // @override
  // void calculate() {}

  void initState() {
    super.initState();
    metricUnit = true;
    print('a_menu');
    resetValues(metricUnit);
    deviceCheck();
    tapTime = tapTimeFast;

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
    _incrementStartup();
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
            'Warning: Exducer is always larger than Inducer on the compressor',
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textScaleFactor: textScaleFactorTc,
          ),
          SizedBox(height: 10.0),
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

  Color primaryColor = Color(0xff7b0000);

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settings = Provider.of<SettingsNotifier>(context);
    deviceWidth = MediaQuery.of(context).size.width;
    displaySizeLength = MediaQuery.of(context).size.longestSide;
    print('displaySizeLength $displaySizeLength');
    if (deviceWidth < 380) {
      textScaleFactorTc = 0.72;
      logoSize = 35.0;
      logoPadding = 'right: 8.0';
    } else {
      textScaleFactorTc = 0.95;
      logoSize = 40.0;
      logoPadding = 'right: 12.0';

      if (displaySizeLength > 800) {
        displayScaleFactor = 0.95;
        displayHeight = 0.45;
      } else {
        displayScaleFactor = 0.70;
        displayHeight = 0.55;
      }
    }

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 4.0,
            onTap: (index) {
              setState(() {
                switch (index) {
                  case 0:
                    primaryColor = Color(0xff7b0000);

                    if (turboTabCount > 0) {
                      // Analytics events
                      var _analyticsParameter = {'TurboTab': 'Turbo Tab'};
                      // Execute a function to send logEvent() to Firebase Analytics
                      Analytics.analyticsLogEvent(
                          AnalyticsEventType.turbo_tab, _analyticsParameter);
                    }
                    break;
                  case 1:
                    primaryColor = Color(0xFF121F41);
                    turboTabCount++;
                    // Analytics events
                    var _analyticsParameter = {'TurboTab': 'Airflow Tab'};
                    // Execute a function to send logEvent() to Firebase Analytics
                    Analytics.analyticsLogEvent(
                        AnalyticsEventType.turbo_tab, _analyticsParameter);

                    break;
                  case 2:
                    primaryColor = Color(0xff7b0000);
                    turboTabCount++;

// Analytics events
                    var _analyticsParameter = {'TurboTab': 'Tuning Tab'};
                    // Execute a function to send logEvent() to Firebase Analytics
                    Analytics.analyticsLogEvent(
                        AnalyticsEventType.turbo_tab, _analyticsParameter);

                    break;
                  case 3:
                    primaryColor = Color(0xff7b0000);
                    turboTabCount++;

                    // Analytics events
                    var _analyticsParameter = {'TurboTab': 'Convert Tab'};
                    // Execute a function to send logEvent() to Firebase Analytics
                    Analytics.analyticsLogEvent(
                        AnalyticsEventType.turbo_tab, _analyticsParameter);

                    break;
                  case 4:
                    primaryColor = Color(0xff7b0000);
                    turboTabCount++;

                    // Analytics events
                    var _analyticsParameter = {'TurboTab': 'Info Tab'};
                    // Execute a function to send logEvent() to Firebase Analytics
                    Analytics.analyticsLogEvent(
                        AnalyticsEventType.turbo_tab, _analyticsParameter);

                    break;
                  default:
                }
              });
            },
            tabs: [
              Column(
                children: <Widget>[
                  Tab(icon: Icon(TurbochargerIcons.iconturbo2048px)),
                  Text(
                    AppLocalizations.of(context).translate('a_menu_0000'),
                    //Turbo
                    textScaleFactor: textScaleFactorTc,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Tab(icon: Icon(TurbochargerIcons.iconturbo2048px)),
                  Text(
                    AppLocalizations.of(context).translate('a_menu_0010'),
                    //Airflow
                    textScaleFactor: textScaleFactorTc,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Tab(icon: Icon(TurbochargerIcons.iconcylinder2048px)),
                  Text(
                    AppLocalizations.of(context).translate('a_menu_0020'),
                    //Tuning
                    textScaleFactor: textScaleFactorTc,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Tab(icon: Icon(TurbochargerIcons.iconenginecalc2048px)),
                  Text(
                    AppLocalizations.of(context).translate('a_menu_0030'),
                    //Convert
                    textScaleFactor: textScaleFactorTc,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Tab(
                      icon: Icon(
                    Icons.info_outline,
                    color: Colors.white70,
                  )),
                  Text(
                    AppLocalizations.of(context).translate('a_menu_0040'),
                    //Information
                    textScaleFactor: textScaleFactorTc,
                  ),
                ],
              ),
            ],
          ),
//          leading: Container(
//            width: 10.0,
//          ),
          title: Container(
            child: Row(
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
                    ),
                  ),
                ),
                Text(
                  'TurboCharger Tuning',
                  style: kAppBarTextStyle,
                  textScaleFactor: textScaleFactorTc * 1.1,
                ),
                Container(width: 30),
              ],
            ),
          ),
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.settings),
//              onPressed: () {
//                Navigator.of(context)
//                    .push(MaterialPageRoute(builder: (context) => Settings()));
//              },
//            )
//          ],
        ),
        body: Builder(builder: (context) {
          return TabBarView(
            children: [
              Container(
                child: ListView(
                  children: <Widget>[
                    //Text('Start'),

                    SizedBox(height: 10.0),
//                    ReusableCard(
//                      colour: kActiveCardColour,
//                      cardChild: ListTile(
//                        leading: Icon(TurbochargerIcons.iconturbo2048px),
//                        trailing: Icon(Icons.keyboard_arrow_right),
//                        title: Text(
//                          'Max Horsepower',
//                          style: kSecondSubjectTextStyle,
//                          textScaleFactor: textScaleFactorTc,
//                        ),
//                        subtitle: Text(
//                          'Max HorsePower based on inducer size',
//                          textScaleFactor: textScaleFactorTc,
//                        ),
//                        onTap: () {
//                          //Navigator.of(context).pop();
//                          Navigator.of(context).pushNamed("basiccompressorpage",
//                              arguments: metricUnit);
//                        },
//                      ),
//                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconturbo2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context).translate('a_menu_0050'),
                          // TCT Turbo Register
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).translate(
                                  'a_menu_0060'), //width compressor maps
                              textScaleFactor: textScaleFactorTc,
                            ),
                            SizedBox(width: 8),
                            Container(
                                child: CircleAvatar(
                                  radius: 9,
                                  backgroundColor: kActiveCardColourOutput,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                          AppLocalizations.of(context)
                                              .translate('a_menu_0070'), //CM
                                          style: kLabelTextStyle,
                                          textScaleFactor:
                                              textScaleFactorTc * .8),
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(1.0),
                                // borde width
                                decoration: new BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  // border color
                                  shape: BoxShape.circle,
                                )),
                          ],
                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
                          //Navigator.of(context).pushNamed("turbo_chips",arguments: metricUnit);
//                          Navigator.of(context).push(MaterialPageRoute(
//                              builder: (_) => TurboSelection()));
                          Navigator.of(context).pushNamed("turbo_register",
                              arguments: metricUnit);
                        },
                      ),
                    ),

                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconturbo2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context).translate('a_menu_0080')
                          //Compressor & Turbine
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
//                        subtitle: Text(
//                          'Trim, boost pressure',
//                          textScaleFactor: textScaleFactorTc,
//                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(
                              "compressor_turbine_page",
                              arguments: metricUnit);
                        },
                      ),
                    ),

                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconturbo2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context).translate('a_menu_0090'),
                          //'A/R ratio',
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        // subtitle: Text(
                        // 'Trim and back pressure',
                        // textScaleFactor: textScaleFactorTc,
                        //),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("ar_ratio", arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(Icons.info_outline),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context).translate('a_menu_0100'),
                          //'TCT News',
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).translate('a_menu_0110'),
                          //'News and TCT roadmaps',
                          textScaleFactor: textScaleFactorTc,
                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("tctappnews", arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(Icons.info_outline),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context).translate('a_menu_0120'),
                          //'What are we missing?',
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).translate('a_menu_0130'),
                          //'Give us feedback please',
                          textScaleFactor: textScaleFactorTc,
                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("feedback", arguments: metricUnit);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ListView(
                  children: <Widget>[
                    //Text('Start'),

                    SizedBox(height: 10.0),

//                    ReusableCard(
//                      colour: kActiveCardColour,
//                      cardChild: ListTile(
//                        leading: Icon(TurbochargerIcons.iconturbo2048px),
//                        trailing: Icon(Icons.keyboard_arrow_right),
//                        title: Text(
//                          'Airflow and Pressure Ratio',
//                          style: kSecondSubjectTextStyle,
//                          textScaleFactor: textScaleFactorTc,
//                        ),
//                        subtitle: Text(
//                          'Engine Speed and Target boost pressure',
//                          textScaleFactor: textScaleFactorTc,
//                        ),
//                        onTap: () {
//                          // Navigator.of(context).pop();
//                          Navigator.of(context).pushNamed("airflowtbppage",
//                              arguments: metricUnit);
//                        },
//                      ),
//                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconturbo2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context).translate('a_menu_0140')
                          // 'Airflow Conversion',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).translate('a_menu_0150')
                          //'Air Density',
                          ,
                          textScaleFactor: textScaleFactorTc * 0.9,
                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context).pushNamed("airflowsimplepage",
                              arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kInactiveCardColour,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconturbo2048px),
                        //trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context).translate('a_menu_0160')
                          // 'Airflow Conversion',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).translate('a_menu_0170')
                          // 'Gas Law formula  - temporarly closed',
                          ,
                          textScaleFactor: textScaleFactorTc * 0.9,
                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
//                          Navigator.of(context).pushNamed("airflowconvgaslaw",
//                              arguments: metricUnit);
                        },
                      ),
                    ),
//

                    ReusableCard(
                      colour: kInactiveCardColour,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconturbo2048px),
                        //trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context).translate('a_menu_0180')
                          //'Airflow and Pressure Ratio'
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).translate('a_menu_0190')
                          //'HorsePower and Engine Speed - temporarly closed'
                          ,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
//                          Navigator.of(context)
//                              .pushNamed("airflowpage", arguments: metricUnit);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconcylinder2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context).translate('a_menu_0200')
                          // 'Engine Displacement',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).translate('a_menu_0210')
                          //'Engine size based on bore, stroke and cylinders',
                          ,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("enginesize", arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconcylinder2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('a_menu_0220') //'Torque',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).translate(
                              'a_menu_0230') //'Calculate torque based horsepower and RPM',
                          ,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("torque", arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconcylinder2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('a_menu_0240') //'Horsepower',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).translate(
                              'a_menu_0250') //'Calculate horespower based on torque and RPM',
                          ,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("hptorque", arguments: metricUnit);
                        },
                      ),
                    ),
//                    ReusableCard(
//                      colour: kInactiveCardColour,
//                      cardChild: ListTile(
//                        leading: Icon(TurbochargerIcons.iconcylinder2048px),
//                        // trailing: Icon(Icons.info_outline),
//                        title: Text(
//                          'Compression Ratio',
//                          textScaleFactor: textScaleFactorTc,
//                          style: TextStyle(color: Colors.white30),
//                        ),
//                        subtitle: Text(
//                          'This calculation is in development and are soon released',
//                          textScaleFactor: textScaleFactorTc,
//                          style: TextStyle(color: Colors.white30),
//                        ),
//                        onTap: () {},
//                      ),
//                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(Icons.info_outline),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context).translate(
                              'a_menu_0260') // 'Are we missing something?',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).translate(
                              'a_menu_0270') //'What tuning calculation do you need?',
                          ,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("feedback", arguments: metricUnit);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconenginecalc2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('a_menu_0280') //'Speed',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        //  subtitle: Text(
                        //    'Conversions is next on the list'),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("speed", arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconenginecalc2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('a_menu_0290') // 'Pressure',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        // subtitle: Text(
                        //   'Conversions is next on the list'),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("psiandbar", arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconenginecalc2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('a_menu_0300') //  'Length',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        //subtitle: Text(
                        //  'Conversions is next on the list'),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("inchandmm", arguments: metricUnit);
                        },
                      ),
                    ),

//                    ReusableCard(
//                      colour: kInactiveCardColour,
//                      cardChild: ListTile(
//                        leading: Icon(TurbochargerIcons.iconenginecalc2048px),
//                        trailing: Icon(Icons.keyboard_arrow_right),
//                        title: Text(
//                          AppLocalizations.of(context).translate('a_menu_0310')//'Distance',
//                          ,style: kSecondSubjectTextStyle,
//                          textScaleFactor: textScaleFactorTc,
//                        ),
//                        subtitle: Text(AppLocalizations.of(context).translate('a_menu_0320')//'Km, Miles, Nautical Miles etc')
//                     ,
//                        onTap: () {
//                          // Navigator.of(context).pop();
////                          Navigator.of(context)
////                              .pushNamed("convert_distance", arguments: metricUnit);
//                        },
//                      ),
//                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconenginecalc2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('a_menu_0330') // 'Temperature',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        // subtitle: Text(
                        //    'Conversions is next on the list'),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              "celsiusandfahrenheit",
                              arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconenginecalc2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('a_menu_0340') // 'Volume',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        //subtitle: Text(
                        //  'Conversions is next on the list'),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("volume", arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(TurbochargerIcons.iconenginecalc2048px),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('a_menu_0350') // 'Mass/Weight',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        //  subtitle: Text(
                        //    'Conversions is next on the list'),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("mass", arguments: metricUnit);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(Icons.info_outline),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('a_menu_0360') // 'About TurboCharger',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        //  subtitle: Text(
                        //    'Conversions is next on the list'),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context).pushNamed("appinformation",
                              arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(Icons.info_outline),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context).translate(
                              'a_menu_0370') // 'TurboCharger Website',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        //  subtitle: Text(
                        //    'Conversions is next on the list'),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("tcwebsite", arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(Icons.info_outline),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('a_menu_0380') // 'TCT News',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).translate(
                              'a_menu_0390') // 'News and TCT roadmap',
                          ,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("tctappnews", arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(Icons.info_outline),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('a_menu_0400') // 'Credits',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("credits", arguments: metricUnit);
                        },
                      ),
                    ),
                    ReusableCard(
                      colour: kActiveCardColourInput,
                      cardChild: ListTile(
                        leading: Icon(Icons.info_outline),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          AppLocalizations.of(context).translate(
                              'a_menu_0410') //  'Please give us feedback',
                          ,
                          style: kSecondSubjectTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                        //  subtitle: Text(
                        //    'Conversions is next on the list'),
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed("feedback", arguments: metricUnit);
                        },
                      ),
                    ),

//                    ReusableCard(
//                      colour: kActiveCardColour,
//                      cardChild: ListTile(
//                        leading: Icon(Icons.info_outline),
//                        // trailing: Icon(Icons.keyboard_arrow_right),
//                        title: Text(
//                          'Turbo Wiki',
//                          textScaleFactor: textScaleFactorTc,
//                        ),
//                        subtitle: Text(
//                          'Experimental ... soon ready',
//                          textScaleFactor: textScaleFactorTc,
//                        ),
//                        onTap: () {
//                          // Navigator.of(context).pop();
//                          //  Navigator.of(context)
//                          //      .pushNamed("mass", arguments: metricUnit);
//                        },
//                      ),
//                    ),
//                    ReusableCard(
//                      colour: kActiveCardColour,
//                      cardChild: ListTile(
//                        leading: Icon(Icons.explore),
//                        // trailing: Icon(Icons.keyboard_arrow_right),
//                        title: Text(
//                          'Measure Help',
//                          textScaleFactor: textScaleFactorTc,
//                        ),
//                        subtitle: Text('Experimental ...Not ready',
//                            textScaleFactor: textScaleFactorTc),
//                        onTap: () {
//                          // Navigator.of(context).pop();
//                          Navigator.of(context)
//                              .pushNamed("measurehelp", arguments: metricUnit);
//                        },
//                      ),
//                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void resetValues(bool metricUnit) {
    setState(() {});
  }

  Future<void> deviceCheck() async {
    bool update = false;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PackageInfo info = await PackageInfo.fromPlatform();
    int currentBuildNumber = int.parse(info.buildNumber);
    String currentVersionNumber = info.version;

    RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
    await remoteConfig.fetch(expiration: Duration(seconds: 5));
    final requiredBuildNumberAndroid =
        remoteConfig.getInt('android_app_version');
    print('requiredBuildNumberAndroid $requiredBuildNumberAndroid');

    RemoteConfig remoteConfigIos = await RemoteConfig.instance;
    await remoteConfigIos.fetch();
    await remoteConfigIos.activateFetched();
    await remoteConfigIos.fetch(expiration: Duration(seconds: 5));
    final requiredBuildNumberIos = remoteConfig.getInt('ios_app_version');
    print('requiredBuildNumberIos $requiredBuildNumberIos');

    if (Platform.isAndroid) {
      androidInfo = await DeviceInfoPlugin().androidInfo;
      release = androidInfo.version.release;
      sdkInt = androidInfo.version.sdkInt;
      manufacturer = androidInfo.manufacturer;
      model = androidInfo.model;
      print('xAndroid $release (SDK $sdkInt), $manufacturer $model');
      currentBuildNumberGlobal = currentBuildNumber;
      currentVersionNumberGlobal = currentVersionNumber;
      remoteConfigBuild = requiredBuildNumberAndroid;

      mobilSystemAndroidAnalytics(androidInfo);

      if (requiredBuildNumberAndroid > currentBuildNumber) {
        update = true;
        print('$currentVersionNumber and $currentVersionNumber');
        print('$currentBuildNumber and $requiredBuildNumberAndroid');

        updateBuildAndroid(update);
      }
    }

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      modelIphone = iosInfo.utsname.machine;
      print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
      print('Running at $modelIphone');
      iosInfo = await DeviceInfoPlugin().iosInfo;
      systemName = iosInfo.systemName;
      version = iosInfo.systemVersion;
      name = iosInfo.name;
      model = iosInfo.model;
      print('$systemName $version, $name $model');
      currentBuildNumberGlobal = currentBuildNumber;
      currentVersionNumberGlobal = currentVersionNumber;
      remoteConfigBuild = requiredBuildNumberIos;

      mobilSystemIosAnalytics(iosInfo);

      if (requiredBuildNumberIos > currentBuildNumber) {
        update = true;
        print('$currentVersionNumber and $currentVersionNumber');
        print('$currentBuildNumber and $requiredBuildNumberIos');

        updateBuildIos(update);
      }
      // iOS 13.1, iPhone 11 Pro Max iPhone
    }
  }

  void updateBuildIos(bool update) {
    if (Platform.isIOS && update) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog

          return CupertinoAlertDialog(
            title: new Text(
              AppLocalizations.of(context)
                  .translate('a_menu_0420') //"Please Update the app!\n",
              ,
              style: kLabelTextStyleActive,
              textScaleFactor: textScaleFactorTc * 1.2,
            ),
            content: new Text(
              AppLocalizations.of(context).translate(
                  'a_menu_0430') // "A new version is available at Apple AppStore.",
              ,
              style: kResultLabelStyleWhite15_600,
              textScaleFactor: textScaleFactorTc * 1.2,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  AppLocalizations.of(context)
                      .translate('a_menu_0440') //  "Close",
                  ,
                  style: kLabelTextStyle,
                  textScaleFactor: textScaleFactorTc * 1.4,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void updateBuildAndroid(bool update) {
    if (Platform.isAndroid && update) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog

          return AlertDialog(
            backgroundColor: kActiveCardColourInput,
            title: new Text(
                AppLocalizations.of(context)
                    .translate('a_menu_0450') //"Please Update the app!",
                ,
                style: kLabelTextStyleActive,
                textScaleFactor: textScaleFactorTc * 1.2),
            content: new Text(
              AppLocalizations.of(context).translate(
                  'a_menu_0460') // "A new version is available at Google Play.",
              ,
              textScaleFactor: textScaleFactorTc * 1.2,
              style: kResultLabelStyleWhite15_600,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                    AppLocalizations.of(context)
                        .translate('a_menu_0470') //"Close",
                    ,
                    style: kLabelTextStyle,
                    textScaleFactor: textScaleFactorTc * 1.4),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  /// Will get the startupnumber from shared_preferences
  /// will return 0 if null
  Future<int> _getIntFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final startupNumber = prefs.getInt('startupNumber');
    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  /// Reset the counter in shared_preferences to 0
  Future<void> _resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('startupNumber', 0);
  }

  /// Will Increment the startup number and store it then
  /// use setState to display in the UI
  Future<void> _incrementStartup() async {
    final prefs = await SharedPreferences.getInstance();

    int lastStartupNumber = await _getIntFromSharedPref();
    int currentStartupNumber = ++lastStartupNumber;

    await prefs.setInt('startupNumber', currentStartupNumber);

//    if (currentStartupNumber == 3) {
//      setState(() => haveStartedTimes = '$currentStartupNumber Times Completed');
//
//      // Reset only if you want to
//      await _resetCounter();
//    } else {
    setState(() => haveStartedTimes =
        'You have started this version of the app: $currentStartupNumber times');
//    }
  }
}

void mobilSystemAndroidAnalytics(androidInfo) {
  // print('I am at Android');
  release = androidInfo.version.release;
  manufacturer = androidInfo.manufacturer;
  model = androidInfo.model;

  var androids = 'Android';
  var mobileSystemWidth;
  double systemWidth_nr;
  String systemWidth_txt;

  systemAndVersion = androids + ' ' + release;
  mobileBrandModel = manufacturer + ' ' + model;
  mobileSystemWidth = androids + ' ' + deviceWidth.toStringAsFixed(0);
  systemWidth_nr = deviceWidth.roundToDouble();
  systemWidth_txt = deviceWidth.toStringAsFixed(0);

  String strList = mobileBrandModel;
  var str1 = strList.split(' ')[0];
  // print(str1[0].toUpperCase() + str1.substring(1).toLowerCase()); // Welcome
  var mobileBrand = str1[0].toUpperCase() + str1.substring(1).toLowerCase();

// mobileSystem
  var _analyticsParameterMobileSystem = {'MobileSystem': androids};
// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(
      AnalyticsEventType.mobile_system, _analyticsParameterMobileSystem);
  print('androids $androids');

// MobileSytem and Width
  var _analyticsParameterMobileSystemWidth = {
    'MobileSystemWidth': mobileSystemWidth
  };
  print('MobileSystemWidth $mobileSystemWidth');
// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(AnalyticsEventType.mobile_system_width,
      _analyticsParameterMobileSystemWidth);

  // SystemWidth NR
  var _analyticsParameterSystemWidth = {'SystemWidthNr': systemWidth_nr};
  print('SystemWidthNr $systemWidth_nr');
// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(
      AnalyticsEventType.system_width_nr, _analyticsParameterSystemWidth);

  // SystemWidth TXT
  var _analyticsParameterSystemWidthTxt = {'SystemWidthTxt': systemWidth_txt};
  print('SystemWidthTxt  $systemWidth_txt');
// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(
      AnalyticsEventType.system_width_txt, _analyticsParameterSystemWidthTxt);

// mobileOsVersion
  var _analyticsParameterMobileOsVersion = {
    'MobileOsVersion': systemAndVersion
  };
  print('systemAndVersion $systemAndVersion');

// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(
      AnalyticsEventType.mobile_os_version, _analyticsParameterMobileOsVersion);

// mobileBrandModel
  var _analyticsParameterMobileBrandModel = {
    'MobileBrandModel': mobileBrandModel
  };
  print('mobileBrandModel $mobileBrandModel');

// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(AnalyticsEventType.mobile_brand_model,
      _analyticsParameterMobileBrandModel);

  // mobileBrand
  var _analyticsParameterMobileBrand = {'MobileBrand': mobileBrand};
  print('mobileBrand $mobileBrand');

// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(
      AnalyticsEventType.mobile_brand, _analyticsParameterMobileBrand);
}

mobilSystemIosAnalytics(iosInfo) {
  systemName = iosInfo.systemName;
  version = iosInfo.systemVersion;
  name = iosInfo.name;
  model = iosInfo.model;

  var mobileSystem;
  var mobileSystemWidth;
  double systemWidth_nr;
  String systemWidth_txt;

//  var mobileOsVersion;
  mobileSystem = systemName;
  mobileSystemWidth = systemName + ' ' + deviceWidth.toStringAsFixed(0);
  systemWidth_nr = deviceWidth.roundToDouble();
  systemWidth_txt = deviceWidth.toStringAsFixed(0);

  systemAndVersion = systemName + ' ' + version;
  mobileBrandModel = iphoneMapping[modelIphone];
  var mobileBrand = 'Apple';
  print('mobileBrandModel $mobileBrandModel');

  String strList = mobileBrandModel;
  var str1 = strList.split(' ')[0];
  print(str1[0].toUpperCase() + str1.substring(1).toLowerCase()); // Welcome

  var _analyticsParameterMobileSystem = {'MobileSystem': systemName};
  print('systemName $systemName');
// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(
      AnalyticsEventType.mobile_system, _analyticsParameterMobileSystem);

  // MobileSytem and Width
  var _analyticsParameterMobileSystemWidth = {
    'MobileSystemWidth': mobileSystemWidth
  };
  print('MobileSystemWidth $mobileSystemWidth');
// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(AnalyticsEventType.mobile_system_width,
      _analyticsParameterMobileSystemWidth);

  // SystemWidth
  var _analyticsParameterSystemWidth = {'SystemWidth': systemWidth_nr};
  print('SystemWidth $systemWidth_nr');
// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(
      AnalyticsEventType.system_width_nr, _analyticsParameterSystemWidth);

  // SystemWidth TXT
  var _analyticsParameterSystemWidthTxt = {'SystemWidth': systemWidth_txt};
  print('SystemWidth $systemWidth_txt');
// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(
      AnalyticsEventType.system_width_txt, _analyticsParameterSystemWidthTxt);

// mobileOsVersion
  var _analyticsParameterMobileOsVersion = {
    'MobileOsVersion': systemAndVersion
  };
  print('systemAndVersion $systemAndVersion');

// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(
      AnalyticsEventType.mobile_os_version, _analyticsParameterMobileOsVersion);

// mobileBrandModel
  var _analyticsParameterMobileBrandModel = {
    'MobileBrandModel': mobileBrandModel
  };
  print('modelIphone $mobileBrandModel');

// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(AnalyticsEventType.mobile_brand_model,
      _analyticsParameterMobileBrandModel);

  // mobileBrand
  var _analyticsParameterMobileBrand = {'MobileBrand': mobileBrand};
  print('mobileBrand $mobileBrand');

// Execute a function to send logEvent() to Firebase Analytics
  Analytics.analyticsLogEvent(
      AnalyticsEventType.mobile_brand, _analyticsParameterMobileBrand);
}
