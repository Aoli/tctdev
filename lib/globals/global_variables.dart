// **************** GLOBAL VARIABLES ****************************

// ************  Tuning Calc  ************************************

import 'dart:async';
import 'package:Turbocharger/globals/constant.dart';
import 'package:Turbocharger/globals/constants_ui.dart';


Timer timer;
Timer acceleration;
var tapTime = 50;

double strokeInputInch = 4.5;
double boreInputInch = 4.125;

double strokeInputMillimeter = strokeInputInch * kConvertLengthInchToMillimeter;
double boreInputMillimeter = boreInputInch * kConvertLengthInchToMillimeter;
double strokeInput = strokeInputInch;
double boreInput = boreInputInch;
double boreStrokeRatio = boreInput / strokeInput;

double stepBoreInput = 0.001;
double stepStrokeInput = 0.001;
double stepBoreInputInch = 0.001;
double stepStrokeInputInch = 0.001;

double vMinStrokeInputMillimeter = 5.0;
double vMaxStrokeInputMillimeter = 160.0;
double vMinBoreInputMillimeter = 5.0;
double vMaxBoreInputMillimeter = 160.0;
double stepBoreInputMillimeter = 0.001;
double stepStrokeInputMillimeter = 0.001;

double vMinStrokeInput = 5.0;
double vMaxStrokeInput = 160.0;
double vMinBoreInput = 5.0;
double vMaxBoreInput = 160.0;

double vMinStrokeInputInch =
    vMinStrokeInputMillimeter * kConvertLengthMillimeterToInch;
double vMaxStrokeInputInch =
    vMaxStrokeInputMillimeter * kConvertLengthMillimeterToInch;
double vMinBoreInputInch =
    vMinBoreInputMillimeter * kConvertLengthMillimeterToInch;
double vMaxBoreInputInch =
    vMaxBoreInputMillimeter * kConvertLengthMillimeterToInch;

double resultEngineLiter = 4.69;
double resultEngineCubicCentimeter = 4691;
double resultEngineCid = 97.6;

String boreInputDisplay;
String strokeInputDisplay;
String boreStrokeRatioDisplay;
String boreStrokeRatioSquareDisplay = 'Square';

var vEngineSizeSwitchActiveColor;
var vEngineSizeSwitchInActiveThumbColor;
var vEngineSizeSwitchActiveTrackColor;
var vEngineSizeSwitchInActiveTrackColor;



int cylinderInput = 6;

double resultEngineDisplacement;
String unitNrCylinders = "Cyl";

double tempCelsius = 20.0;




double tempTemperatureFahrenheit = 68.0;

double resultTemperatureFahrenheit = 1.0;
double resultTemperatureCelsius = 2.0;

//********* Torque calculation

double torqueHpInput = 250;
double torqueRpmInput = 6500;

double vMinTorqueRpmInput = 10;
double vMaxTorqueRpmInput = 15000;
double vMinTorqueHpInput = 10;
double vMaxTorqueHpInput = 1500;
double stepTorqueHpInput = 1.0;
double stepTorqueRpmInput = 1.0;

int sliderSliderTorqueRpm = 150;
int sliderSliderTorqueHp = 30;

String unitTorque = 'ft-lbs';


// **********  Units  *************************************
double changeThisValue = 1000.00;



String convertSliderHeaderSpeedTextAll = 'Miles Per Hour';



// ************  Speed  ************************************

double resultKmh;
double resultMph;
double resultFeetPerSecond;
double resultMeterPerSecond;
double resultKnots;

// ************  Length  ************************************

double resultMeterM;
double resultKmM;
double resultNauticalMileM;
double resultMileM;
double resultYardM;
double resultFootM;
double resultInchM;

double resultMeterN;
double resultKmFromKilometer;
double resultNauticalMileFromKilometer;
double resultMileFromKilometer;
double resultYardN;
double resultFootN;
double resultInchN;

double resultMileCalcMile;
double resultNauticalMileCalcMile;
double resultKmCalcMile;

// ************  ETA-variables  ************************************

double resultKmhEta;
double resultMphEta;
double resultFeetPerSecondEta;
double resultMeterPerSecondEta;
double resultKnotsEta;

double resultMeterEta;
double resultKmEta;
double resultNauticalMileEta;
double resultMileEta;
double resultYardEta;
double resultFootEta;
double resultInchEta;

