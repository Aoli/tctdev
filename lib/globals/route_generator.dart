import 'package:Turbocharger/screens/convert/convert_distance.dart';
import 'package:Turbocharger/screens/convert/convert_speed.dart';
import 'package:Turbocharger/screens/convert/convert_temperature.dart';
import 'package:Turbocharger/screens/convert/convert_length.dart';
import 'package:Turbocharger/screens/convert/convert_mass.dart';
import 'package:Turbocharger/screens/convert/convert_psi_and_bar.dart';
import 'package:Turbocharger/screens/convert/convert_volume.dart';
import 'package:Turbocharger/globals/global_variables.dart';
import 'package:Turbocharger/screens/tuning/tuning_hp_torque.dart';
import 'package:Turbocharger/expriment/sliver_test.dart';
import 'package:Turbocharger/screens/turbo/turbo_compressor_turbine_page.dart';
import 'package:Turbocharger/screens/info/turbo_selector_feedback.dart';
import 'package:Turbocharger/screens/turbo/turbo_details.dart';
import 'package:Turbocharger/screens/turbo/turbo_selection.dart';
import 'package:Turbocharger/screens/tuning/tuning_torque.dart';
import 'package:Turbocharger/screens/airflow/turbo_airflow_conv_density.dart';
import 'package:Turbocharger/screens/turbo/ar_ratio.dart';
import 'package:Turbocharger/arkiv/compressor_map_query.dart';
import 'package:Turbocharger/arkiv/compressor_maps.dart';
import 'package:Turbocharger/arkiv/compressor_maps_chips.dart';
import 'package:Turbocharger/screens/info/info_app_news.dart';
import 'package:Turbocharger/screens/info/info_web_app_feedback.dart';
import 'package:Turbocharger/screens/info/info_web_tc_website.dart';
import 'package:Turbocharger/expriment/meassure_help.dart';
import 'package:Turbocharger/screens/airflow/turbo_airflow_conv_gaslaw.dart';
import 'package:Turbocharger/screens/airflow/turbo_airflow_hp_rpm.dart';
import 'package:Turbocharger/screens/airflow/turbo_airflow_conversions.dart';
import 'package:Turbocharger/screens/airflow/turbo_airflow_target_boost_pressure.dart';
import 'package:Turbocharger/screens/info/info_about_tct.dart';
import 'package:Turbocharger/screens/info/info_credits.dart';
import 'package:Turbocharger/screens/a_menu.dart';
import 'package:Turbocharger/screens/tuning/tuning_engine_size.dart';
import 'package:flutter/material.dart';
import 'package:Turbocharger/arkiv/turbine_page.dart';
import 'package:Turbocharger/arkiv/turbo_basic_compressor_page.dart';
import 'package:Turbocharger/arkiv/turbo_compressor_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final metricUnit = true;
    print('Routsettings start $settings');

    switch (settings.name) {
      case 'start':
        print('Start metricUnit: $metricUnit');
        print('settings.name' + ' ' + settings.name);
        print(settings.arguments);

        print('Routsettings start $settings');

        //if (metricUnit is bool) {
        return MaterialPageRoute(
          builder: (_) => MenuPage(metricUnit: metricUnit),
//          settings: const RouteSettings(name: 'Start Page', arguments: true),
        );
        // }
        return _errorRoute();
      case 'turbo_register':
        print(settings.name);
        print('Routsettings turboregister $settings');
        print('metricUnit $metricUnit');

        return MaterialPageRoute(
          builder: (_) => TurboSelection(routeSetting: metricUnit),
          settings: const RouteSettings(name: 'Turbo Register'),
        );
        return _errorRoute();

      case 'turbo_details':
        print(settings.name);
        print('Routsettings turbodetails $settings');
        print('metricUnit $metricUnit');
        print(turboBradAnalytics);
        return MaterialPageRoute(
          builder: (_) => TurboInfoPage(),
          settings: RouteSettings(name: 'Turbo detail'),
        );
        return _errorRoute();

      case 'turbo_register_feedback':
        print(settings.name);
        print('Routsettings turboregister $settings');
        print('metricUnit $metricUnit');

        return MaterialPageRoute(
          builder: (_) => TurboSelectorFeedback(feedbackLink: feedBackLink),
          settings: const RouteSettings(name: 'Turbo Reg Feedback'),
        );
        return _errorRoute();

      case 'turbo_add':
        print(settings.name);
        print('Routsettings turboregister $settings');
        print('metricUnit $metricUnit');

        return MaterialPageRoute(
          builder: (_) => TurboSelectorFeedback(feedbackLink: addTurbos),
          settings: const RouteSettings(name: 'Turbo Reg Add'),
        );
        return _errorRoute();

      case 'basiccompressorpage':
        print(settings.name);
        print(settings);
        print(metricUnit);

        return MaterialPageRoute(
          builder: (_) =>
              BasicCompressorPage(
                metricUnit: metricUnit,
              ),
          settings: const RouteSettings(name: 'Hp Compressor'),
        );

        return _errorRoute();

      case 'compressor_turbine_page':
        print(settings.name);
        print('Routsettings compressor_turbine $settings');
        print('metricUnit $metricUnit');

        return MaterialPageRoute(
          builder: (_) =>
              CompressorTurbinePage(
                metricUnit: metricUnit,
              ),
          settings: const RouteSettings(name: 'Compressor Turbine'),
        );

        return _errorRoute();

      case 'compressorpage':
        print(settings.name);
        print('settings $settings');
        print('metricUnit $metricUnit');

        return MaterialPageRoute(
          builder: (_) =>
              CompressorPage(
                metricUnit: metricUnit,
              ),
          settings: const RouteSettings(name: 'Compressor'),
        );

        return _errorRoute();
      case 'turbinepage':
        print(settings.name);
        print(settings);

        return MaterialPageRoute(
          builder: (_) =>
              TurbinePage(
                metricUnit: metricUnit,
              ),
          settings: const RouteSettings(name: 'Turbine'),
        );

        return _errorRoute();
      case 'ar_ratio':
        print(settings.name);
        print(settings);

        return MaterialPageRoute(
          builder: (_) =>
              ArRatioPage(
                metricUnit: metricUnit,
              ),
          settings: const RouteSettings(name: 'A/R ratio'),
        );

        return _errorRoute();
      case 'airflowpage':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) => AirflowPage(
              metricUnit: metricUnit,
            ),
            settings: const RouteSettings(name: 'Airflow HP'),
          );
        }
        return _errorRoute();
      case 'airflowsimplepage':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) => AirflowSimple(),
            settings: const RouteSettings(name: 'Airflow Air Density'),
          );
        }
        return _errorRoute();
      case 'airflowtbppage':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) => AirflowTbpPage(
              metricUnit: metricUnit,
            ),
            settings: const RouteSettings(name: 'Airflow BP'),
          );
        }
        return _errorRoute();
      case 'airflowconversions':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                AirFlowConversion(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'Airflow Adv'),
          );
        }
        return _errorRoute();

      case 'airflowconversions':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                AirFlowConversion(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'Airflow GL-OLD'),
          );
        }
        return _errorRoute();

      case 'airflowconvgaslaw':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                AirflowGasLawConv(
//                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'Airflow Gas Law'),
          );
        }
        return _errorRoute();
      case 'enginesize':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                EngineSizePage(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'Engine size'),
          );
        }
        return _errorRoute();

      case 'torque':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                TorquePage(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'Torque'),
          );
        }
        return _errorRoute();

      case 'hptorque':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                HpBasedOnTorquePage(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'HP Torque'),
          );
        }
        return _errorRoute();

      case 'speed':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) => SpeedPage(),
            settings: const RouteSettings(name: 'Speed conv'),
          );
        }
        return _errorRoute();
      case 'psiandbar':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) => PsiAndBarPage(),
            settings: const RouteSettings(name: 'Pressure conv'),
          );
        }
        return _errorRoute();
      case 'inchandmm':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) => InchAndMillimeterPage(),
            settings: const RouteSettings(name: 'Length conv'),
          );
        }
        return _errorRoute();
      case 'convert_distance':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) => ConvertDistancePage(),
            settings: const RouteSettings(name: 'Distance conv'),
          );
        }
        return _errorRoute();


      case 'celsiusandfahrenheit':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) => CelsiusToFahrenheitPage(),
            settings: const RouteSettings(name: 'Temp conv'),
          );
        }
        return _errorRoute();
      case 'volume':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) => VolumePage(),
            settings: const RouteSettings(name: 'Volume conv'),
          );
        }
        return _errorRoute();
      case 'mass':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) => MassPage(),
            settings: const RouteSettings(name: 'Mass conv'),
          );
        }
        return _errorRoute();
      case 'measurehelp':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                MeasureHelpPage(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'Meassure Help'),
          );
        }
        return _errorRoute();
      case 'compressormap':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                CompressorMapPage(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'Compressor Map'),
          );
        }
        return _errorRoute();
      case 'compressormapchips':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                CompressorMapChipsPage(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'Compressor Chip'),
          );
        }
        return _errorRoute();
      case 'compressormapquery':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                CompressorMapQueryPage(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'Compressor Query'),
          );
        }
        return _errorRoute();

      case 'appinformation':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                AppInformationPage(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'App Info'),
          );
        }
        return _errorRoute();
      case 'credits':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                CreditsPage(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'Credits'),
          );
        }
        return _errorRoute();
      case 'tcwebsite':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                TcWebSitePage(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'TCT Website'),
          );
        }
        return _errorRoute();
      case 'tctappnews':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                TctAppNewsPage(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'TCT App News'),
          );
        }
        return _errorRoute();
      case 'feedback':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                FeedbackPage(
                  metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'TCT Feedback'),
          );
        }
        return _errorRoute();
      case 'sliver_test':
        print(settings.name);
        print(settings);
        if (metricUnit is bool) {
          return MaterialPageRoute(
            builder: (_) =>
                SliversBasicPage(
                  //metricUnit: metricUnit,
                ),
            settings: const RouteSettings(name: 'Sliver test'),
          );
        }
        return _errorRoute();
    }
    return null;
  }

  static Route<dynamic> _errorRoute() {
    const RouteSettings(name: 'Error route');
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error No Menu'),
        ),
        body: Center(
          child: Text('Error No Tab'),
        ),
      );
    });
  }
}
