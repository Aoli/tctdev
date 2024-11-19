import 'package:tct/data_models/turbo_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/settings_provider.dart';
import 'global_variables.dart';
import 'package:tct/globals/constants_ui.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsNotifier>(context);

//    List <Report> reports =  Provider.of<List<Report>>(context)
//        .where((report) => settingsProvider.brandNameList.contains(report.aaBrandName))
//        .toList() ?? true;

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 25.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Units'),
                DropdownButton<String>(
                  value: settingsProvider.units,
                  onChanged: (String? value) {
                    if (value != null) {
                      settingsProvider.setUnits(value);
                      print('Unit: $value');
                    }
                  },
                  items: <String>['Imperial', 'Metric']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              child: Wrap(
                spacing: 10.0,
                runSpacing: 2.0,
                children: <Widget>[
                  FilterChip(
                    // avatar: CircleAvatar(child: Text('AO',style: TextStyle( fontSize: 8.0))),
                    shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                    // checkmarkColor: Colors.white,
                    selectedColor: kSelectedTurboFlipCardColor,
                    backgroundColor: kActiveCardColourInput,
                    showCheckmark: false,
                    // labelStyle: TextStyle(color: Colors.black12),
                    label: Container(
                      width: MediaQuery.of(context).size.width / 4.6,
                      child: Center(
                        child: Text(
                          'Garrett',
                          style: kLabelTextStyle,
                          textScaleFactor: textScaleFactorTc * 1.1,
                        ),
                      ),
                    ),
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
                      width: MediaQuery.of(context).size.width / 4.6,
                      child: Center(
                        child: Text(
                          'Borg Warner',
                          style: kLabelTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                      ),
                    ),
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
                      width: MediaQuery.of(context).size.width / 4.6,
                      child: Center(
                        child: Text(
                          'Precision',
                          style: kLabelTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                      ),
                    ),
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
                      width: MediaQuery.of(context).size.width / 4.6,
                      child: Center(
                        child: Text(
                          'Holset',
                          style: kLabelTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                      ),
                    ),
                    selected:
                        (settingsProvider.brandNameList.contains('Holset'))
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
                      width: MediaQuery.of(context).size.width / 4.6,
                      child: Center(
                        child: Text(
                          'Turbonetics',
                          style: kLabelTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                      ),
                    ),
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
                      width: MediaQuery.of(context).size.width / 4.6,
                      child: Center(
                        child: Text(
                          'Mitsubishi',
                          style: kLabelTextStyle,
                          textScaleFactor: textScaleFactorTc,
                        ),
                      ),
                    ),
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
                ],
              ),
            ),
          ),
          Divider(color: Colors.white),
          Container(
            //alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  currentVersionNumberGlobal,
                  style: kBuildVersionStyle,
                  textScaleFactor: textScaleFactorTc,
                ),
                Text(' ',
                    style: kBuildVersionStyle,
                    textScaleFactor: textScaleFactorTc),
                Text(
                  'Build:' + currentBuildNumberGlobal.toString(),
                  style: kBuildVersionStyle,
                  textScaleFactor: textScaleFactorTc,
                ),
                Text('  ',
                    style: kBuildVersionStyle,
                    textScaleFactor: textScaleFactorTc),
                Text('b:' + deviceWidth.toStringAsFixed(0),
                    style: kBuildVersionStyle,
                    textScaleFactor: textScaleFactorTc),
                Text(' h:' + displaySizeLength.toStringAsFixed(0),
                    style: kBuildVersionStyle,
                    textScaleFactor: textScaleFactorTc),
                Text(
                  ' RC:' + remoteConfigBuild.toString(),
                  style: kBuildVersionStyle,
                  textScaleFactor: textScaleFactorTc,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