double resultTimeEta;
double resultHourEta;
double resultMinutesEta;
double resultSecondsEta;
String resultTime = 'hh:mm';

double normalSkrovSpeedValue = 1.0;
double normalSkrovPitchValue = 1.0;

double lenghtValue = 20.0;

double horsepowerValue = 150.0;
double rpmValue = 4800.0;
double utvaxlingValue = 2.15;

//Swedish
String unitTon = 'ton';
String unitWeightKilogram = 'kg';
String unitKnop = 'knop';
String unitFoot = 'fot';

//English
String unitLbs = 'lbs';
String unitTonne = 'tonne';
String unitKnots = 'knots';

//Both language
String unitRpm = 'rpm';
String unitRatio = ':1';
String unitHorsepower = 'hp';

String lightSkrovSpeedPrint = '0.3';
String normalSkrovSpeedPrint = '0.3';
String pressureCompressorPrint = '0.1';
int sliderDivisions = 1000;

//******************* Airflow Calc variables ***********************

double desiredWheelHorsepower = 425.0; // hp Calculated
double desiredEngineHorsepower = 518.0; // hp Slide
double desiredDriveTrainPower = 82.0; // procent plus/minus
String unitProcent = '%';
String unitLiter = 'l'; // liters

double engineDisplacementAirflow = 2.50;
String unitEngineDisplacement = 'liter';

double engineDisplacementCidAirflow = 153;
double stepEngineDisplacementCid = 0.1;
// plus/minus
double bSFC = 0.55; // Brake-specific fuel consumption BFSC = lbsF/HP plus/minus
String unitBSFC = 'lb/HPh';
double volumetricEfficiency = 90.0; // unit % plus/minus
double maxEngineSpeed = 6500.0; // 7500	rpm Slide
String unitMaxEngineSpeed = 'rpm';
double desiredAFR = 11.0; //	11	:1
double intakeTempAtValve = 68.0; //	110	degrees F

double atmosphericPressure = 14.7; //	14,7	psi
double preTurboFlowLoss = 0.5; //	0,5	psi
double postTurboFlowLoss = 1.0; //	1	psi
double gasConstant = 639.6; //	639,6
double numberOfTurbos = 1.0; //	1 el 2

double vAirflowPsiG = 14.7;
double vAirflowPsiAmbient = 14.7;
double vAirflowPsiTotal = 29.4;
double vAirflowCfm = 500.0;
double vAirflowPoundMinute = 52.33;
double vAirflowManifoldTemp = 110.0;


//****************** Airflow calculation OUT ********************
double massFlowRatePoundMinute = 52.23;
String unitMassFlowRatePoundMinute = 'lbs/min';
String unitMassFlowRateKilogramSecond = 'Kg/s';
double volumeFlowRateCfm = 11.0; // (lb/min):	52,26
String unitVolumeFlowRateCfm = 'm^3/s';
double volumetricFlowRate = 0.305; // (m^3/s):	0,31
double volumetricFlowRateCfm = 647.0;
String unitVolumetricCubicMeterPerSecond = 'm^3/s';
String unitVolumetricCubicMeterPerMinute = 'm^3/min';

String unitVolumetricFlowRateCfm = 'cfm';
double requiredAbsolutePressure = 37.0; // (psi):	37,00
String unitRequiredAbsolutePressure = 'psi';
double resultantManifoldPressure = 22.30; // (psi):	22,30
String unitResultantManifoldPressure = 'psi';
double pressureRatio = 2.68; //	2,68
String unitPressureRatio = 'Pr';

String unitChangeThisValue = 'Enhet';
double trimTurbineResult = 1.0;
double pressureTurbineResult = 121.52;
double pressureCompressorResult = 121.52;
double pressureMetricReset = 121.52;
double pressureImperialReset = 1762.49859;

//**************** Airflow Conversion *****************
double poundPerMinuteConversion = 50.0; // lb/min 50.0
double vAirflowCubicMeterPerSecond = 0.342;
double vAirflowCubicMeterPerMinute = 0.342 * 60; // (m^3/s):	0,293
double cubicFeetPerMinuteConversion = 725; // (lb/min):	725

String unitHorsePower = 'Hp';
String unitValue;

