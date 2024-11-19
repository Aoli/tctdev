import 'package:flutter/material.dart';


const tapTimeSlow = 100;
const tapTimeFast = 25;

const kBottomContainerHeight = 80.0;
const kCompressorExducerSliderNob = Color(0xFF064acb);
const kCompressorInducerSliderNob = Color(0xFF448ef6);
const kTurbineExducerSliderNob = Color(0xFFb22222);
const kTurbineInducerSliderNob = Color(0xFFe41749);
const kCompressorSliderOverlayColor = Color(0x39448ef6);
const kTurbineSliderOverlayColor = Color(0x39EB1555);

const kConversionSliderNob = Color(0xFF4c8c4a);
const kConversionSliderLabelColor = Color(0xFF1b5e20);
const kConversionSliderOverlayColor = Color(0x394c8c4a);

const kBottomContainerColour = Color(0xFFEB1555);
const kActiveSlideColour = Color(0xFFFFFFFF);
const kInactiveSlideColour = Color(0xFF18E89);
const kCompressorWeightSliderNob = Color(0xFF064acb);
const kPropPageSliderNob = Color(0xFfb22222);
const kTurbineWeightSliderNob = Color(0xFFb22222);
const kTurbineLengthSliderNob = Color(0xFFe41749);
const kPrimaryColor = Color(0xFF0A0E21);

const kEngineSizeInchSwitchActiveColorIos = Colors.green;
const kEngineSizeInchSwitchInActiveThumbColorIos = Colors.red;
const kEngineSizeInchSwitchActiveTrackColorIos = Colors.green;
const kEngineSizeInchSwitchInActiveTrackColorIos = Colors.green;
const kEngineSizeInchSwitchActiveColorAndroid = Colors.red;
const kEngineSizeInchSwitchInActiveColorAndroid = Colors.blue;
const kEngineSizeInchSwitchActiveTrackColorAndroid = Colors.green;
const kEngineSizeInchSwitchInActiveTrackColorAndroid = Colors.red;


const kNobThumbShapeSmall = 8.0;
const kNobOverlayShapeSmall = 20.0;
const kNobThumbShapeLarge = 12.0;
const kNobOverlayShapeLarge = 25.0;



const kPi = 3.1415926535;
const kPiDiv4 = 3.1415926535 / 4;


// Compressor Page

const kMinCompressorInducerMetric = 10.0;
const kMaxCompressorInducerMetric = 140.0;
const kMinCompressorExducerMetric = 10.0;
const kMaxCompressorExducerMetric = 140.0;

const kMinCompressorInducerImperial = 0.3;
const kMaxCompressorInducerImperial = 5.6;
const kMinCompressorExducerImperial = 0.3;
const kMaxCompressorExducerImperial = 5.6;

const stepValueCompressorTurbine = 0.01;


//  TurbinePage
const kMinTurbineInducerMetric = 10.0;
const kMaxTurbineInducerMetric = 140.0;
const kMinTurbineExducerMetric = 10.0;
const kMaxTurbineExducerMetric = 140.0;

const kMinTurbineInducerImperial = 0.3;
const kMaxTurbineInducerImperial = 5.6;
const kMinTurbineExducerImperial = 0.3;
const kMaxTurbineExducerImperial = 5.6;



// **************** TUNING ******************************



const kMinNrCylinder = 1;
const kMaxNrCylinder = 16;
const stepNrCylinder = 1;

// Airflow Temperature
const kMinTempCelsius = -17.8;
const kMaxTempCelsius = 60.0;
const stepTempCelsius = 0.1;

const kMinTempFahrenheit = 0.0;
const kMaxTempFahrenheit = 140.0;
const stepTempFahrenheit = 0.1;

// Convert Temperature

const kMinConvertTempCelsius = 0.0;
const kMaxConvertTempCelsius = 180.0;
const stepConvertTempCelsius = 0.01;
const sliderConvertDivisionTempCelsius = 1000;

const kMinConvertTempFahrenheit = 32.0;
const kMaxConvertTempFahrenheit = 356.0;
const stepConvertTempFahrenheit = 0.1;
const sliderConvertDivisionTempFahrenheit = 1000;

// **************** AIRFLOW ******************************
const kPoundPerMinuteToCubicMeterPerSecond = 1 / 146.2;
const kPoundPerMinuteToCubicFeetPerMinute = 14.5;

