import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todolist_flutter/providers/providers.dart';
import 'package:todolist_flutter/routes/routes.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xffffc0cb), // navigation bar color
    statusBarColor: Color(0xffffc0cb), // status bar color
  ));*/
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final isLightTheme = ref.watch(themeProvider);
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: GetMaterialApp(
            // Remove the debug banner
            debugShowCheckedModeBanner: false,
            title: 'IPTV',
            theme: isLightTheme ? ThemeData.light() : ThemeData.dark(),
            initialRoute: Routes.splashScreen,
            getPages: appRoutes()));
  }
}
