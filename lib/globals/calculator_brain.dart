import 'dart:math';
import 'package:Turbocharger/globals/constant.dart';
import 'package:flutter/cupertino.dart';

class CalculatorBrain {
  CalculatorBrain({this.compressorInducerSize,
    this.compressorExducerSize,
    this.turbineInducerSize,
    this.turbineExducerSize});

  final double compressorInducerSize;
  final double compressorExducerSize;
  final double turbineInducerSize;
  final double turbineExducerSize;

// ************************* Generic Calculation ******************************

  double calculatePetrolHp(double compressorInducerSize) {
    double petrolHp = pow(compressorInducerSize, 2) / (2 * (exp(1)));
    return petrolHp;
  }

  double calculateDieselHp(double compressorInducerSize) {
    double dieselHp = 0.6 * (pow(compressorInducerSize, 2) / (2 * (exp(1))));
    return dieselHp;
  }

  double calculateCompressorTrim(double compressorInducerSize,
      double compressorExducerSize) {
    double compressorTrim = (100 *
        ((pow(compressorInducerSize, 2)) / (pow(compressorExducerSize, 2))));

    return compressorTrim;
  }

//************************* Compressor Metric calculation ***************************

  double calculateCompressorPressure(double compressorInducerSize,
      double compressorExducerSize) {
    double compressorPressure = (1 *
        ((pow(compressorExducerSize, 2)) / (pow(compressorInducerSize, 2))));
    return compressorPressure;
  }

  //************************* Compressor Imperial calculation ***************************

//************************* Turbine Metric calculation ***************************

  double calculateTurbineTrim(double turbineInducerSize,
      double turbineExducerSize) {
    double turbineTrim =
    (100 * ((pow(turbineExducerSize, 2)) / (pow(turbineInducerSize, 2))));
    return turbineTrim;
  }

  double calculateTurbinePressure(double turbineInducerSize,
      double turbineExducerSize) {
    double turbinePressure =
    (1 * ((pow(turbineInducerSize, 2)) / (pow(turbineExducerSize, 2))));
    return turbinePressure;
  }

//******************** Calculate Airflow and Pressure Ratio ******************

  double calcDesiredWheelHorsepower(double desiredEngineHorsepower,
      double desiredDriveTrainPower) {
    double desiredWheelHorsepower =
        desiredEngineHorsepower * (desiredDriveTrainPower / 100);
    return desiredWheelHorsepower;
  }

  double calcMassFlowRatePoundMinute(double desiredEngineHorsepower,
      double bsfc, double afr) {
    double massFlowRatePoundMinute =
        (desiredEngineHorsepower * (bsfc) * afr) / 60;
    return massFlowRatePoundMinute;
  }

  double calcMassFlowRatePoundMinuteTbp(double targetBoostPressure,
      double engineDisplacement,
      double volumetricEfficiency,
      double maxEngineSpeed,
      double intakeTempAtValve,
      double vAirflowPsiAmbient,
      double numberOfTurbos) {
    double n1;
    double n2;
    double n3;
    double n4;
    double n5;

    n1 = engineDisplacement * 61.0237441 / 1728;
    n2 = maxEngineSpeed / 2;
    n3 = (vAirflowPsiAmbient + targetBoostPressure);
    n4 = 29 / (10.73 * (intakeTempAtValve + 460));
    n5 = (volumetricEfficiency / 100) / numberOfTurbos;

    double massFlowRatePoundMinute = n1 * n2 * n3 * n4 * n5;

    return massFlowRatePoundMinute;
  }

// =((engineDisplacement*61,0237441/1728*maxEngineSpeed/2)*(vAirflowPsiAmbient+targetBoostPressure)*29/(10,73*(intakeTempAtValve+460)))*volumetricEfficiency/numberOfTurbos
  double calcCubicMeterPerSecond(double poundPerMinute) {
    double cubicMeterPerSecond = poundPerMinute / 171;
    return cubicMeterPerSecond;
  }

