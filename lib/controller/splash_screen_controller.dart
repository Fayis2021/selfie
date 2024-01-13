import 'package:get/get.dart';

import '../service/shared_preference.dart';

class SplashController extends GetxController {
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoggedIn();
  }

  Future<void> checkLoggedIn() async {
    String log = await SharedPreferencesService.getData();
    await Future.delayed(const Duration(seconds: 2));
    if (log == "loggedIn") {
      Get.toNamed('/Home');
    }else{
       Get.toNamed('/Login');
    }
  }
}
