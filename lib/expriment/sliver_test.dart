import 'package:Turbocharger/components/reusable_card.dart';
import 'package:Turbocharger/components/turbocharger_icons_icons.dart';
import 'package:Turbocharger/globals/constant.dart';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:Turbocharger/data_models/turboDb.dart';
import 'package:Turbocharger/provider/settings_provider.dart';
import 'package:Turbocharger/screens/info/turbo_selector_feedback.dart';
import 'package:Turbocharger/screens/turbo/turbo_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Turbocharger/globals/constants_ui.dart';


class SliversBasicPage extends StatelessWidget {
  var list = true;

  var nrTurbo;

  @override
  Widget build(BuildContext context) {
    SettingsNotifier settings = Provider.of<SettingsNotifier>(context);
//
    List<TurboDb> reports = Provider.of<List<TurboDb>>(context);
//    ScrollController _controller;
//    _controller = ScrollController();
//
//    _controller.addListener(_scrollListener);

    var feedBackLink =
        'https://docs.google.com/forms/d/e/1FAIpQLSeiV8Q0U-7uCUpEYOJrOiTDhRIYuGP_4rhvvg477jCk4eQwVw/viewform?usp=sf_link';

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          floating: false,
          expandedHeight: 450.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Column(
              children: <Widget>[
                Text('Basic Slivers'),
                _searchBar(settings, context),
                Divider(
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
//        SliverFixedExtentList(
//          itemExtent: 50,
//          delegate: SliverChildListDelegate([
//            Container(color: Colors.red),
//            Container(color: Colors.green),
//            Container(color: Colors.blue),
//          ]),
//        ),
//        SliverList(
//          delegate: SliverChildBuilderDelegate(
//                (context, index) {
//              return Container(
//                height: 50,
//                alignment: Alignment.center,
//                color: Colors.orange[100 * (index % 9)],
//                child: Text('orange $index',textScaleFactor: textScaleFactorTc,),
//              );
//            },
//            childCount: 9,
//          ),
//        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
//                    Row(
//                      children: <Widget>[
//                        Text('Totalt turbo brand names: '),
//                        Text(settings?.brandNameList?.length.toString()),
//                      ],
//                    ),

//                    Row(
//                      children: <Widget>[
//                        Text('Totalt turbos i database: '),
//                        Text(reports?.length.toString()),
//                      ],
//                    ),
                      // Divider(color: Colors.white70),
//                      Expanded(
//                        child: Container(
//                          child: ListView.builder(
//                            scrollDirection: Axis.vertical,
//                            //  itemExtent: 115.0,
//
//                            itemCount: reports?.length == null
//                                ? Container()
//                                : reports?.length,
////                          controller: _controller,
//                            itemBuilder: (context, index) {
////                            Report report = reports[index];
//                              reports = Provider.of<List<Report>>(context)
//                                  .where((report) => settings.brandNameList
//                                  .contains(report.aaBrandName))
//                              // .where((report) => settings.aaDataStatus == 'Published')
//                                  .toList();
//
//                              print('index $index');
//                              print('itemCount' + (reports?.length).toString());
//
//                              nrTurbo = reports?.length;
//
//                              return Column(
//                                children: <Widget>[
//                                  index == 0
//                                      ? Column(
//                                    children: <Widget>[
//                                      reports?.length != 0
//                                          ? Container()
//                                          : Column(
////                                                  mainAxisAlignment:
////                                                      MainAxisAlignment.center,
////                                                  crossAxisAlignment:
////                                                      CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Center(
//                                              heightFactor: 1.2,
//                                              child: Column(
//                                                children: <Widget>[
//                                                  Icon(
//                                                    TurbochargerIcons
//                                                        .iconturbo2048px,
//                                                    color: Colors.red,
//                                                    size: 48.0,
//                                                    semanticLabel:
//                                                    'Turbo-icon',
//                                                  ),
//                                                  SizedBox(
//                                                      height: 30),
//                                                  Text(
//                                                    'No data?',
//                                                    style:
//                                                    kLabelTextStyleActive,
//                                                    textScaleFactor:
//                                                    textScaleFactorTc,
//                                                  ),
//                                                  SizedBox(height: 8),
//                                                  Text(
//                                                      'Please change your selections',
//                                                      style:
//                                                      kLabelTextStyle,
//                                                      textScaleFactor:
//                                                      textScaleFactorTc *
//                                                          1.1),
//                                                  SizedBox(height: 8),
//
//                                                  Padding(
//                                                    padding: const EdgeInsets.only(left: 20.0, top:0, right: 20, bottom: 5),
//                                                    child: Column(
//                                                      children: <Widget>[
//                                                        Divider(color: Colors.white),
//                                                        Opacity(opacity: 0.7,
//                                                          child: Text(
//                                                              'We are continuously adding more turbos to the turbo register.\n\nHowever, if you are missing a particular turbo-brand or turbo, please fill in the form to suggest a new turbo for the turbo register.',
//                                                              style:
//                                                              kBodyItalicTextStyle,
//                                                              textScaleFactor:
//                                                              textScaleFactorTc*0.9),
//                                                        ),
//                                                      ],
//                                                    ),
//
//                                                  ),
//                                                  Padding(
//                                                    padding: const EdgeInsets.only(left: 20.0, top:0, right: 20, bottom: 5),
//                                                    child: Column(
//                                                      children: <Widget>[
//                                                        RaisedButton(
//                                                          color: kActiveCardColourOutput,
//                                                          splashColor: Colors.blue,
//                                                          elevation: 8,
//                                                          shape: RoundedRectangleBorder(
//                                                            borderRadius: new BorderRadius.circular(8.0),
//                                                            side: BorderSide(color: Colors.blue),
//                                                          ),
//                                                          onPressed: () {
//                                                            Navigator.of(context)
//                                                                .push(MaterialPageRoute(builder: (context) => TurboSelectorFeedback(feedbackLink: feedBackLink)));
//                                                            events:
//                                                            const RouteSettings(name: 'Add turbo');
//                                                          },
//                                                          child: Container(
//                                                            child: Row(
//                                                              mainAxisAlignment: MainAxisAlignment.center,
//                                                              children: <Widget>[
//                                                                Icon(
//                                                                  TurbochargerIcons.iconturbo2048px,
//                                                                  color: Colors.white,
//                                                                  size: 20.0,
//                                                                  semanticLabel:
//                                                                  'Feedback',
//                                                                ),
//                                                                SizedBox(width: 10),
//                                                                Text(
//                                                                  'Add a turbo',
//                                                                  style: kLabelTextStyle,
//                                                                  textScaleFactor: textScaleFactorTc,
//                                                                ),
//                                                              ],
//                                                            ),
//                                                          ),
//                                                        ),
//
//
//                                                      ],
//                                                    ),
//                                                  ),
//                                                  Padding(
//                                                    padding: const EdgeInsets.only(left: 20.0, top:0, right: 20, bottom: 10),
//                                                    child: Opacity(opacity: 0.7,
//                                                      child: Text(
//                                                          'All turbos are added manually by the TCT-team after evaluating your input.',
//                                                          style:
//                                                          kBodyItalicTextStyle,
//                                                          textScaleFactor:
//                                                          textScaleFactorTc *
//                                                              0.9),
//                                                    ),
//                                                  ),
//                                                ],
//                                              )),
//                                        ],
//                                      ),
//                                    ],
//                                  )
//                                      : Container(),
//                                  Container(
//                                      child: index >= reports?.length
//                                          ? Container()
//                                          : _listItem(
//                                          settings, index, reports, context)),
//                                ],
//                              );
//                            },
////                          itemCount: reports.length-1,
//                          ),
//                        ),
//                      ),
                    ],
                  ),
                ],
              );
            },
            childCount: 57,
          ),
          // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //   maxCrossAxisExtent: 200.0,
          //   mainAxisSpacing: 10.0,
          //   crossAxisSpacing: 10.0,
          //   childAspectRatio: 4.0,
          // ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            //childAspectRatio: 2.0,
          ),
        ),
