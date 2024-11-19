import 'dart:math';
import 'package:tct/globals/global_variables.dart';
import 'package:tct/data_models/turbine_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data_models/turbo_db.dart';

class FireStoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  var random = Random();

  String sortItem = 'compressorInducer';

  int sortValue2 = 1;

  Stream<List<TurboDb>> getTurbos() {
    return _db
        .collection('turbodatabase')
        .where('aaDataStatus', isEqualTo: 'Published')
        .orderBy(sortItem, descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => TurboDb.fromJson(document.data()))
            .toList());
  }

  Stream<List<TurbineDb>> getTurbine() {
    return _db
        .collection('turbinHousing')
        .where('aaTurboModel', isEqualTo: turboModel)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => TurbineDb.fromJson(document.data()))
            .toList());
  }

  Future<void> addReport() {
    var hpMin = next(100, 1000);
    var brandName = (hpMin.isEven) ? 'Garrett' : 'Borg Warner';
    var turboModel = (hpMin < 500) ? 'Liten Turbo' : 'Stor Turbo';
    var dataMap = Map<String, dynamic>();
    dataMap['brandName'] = brandName;
    dataMap['turboModel'] = turboModel;
    dataMap['hpMin'] = hpMin;
    dataMap['timeStamp'] = DateTime.now().toIso8601String();
    return _db.collection('turbodatabase').add(dataMap);
  }

  int next(int min, int max) => min + random.nextInt(max - min);
}