String unitPressureBar = 'bar';
String unitPressurePsi = 'psi';
String unitPressureKiloPascal = 'kPa';
String unitPressureAtmosphere = 'atm';
String unitPressurePoundForcePerSquareInch = 'PfSi';
String unitPressureTorr = 'torr';
String unitPressureInchOfMercury = 'inHg';

String pressureUnitValue;

String inducerTurbineDisplay = '0.5';
String exducerTurbineDisplay = '0.5';
String pressureTurbineDisplay = '0.01';
String trimTurbineDisplay = '1.0';

String inducerCompressorDisplay = '12.7';
String exducerCompressorDisplay = '140.0';
String pressureCompressorDisplay = '0.01';
String trimCompressorDisplay = '1.0';

double targetBoostPressure = 22.28;

bool metricUnit = true;
bool snackbarEnable = true;

//******************* Airflow Calc variables ***********************

double massFlowRateCfm = 11.0; // (lb/min):	52,26
String unitMassFlowRateCfm = 'm^3/s';

// ***** Basic HP *****
double inducerCompressorMetric = 12.7;
double inducerCompressorValue = 0.3;
double inducerCompressorImperial = 0.3;
double exducerCompressor = 140.0;

double exducerCompressorMetric = 12.7;

double exducerTurbine = 140.0;

double turboSizeInch = 39.6 / 25.4;

double hpPetrolResult = 16.7;
double hpDieselResult = 10.0;

double vMaxExducerMetric = 140.0;
double vMinExducerMetric = 12.7;
double vMaxInducerMetric = 140.0;
double vMinInducerMetric = 12.7;

double vMaxInducerImperial = 5.6;
double vMinInducerImperial = 0.3;
double vMaxExducerImperial = 5.6;
double vMinExducerImperial = 0.3;

int sliderDivisionInducer = 1;


//  AirFlow  AirDensity
double convertResultAirflowAirDensityPoundPerMinute = 1.2;
double convertResultAirflowAirDensityUsLiquidQuart = 10.0;
double convertResultAirflowAirDensityUsLiquidPint = 10.0;
double convertResultAirflowAirDensityUsLegalCup = 10.0;
double convertResultAirflowAirDensityUsFluidOunce = 10.0;
double convertResultAirflowAirDensityUsTablespoon = 10.0;
double convertResultAirflowAirDensityUsTeaSpoon = 10.0;
double convertResultAirflowAirDensityCubicMeter = 10.0;
double convertResultAirflowAirDensityCfm = 6.7;
double convertResultAirflowAirDensityMillilitre = 10.0;
double convertResultAirflowAirDensityImperialGallon = 10.0;
double convertResultAirflowAirDensityImperialQuart = 10.0;
double convertResultAirflowAirDensityImperialPint = 10.0;
double convertResultAirflowAirDensityImperialCup = 10.0;
double convertResultAirflowAirDensityImperialFluidOunce = 10.0;
double convertResultAirflowAirDensityImperialTableSpoon = 10.0;
double convertResultAirflowAirDensityImperialTeaSpoon = 10.0;
double convertResultAirflowAirDensityCubicFoot = 10.0;
double convertResultAirflowAirDensityCubicInch = 30.0;
double convertResultAirflowAirDensityCubicCentimeter = 1000.0;

double convertSliderResultAirflowAirDensityAll = 10.0;
String convertSliderTextAirflowAirDensityAll = 'lbs/min';
String convertSliderHeaderAirflowAirDensityTextAll = 'Pound per Minute - lbs/min';
double kMinSliderConvertAirflowAirDensityAll = 0.0;
double kMaxSliderConvertAirflowAirDensityAll = 100.0;
int sliderSliderConvertAirflowAirDensityAll = 100;
double stepSliderConvertAirflowAirDensityAll = 0.1;

double vMinConvertAirflowAirDensityPoundPerMinute = kMinConvertAirflowAirDensityPoundPerMinute +
    0.05;
double vMaxConvertAirflowAirDensityPoundPerMinute = kMaxConvertAirflowAirDensityPoundPerMinute -
    0.05;

double vMinConvertAirflowAirDensityCfm = kMinConvertAirflowAirDensityCfm + 0.1;
double vMaxConvertAirflowAirDensityCfm = kMaxConvertAirflowAirDensityCfm - 0.2;

