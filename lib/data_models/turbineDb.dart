class TurbineDb {
  final String aaStatus;
  final String aaTurboModel;
  final String arTurbine;
  final String divided;
  final Map imgInletMap;
  final Map imgOutletMap;
  final String scroll;
  final String turbineInlet;
  final String turbineOutlet;
  final String wastegate;

  TurbineDb({
    this.aaStatus,
    this.aaTurboModel,
    this.arTurbine,
    this.divided,
    this.imgInletMap,
    this.imgOutletMap,
    this.scroll,
    this.turbineInlet,
    this.turbineOutlet,
    this.wastegate,
  });

  TurbineDb.fromJson(Map<String, dynamic> parsedJson)
      : aaStatus = parsedJson['aaStatus'],
        aaTurboModel = parsedJson['aaTurboModel'],
        arTurbine = parsedJson['arTurbine'],
        divided = parsedJson['divided'],
        imgInletMap = parsedJson['imgInletMap'],
        imgOutletMap = parsedJson['imgOutletMap'],
        scroll = parsedJson['scroll'],
        turbineInlet = parsedJson['turbineInlet'],
        turbineOutlet = parsedJson['turbineOutlet'],
        wastegate = parsedJson['wastegate'];

//  Map<String, dynamic> toMap() {
//    return {
//      'aaBrandName': aaBrandName,
//      'aaDataStatus': aaDataStatus,
//      'aaTurboBranchModel': aaTurboBranchModel,
//      'aaTurboModel': aaTurboModel,
//      'aaUniqueDataId': aaUniqueDataId,
//      'arCompressor': arCompressor,
//      'arTurbine': arTurbine,
//      'displacementMax': displacementMax,
//      'displacementMin': displacementMin,
//      'compressorExducer': compressorExducer,
//      'compressorAR': compressorAR,
//      'turbineAR': turbineAR,
//      'turbineExducer': turbineExducer,
//      'hpMax': hpMax,
//      'hpMin': hpMin,
//      'hpMaxD': hpMaxD,
//      'hpMinD': hpMinD,
//      'mapStatusCompressor': mapStatusCompressor,
//      'mapStatusTurbine': mapStatusTurbine,
//      'imgCompressorMap': imgCompressorMap,
//      'imgTurbineMap': imgTurbineMap,
//      'imgBrandLogo': imgBrandLogo,
//      'imgBranchLogo': imgBranchLogo,
//      'imgTurboPic': imgTurboPic,
//      'compressorInducer': compressorInducer,
//      'turbineInducer': turbineInducer,
//      'compressorTrim': compressorTrim,
//      'turbineTrim': turbineTrim,
//      'turbineInlet': turbineInlet,
//      'turbineScroll': turbineScroll,
//      'turbineWastegate': turbineWastegate,
//      'compMapAirflowUnit': compMapAirflowUnit,
//      'compMapAirflowMin': compMapAirflowMin,
//      'compMapAirflowMax': compMapAirflowMax,
//      'compMapPrMin': compMapPrMin,
//      'compMapPrMax': compMapPrMax,
//      'inletTempCelsius': inletTempCelsius,
//      'inletTempUnit': inletTempUnit,
//      'inletPressure': inletPressure,
//      'inletPressureUnit': inletPressureUnit,
//      'keyFeaturesText': keyFeaturesText,
//      'countryCompany': countryCompany,
//      'timeStamp': timeStamp,
//      'timeStampUpdated': timeStampUpdated,
//      'sortValue2': sortValue2,
//      'zTctDisclaimer': zTctDisclaimer,
//      'zTctFeedbackLink': zTctFeedbackLink,
//      'zTurboCompanyIntellectualPropertyDisclaimer':
//      zTurboCompanyIntellectualPropertyDisclaimer,
//      'zTurboCompanyReferenceLink': zTurboCompanyReferenceLink,
//      'tctComment': tctComment,
//      'tctInfoSource': tctInfoSource,
//    };
//  }
}