const kCubicMeterPerSecondToCubicFeetPerMinute = 2118.8799727597;
const kCubicMeterPerSecondTokPoundPerMinute = 146.2;

const kCubicFeetPerMinuteToCubicMeterPerSecond = 1 / 2118.8799727597;
const kCubicFeetPerMinuteToPoundPerMinute = 0.069;
const kPoundPerMinuteToKilogramPerSecond = 0.00755987283;


const kMinPoundPerMinute = 1.0;
const kMinCubicMeterPerSecond = 0.01;
const kMinAirflowCfm = 1.0;
const kMaxPoundPerMinute = 150.0;
const kMaxCubicMeterPerSecond = 2.0;
const kMaxAirflowCfm = 1500.0;

const kMinCubicMeterPerMinute = 2.0;
const kMaxCubicMeterPerMinute = 150.0;



const stepPoundPerMinute = 0.1;
const stepCubicMeterPerSecond = 0.0001;
const stepCubicMeterPerMinute = 0.001;
const stepCubicFeetPerMinute = 0.1;

const kAirflowGasConstant = 1545 / 28.964; //53,34207982
const kAirflowTempMinusManifold = 440;
const kAirflowCompressibility = 1;
const kAirflowPsiA = 29.4;
const kAirflow144P = 144;

const stepAirflowPsiG = 0.01;
const stepAirflowPsiAmbient = 0.01;
const stepAirflowPoundMinute = 0.01;
const stepAirflowManifoldTemp = 1.0;

const kMinAirflowPsiG = 0.00;
const kMinAirflowPsiAmbient = 0.01;
const kMinAirflowPoundMinute = 0.1;
const kMinAirflowManifoldTemp = 1.0;

const kMaxAirflowPsiG = 50.0;
const kMaxAirflowPsiAmbient = 50.0;
const kMaxAirflowPoundMinute = 100.0;
const kMaxAirflowManifoldTemp = 500.0;


// standard temp and pressure (STP)


// ************** Airflow or what ***********************
const kMinDesiredCrankHorsePower = 0.0;
const kMaxDesiredCrankHorsePower = 1500.0;

const sliderDivisionsDesiredCrankHorsePower = 150;
const stepDesiredCrankHorsePower = 1.0;

const kMinMaxEngineSpeed = 0.0;
const kMaxMaxEngineSpeed = 15000.0;
const stepMaxEngineSpeed = 1;

const sliderDivisionsMaxEngineSpeed = 30;

const kMinDesiredDriveTrainPower = 0.0; // procent plus/minus
const kMaxDesiredDriveTrainPower = 100.0;
const stepDesiredDriveTrainPower = 1.0;
const kMinEngineDisplacement = 0.33;
const kMaxEngineDisplacement = 10.0;
const stepEngineDisplacement = 0.01;

const kMinCubicInchEngineDisplacement = 20.0;
const kMaxCubicInchEngineDisplacement = 650.0;
const stepCubicInchEngineDisplacement = 1.0;

const kMinBsfc =
    0.0; // Brake-specific fuel consumption BFSC = lbsF/HP plus/minus
const kMaxBsfc = 1.0;
const stepBsfc = 0.01;
const kMinVolumetricEfficiency = 0.0; // unit % plus/minus
const kMaxVolumetricEfficiency = 130.0;
const stepVolumetricEfficiency = 1.0;
const kMinDesiredAFR = 0.0; //	11	:1
const kMaxDesiredAFR = 20.0;
const stepDesiredAFR = 0.1;
const kMinIntakeTempAtValve = 0.0; //	110	degrees F
const kMaxIntakeTempAtValve = 150.0;
const stepIntakeTempAtValve = 1.0; //	110	degrees F
const kMinAtmosphericPressure = 0.0; //	14,7	psi
const kMaxAtmosphericPressure = 30.0;
const stepAtmosphericPressure = 0.1;
const kMinPreTurboFlowLoss = 0.0; //	0,5	psi
const kMaxPreTurboFlowLoss = 5.0;
const stepPreTurboFlowLoss = 0.1;
const kMinPostTurboFlowLoss = 0.0; //	1	psi
const kMaxPostTurboFlowLoss = 5.0;
const stepPostTurboFlowLoss = 0.1;
const kMinGasConstant = 500.0; //	639,6
const kMaxGasConstant = 1000.0;
const stepGasConstant = 0.1;
const kMinNumberOfTurbos = 1.0; //	1 el 2
const kMaxNumberOfTurbos = 2.0;
const stepNumberOfTurbos = 1.0;