  double calcCubicFeetPerMinute(double cubicMeterPerSecond) {
    double cubicFeetPerMinute =
        cubicMeterPerSecond * kCubicMeterPerSecondToCubicFeetPerMinute;
    return cubicFeetPerMinute;
  }

  double calcCubicPoundMinute(double vAirflowCfm, double vAirflowManifoldTemp,
      double vAirflowPsi, double vAirflowPsiG) {
    var upper = vAirflowCfm * kAirflow144P * (vAirflowPsi + vAirflowPsiG);
    print(vAirflowCfm);
//    print('upper $upper');
    var lower = kAirflowGasConstant *
        (kAirflowTempMinusManifold + vAirflowManifoldTemp) *
        kAirflowCompressibility;

//    print('lower $lower');
    print(upper / lower);

    return upper / lower;
  }

  double calcCubicFeetPerMinuteExact(double vAirflowPoundMinute,
      double vAirflowManifoldTemp, double vAirflowPsi, double vAirflowPsiG) {
    var upper = vAirflowPoundMinute *
        kAirflowGasConstant *
        (kAirflowTempMinusManifold + vAirflowManifoldTemp) *
        kAirflowCompressibility;
    var lower = kAirflow144P * (vAirflowPsi + vAirflowPsiG);

//    print(upper);
//    print(lower);
//    print(upper/lower);

    return upper / lower;
  }

  double calcCubicPoundMinuteManiFoldTemp(double vAirflowCfm,
      double vAirflowManifoldTemp,
      double vAirflowPsi, double vAirflowPsiG) {
    var upper = vAirflowCfm * kAirflow144P * (vAirflowPsi + vAirflowPsiG);
//    print(vAirflowCfm);
//    print('upper $upper');
    var lower = kAirflowGasConstant *
        (kAirflowTempMinusManifold + vAirflowManifoldTemp) *
        kAirflowCompressibility;

//    print('lower $lower');
//    print(upper / lower);

    return upper / lower;
  }

  double calcCubicFeetPerMinuteManifoldTemp(double vAirflowPoundMinute,
      double vAirflowManifoldTemp, double vAirflowPsi, double vAirflowPsiG) {
    var upper = vAirflowPoundMinute *
        kAirflowGasConstant *
        (kAirflowTempMinusManifold + vAirflowManifoldTemp) *
        kAirflowCompressibility;
    var lower = kAirflow144P * (vAirflowPsi + vAirflowPsiG);

    return upper / lower;
  }

//  double vAirflowPsiG=14.7;
//  double vAirflowPsi=14.7;
//  double vAirflowPsiA = 29.4;
//  double vAirflowCfm = 500;
//  double vAirflowPoundMinute=52.33;

//  const kAirflowGasConstant = 1545/28.964; //53,34207982
//  const kAirflowTempMinusManifold = 440;
//  const kAirflowCompressibility = 1;
//  const kAirflowPsiA = 29.4;
//  const kAirflow144P=144;

  double calcRequiredAbsolutePressure(double massFlowRatePoundMinute,
      double engineDisplacment,
      double volumeEffiency,
      double maxEngineSpeed,
      double intakeTempValve,
      double gasConstant,
      double numberOfTurbos) {
    double requiredAbsolutePressure =
    ((massFlowRatePoundMinute * gasConstant * (460 + intakeTempValve)) /
        (61.0237441 *
            ((volumeEffiency / 100) *
                (maxEngineSpeed / 2) *
                engineDisplacment) /
            numberOfTurbos));

    return requiredAbsolutePressure;
  }

  double calcResultantManifoldPressure(double requiredAbsolutePressure,
      double vAirflowPsiAmbient) {
    double resultantManifoldPressure =
        requiredAbsolutePressure - vAirflowPsiAmbient;
    return resultantManifoldPressure;
  }