double vMinConvertAirflowAirDensityCubicCentimeter =
    kMinConvertAirflowAirDensityCubicCentimeter + 3.0;
double vMaxConvertAirflowAirDensityCubicCentimeter =
    kMaxConvertAirflowAirDensityCubicCentimeter - 3.0;

double vMinConvertAirflowAirDensityCubicInch = kMinConvertAirflowAirDensityCubicInch +
    0.1;
double vMaxConvertAirflowAirDensityCubicInch = kMaxConvertAirflowAirDensityCubicInch -
    0.1;

double vMinSliderConvertAirflowAirDensityAllStepper;
double vMaxSliderConvertAirflowAirDensityAllStepper;

String unitSliderConvertAirflowAirDensityAll = 'Lbs/Min';

double convertResultAirflowAirDensityCubicMeterPerMinute = 1.0;
double convertResultAirflowAirDensityCubicMeterPerSecond = 1.0;
double kMinConvertAirflowAirDensityCubicMeterPerMinute = 0.1;
double kMaxConvertAirflowAirDensityCubicMeterPerMinute = 100.0;
double kMaxConvertAirflowAirDensityCubicMeterPerSecond = 20.0;
double kMinConvertAirflowAirDensityCubicMeterPerSecond = 0.01;


// **************
double vAirDensityAirflow = 0.075;
double kMaxAirDensityAirflow = 2.0;
double kMinAirDensityAirflow = 0.01;
double stepAirDensityAirflow = 0.001;
String unitAirDensityAirflow = 'lbs/f^3';
int vAirflowResultDecimals = 1;



//***** Exducer Page *********************************

double inducerTurbineMetric = 12.7;
double inducerTurbineValue = kMinCompressorInducerMetric;
double inducerTurbineImperial = vMaxExducerImperial;
double exducerTurbineMetric = 12.7;
double exducerTurbineValue = kMinCompressorExducerMetric;
double exducerTurbineImperial = vMinExducerImperial;

double vMinExducerValue;
double vMaxExducerValue;

double vMinInducer = 0.3;
double vMaxInducer = 140.0;
double vMinExducer = 0.3;
double vMaxExducer = 140.0;

int sliderDivisionInducerExducer = 50;

// ***** Compressor Page *************

double trimCompressorResult = 1;

double exducerCompressorImperial = vMaxExducerImperial;
double exducerCompressorValue;

double vMinInducerValue;
double vMaxInducerValue;

// ************ StepButton ******************
bool stepDirection = false;
bool inducerExducerCalc = true;

//********** Conversions ***********************************
//Speed
double convertResultSpeedMilesPerHour = 10.0;
double convertResultSpeedKilometerPerHour = 10.0;

double convertResultSpeedNauticalMileHour = 10.0;
double convertResultSpeedNauticalMileMinute = 10.0;

double convertSliderResultSpeedAll = 10.0;
double kMinSliderConvertSpeedAll = 0.0;
double kMaxSliderConvertSpeedAll = 100.0;
int sliderSliderConvertSpeedAll = 1000000;
double stepSliderConvertSpeedAll = 0.1;

int sliderConvertSpeedKilometerPerHour = 45000;
int sliderConvertSpeedMilesPerHour = 28000;

String unitSliderConvertSpeedAll = 'Miles Per Hour';

//Length
double convertResultLengthMeter = 10.0;
double convertResultLengthInch = 10.0;
double convertResultLengthFoot = 10.0;
double convertResultLengthYard = 10.0;
double convertResultLengthNanometer = 10.0;
double convertResultLengthMicrometer = 10.0;
double convertResultLengthMillimeter = 10.0;

//Distance
double convertResultDistanceKilometer = 10.0;
double convertResultDistanceMiles = 10.0;
double convertResultDistanceNauticalMiles = 10.0;

//Area
double convertResultAreaSquareMeter = 10.0;
double convertResultAreaSquareKilometer = 10.0;
double convertResultAreaSquareMile = 10.0;
double convertResultAreaYard = 10.0;
double convertResultAreaSquareFoot = 10.0;
double convertResultAreaSquareInch = 10.0;
double convertResultAreaHectare = 10.0;
double convertResultAreaAcre = 10.0;