const kMinTargetBoostPressure = 0.0;
const kMaxTargetBoostPressure = 69.9;
const stepTargetBoostPressure = 0.1;

const sliderDivisionsNauticalMile = 1000;
const stepValueNauticalMile = 0.1;
const kMinNauticalMile = 0.0;
const kMaxNauticalMile = 100.0;

// ********************* Convert and Conversions *****************
const kMinConvert = 0.0;
const kMaxConvert = 1000.0;
const stepConvert = 1.0;
const slideConvertDivision = 100;

// Convert Speed ********************************************************
const kConvertSpeedKnotsToMph = 1.15078;
const kConvertSpeedKnotsToKmh = 1.852;
const kConvertSpeedKnotsToKmhKnotsToMeterPerSecond = 0.514444;
const kConvertSpeedKnotsToFeetPerSecond = 1.68781;

const kConvertSpeedMilesPerHourToKilometerPerHour = 1.60934;
const kConvertSpeedKilometerPerHourToMilesPerHour = 0.621371;

const kMinConvertSpeedMilesPerHour = 0.0;
const kMaxConvertSpeedMilesPerHour = 280.0;
const stepValueConvertSpeedMilesPerHour = 0.1;
const sliderDivisionsSpeedMilesPerHour = 280;


const kMinConvertSpeedKilometerPerHour = 0.0;
const kMaxConvertSpeedKilometerPerHour = 450.0;
const stepValueConvertSpeedKilometerPerHour = 0.1;
const sliderDivisionsSpeedKilometerPerHour = 450;


const kConvertSpeedMilesPerHourToKnots = 0.868976;
const kConvertSpeedMilesPerHourToMeterPerSecond = 0.44704;
const kConvertSpeedMilesPerHourToFootPerSecond = 1.46667;

const kResetValueMilesPerHour = 0.0;
const kResetValueKilometerPerHour = 0.0;


// ****** Conversion *******
const kMinConvertSpeed = 0.0;
const kMaxConvertSpeed = 100.0;
const stepValueSpeed = 1;
const sliderDivisionsSpeed = 100;


// Convert Distance ********************************************************
const kConvertDistanceNauticalMileToMeter = 1852;
const kConvertDistanceNauticalMileToInch = 72913.4;
const kConvertDistanceNauticalMileToFoot = 6076.12;
const kConvertDistanceNauticalMileToYard = 2025.372;
const kConvertDistanceNauticalMileToMile = 1.15078;
const kConvertDistanceNauticalMileToKm = 1.852;
const kConvertDistanceMileToNauticalMile = 0.868976;
const kConvertDistanceKilometerToNauticalMile = 1 / 1.852;

const kConvertDistanceMileToKm = 1.609344;
const kConvertDistanceMileToMeter = 1609.344;
const kConvertDistanceMileToInch = 63360.0;
const kConvertDistanceMileToFoot = 5280.0;
const kConvertDistanceMileToYard = 1760.0;
const kConvertDistanceMileToMile = 1.0;
const kConvertDistanceMileToMillimeter = 1609344.0;

const kConvertDistanceKilometerToMile = 0.621371192;
const kConvertDistanceKilometerToMeter = 1000;
const kConvertDistanceKilometerToInch = 39370.0787;
const kConvertDistanceKilometerToFoot = 3280.8399;
const kConvertDistanceKilometerToYard = 1093.6133;
const kConvertDistanceKilometerToMillimeter = 1000000.0;

const kConvertDistanceMillimeterToMile = 0.621371;
const kConvertDistanceMillimeterToMeter = 1 / 1000;
const kConvertDistanceMillimeterToInch = 10000000.0;
const kConvertDistanceMillimeterToFoot = 10000000.0;
const kConvertDistanceMillimeterToYard = 10000000.0;
const kConvertDistanceMillimeterToMillimeter = 10000000.0;

const kConvertDistanceMeterToMile = 0.621371;
const kConvertDistanceMeterToMeter = 1 / 1000;
const kConvertDistanceMeterToInch = 10000000.0;
const kConvertDistanceMeterToFoot = 10000000.0;
const kConvertDistanceMeterToYard = 10000000.0;
const kConvertDistanceMeterToMillimeter = 10000000.0;