  double calcPressureRatio(double vAirflowPsiG,
      double vAirflowPsiAmbient,
      double preTurboFlowLoss,
      double postTurboFlowLoss) {
    double pressureRatio = (vAirflowPsiG + vAirflowPsiAmbient +
        postTurboFlowLoss) /
        (vAirflowPsiAmbient - preTurboFlowLoss);
    return pressureRatio;
  }

// ***************** CONVERSIONS *****************************************************************************

  double calculateKnotsToMph(double knots) {
    double resultMph = knots * kConvertSpeedKnotsToMph;
    return resultMph;
  }

  double calculateKnotsToKmh(double knots) {
    double resultKmh = knots * kConvertSpeedKnotsToKmh;
    return resultKmh;
  }

  double calculateKnotsToFeetPerSecond(double knots) {
    double resultFeetPerSecond = knots * kConvertSpeedKnotsToFeetPerSecond;
    return resultFeetPerSecond;
  }

  // Length ************************************************************

  // Meter

  // Kilometer
  double calculateKilometerToNauticalMile(double kilometer) {
    double resultKilometerToNauticalMile =
        kilometer * kConvertDistanceKilometerToNauticalMile;
    return resultKilometerToNauticalMile;
  }

  double calculateKilometerToMile(double kilometer) {
    double resultKilometerToMile = kilometer * kConvertDistanceKilometerToMile;
    return resultKilometerToMile;
  }

  // Nautical Mile
  double calculateNauticalMileToMeter(double nauticalmile) {
    double resultNauticalMileToMeter =
        nauticalmile * kConvertDistanceNauticalMileToMeter;
    return resultNauticalMileToMeter;
  }

  double calculateNauticalMileToMile(double nauticalmile) {
    double resultNauticalMileToMile =
        nauticalmile * kConvertDistanceNauticalMileToMile;
    return resultNauticalMileToMile;
  }

  double calculateNauticalMileToKm(double nauticalmile) {
    double resultNauticalMileToKm =
        nauticalmile * kConvertDistanceNauticalMileToKm;
    return resultNauticalMileToKm;
  }

  double calculateMileToNauticalMile(double mile) {
    double resultNauticalMileToMile = mile * kConvertDistanceMileToNauticalMile;
    return resultNauticalMileToMile;
  }

  double calculateMileToKilometer(double mile) {
    double resultMileToKm = mile * kConvertDistanceNauticalMileToKm;
    return resultMileToKm;
  }

  // ******** Pressure conversion

  double calculateBar(convertResultPressurePsi) {
    if (convertResultPressurePsi < (kMinPressurePsi * 2)) {
      return 0.1;
    } else {
      double convertResultPressureBar =
          convertResultPressurePsi * kConvertPressurePsiToBar;
      convertResultPressureBar = convertResultPressureBar.abs();
      // debugPrint('B convertResultPressurePsi $convertResultPressurePsi');
      // debugPrint('B convertResultPressureBar $convertResultPressureBar');
      // debugPrint('B kConvertPressurePsiToBar $kConvertPressurePsiToBar');
      // debugPrint('BP convertResultPressurePsi $convertResultPressurePsi');
      // debugPrint('BP convertResultPressureBar $convertResultPressureBar');
      // debugPrint('BP kConvertPressureBarToPsi $kConvertPressureBarToPsi');
      return convertResultPressureBar;
    }
  }

  double calculatePsi(convertResultPressureBar) {
    if (convertResultPressureBar > (kMaxPressureBar - 0.01)) {
      return kMaxPressurePsi;
    } else {
      double convertResultPressurePsi =
          convertResultPressureBar * kConvertPressureBarToPsi;

      // debugPrint('B convertResultPressurePsi $convertResultPressurePsi');
      // debugPrint('B convertResultPressureBar $convertResultPressureBar');
      // debugPrint('B kConvertPressurePsiToBar $kConvertPressurePsiToBar');
      // debugPrint('PB convertResultPressurePsi $convertResultPressurePsi');
      // debugPrint('PB convertResultPressureBar $convertResultPressureBar');
      // debugPrint('PB kConvertPressureBarToPsi $kConvertPressureBarToPsi');
      return convertResultPressurePsi;
    }
  }