//Mass
double convertResultMassTonne = 10.0;
double convertResultMassKilogram = 10.0;
double convertResultMassGram = 10.0;
double convertResultMassMilligram = 10.0;
double convertResultMassMicrogram = 10.0;
double convertResultMassImperialTon = 10.0;
double convertResultMassUsTon = 10.0;
double convertResultMassUsStone = 10.0;
double convertResultMassUsPound = 10.0;
double convertResultMassUsOunce = 10.0;

double convertResultMassPound = 1.0;

String unitMassUsPound = 'lb';
String unitMassGram = 'g';

//Pressure
double convertResultPressurePsi = 10.0;
double convertResultPressureAtmosphere = 10.0;
double convertResultPressureBar = 10.0;
double convertResultPressureKiloPascal = 10.0;
double convertResultPressureTorr = 10.0;
double convertResultPoundPressureForcePerSquareInch = 10.0;
double convertResultPressureInchOfMercury = 10.0;

//Temperature
double convertResultTemperatureCelsius = 10.0;
double convertResultTemperatureFahrenheit = 10.0;
double convertResultTemperatureKelvin = 10.0;

//Volume
double convertResultVolumeUsLiquidGallon = 1.2;
double convertResultVolumeUsLiquidQuart = 10.0;
double convertResultVolumeUsLiquidPint = 10.0;
double convertResultVolumeUsLegalCup = 10.0;
double convertResultVolumeUsFluidOunce = 10.0;
double convertResultVolumeUsTablespoon = 10.0;
double convertResultVolumeUsTeaSpoon = 10.0;
double convertResultVolumeCubicMeter = 10.0;
double convertResultVolumeLitre = 6.7;
double convertResultVolumeMillilitre = 10.0;
double convertResultVolumeImperialGallon = 10.0;
double convertResultVolumeImperialQuart = 10.0;
double convertResultVolumeImperialPint = 10.0;
double convertResultVolumeImperialCup = 10.0;
double convertResultVolumeImperialFluidOunce = 10.0;
double convertResultVolumeImperialTableSpoon = 10.0;
double convertResultVolumeImperialTeaSpoon = 10.0;
double convertResultVolumeCubicFoot = 10.0;
double convertResultVolumeCubicInch = 30.0;
double convertResultVolumeCubicCentimeter = 1000.0;

double convertSliderResultVolumeAll = 10.0;
String convertSliderTextVolumeAll = 'US Gal';
String convertSliderHeaderVolumeTextAll = 'US Gallon';
double kMinSliderConvertVolumeAll = 0.0;
double kMaxSliderConvertVolumeAll = 100.0;
int sliderSliderConvertVolumeAll = 100;
double stepSliderConvertVolumeAll = 0.1;

double convertSliderResultMassAll = 10.0;
double kMinSliderConvertMassAll = 0.0;
double kMaxSliderConvertMassAll = 100.0;
int sliderSliderConvertMassAll = 100;
double stepSliderConvertMassAll = 0.1;

double vMinConvertVolumeUsLiquidGallon = kMinConvertVolumeUsLiquidGallon + 0.05;
double vMaxConvertVolumeUsLiquidGallon = kMaxConvertVolumeUsLiquidGallon - 0.05;

double vMinConvertVolumeLiter = kMinConvertVolumeLiter + 0.1;
double vMaxConvertVolumeLiter = kMaxConvertVolumeLiter - 0.2;

double vMinConvertVolumeCubicCentimeter =
    kMinConvertVolumeCubicCentimeter + 3.0;
double vMaxConvertVolumeCubicCentimeter =
    kMaxConvertVolumeCubicCentimeter - 3.0;

double vMinConvertVolumeCubicInch = kMinConvertVolumeCubicInch + 0.1;
double vMaxConvertVolumeCubicInch = kMaxConvertVolumeCubicInch - 0.1;

double vMinSliderConvertVolumeAllStepper;
double vMaxSliderConvertVolumeAllStepper;

// ****************** A/R ratio

double arRatioResultCompressorMillimeter = 6.0;
double arRatioResultTurbineMillimeter = 6.0;
double arRatioResultCompressorInch = 6.0;
double arRatioResultTurbineInch = 6.0;

String arRatioResultCompressorDisplay = '6.0';
String arRatioResultTurbineDisplay = '6.0';
String arRatioResultDisplay = '4.0';