const kConvertDistanceInchToMile = 0.621371;
const kConvertDistanceInchToMeter = 1 / 1000;
const kConvertDistanceInchToInch = 10000000.0;
const kConvertDistanceInchToFoot = 10000000.0;
const kConvertDistanceInchToYard = 10000000.0;
const kConvertDistanceInchToMillimeter = 10000000.0;

const kMinDistance = 0.0;
const kMaxDistance = 100.0;
const stepValueDistance = 1;
const sliderDivisionsDistance = 100;

const sliderConvertDistanceDivisionsKilometer = 1000;

const kMinDistanceMiles = 0.0;
const kMaxDistanceMiles = 100.0;
const stepValueDistanceMiles = 0.01;
const sliderDivisionsDistanceMiles = 10000000;

const kMinDistanceKilometer = 0.0;
const kMaxDistanceKilometer = 2540.0;
const stepValueDistanceKilometer = 0.01;
const sliderDivisionsDistanceKilometer = 10000000;

const kConvertDistanceKilometerToMiles = 1 / 25.4;

// Convert Temperature  ********************************************************
// Ej multiplication, use with care
const kConvertTemperatureCelsiusToFahrenheit =
    (1 * 9 / 5) + 32; //(0°C × 9/5) + 32
const kConvertTemperatureCelsiusToKelvin = 0 + 273.15; //0°C + 273.15 = 273,15K

const kConvertTemperatureFahrenheitToCelsius =
    (1 - 32) * 5 / 9; //(0°F − 32) × 5/9 = -17,78°C
const kConvertTemperatureFahrenheitToKelvin = 10000000.0;

const kConvertTemperatureKelvinToCelsius = 10000000.0;
const kConvertTemperatureKelvinToFahrenheit = 10000000.0;

double convertTemperatureFahrenheit = 10.0;
double convertTemperatureKelvin = 10.0;

// Convert Mass
const kConvertMassKilogramToTonne = 10000000.0;
const kConvertMassKilogramToMilligram = 10000000.0;
const kConvertMassKilogramToMicrogram = 10000000.0;
const kConvertMassPoundToTonne = 10000000.0;
const kConvertMassPoundToMilligram = 10000000.0;
const kConvertMassPoundToMicrogram = 10000000.0;
const kConvertMassPoundToImperialTon = 10000000.0;
const kConvertMassOunceToTonne = 10000000.0;
const kConvertMassOunceToMilligram = 10000000.0;
const kConvertMassOunceToMicrogram = 10000000.0;
const kConvertMassOunceToImperialTon = 10000000.0;
const kConvertMassOunceToUsTon = 10000000.0;


const kConvertMassPoundToGram = 453.592;
const kConvertMassPoundToKilogram = 0.453592;
const kConvertMassKilogramToGram = 1000.0;
const kConvertMassKilogramToPound = 2.20462;
const kConvertMassGramToPound = 1 / 454;
const kConvertMassGramToKilogram = 1 / 1000;

const kMinConvertMassPound = 0.0;
const kMaxConvertMassPound = 100000.0;
const sliderConvertMassPound = 1000000;
const stepConvertMassPound = 0.01;

const kMinConvertMassGram = 0.0;
const kMaxConvertMassGram = 2000.0;
const sliderConvertMassGram = 20000;
const stepConvertMassGram = 1.0;

const kMinConvertMassKilogram = 0.0;
const kMaxConvertMassKilogram = 50000.0;
const sliderConvertMassKilogram = 50000;
const stepConvertMassKilogram = 0.01;

const kResetValuePound = 0.0;
const kResetValueGram = 0.0;
const kResetValueKilogram = 0.0;

const kConvertMassKilogramToImperialTon = 7.0;
const kConvertMassKilogramToUsTon = 7.0;
const kConvertMassKilogramToStone = 7.0;
const kConvertMassKilogramOunce = 7.0;
const kConvertMassPoundToUsTon = 7.0;
const kConvertMassPoundToStone = 7.0;
const kConvertMassPoundOunce = 7.0;
const kConvertMassOunceToKilogram = 7.0;
const kConvertMassOunceToGram = 7.0;
const kConvertMassOunceToStone = 7.0;
const kConvertMassOunceToPound = 7.0;