  double calculateAtmosphere(convertResultPressureBar) {
    double convertResultPressureAtmosphere =
        convertResultPressureBar * kConvertPressureBarToAtmosphere;
    return convertResultPressureAtmosphere;
  }

  double calculateKiloPascal(convertResultPressureBar) {
    double convertResultPressureKiloPascal =
        convertResultPressureBar * kConvertPressureBarToKiloPascal;
    return convertResultPressureKiloPascal;
  }

  double calculateTorr(convertResultPressureBar) {
    double convertResultPressureTorr =
        convertResultPressureBar * kConvertPressureBarToTorr;
    return convertResultPressureTorr;
  }

  double calculateInchOfMercury(convertResultPressureBar) {
    double convertResultPressureInchOfMercury =
        convertResultPressureBar * kConvertPressureBarToInchOfMercuryColumn;
    return convertResultPressureInchOfMercury;
  }

  //********* Length Conversion

  double calculateMillimeter(convertResultLengthInch) {
    if (convertResultLengthInch > (kMaxLengthInch - 0.1)) {
      return kMaxLengthMillimeter;
    } else {
      double convertResultLengthMillimeter =
          convertResultLengthInch * kConvertLengthInchToMillimeter;
      return convertResultLengthMillimeter;
    }
  }

  double calculateInch(convertResultLengthMillimeter) {
    if (convertResultLengthMillimeter > (kMaxLengthMillimeter - 0.01)) {
      return kMaxLengthInch;
    } else {
      double convertResultLengthInch = convertResultLengthMillimeter * 1;
      return convertResultLengthInch;
    }
  }

