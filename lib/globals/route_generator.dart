import 'package:tct/screens/convert/convert_distance.dart';
import 'package:tct/screens/convert/convert_speed.dart';
import 'package:tct/screens/convert/convert_temperature.dart';
import 'package:tct/screens/convert/convert_length.dart';
import 'package:tct/screens/convert/convert_mass.dart';
import 'package:tct/screens/convert/convert_psi_and_bar.dart';
import 'package:tct/screens/convert/convert_volume.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:tct/screens/tuning/tuning_hp_torque.dart';
import 'package:tct/expriment/sliver_test.dart';
import 'package:tct/screens/turbo/turbo_compressor_turbine_page.dart';
import 'package:tct/screens/info/turbo_selector_feedback.dart';
import 'package:tct/screens/turbo/turbo_details.dart';
import 'package:tct/screens/turbo/turbo_selection.dart';
import 'package:tct/screens/tuning/tuning_torque.dart';
import 'package:tct/screens/airflow/turbo_airflow_conv_density.dart';
import 'package:tct/screens/turbo/ar_ratio.dart';
import 'package:tct/arkiv/compressor_map_query.dart';
import 'package:tct/arkiv/compressor_maps.dart';
import 'package:tct/arkiv/compressor_maps_chips.dart';
import 'package:tct/screens/info/info_app_news.dart';
import 'package:tct/screens/info/info_web_app_feedback.dart';
import 'package:tct/screens/info/info_web_tc_website.dart';
import 'package:tct/expriment/meassure_help.dart';
import 'package:tct/screens/airflow/turbo_airflow_conv_gaslaw.dart';
import 'package:tct/screens/airflow/turbo_airflow_hp_rpm.dart';
import 'package:tct/screens/airflow/turbo_airflow_conversions.dart';
import 'package:tct/screens/airflow/turbo_airflow_target_boost_pressure.dart';
import 'package:tct/screens/info/info_about_tct.dart';
import 'package:tct/screens/info/info_credits.dart';
import 'package:tct/screens/a_menu.dart';
import 'package:tct/screens/tuning/tuning_engine_size.dart';
import 'package:flutter/material.dart';
import 'package:tct/arkiv/turbine_page.dart';
import 'package:tct/arkiv/turbo_basic_compressor_page.dart';
import 'package:tct/arkiv/turbo_compressor_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final metricUnit = true;
    print('Routsettings start $settings');

    switch (settings.name) {
      case 'start':
        print('Start metricUnit: $metricUnit');
        print('settings.name ${settings.name}');
        print(settings.arguments);

        print('Routsettings start $settings');

        //if (metricUnit is bool) {
        return MaterialPageRoute(
          builder: (_) => MenuPage(metricUnit: metricUnit),
//          settings: const RouteSettings(name: 'Start Page', arguments: true),
        );
      // }
      case 'turbo_register':
        print(settings.name);
        print('Routsettings turboregister $settings');
        print('metricUnit $metricUnit');

        return MaterialPageRoute(
          builder: (_) => TurboSelection(
            key: UniqueKey(),
            routeSetting: metricUnit,
          ),
          settings: const RouteSettings(name: 'Turbo Register'),
        );

      case 'turbo_details':
        print(settings.name);
        print('Routsettings turbodetails $settings');
        print('metricUnit $metricUnit');
        print(turboBradAnalytics);
        return MaterialPageRoute(
          builder: (_) => TurboInfoPage(),
          settings: RouteSettings(name: 'Turbo detail'),
        );

      case 'turbo_register_feedback':
        print(settings.name);
        print('Routsettings turboregister $settings');
        print('metricUnit $metricUnit');

        return MaterialPageRoute(
          builder: (_) => TurboSelectorFeedback(
            key: UniqueKey(),
            feedbackLink: feedBackLink,
          ),
          settings: const RouteSettings(name: 'Turbo Reg Feedback'),
        );

      case 'turbo_add':
        print(settings.name);
        print('Routsettings turboregister $settings');
        print('metricUnit $metricUnit');

        return MaterialPageRoute(
          builder: (_) =>
              TurboSelectorFeedback(key: UniqueKey(), feedbackLink: addTurbos),
          settings: const RouteSettings(name: 'Turbo Reg Add'),
        );

      case 'basiccompressorpage':
        print(settings.name);
        print(settings);
        print(metricUnit);

        return MaterialPageRoute(
          builder: (_) => BasicCompressorPage(
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Hp Compressor'),
        );

      case 'compressor_turbine_page':
        print(settings.name);
        print('Routsettings compressor_turbine $settings');
        print('metricUnit $metricUnit');

        return MaterialPageRoute(
          builder: (_) => CompressorTurbinePage(
            key: UniqueKey(),
            settings: settings,
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Compressor Turbine'),
        );

      case 'compressorpage':
        print(settings.name);
        print('settings $settings');
        print('metricUnit $metricUnit');

        return MaterialPageRoute(
          builder: (_) => CompressorPage(
            metricUnit: metricUnit,
            settings: settings,
          ),
          settings: const RouteSettings(name: 'Compressor'),
        );

      case 'turbinepage':
        print(settings.name);
        print(settings);

        return MaterialPageRoute(
          builder: (_) => TurbinePage(
            metricUnit: metricUnit,
            settings: settings,
          ),
          settings: const RouteSettings(name: 'Turbine'),
        );

      case 'ar_ratio':
        print(settings.name);
        print(settings);

        return MaterialPageRoute(
          builder: (_) => ArRatioPage(
            key: UniqueKey(),
            settings: settings,
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'A/R ratio'),
        );

      case 'airflowpage':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => AirflowPage(
            key: UniqueKey(),
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Airflow HP'),
        );
      case 'airflowsimplepage':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => AirflowSimple(),
          settings: const RouteSettings(name: 'Airflow Air Density'),
        );
      case 'airflowtbppage':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => AirflowTbpPage(
            key: UniqueKey(),
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Airflow BP'),
        );
      case 'airflowconversions':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => AirFlowConversion(
            key: UniqueKey(),
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Airflow Adv'),
        );

      case 'airflowconversions':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => AirFlowConversion(
            key: UniqueKey(),
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Airflow GL-OLD'),
        );

      case 'airflowconvgaslaw':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => AirflowGasLawConv(
//                  metricUnit: metricUnit,
              ),
          settings: const RouteSettings(name: 'Airflow Gas Law'),
        );
      case 'enginesize':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => EngineSizePage(
            key: UniqueKey(),
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Engine size'),
        );

      case 'torque':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => TorquePage(
            key: UniqueKey(),
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Torque'),
        );

      case 'hptorque':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => HpBasedOnTorquePage(
            key: UniqueKey(),
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'HP Torque'),
        );

      case 'speed':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => SpeedPage(),
          settings: const RouteSettings(name: 'Speed conv'),
        );
      case 'psiandbar':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => PsiAndBarPage(),
          settings: const RouteSettings(name: 'Pressure conv'),
        );
      case 'inchandmm':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => InchAndMillimeterPage(),
          settings: const RouteSettings(name: 'Length conv'),
        );
      case 'convert_distance':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => ConvertDistancePage(),
          settings: const RouteSettings(name: 'Distance conv'),
        );

      case 'celsiusandfahrenheit':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => CelsiusToFahrenheitPage(),
          settings: const RouteSettings(name: 'Temp conv'),
        );
      case 'volume':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => VolumePage(),
          settings: const RouteSettings(name: 'Volume conv'),
        );
      case 'mass':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => MassPage(),
          settings: const RouteSettings(name: 'Mass conv'),
        );
      case 'measurehelp':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => MeasureHelpPage(
            key: UniqueKey(),
            settings: settings,
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Meassure Help'),
        );
      case 'compressormap':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => CompressorMapPage(
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Compressor Map'),
        );
      case 'compressormapchips':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => CompressorMapChipsPage(
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Compressor Chip'),
        );
      case 'compressormapquery':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => CompressorMapQueryPage(
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Compressor Query'),
        );

      case 'appinformation':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => AppInformationPage(
            key: UniqueKey(),
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'App Info'),
        );

      case 'credits':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => CreditsPage(
            key: UniqueKey(),
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'Credits'),
        );

      case 'tcwebsite':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => TcWebSitePage(
            key: UniqueKey(),
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'TCT Website'),
        );

      case 'tctappnews':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => TctAppNewsPage(
            key: UniqueKey(),
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'TCT App News'),
        );
      case 'feedback':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => FeedbackPage(
            key: UniqueKey(),
            metricUnit: metricUnit,
          ),
          settings: const RouteSettings(name: 'TCT Feedback'),
        );
      case 'sliver_test':
        print(settings.name);
        print(settings);
        return MaterialPageRoute(
          builder: (_) => SliversBasicPage(
              //metricUnit: metricUnit,
              ),
          settings: const RouteSettings(name: 'Sliver test'),
        );
    }
    return _errorRoute();
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
