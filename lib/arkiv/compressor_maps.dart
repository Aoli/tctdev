import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tct/globals/constants_ui.dart';

class CompressorMapPage extends StatefulWidget {
  final bool metricUnit;

  CompressorMapPage(
      {Key key, @required this.metricUnit, RouteSettings settings})
      : super(key: key);

  @override
  _CompressorMapPageState createState() => _CompressorMapPageState(metricUnit);
}

class _CompressorMapPageState extends State<CompressorMapPage> {
  bool metricUnit;

  _CompressorMapPageState(this.metricUnit);

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
      body: StreamBuilder(
          stream: Firestore.instance.collection('compressormap').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(width: 0.0, height: 0.0);
            } else if (snapshot == null) {
              return Container(width: 0.0, height: 0.0);
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot myCompressor =
                        snapshot.data.documents[index];
                    return Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20,
                            //height: 350.0,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Material(
                                color: Colors.white,
                                elevation: 14.0,
                                shadowColor: Color(0x802196F3),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          //height: 200.0,
                                          child: Image.network(
                                            '${myCompressor['imageMap']}',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                '${myCompressor['brand']}',
                                                style: kCompressorMapTextStyle,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '${myCompressor['turbo']}',
                                                style: kCompressorMapTextStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1, color: Colors.red),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'TCT are currently pre-viewing a small collection of compressor maps. Later in 2020 when the needed Airflow/Pr-calculations are in place, we will add a lot more compressor maps, and a "search function" to help you find the right turbo and related compressor maps for your project. TurboCharger Tuning is not affiliated with any company behind those maps.',
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Colors.black),
                                                    textScaleFactor:
                                                        textScaleFactorTc * 0.8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }
          }),
    );
  }
}