  double conversionCalc(valueOfUnitFrom, unitFormula) {
    // String unitFormula;
    debugPrint('unitForumula $unitFormula');
    debugPrint('valueOfUnitFrom $valueOfUnitFrom');

    switch (unitFormula) {
    // *** Convert Length
      case 'LengthInchToMillimeter':
        double valueReturn = valueOfUnitFrom * kConvertLengthInchToMillimeter;
        return valueReturn;
      case 'LengthMillimeterToInch':
        double valueReturn = valueOfUnitFrom * kConvertLengthMillimeterToInch;
        return valueReturn;
      case 'LengthMillimeterToMeter':
        double valueReturn = valueOfUnitFrom * kConvertLengthMillimeterToMeter;
        return valueReturn;

    // *** Convert Pressure Bar
      case 'PressureBarToAtmosphere':
        double valueReturn = valueOfUnitFrom * kConvertPressureBarToAtmosphere;
        return valueReturn;
      case 'PressureBarToTorr':
        double valueReturn = valueOfUnitFrom * kConvertPressureBarToTorr;
        return valueReturn;
      case 'PressureBarToInchOfMercuryColumn':
        double valueReturn =
            valueOfUnitFrom * kConvertPressureBarToInchOfMercuryColumn;
        return valueReturn;
      case 'PressurePsiToInchOfMercuryColumn':
        double valueReturn =
            valueOfUnitFrom * kConvertPressurePsiToInchOfMercuryColumn;
        return valueReturn;
      case 'PressureBarToKiloPascal':
        double valueReturn = valueOfUnitFrom * kConvertPressureBarToKiloPascal;
        return valueReturn;
      case 'PressureBarToPsi':
        debugPrint('BarToPsi: valueOfUnitFrom $valueOfUnitFrom');
        double valueReturn = valueOfUnitFrom * kConvertPressureBarToPsi;
        return valueReturn;

    // *** Convert Pressure Psi
      case 'PressurePsiToBar':
        debugPrint('PsiToBar: valueOfUnitFrom $valueOfUnitFrom');
        double valueReturn = valueOfUnitFrom * kConvertPressurePsiToBar;
        return valueReturn;
      case 'PressurePsiToKiloPascal':
        double valueReturn = valueOfUnitFrom * kConvertPressurePsiToKiloPascal;
        return valueReturn;
      case 'PressurePsiToAtmosphere':
        double valueReturn = valueOfUnitFrom * kConvertPressurePsiToAtmosphere;
        return valueReturn;

    // *** Convert Distance
      case 'DistanceNauticalMileToKm':
        double valueReturn = valueOfUnitFrom * kConvertDistanceNauticalMileToKm;
        return valueReturn;
      case 'DistanceNauticalMileToMile':
        double valueReturn =
            valueOfUnitFrom * kConvertDistanceNauticalMileToMile;
        return valueReturn;
      case 'DistanceKilometerToMile;':
        double valueReturn = valueOfUnitFrom * kConvertDistanceKilometerToMile;
        return valueReturn;
      case 'DistanceKilometerToNauticalMile;':
        double valueReturn =
            valueOfUnitFrom * kConvertDistanceKilometerToNauticalMile;
        return valueReturn;
      case 'DistanceMileToKm':
        double valueReturn = valueOfUnitFrom * kConvertDistanceMileToKm;
        return valueReturn;
      case 'DistanceMileToNauticalMile':
        double valueReturn =
            valueOfUnitFrom * kConvertDistanceMileToNauticalMile;
        return valueReturn;

    // *** Convert Mass
      case 'MassKilogramToPound':
        double valueReturn = valueOfUnitFrom * kConvertMassKilogramToPound;
        return valueReturn;
      case 'MassGramToPound':
        double valueReturn = valueOfUnitFrom * kConvertMassGramToPound;
        return valueReturn;
      case 'MassPoundToKilogram':
        double valueReturn = valueOfUnitFrom * kConvertMassPoundToKilogram;
        return valueReturn;
      case 'MassPoundToGram':
        double valueReturn = valueOfUnitFrom * kConvertMassPoundToGram;
        return valueReturn;
      case 'MassGramToKilogram':
        double valueReturn = valueOfUnitFrom * kConvertMassGramToKilogram;
        return valueReturn;
      case 'MassKilogramToGram':
        double valueReturn = valueOfUnitFrom * kConvertMassKilogramToGram;
        return valueReturn;
    // ***** Convert Temperature

      case 'TemperatureCelsiusToFahrenheit':
        double valueReturn = (valueOfUnitFrom * 9 / 5) + 32;
        return valueReturn;
      case 'TemperatureFahrenheitToCelsius':
        double valueReturn = (valueOfUnitFrom - 32) * 5 / 9;
        return valueReturn;

    // *** Convert Speed
      case 'SpeedKilometerPerHourToMilesPerHour':
        debugPrint('Multi_Mph $valueOfUnitFrom');
        double valueReturn =
            valueOfUnitFrom * kConvertSpeedKilometerPerHourToMilesPerHour;
        debugPrint('Mph $valueReturn');
        return valueReturn;

      case 'SpeedMilesPerHourToKilometerPerHour':
        print('Multi_Kmh $valueOfUnitFrom');
        double valueReturn =
            valueOfUnitFrom * kConvertSpeedMilesPerHourToKilometerPerHour;
        print('Kmh $valueReturn');
        return valueReturn;

    // *** Convert Volume

      case 'VolumeUsLiquidGallonToLiter':
        double valueReturn =
            valueOfUnitFrom * kConvertVolumeUsLiquidGallonToLiter;
        print(valueReturn);
        return valueReturn;
      case 'VolumeUsLiquidGallonToCubicCentimeter':
        double valueReturn =
            valueOfUnitFrom * kConvertVolumeUsLiquidGallonToCubicCentimeter;
        print(valueReturn);
        return valueReturn;
      case 'VolumeUsLiquidGallonToCubicInch':
        double valueReturn =
            valueOfUnitFrom * kConvertVolumeUsLiquidGallonToCubicInch;
        print(valueReturn);
        return valueReturn;

      case 'VolumeLiterToUsLiquidGallon':
        double valueReturn =
            valueOfUnitFrom * kConvertVolumeLiterToUsLiquidGallon;
        print(valueReturn);
        return valueReturn;
      case 'VolumeLiterToCubicCentimeter':
        double valueReturn =
            valueOfUnitFrom * kConvertVolumeLiterToCubicCentiMeter;
        print(valueReturn);
        return valueReturn;
      case 'VolumeLiterToCubicInch':
        double valueReturn = valueOfUnitFrom * kConvertVolumeLiterToCubicInch;
        print(valueReturn);
        return valueReturn;

      case 'VolumeCubicCentimeterToUsLiquidGallon':
        double valueReturn =
            valueOfUnitFrom * kConvertVolumeCubicCentiMeterToUsLiquidGallon;
        print(valueReturn);
        return valueReturn;
      case 'VolumeCubicCentimeterToLiter':
        double valueReturn =
            valueOfUnitFrom * kConvertVolumeCubicCentiMeterToLiter;
        print(valueReturn);
        return valueReturn;
      case 'VolumeCubicCentimeterToCubicInch':
        double valueReturn =
            valueOfUnitFrom * kConvertVolumeCubicCentiMeterToCubicInch;
        print(valueReturn);
        return valueReturn;

      case 'VolumeCubicInchToUsLiquidGallon':
        double valueReturn =
            valueOfUnitFrom * kConvertVolumeCubicInchToUsLiquidGallon;
        print(valueReturn);
        return valueReturn;
      case 'VolumeCubicInchToLiter':
        double valueReturn = valueOfUnitFrom * kConvertVolumeCubicInchToLiter;
        print(valueReturn);
        return valueReturn;
      case 'VolumeCubicInchToCubicCentimeter':
        double valueReturn =
            valueOfUnitFrom * kConvertVolumeCubicInchToCubicCentiMeter;
        print(valueReturn);
        return valueReturn;
    }
    return 0;
  }