//        SliverToBoxAdapter(
//          child: Container(
//            color: Colors.yellow,
//            padding: const EdgeInsets.all(8.0),
//            child: Text('Grid Header', style: TextStyle(fontSize: 24),textScaleFactor: textScaleFactorTc),
//          ),
//        ),
//        SliverGrid.count(
//          crossAxisCount: 3,
//          mainAxisSpacing: 10.0,
//          crossAxisSpacing: 10.0,
//          childAspectRatio: 4.0,
//          children: <Widget>[
//            Container(color: Colors.red),
//            Container(color: Colors.green),
//            Container(color: Colors.blue),
//            Container(color: Colors.red),
//            Container(color: Colors.green),
//            Container(color: Colors.blue),
//          ],
//        ),
//        SliverGrid.extent(
//          maxCrossAxisExtent: 200,
//          mainAxisSpacing: 10.0,
//          crossAxisSpacing: 10.0,
//          childAspectRatio: 8.0,
//          children: <Widget>[
//            Container(color: Colors.pink),
//            Container(color: Colors.indigo),
//            Container(color: Colors.orange),
//            Container(color: Colors.pink),
//            Container(color: Colors.indigo),
//            Container(color: Colors.orange),
//          ],
//        ),
      ],
    );
  }

  _listItem(settings, index, reports, context) {
    nrTurbo = reports.length;
    var flag = reports[index].countryCompany.toLowerCase() + '.png';
    return ReusableCard(
      onPress: () {
        settings.selectedTurbo = reports[index];
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TurboInfoPage()));
      },
      colour: kActiveCardColourOutput,
      cardChild: Column(
        children: <Widget>[
          Container(
//        height: 100,
            child: ListTile(
              leading: Container(
                width: MediaQuery.of(context).size.width / 2.7,
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
                                      'Turbine A/R: ',
                                      style: kLabelTextStyle,
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
                                    'Horsepower',
                                    style: kLabelTextStyle,
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
                      ? Text(kNotApplicable)
                      : Column(
                          children: <Widget>[
                            Opacity(
                              opacity: 0.5,
                              child: Text(
                                'Comp Ind',
                                style: kLabelTextStyle,
                                textScaleFactor: textScaleFactorTc,
                              ),
                            ),
                            Container(
                              child: reports[index]?.compressorInducer == 0
                                  ? Text(kNotApplicable)
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
                      ? Text(' ')
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

  _searchBar(settings, context) {
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
                  // ignore: null_aware_in_condition
                  selected: (settings.brandNameList?.contains('Garrett'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settings.addBrandNameList('Garrett');
                    } else {
                      settings.removeBrandNameList('Garrett');
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
                  // ignore: null_aware_in_condition
                  selected: (settings.brandNameList?.contains('Borg Warner'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settings.addBrandNameList('Borg Warner');
                    } else {
                      settings.removeBrandNameList('Borg Warner');
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
                  // ignore: null_aware_in_condition
                  selected: (settings.brandNameList?.contains('Precision'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settings.addBrandNameList('Precision');
                    } else {
                      settings.removeBrandNameList('Precision');
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
                  // ignore: null_aware_in_condition
                  selected: (settings.brandNameList?.contains('Holset'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settings.addBrandNameList('Holset');
                    } else {
                      settings.removeBrandNameList('Holset');
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
                  // ignore: null_aware_in_condition
                  selected: (settings.brandNameList?.contains('Turbonetics'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settings.addBrandNameList('Turbonetics');
                    } else {
                      settings.removeBrandNameList('Turbonetics');
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
                  // ignore: null_aware_in_condition
                  selected: (settings.brandNameList?.contains('Mitsubishi'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settings.addBrandNameList('Mitsubishi');
                    } else {
                      settings.removeBrandNameList('Mitsubishi');
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
                        'Xona',
                        style: kLabelTextStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ),
                  // ignore: null_aware_in_condition
                  selected:
                      (settings.brandNameList.contains('Xona')) ? true : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settings.addBrandNameList('Xona');
                    } else {
                      settings.removeBrandNameList('Xona');
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
                        'Bullseye',
                        style: kLabelTextStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ),
                  // ignore: null_aware_in_condition
                  selected: (settings.brandNameList?.contains('Bullseye'))
                      ? true
                      : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settings.addBrandNameList('Bullseye');
                    } else {
                      settings.removeBrandNameList('Bullseye');
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
                        'IHI',
                        style: kLabelTextStyle,
                        textScaleFactor: textScaleFactorTc,
                      ),
                    ),
                  ),
                  // ignore: null_aware_in_condition
                  selected:
                      (settings.brandNameList.contains('IHI')) ? true : false,
                  onSelected: (bool value) {
                    if (value == true) {
                      settings.addBrandNameList('IHI');
                    } else {
                      settings.removeBrandNameList('IHI');
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
}
