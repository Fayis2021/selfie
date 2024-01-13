import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'dart:convert';

import '../constants/app_names_constants.dart';
import '../service/shared_preference.dart';

class UserApiController extends GetxController {
  RxBool isLoadingLogin = false.obs;
  RxString userid = ''.obs;

  Future<void> loginPageApi(var username, var pwd) async {
    try {
      const String apiUrl = 'https://work.kannathal.com/Sheela/login.php';
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.fields['name'] = "$username";
      request.fields['pwd'] = "$pwd";

      // Send the request
      var response = await request.send();
      isLoadingLogin.value = true;

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        await SharedPreferencesService.setData("loggedIn");
        var decodedResponse = json.decode(responseData);

        isLoadingLogin.value = false;
        userid.value = decodedResponse["userid"];

        Get.toNamed("/Home");
      }
    } catch (e) {
      Get.snackbar(
          AppNamesConstants.errormsg, "Check The Usename and password");
      isLoadingLogin.value = false;
    }
  }

  //

  //send to db

  Future<void> uploadData(
    XFile selfi,
    String lat,
    String long,
  ) async {
    const String apiUrl = 'https://work.kannathal.com/Sheela/register.php';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    request.files.add(await http.MultipartFile.fromPath('photo', selfi.path));

    request.fields['userid'] = userid.toString();
    request.fields['geolocation'] = lat + long.toString();

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      // var responseBytes = await response.stream.toBytes();

      Get.snackbar("Uploaded", "success");
    } else {
      Get.snackbar(AppNamesConstants.errormsg, AppNamesConstants.tryagain);
    }
  }
}