  //************** Airflow density

  double calcAirflow(valueOfUnitFrom, vAirDensityAirflow, unitFormula) {
    // String unitFormula;
    debugPrint('unitForumula $unitFormula');
    debugPrint('valueOfUnitFrom $valueOfUnitFrom');

    switch (unitFormula) {
    // *** Convert Length
      case 'AirflowAirDensityPoundPerMinuteToCfm':
        double valueReturn = valueOfUnitFrom / vAirDensityAirflow;
        return valueReturn;
      case 'AirflowAirDensityCfmToPoundPerMinute':
        double valueReturn = valueOfUnitFrom * vAirDensityAirflow;
        return valueReturn;
    }
    return 0;
  }

  //AirflowAirDensityCfmToCubicMeterPerMinute
  //AirflowAirDensityCfmToCubicMeterPerSecond

//******************** Start Calculate Time **************************************

  double calculateHourMinutesKnotsNauticalMile(double speed, double length) {
    double resultMinutes = (length * 60) / speed;
    print('resultminutes: $resultMinutes');
    resultMinutes = resultMinutes + 0.5;

    int minuteValue = resultMinutes.toInt();

    final int resultHour = minuteValue ~/ 60;
    final int minutes = minuteValue % 60;
    print(
        '${resultHour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(
            2, "0")}');
    return resultMinutes;
  }

  double calculateHourMinutesKmPerHourKilometer(double speed, double length) {
    length = length / 1000; // Kilometer -> Meter
    speed = speed / 3.6; // Kilometer/hour -> Meter/Second
    double resultSecond = speed * length;
// 20 m/s * 630m = 12600 s
    double resultMinutes = resultSecond * 60;
// -> 210 min
    double resultHour = resultMinutes * 60;
    // 3.50
    // double resultHour =  resultMinutes/60;
    return resultHour;
  }

