import 'package:flutter/material.dart'; // Import the Material package
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'globals/app_localizations.dart';
import 'globals/route_generator.dart';
import 'provider/settings_provider.dart';
import 'services/firestore_service.dart';

void main() {
//  FlutterError.onError = (FlutterErrorDetails details) {
//    FlutterError.dumpErrorToConsole(details);
//    if (kReleaseMode)
//      exit(1);
//  };
  runApp(TurboCalculator());
}

//git
class TurboCalculator extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  const TurboCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final FireStoreService _db = FireStoreService();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => SettingsNotifier(),
          ),
          StreamProvider(
            create: (_) => _db.getTurbos(),
            catchError: (context, error) {
              // catchError: (context, error) {
              print(
                error.toString(),
              );
            },
            initialData: [],
          ),
          StreamProvider(
            create: (_) => _db.getTurbine(),
            catchError: (context, error) {
              print(
                error.toString(),
              );
            },
            initialData: [],
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            // primaryColor: Color(0xFF0a0A31),
            // scaffoldBackgroundColor: Color(0xFF0a0A31),
            primaryColor: Color(0xFF0a0A31),
            scaffoldBackgroundColor: Color(0xFF0a0A31),
          ),

          supportedLocales: [
            Locale('en', 'US'),
            Locale('en', 'GB'),
            Locale('en', 'AU'),
            Locale('en', 'CA'),
            Locale('en', 'IN'),
            Locale('en', 'NZ'),
            Locale('en', 'ZA'),
            Locale('sv', 'SE'),
            Locale('sv', 'FI'),
            Locale('es', 'ES'),

            /*
            en-GB	British English
            en-US	American English
            en-CA	Canadian English
            en-IN	Indian English
            en-AU	Australian English
            en-NZ	New Zealand English
            en-ZA	South African English
            */

            Locale('es', 'MX'),
            Locale('es', 'AR'),
            Locale('es', 'CO'),
            Locale('es', 'CL'),
            Locale('es', 'PE'),
            Locale('es', 'VE'),
            Locale('es', 'DO'),

            /* es-ES	Castilian Spanish (as spoken in Central-Northern Spain)
            es-MX	Mexican Spanish
            es-AR	Argentine Spanish
            es-CO	Colombian Spanish
            es-CL	Chilean Spanish
            es-PE	Peruvian Spanish
            es-VE	Venezuelan Spanish
            es-DO	Dominican Spanish */

            Locale('pt', 'PT'),
            Locale('pt', 'BR'),
            Locale('pt', 'AO'),
            Locale('pt', 'MZ'),

            /*
              pt-PT	European Portuguese (as written and spoken in Portugal)
              pt-BR	Brazilian Portuguese
              pt-AO	Angolan Portuguese
              pt-MZ	Mozambican Portuguese
            */

            Locale('de', 'DE'),
            Locale('de', 'AT'),
            Locale('de', 'CH'),

            /*
            de-AT	Austrian German
            de-DE	Standard German (as spoken in Germany)
            de-CH	"Swiss" German
            */

            Locale('fr', 'FR'),
            Locale('fr', 'CH'),
            Locale('fr', 'CA'),
            Locale('fr', 'BE'),
            Locale('fr', 'LU'),

            /*
              fr-BE	Belgian French
              fr-CH	"Swiss" French
              fr-FR	Standard French (especially in France)
              fr-CA	Canadian French
              fr-LU	Luxembourgish French
            */

            Locale('it', 'IT'),
            Locale('it', 'CH'),
            Locale('ru', 'RU'),
          ],

          // These delegates make sure that the localization data for the proper language is loaded
          localizationsDelegates: [
            // THIS CLASS WILL BE ADDED LATER
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
          ],

          // Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            // If the locale of the device is not supported, use the first one
            // from the list (English, in this case).
            return supportedLocales.first;
          },

          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          initialRoute: 'start',

          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}