// Convert Volume
const kConvertVolumeCubicMeterToUsLiquidGallon = 10000000.0;
const kConvertVolumeCubicMeterToUsLiquidQuart = 10000000.0;
const kConvertVolumeCubicMeterToUsLiquidPint = 10000000.0;
const kConvertVolumeCubicMeterToUsLegalCup = 10000000.0;
const kConvertVolumeCubicMeterToUsFluidOnce = 10000000.0;
const kConvertVolumeCubicMeterToUsTableSpoon = 10000000.0;
const kConvertVolumeCubicMeterToUsTeaSpoon = 10000000.0;
const kConvertVolumeCubicMeterToCubicMeter = 10000000.0;
const kConvertVolumeCubicMeterToCubicCentiMeter = 10000000.0;
const kConvertVolumeCubicMeterToLiter = 10000000.0;
const kConvertVolumeCubicMeterToMilliliter = 10000000.0;
const kConvertVolumeCubicMeterToImperialGallon = 10000000.0;
const kConvertVolumeCubicMeterToImperialQuart = 10000000.0;
const kConvertVolumeCubicMeterToImperialPint = 10000000.0;
const kConvertVolumeCubicMeterToImperialCup = 10000000.0;
const kConvertVolumeCubicMeterToImperialFluidOnce = 10000000.0;
const kConvertVolumeCubicMeterToImperialTableSpoon = 10000000.0;
const kConvertVolumeCubicMeterToImperialTeaSpoon = 10000000.0;
const kConvertVolumeCubicMeterToCubicFoot = 10000000.0;
const kConvertVolumeCubicMeterTo = 10000000.0;
const kConvertVolumeCubicMeterToCubicInch = 10000000.0;
const kConvertVolumeCubicMeterToDeciliter = 10000000.0;

const kConvertVolumeLiterToUsLiquidQuart = 10000000.0;
const kConvertVolumeLiterToUsLiquidPint = 10000000.0;
const kConvertVolumeLiterToUsLegalCup = 10000000.0;
const kConvertVolumeLiterToUsFluidOnce = 10000000.0;
const kConvertVolumeLiterToUsTableSpoon = 10000000.0;
const kConvertVolumeLiterToUsTeaSpoon = 10000000.0;
const kConvertVolumeLiterToLiter = 1.0;
const kConvertVolumeLiterToCubicMeter = 10000000.0;
const kConvertVolumeLiterToMilliliter = 10000000.0;
const kConvertVolumeLiterToImperialGallon = 10000000.0;
const kConvertVolumeLiterToImperialQuart = 10000000.0;
const kConvertVolumeLiterToImperialPint = 10000000.0;
const kConvertVolumeLiterToImperialCup = 10000000.0;
const kConvertVolumeLiterToImperialFluidOnce = 10000000.0;
const kConvertVolumeLiterToImperialTableSpoon = 10000000.0;
const kConvertVolumeLiterToImperialTeaSpoon = 10000000.0;
const kConvertVolumeLiterToCubicFoot = 10000000.0;
const kConvertVolumeLiterTo = 10000000.0;
const kConvertVolumeLiterToDeciliter = 10000000.0;
const kConvertVolumeLiterToCubicInch = 61.0237;


const kConvertVolumeCubicCentiMeterToUsLiquidQuart = 10000000.0;
const kConvertVolumeCubicCentiMeterToUsLiquidPint = 10000000.0;
const kConvertVolumeCubicCentiMeterToUsLegalCup = 10000000.0;
const kConvertVolumeCubicCentiMeterToUsFluidOnce = 10000000.0;
const kConvertVolumeCubicCentiMeterToUsTableSpoon = 10000000.0;
const kConvertVolumeCubicCentiMeterToUsTeaSpoon = 10000000.0;
const kConvertVolumeCubicCentiMeterToCubicCentiMeter = 1.0;
const kConvertVolumeCubicCentiMeterToCubicMeter = 10000000.0;
const kConvertVolumeCubicCentiMeterToMilliCubicCentiMeter = 10000000.0;
const kConvertVolumeCubicCentiMeterToImperialGallon = 10000000.0;
const kConvertVolumeCubicCentiMeterToImperialQuart = 10000000.0;
const kConvertVolumeCubicCentiMeterToImperialPint = 10000000.0;
const kConvertVolumeCubicCentiMeterToImperialCup = 10000000.0;
const kConvertVolumeCubicCentiMeterToImperialFluidOnce = 10000000.0;
const kConvertVolumeCubicCentiMeterToImperialTableSpoon = 10000000.0;
const kConvertVolumeCubicCentiMeterToImperialTeaSpoon = 10000000.0;
const kConvertVolumeCubicCentiMeterToCubicFoot = 10000000.0;
const kConvertVolumeCubicCentiMeterTo = 10000000.0;
const kConvertVolumeCubicCentiMeterToDeciliter = 10000000.0;

