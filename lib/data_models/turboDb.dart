class TurboDb {
  final String aaBrandName;
  final String aaDataStatus;
  final String aaTurboBranchModel;
  final String aaTurboModel;
  final int aaUniqueDataId;
  final int arCompressor;
  final int arTurbine;
  final int compMapAirflowMax;
  final int compMapAirflowMin;
  final String compMapAirflowUnit;
  final int compMapPrMax;
  final int compMapPrMin;
  final int compressorExducer;
  final int compressorInducer;
  final int compressorTrim;
  final String countryCompany;
  final int displacementMax;
  final int displacementMin;
  final int displacementMaxD;
  final int displacementMinD;
  final int hpMax;
  final int hpMin;
  final int hpMaxD;
  final int hpMinD;
  final String imgCompressorMap;
  final String imgTurbineMap;
  final String imgBrandLogo;
  final String imgBranchLogo;
  final String imgTurboPic;
  final int inletTempCelsius;
  final String inletTempUnit;
  final int inletPressure;
  final String inletPressureUnit;
  final bool mapStatusCompressor;
  final bool mapStatusTurbine;
  final int compressorAR;
  final int turbineAR;
  final int turbineInducer;
  final int turbineTrim;
  final int turbineExducer;
  final String turbineInlet;
  final String turbineScroll;
  final String turbineWastegate;
  final String keyFeaturesText;
  final String timeStamp;
  final String timeStampUpdated;
  final String keyFeature_0;
  final String keyFeature_1;
  final String keyFeature_2;
  final String keyFeature_3;
  final String keyFeature_4;
  final double sortValue2;
  final String zTctDisclaimer;
  final String zTctFeedbackLink;
  final String zTurboCompanyIntellectualPropertyDisclaimer;
  final String zTurboCompanyReferenceLink;
  final String tctComment;
  final String tctInfoSource;

  TurboDb({
    this.aaBrandName,
    this.aaDataStatus,
    this.aaTurboBranchModel,
    this.aaTurboModel,
    this.aaUniqueDataId,
    this.arCompressor,
    this.arTurbine,
    this.displacementMax,
    this.displacementMin,
    this.displacementMaxD,
    this.displacementMinD,
    this.compressorExducer,
    this.turbineExducer,
    this.hpMax,
    this.hpMin,
    this.hpMaxD,
    this.hpMinD,
    this.mapStatusCompressor,
    this.mapStatusTurbine,
    this.imgCompressorMap,
    this.imgTurbineMap,
    this.imgBrandLogo,
    this.imgBranchLogo,
    this.imgTurboPic,
    this.compressorInducer,
    this.turbineInducer,
    this.compressorTrim,
    this.turbineTrim,
    this.turbineInlet,
    this.turbineScroll,
    this.turbineWastegate,
    this.compressorAR,
    this.turbineAR,
    this.compMapAirflowUnit,
    this.compMapAirflowMin,
    this.compMapAirflowMax,
    this.compMapPrMin,
    this.compMapPrMax,
    this.inletTempCelsius,
    this.inletTempUnit,
    this.inletPressure,
    this.inletPressureUnit,
    this.keyFeaturesText,
    this.countryCompany,
    this.timeStamp,
    this.timeStampUpdated,
    this.keyFeature_0,
    this.keyFeature_1,
    this.keyFeature_2,
    this.keyFeature_3,
    this.keyFeature_4,
    this.sortValue2,
    this.zTctDisclaimer,
    this.zTctFeedbackLink,
    this.zTurboCompanyIntellectualPropertyDisclaimer,
    this.zTurboCompanyReferenceLink,
    this.tctComment,
    this.tctInfoSource,
  });

  TurboDb.fromJson(Map<String, dynamic> parsedJson)
      : aaBrandName = parsedJson['aaBrandName'],
        aaDataStatus = parsedJson['aaDataStatus'],
        aaTurboBranchModel = parsedJson['aaTurboBranchModel'],
        aaTurboModel = parsedJson['aaTurboModel'],
        aaUniqueDataId = parsedJson['aaUniqueDataId'],
        arCompressor = parsedJson['arCompressor'],
        arTurbine = parsedJson['arTurbine'],
        displacementMax = parsedJson['displacementMax'],
        displacementMin = parsedJson['displacementMin'],
        displacementMaxD = parsedJson['displacementMaxD'],
        displacementMinD = parsedJson['displacementMinD'],
        compressorExducer = parsedJson['compressorExducer'],
        compressorAR = parsedJson['compressorAR'],
        turbineAR = parsedJson['turbineAR'],
        turbineExducer = parsedJson['turbineExducer'],
        hpMax = parsedJson['hpMax'],
        hpMin = parsedJson['hpMin'],
        hpMaxD = parsedJson['hpMaxD'],
        hpMinD = parsedJson['hpMinD'],
        mapStatusCompressor = parsedJson['mapStatusCompressor'],
        mapStatusTurbine = parsedJson['mapStatusTurbine'],
        imgCompressorMap = parsedJson['imgCompressorMap'],
        imgTurbineMap = parsedJson['imgTurbineMap'],
        imgBrandLogo = parsedJson['imgBrandLogo'],
        imgBranchLogo = parsedJson['imgBranchLogo'],
        imgTurboPic = parsedJson['imgTurboPic'],
        compressorInducer = parsedJson['compressorInducer'],
        turbineInducer = parsedJson['turbineInducer'],
        compressorTrim = parsedJson['compressorTrim'],
        turbineTrim = parsedJson['turbineTrim'],
        turbineInlet = parsedJson['turbineInlet'],
        turbineScroll = parsedJson['turbineScroll'],
        turbineWastegate = parsedJson['turbineWastegate'],
        compMapAirflowUnit = parsedJson['compMapAirflowUnit'],
        compMapAirflowMin = parsedJson['compMapAirflowMin'],
        compMapAirflowMax = parsedJson['compMapAirflowMax'],
        compMapPrMin = parsedJson['compMapPrMin'],
        compMapPrMax = parsedJson['compMapPrMax'],
        inletTempCelsius = parsedJson['inletTempCelsius'],
        inletTempUnit = parsedJson['inletTempUnit'],
        inletPressure = parsedJson['inletPressure'],
        inletPressureUnit = parsedJson['inletPressureUnit'],
        keyFeaturesText = parsedJson['keyFeaturesText'],
        countryCompany = parsedJson['countryCompany'],
        timeStamp = parsedJson['timeStamp'],
        timeStampUpdated = parsedJson['timeStampUpdated'],
        keyFeature_0 = parsedJson['keyFeature_0'],
        keyFeature_1 = parsedJson['keyFeature_1'],
        keyFeature_2 = parsedJson['keyFeature_2'],
        keyFeature_3 = parsedJson['keyFeature_3'],
        keyFeature_4 = parsedJson['keyFeature_4'],
        sortValue2 = parsedJson['sortValue2'],
        zTctDisclaimer = parsedJson['zTctDisclaimer'],
        zTctFeedbackLink = parsedJson['zTctFeedbackLink'],
        zTurboCompanyIntellectualPropertyDisclaimer =
        parsedJson['zTurboCompanyIntellectualPropertyDisclaimer'],
        zTurboCompanyReferenceLink = parsedJson['zTurboCompanyReferenceLink'],
        tctComment = parsedJson['tctComment'],
        tctInfoSource = parsedJson['tctInfoSource'];

  Map<String, dynamic> toMap() {
    return {
      'aaBrandName': aaBrandName,
      'aaDataStatus': aaDataStatus,
      'aaTurboBranchModel': aaTurboBranchModel,
      'aaTurboModel': aaTurboModel,
      'aaUniqueDataId': aaUniqueDataId,
      'arCompressor': arCompressor,
      'arTurbine': arTurbine,
      'displacementMax': displacementMax,
      'displacementMin': displacementMin,
      'compressorExducer': compressorExducer,
      'compressorAR': compressorAR,
      'turbineAR': turbineAR,
      'turbineExducer': turbineExducer,
      'hpMax': hpMax,
      'hpMin': hpMin,
      'hpMaxD': hpMaxD,
      'hpMinD': hpMinD,
      'mapStatusCompressor': mapStatusCompressor,
      'mapStatusTurbine': mapStatusTurbine,
      'imgCompressorMap': imgCompressorMap,
      'imgTurbineMap': imgTurbineMap,
      'imgBrandLogo': imgBrandLogo,
      'imgBranchLogo': imgBranchLogo,
      'imgTurboPic': imgTurboPic,
      'compressorInducer': compressorInducer,
      'turbineInducer': turbineInducer,
      'compressorTrim': compressorTrim,
      'turbineTrim': turbineTrim,
      'turbineInlet': turbineInlet,
      'turbineScroll': turbineScroll,
      'turbineWastegate': turbineWastegate,
      'compMapAirflowUnit': compMapAirflowUnit,
      'compMapAirflowMin': compMapAirflowMin,
      'compMapAirflowMax': compMapAirflowMax,
      'compMapPrMin': compMapPrMin,
      'compMapPrMax': compMapPrMax,
      'inletTempCelsius': inletTempCelsius,
      'inletTempUnit': inletTempUnit,
      'inletPressure': inletPressure,
      'inletPressureUnit': inletPressureUnit,
      'keyFeaturesText': keyFeaturesText,
      'countryCompany': countryCompany,
      'timeStamp': timeStamp,
      'timeStampUpdated': timeStampUpdated,
      'sortValue2': sortValue2,
      'zTctDisclaimer': zTctDisclaimer,
      'zTctFeedbackLink': zTctFeedbackLink,
      'zTurboCompanyIntellectualPropertyDisclaimer':
      zTurboCompanyIntellectualPropertyDisclaimer,
      'zTurboCompanyReferenceLink': zTurboCompanyReferenceLink,
      'tctComment': tctComment,
      'tctInfoSource': tctInfoSource,
    };
  }
}