double arRatioCalculation = 0.5;
double radiusArCalculation = 45.0;
double areaArCalculation = 90.0;
double ArResultRatioMm = 1.0;

String areaArCalculationDisplay = 'NA';
String radiusArCalculationDisplay = 'NA';
bool compressorOrTurbine = true;

String unitAreaArRatioDisplay = 'mm^3';
String unitRadiusArRatioDisplay = 'mm';

double kMinAreaArCalculation = 0.0;
double kMaxAreaArCalculation = 150.0;
double stepValueAreaArCalculation = 0.01;
double kMinRadiusArCalculation = 0.0;
double kMaxRadiusArCalculation = 150.0;
double stepValueRadiusArCalculation = 0.01;

//*************** Engine Size ***********

double resultEngineCubicInch = 10.0;
String unitEngineSizeBoreInput;
String unitEngineSizeStrokeInput;
//*************************************************************************

var labelTextStyleResult0 = kLabelTextStyle;
var labelTextStyleResult1 = kLabelTextStyle;
var labelTextStyleResult2 = kLabelTextStyle;
var labelTextStyleResult3 = kLabelTextStyle;

var labelTextStyleResultTitle0 = kSecondSubjectTextStyleInActive;
var labelTextStyleResultTitle1 = kSecondSubjectTextStyleActive;
var labelTextStyleResultUnit0 = kUnitTextStyleAirflowInActive;
var labelTextStyleResultUnit1 = kUnitTextStyleAirflowActive;

var displaySizeLength = 1.0;
var displayScaleFactor = 0.8;
var displayScaleFactorSmall = 1.2;

var textScaleFactorTc = 1.0;
var textScaleFactorMini = 0.8;

int currentBuildNumberGlobal = 1;
String currentVersionNumberGlobal = 'NA';
int remoteConfigBuild = 1;

//** Android
var androidInfo;
var release;
var sdkInt;
var manufacturer;
var model;

//** iOS
var iosInfo;
var systemName;
var version;
var name;
var modelIphone;


double deviceWidth = 0.0;
double deviceHeight = 0.0;
double picWidth = 0.0;
double picHeight = 0.0;

double logoSize = 30.0;
double logoRadius = logoSize / 2;
String logoPadding = 'right: 8.0';

int temp = 0;
int radioValueMetric = 0;


//******************** turbodatabase firebase

double sortValue = 1;
int sortValue2 = 1;
double displayHeight = 0.5;

//************  DataTables ***************
double tableRowHeight = 17.0;
double columnSpacing = 30.0;
double headingRowHeight = 25;
double horizontalMargin = 0.0;

bool flipSide = true; // true - Compressor, false - Turbine
String flipSideButtonText = 'Test';

String feedBackLink =
    'https://docs.google.com/forms/d/e/1FAIpQLSfyQ5CoB28YMz3z2iJvPNJB1mW_lS3Lb7xepz13UjeRFmeFxg/viewform?usp=sf_link';

String addTurbos =
    'https://docs.google.com/forms/d/e/1FAIpQLSeiV8Q0U-7uCUpEYOJrOiTDhRIYuGP_4rhvvg477jCk4eQwVw/viewform?usp=sf_link';

String turboBradAnalytics;

String haveStartedTimes = '';

// *** FireStore
String turboModel;


//****************** HP Torque variables

double hpTorqueResult = 250.0;
double hpTorqueRpm = 5252.0;
double hpTorqueTorque = 250.0;
int hpTorqueConstant = 5252;
double resultHpTorque;
double stepHpTorqueRpm = 100.0;
double vMaxHpTorqueRpm = 10000.0;
double vMinHpTorqueRpm = 1.0;
double stepHpTorqueTorque = 1;
double vMaxHpTorqueTorque = 10000;
double vMinHpTorqueTorque = 1;
int sliderSliderHpTorqueTorque = vMaxHpTorqueTorque.toInt();
int sliderSliderHpTorqueRpm = vMaxHpTorqueRpm.toInt();


// ****** Ar Map

double mapArResultRatioMm;
double mapArResultRatioInch;
double mapArInputAreaMm;
double mapArInputAreaInch;
double mapArInputRadiusMm;
double mapArInputRadiusInch;
double mapArUnitSwitchValue;
String mapArSaveTime;
int mapArSaveIndex;

var systemAndVersion;
var mobileBrandModel;