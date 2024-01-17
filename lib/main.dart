import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todolist_flutter/providers/providers.dart';
import 'package:todolist_flutter/routes/routes.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final isLightTheme = ref.watch(themeProvider);

    return GetMaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'IPTV',
        theme: isLightTheme ? ThemeData.light() : ThemeData.dark(),
        initialRoute: Routes.homeScreen,
        getPages: appRoutes());
  }
}
