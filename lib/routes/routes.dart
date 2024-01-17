import 'package:get/get.dart';
import 'package:todolist_flutter/screen/details_screen.dart';
import 'package:todolist_flutter/screen/home_screen.dart';
import 'package:todolist_flutter/screen/onbording_screen.dart';

import '../screen/splash_screen.dart';

class Routes {
  static String homeScreen = '/homeScreen';

  static String splashScreen = '/splashScreen';

  static String details = '/details';

  static String onboardPage = '/onboardPage';
}

appRoutes() => [
      GetPage(name: Routes.splashScreen, page: () => SplashScreen()),
      GetPage(
        name: Routes.homeScreen,
        page: () => HomeScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routes.details,
        page: () => DetailsScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routes.onboardPage,
        page: () => OnBoardingScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
    ];
