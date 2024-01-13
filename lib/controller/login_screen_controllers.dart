import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenControllers extends GetxController {
  final TextEditingController emailcontrollers = TextEditingController();
   final TextEditingController passwordcontrollers = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailcontrollers.dispose();
  }
}