const kConvertVolumeCubicInchToUsLiquidQuart = 10000000.0;
const kConvertVolumeCubicInchToUsLiquidPint = 10000000.0;
const kConvertVolumeCubicInchToUsLegalCup = 10000000.0;
const kConvertVolumeCubicInchToUsFluidOnce = 10000000.0;
const kConvertVolumeCubicInchToUsTableSpoon = 10000000.0;
const kConvertVolumeCubicInchToUsTeaSpoon = 10000000.0;
const kConvertVolumeCubicInchToCubicMeter = 10000000.0;
const kConvertVolumeCubicInchToMilliCubicInch = 1000.0;
const kConvertVolumeCubicInchToImperialGallon = 10000000.0;
const kConvertVolumeCubicInchToImperialQuart = 10000000.0;
const kConvertVolumeCubicInchToImperialPint = 10000000.0;
const kConvertVolumeCubicInchToImperialCup = 10000000.0;
const kConvertVolumeCubicInchToImperialFluidOnce = 10000000.0;
const kConvertVolumeCubicInchToImperialTableSpoon = 10000000.0;
const kConvertVolumeCubicInchToImperialTeaSpoon = 10000000.0;
const kConvertVolumeCubicInchToCubicFoot = 10000000.0;
const kConvertVolumeCubicInchTo = 10000000.0;
const kConvertVolumeCubicInchToCubicInch = 1.0;
const kConvertVolumeCubicInchToDeciliter = 10000000.0;


const kConvertVolumeLiterToUsLiquidGallon = 0.264172;
const kConvertVolumeLiterToCubicCentiMeter = 1000.0;


const kConvertVolumeCubicCentiMeterToUsLiquidGallon = 0.000264172;
const kConvertVolumeCubicCentiMeterToLiter = 0.001;
const kConvertVolumeCubicCentiMeterToCubicInch = 0.0610237;

const kConvertVolumeCubicInchToUsLiquidGallon = 0.004329;
const kConvertVolumeCubicInchToCubicCentiMeter = 16.3871;
const kConvertVolumeCubicInchToLiter = 0.0163871;


const kConvertVolumeUsLiquidGallonToLiter = 3.78541;
const kConvertVolumeUsLiquidGallonToCubicCentimeter = 3785.40999993543;
const kConvertVolumeUsLiquidGallonToCubicInch = 231.0;

const kMinConvertVolumeUsLiquidGallon = 0.0;
const kMaxConvertVolumeUsLiquidGallon = 100.0;
const sliderConvertVolumeUsLiquidGallon = 100;
const stepConvertVolumeUsLiquidGallon = 0.1;

const kMinConvertVolumeLiter = 0.0;
const kMaxConvertVolumeLiter = 400.0;
const sliderConvertVolumeLiter = 400;
const stepConvertVolumeLiter = 0.1;

const kMinConvertVolumeCubicCentimeter = 0.0;
const kMaxConvertVolumeCubicCentimeter = 15000.0;
const sliderConvertVolumeCubicCentimeter = 150;
const stepConvertVolumeCubicCentimeter = 10.0;

const kMinConvertVolumeCubicInch = 0.0;
const kMaxConvertVolumeCubicInch = 1000.0;
const sliderConvertVolumeCubicInch = 100;
const stepConvertVolumeCubicInch = 1.0;

const kResetValueUsLiquidGallon = 0.0;
const kResetValueLiter = 0.0;
const kResetValueCubicInch = 0.0;
const kResetValueCubicCentiMeter = 0.0;


// **********  AirFlowAirDensity

const kConvertAirflowAirDensityCfmToUsLiquidGallon = 0.264172;
const kConvertAirflowAirDensityCfmToCubicCentiMeter = 1000.0;


