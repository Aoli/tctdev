import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Turbocharger/globals/constants_ui.dart';


class CompressorMapChipsPage extends StatefulWidget {
  final bool metricUnit;

  CompressorMapChipsPage({Key key, @required this.metricUnit, RouteSettings settings})
      : super(key: key);

  @override
  _CompressorMapChipsPageState createState() =>
      _CompressorMapChipsPageState(metricUnit);
}

class _CompressorMapChipsPageState extends State<CompressorMapChipsPage> {
  bool metricUnit;

  _CompressorMapChipsPageState(this.metricUnit);

  Color caughtColor = Colors.grey;

  double redLength = 30.0;
  double blueLength = 20.0;

  @override
  Widget build(BuildContext context) {
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
                'Compressor Maps',
                style: kAppBarTextStyle,
                textScaleFactor: textScaleFactorTc,
              ),
              Container(width: 30.0),
            ],
          ),
        ),
        body: Container(
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('compressormap')
                  .orderBy(
                'turbo',
                descending: false,
              )
                  .snapshots(),
//            Firestore.instance.collection('compressormap').where('brand', isEqualTo: 'Garrett')
//                .orderBy(
//              'turbo',
//              descending: false,
//            ).snapshots(),

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(child: Text('No data'));
                } else if (snapshot == null) {
                  return Container(
                    child: Text('Data = Null'),
                  );
                } else {
                  return ListView.builder(


                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot myCompressor =
                        snapshot.data.documents[index];
                        return
                          Stack(
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              '${myCompressor['brand']}',
                                              style:
                                              kLabelTextStyle,
                                              textScaleFactor:
                                              textScaleFactorTc,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '${myCompressor['turbo']}',
                                              style:
                                              kLabelTextStyle,
                                              textScaleFactor:
                                              textScaleFactorTc,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 10,
                                    //height: 350.0,
                                    child: Padding(
                                      padding:
                                      EdgeInsets.only(top: 20.0, bottom: 5.0),
                                      child: Material(
                                        //color: Colors.white70,
                                        elevation: 7.0,
                                        shadowColor: Color(0x802196F3),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width / 4,
                                                  //height: 200.0,
                                                  child: Image.network(
                                                    '${myCompressor['imageMap']}',
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
//                                              SizedBox(height: 10.0),
//                                              Column(
//                                                children: <Widget>[
//                                                  Row(
//                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                    children: <Widget>[
//                                                      Container(
//                                                        child: Text(
//                                                          '${myCompressor['brand']}',
//                                                          style:
//                                                              kCompressorMapTextStyle,
//                                                          textScaleFactor:
//                                                              textScaleFactorTc*0.7,
//                                                        ),
//                                                      ),
//                                                      Container(
//                                                        child: Text(
//                                                          '${myCompressor['turbo']}',
//                                                          style:
//                                                              kCompressorMapTextStyle,
//                                                          textScaleFactor:
//                                                              textScaleFactorTc*.7,
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                ],
//                                              ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]);
                      });
                }
              }),
        ));
  }
}
