import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../constants/app_names_constants.dart';
import '../model/user_data_model.dart';
import '../service/service_data_base_helper.dart';
import 'api_controllers.dart';
import 'camera_view_controller.dart';

class DataController extends GetxController {
  UserApiController userApiController = Get.put(UserApiController());
  CameraController cameraController = Get.put(CameraController());
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  RxList<MyDataModel> data = <MyDataModel>[].obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxBool checkSubmission = false.obs;
  RxBool checkSubmitbuttonpressed = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    //use if we want to show to userdata to UI
    data.value = await dbHelper.getAllData();
  }

  Future<void> insertData(String imageAddress, double lat, double long) async {
    final MyDataModel newData = MyDataModel(
      imageAddress: imageAddress,
      lat: lat,
      long: long,
    );
    await dbHelper.insert(newData);
    await _loadData();
  }

  //get location

  Future<void> getCurrentLocation(imagepath) async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Display Snackbar if permission is not granted
        Get.snackbar(
          'Location Permission',
          'Please grant location permission to use this feature.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      } else {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        latitude.value = position.latitude;
        longitude.value = position.longitude;

        await insertData(imagepath, latitude.value, longitude.value);
        await userApiController.uploadData(cameraController.image.value!,
            latitude.value.toString(), longitude.value.toString());
        checkSubmission.value = true;

        await Future.delayed(Duration(seconds: 3));
        checkSubmission.value = false;
      }
    } catch (e) {
      Get.snackbar(AppNamesConstants.errormsg, AppNamesConstants.tryagain);
    }
  }
}
