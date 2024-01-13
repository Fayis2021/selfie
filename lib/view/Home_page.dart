import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfie/view/widget.dart/button.dart';
import '../constants/close_app.dart';
import '../controller/camera_view_controller.dart';
import '../controller/data_controller.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  CameraController cameraController = Get.put(CameraController());
  DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Selfie"),
        leading: const Icon(Icons.person),
      ),
      body: WillPopScope(
        onWillPop: () async {
          await onBackPressed(context);
          return false;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => cameraController.image.value == null
                    ? const Text('No image selected.')
                    : Image.file(
                        File(cameraController.image.value!.path),
                        height: 200.0,
                        width: 200.0,
                      ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.1,
              ),
              Obx(
                () => CustomElevatedButton(
                  onPressed: () => cameraController.getImage(),
                  buttonText: cameraController.image.value != null
                      ? "Retake"
                      : 'Take Photo',
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              Obx(
                () => CustomElevatedButton(
                    onPressed: cameraController.image.value == null ||
                            dataController.checkSubmitbuttonpressed.value &&
                                dataController.checkSubmission.value == false
                        ? null
                        : () async {
                            dataController.checkSubmitbuttonpressed.value =
                                true;
                            await dataController.getCurrentLocation(
                                cameraController.image.value!.path);
                            dataController.checkSubmitbuttonpressed.value =
                                false;

                            cameraController.image.value = null;
                          },
                    buttonText: dataController.checkSubmitbuttonpressed.value &&
                            dataController.checkSubmission.value == false
                        ? "Processing..."
                        : "Submit"),
              ),
              Obx(() => dataController.checkSubmission.value
                  ? const Text(
                      "Submitted Successfully",
                      style: TextStyle(color: Colors.green),
                    )
                  : const SizedBox())
            ],
          ),
        ),
      ),
    );
  }
}