const kConvertAirflowAirDensityCubicCentiMeterToUsLiquidGallon = 0.000264172;
const kConvertAirflowAirDensityCubicCentiMeterToLiter = 0.001;
const kConvertAirflowAirDensityCubicCentiMeterToCubicInch = 0.0610237;

const kConvertAirflowAirDensityCubicInchToUsLiquidGallon = 0.004329;
const kConvertAirflowAirDensityCubicInchToCubicCentiMeter = 16.3871;
const kConvertAirflowAirDensityCubicInchToLiter = 0.0163871;


const kConvertAirflowAirDensityPoundPerMinuteToLiter = 3.78541;
const kConvertAirflowAirDensityPoundPerMinuteToCubicCentimeter = 3785.40999993543;
const kConvertAirflowAirDensityPoundPerMinuteToCubicInch = 231.0;

const kMinConvertAirflowAirDensityPoundPerMinute = 0.0;
const kMaxConvertAirflowAirDensityPoundPerMinute = 150.0;
const sliderConvertAirflowAirDensityPoundPerMinute = 150;
const stepConvertAirflowAirDensityPoundPerMinute = 0.01;

const kMinConvertAirflowAirDensityCfm = 0.0;
const kMaxConvertAirflowAirDensityCfm = 1000.0;
const sliderConvertAirflowAirDensityCfm = 1000;
const stepConvertAirflowAirDensityCfm = 0.1;

const kMinConvertAirflowAirDensityCubicCentimeter = 0.0;
const kMaxConvertAirflowAirDensityCubicCentimeter = 15000.0;
const sliderConvertAirflowAirDensityCubicCentimeter = 150;
const stepConvertAirflowAirDensityCubicCentimeter = 10.0;

const kMinConvertAirflowAirDensityCubicInch = 0.0;
const kMaxConvertAirflowAirDensityCubicInch = 1000.0;
const sliderConvertAirflowAirDensityCubicInch = 100;
const stepConvertAirflowAirDensityCubicInch = 1.0;

const kResetValueAirFlowAirDensityCFM = 698.0;
const kResetValueAirflowAirDensityPoundPerMinute = 52.33;
//const kResetValueCubicInch = 0.0;
//const kResetValueCubicCentiMeter = 0.0;

const kAirflowDensityCfmToCubicMeterPerMinute = 0.0283168466;
const kAirflowDensityCfmToCubicMeterPerSecond = 0.000471947443;


// Convert Length ********************************************************
const kConvertLengthMillimeterToMeter =
0.001; // millimeter (mm) (1mm = 0.001 meter) - Metric unit
const kConvertLengthInchToMillimeter =
25.4; // Inch (tum) (1 Inch = 25.4 mm) - Imperial unit

const kMinLength = 0.1;
const kMaxLength = 100.0;
const stepValueLength = 1;
const sliderDivisionsLength = 100;

const kMinLengthInch = 0.0;
const kMaxLengthInch = 100.0;
const stepValueLengthInch = 0.01;
const sliderDivisionsLengthInch = 10000000;

const kMinLengthMillimeter = 0.0;
const kMaxLengthMillimeter = 2540.0;
const stepValueLengthMillimeter = 0.01;
const sliderDivisionsLengthMillimeter = 10000000;

const kConvertLengthMillimeterToInch = 1 / 25.4;







// Convert Pressure ********************************************************
const kConvertPressureBarToPsi = 14.5038;
const kConvertPressurePsiToBar = 0.0689476;
const kConvertPressureBarToKiloPascal = 100.0;
const kConvertPressureBarToMegaPascal = 0.1;
const kConvertPressureBarToKilogramPerSquareCentimeters = 1.02;
const kConvertPressureBarToInchOfMercuryColumn = 29.53;
const kConvertPressurePsiToInchOfMercuryColumn = 2.03602;
const kConvertPressureBarToAtmosphere = 0.986923;
const kConvertPressureBarToTorr = 750.0; // 1 Bar = 750 Torr

const kConvertPressureAtmosphereToBar = 1.01325;
const kConvertPressureAtmosphereToPsi = 14.6959;
const kConvertPressurePsiToAtmosphere = 0.068046;
const kConvertPressurePsiToKiloPascal = 6.89476;

