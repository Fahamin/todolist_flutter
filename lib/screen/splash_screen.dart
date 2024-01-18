import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_flutter/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Get.offNamed(Routes.homeScreen);
    } else {
      await prefs.setBool('seen', true);
      Get.offNamed(Routes.onboardPage);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(

              child: CircularProgressIndicator(),
            ),
            Gap(10.h),
            Center(

              child: Text("Todo APP Flutter"),
            )
          ],
        ),
      ),
    );
  }
}

