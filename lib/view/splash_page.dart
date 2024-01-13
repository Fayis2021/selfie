import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfie/constants/app_assets_constant.dart';

import '../controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppAssetsConstant.sPLASHIMAGE),
      ),
    );
  }
}