//******************** Engine Calculations **************************************

  double calculateEngineLiter(double boreInput, double strokeInput,
      int cylinderInput, bool metricUnit) {
    double engineCid =
        pow(boreInput, 2) * strokeInput * kPiDiv4 * cylinderInput / 1000000;
    print('Liter boreInput $boreInput');
    print('Liter strokeInput $strokeInput');
    print('Liter engineCid $engineCid');
    return engineCid;
  }

  double calculateEngineCubicCentimeter(double boreInput, double strokeInput,
      int cylinderInput, bool metricUnit) {
    double engineCid =
        pow(boreInput, 2) * strokeInput * kPiDiv4 * cylinderInput / 1000;
//    print('CC boreInput $boreInput');
//    print('CC strokeInput $strokeInput');
//    print('CC engineCid $engineCid');
    return engineCid;
  }

  double calculateEngineCubicInch(double boreInput, double strokeInput,
      int cylinderInput, bool metricUnit) {
    double engineCid =
        pow(boreInput, 2) * strokeInput * kPiDiv4 * cylinderInput;
//    print('Ci boreInput $boreInput');
//    print('Ci strokeInput $strokeInput');
//    print('Ci engineCid $engineCid');
    return engineCid;
  }

  double calcTempFahrenheit(double tempCelsius) {
    double resultFahrenheit = (tempCelsius * 9 / 5) + 32;
//    print('tempCelsius brain $tempCelsius');
    return resultFahrenheit;
  }

  double calcTempCelsius(double tempFahrenheit) {
    double resultCelsius = (tempFahrenheit - 32) * (5 / 9);
//    print('tempFahrenheit brain $tempFahrenheit');
    return resultCelsius;
  }

  double calcEngineDisplacementCidAirflow(double engineDisplacement) {
    double engineDisplacementCid = engineDisplacement * 61.0237;
    // int temp = engineDisplacementCid.toInt();
    // engineDisplacementCid = temp.toDouble();
//    print('engineDisplacementCid brain $engineDisplacementCid');
//    print(
//        'kMaxCubicInchEngineDisplacement brain $kMaxCubicInchEngineDisplacement');
    return engineDisplacementCid;
  }

  double calcEngineDisplacementAirflow(double engineDisplacementCid) {
    double engineDisplacement = engineDisplacementCid / 61.0237;
//    print('engineDisplacement brain $engineDisplacement');
//    print('kMaxEngineDisplacement brain $kMaxEngineDisplacement');
    return engineDisplacement;
  }

//****************** A/R Ratio

  double calcArRatioCalc(double areaArCalculation, double radiusArCalculation) {
    double calcArRatioCalc = areaArCalculation / radiusArCalculation;

    return calcArRatioCalc;
  }

  double calculateTorque(double torqueHpInput, double torqueRpmInput) {
    double calcTorque = (torqueHpInput * 5252) / torqueRpmInput;

    return calcTorque;
  }

  double calculateHpTorque(double hpTorqueTorque, double hpTorqueRpm) {
    double calcHpTorque = ((hpTorqueTorque * hpTorqueRpm) / 5252);
    return calcHpTorque;
  }
}

// Decimal to Fraction

//function float2rat(x) {
//  var tolerance = 1.0E-6;
//  var h1=1; var h2=0;
//  var k1=0; var k2=1;
//  var b = x;
//  do {
//    var a = Math.floor(b);
//    var aux = h1; h1 = a*h1+h2; h2 = aux;
//    aux = k1; k1 = a*k1+k2; k2 = aux;
//    b = 1/(b-a);
//  } while (Math.abs(x-h1/k1) > x*tolerance);
//
//  return h1+"/"+k1;
//}
