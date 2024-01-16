import 'package:get/get.dart';
import 'package:todolist_flutter/screen/home_screen.dart';


class Routes {
  static String homePage = '/homepage';

  static String splashScreen = '/splashScreen';

  static String m3uPage = '/m3uPage';

  static String playlist = '/playlist';

  static String buildPage = '/buildPage';

  static String iptv = '/iptv';

  static String player = '/player';

  static String player2 = '/player2';

  static String nexusAddons = '/nexusAddons';

  static String productPage = '/productPage';

  static String favPage = '/favPage';
}

appRoutes() => [

      // GetPage(name: Routes.splashScreen, page: () => SplashScreen()),
      GetPage(
        name: Routes.homePage,
        page: () => HomeScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),

    ];
