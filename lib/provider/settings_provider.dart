import 'dart:convert';

import 'package:tct/data_models/turbo_db.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tct/data_models/MapSave_ArRatio.dart';

class SettingsNotifier with ChangeNotifier {
  String _units = 'Imperial';
  List<String> _brandNameList = [];
  double _sortValue2 = 550.0;
  late TurboDb _selectedTurbo;

  SettingsNotifier() {
    _units = 'Imperial';
    _brandNameList = [];
    loadPreferences();
  }

  //Getters
  String get units => _units;
  List<String> get brandNameList => _brandNameList;
  TurboDb get selectedTurbo => _selectedTurbo;
  double get sortValue2 => _sortValue2;

  //Setters
  void setUnits(String units) {
    _units = units;
    notifyListeners();
    savePreferences();
  }

  set selectedTurbo(TurboDb turbo) {
    _selectedTurbo = turbo;
    notifyListeners();
  }

  void setSortValue2(double sortValue2) {
    _sortValue2 = sortValue2;
    notifyListeners();
    savePreferences();
  }

  void _setBrandNameList(List<String> brandNameList) {
    _brandNameList = brandNameList;
    notifyListeners();
  }

  void addBrandNameList(String brandNameList) {
    if (_brandNameList.contains(brandNameList) == false) {
      _brandNameList.add(brandNameList);
      notifyListeners();
      savePreferences();
    }
  }

  void removeBrandNameList(String brandNameList) {
    if (_brandNameList.contains(brandNameList) == true) {
      _brandNameList.remove(brandNameList);
      notifyListeners();
      savePreferences();
    }
  }

//  void _setArValues(Map<String, dynamic> arValues) {
//   _arValues = arValues as ArRatioMap;
//    notifyListeners();
//  }

//  void addArValues(Map arValues) {
//    if (_arValues.containsKey(arValues) == false) {
//      _arValues.update("a", (arValues) => arValues);
//      notifyListeners();
//      savePreferences();
//    }
//  }
//
//  void removeArValues(String arValues) {
//    if (_arValues.containsKey(arValues) == true) {
//      _arValues.removeKey(arValues);
//      notifyListeners();
//      savePreferences();
//    }
//  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('units', _units);
    prefs.setStringList('brandNameList', _brandNameList);
    prefs.setDouble('sortValue2', _sortValue2);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? units = prefs.getString('units');
    List<String>? brandNameList = prefs.getStringList('brandNameList');
    double? sortValue2 = prefs.getDouble('sortValue2');

    if (units != null) setUnits(units);
    if (brandNameList != null) _setBrandNameList(brandNameList);
    if (sortValue2 != null) setSortValue2(sortValue2);
  }
}