const kMinPressure = 0.1;
const kMaxPressure = 100.0;
const stepValuePressure = 1;
const sliderDivisionsPressure = 100;

const kMinPressureBar = 0.101325;
const kMaxPressureBar = 10.1325;
const stepValuePressureBar = 0.001;
const sliderDivisionsPressureBar = 101;

const kMinPressurePsi = 1.46959;
const kMaxPressurePsi = 146.959;
const stepValuePressurePsi = 0.01;
const sliderDivisionsPressurePsi = 1469;

// ********************* A/R ratio


const kMinAreaArCalculationMillimeter = 0.0;
const kMaxAreaArCalculationMillimeter = 150.0;
const stepValueAreaArCalculationMillimeter = 0.1;
const kMinAreaArCalculationInch = 0.0;
const kMaxAreaArCalculationInch = 10.0;
const stepValueAreaArCalculationInch = 0.01;

const kMinRadiusArCalculationMillimeter = 0.0;
const kMaxRadiusArCalculationMillimeter = 150.0;
const stepValueRadiusArCalculationMillimeter = 0.1;
const kMinRadiusArCalculationInch = 0.0;
const kMaxRadiusArCalculationInch = 10.0;
const stepValueRadiusArCalculationInch = 0.01;



// **************** clean up slask raderas *******************
const stepValueKilometer = 0.1;
const kMinMeter = 0.0;
const kMaxMeter = 10000.0;
const kMinKilometer = 0.0;
const kMaxKilometer = 100.0;
const kMinMile = 0.0;
const kMaxMile = 100.0;
const sliderDivisionsMile = 1000;
const stepValueMile = 0.1;

const kWidthResultTextUnit = 45.0;
const kWidthResultTextNumber = 65.0;
const kWidthResultTextContainer = 175.0;
const kHeightResultTextHeight = 25.0;

const kInputTextWidth = 170.0;
const kInputNumberWidth = 80.0;
const kInputNumberBigWidth = 90.0;
const kInputUnitWidth = 40.0;

const kResultTextWidth = 170.0;
const kResultNumberWidth = 75.0;
const kResultNumberBigWidth = 90.0;
const kResultUnitWidth = 50.0;


const kNotApplicable = '';


// ********** Units **********
const unitLengthMeter = 'm';
const unitLengthMillimeter = 'mm';
const unitLengthCentimeter = 'cm';
const unitLengthKilometer = 'km';
const unitNauticalMile = 'nmi';
const unitLengthMile = 'mile';
const unitLengthYard = 'yd';
const unitLengthFeet = 'ft';
const unitLengthInch = 'in';

const unitCelsius = 'ºC';
const unitRankine = 'ºR';
const unitFahrenheit = 'ºF';
const unitKelvin = 'ºK';

const unitArRatio = 'A/R';
const unitAreaArRatioMillimeter = 'mm^2';
const unitRadiusArRatioMillimeter = 'mm';
const unitAreaArRatioInch = 'inch^2';
const unitRadiusArRatioInch = 'inch';

String unitVolumeCubicCentimeter = "CC";
String unitVolumeCid = 'Cid';
String unitVolumeCubicInch = 'Ci';
String unitVolumeUsGallon = 'Us Gal';
String unitVolumeImperialGallon = 'imp Gal';
String unitVolumeLiter = 'Liter';
String unitSliderConvertVolumeAll = 'Us Gal';
String unitSliderConvertMassAll = 'Pound';
String convertSliderHeaderMassTextAll = 'Pound';

String unitSpeedKmh = 'km/h';
String unitSpeedMeterPerSecond = 'm/s';
String unitSpeedMph = 'mph';
String unitSpeedFeetPerSecond = 'feet/s';

//************* SnackBar development info

const kSnackBarDevelopmentInfo = '\nTCT - TurboCharger Tuning\n\nPlease give us your feedback on the TCT app! See feedback form on the info tab in the app. You can also contact us on social media and via website turbochargertuning.com. We are in active development on this app right now and would be very happy to hear from you. Take this opportunity to get your most wanted features into the app. We will consider all suggestions and prioritize our development based on your input. Your ideas and feedback will have a significant impact on our priorities when developing this app. Let us also know if you find errors in the app, and we will fix them too. If you have ideas about current calculations or other things about the app, please let us know.';

// ******** End Unit **********************************

