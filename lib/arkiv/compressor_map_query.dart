import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Turbocharger/globals/constants_ui.dart';


class CompressorMapQueryPage extends StatefulWidget {
  final bool metricUnit;

  CompressorMapQueryPage(
      {Key key, @required this.metricUnit, RouteSettings settings})
      : super(key: key);

  @override
  _CompressorMapQueryPageState createState() =>
      _CompressorMapQueryPageState(metricUnit);
}

class _CompressorMapQueryPageState extends State<CompressorMapQueryPage> {
  _CompressorMapQueryPageState(this.metricUnit);

  bool metricUnit = true;
  bool compressorMapQueryFlag = false;

  var compressorMaps;

  @override
  void initState() {
    super.initState();
    print(compressorMaps);
    print('metricUnit $metricUnit');

    CompressorQuery().getCompressorMaps('Garrett').then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        compressorMapQueryFlag = true;
        setState(() {
          compressorMaps = docs.documents[0].data;
        });
        print('if compressorMapQueryFlag $compressorMapQueryFlag');
        print('1)');
        print(compressorMaps['brand']);
      }
      print('2)');
      print(compressorMaps['brand']);
      print('if compressorMapQueryFlag $compressorMapQueryFlag');
    });
    print('No if compressorMapQueryFlag $compressorMapQueryFlag');
  }

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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              compressorMapQueryFlag
                  ? Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(height: 50.0, width: 50.0),
                      Text(
                        compressorMaps['brand'],
                        style: kSecondSubjectTextStyle,
                      ),
                      Text(
                        compressorMaps['turbo'],
                        style: kSecondSubjectTextStyle,
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        //height: 200.0,
                        child: Image.network(
                          compressorMaps['imageMap'],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  )
                ],
              )
                  : Text('Loading ...shit shit shit'),

//            Text(
//              compressorMaps['brand'],
//              style: kSecondSubjectTextStyle,
//            ),
            ],
          ),
        ));
  }
}

class CompressorQuery {
  getCompressorMaps(String brand) {
    return Firestore.instance
        .collection('compressormap')
        .where('brand', isEqualTo: brand)
//        .where('turbo', isEqualTo: turbo)
        .orderBy(
          'timeStamp',
          descending: true,
        )
        .getDocuments();
  }
}
