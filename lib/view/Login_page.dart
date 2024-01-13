import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfie/controller/api_controllers.dart';
import 'package:selfie/view/widget.dart/button.dart';
import 'package:selfie/view/widget.dart/text_form_field.dart';

import '../constants/close_app.dart';
import '../controller/login_screen_controllers.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  LoginScreenControllers loginScreenControllers =
      Get.put(LoginScreenControllers());
  UserApiController userApiController = Get.put(UserApiController());

  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            await onBackPressed(context);
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    const Text(
                      "Log In",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    Image.asset("assets/login.png"),
                    buildTextFormField(
                      controller: loginScreenControllers.emailcontrollers,
                      labelText: "UserName",
                      validatorCallback: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a user name';
                        }
                        return null;
                      },
                    ),
                    buildTextFormField(
                      controller: loginScreenControllers.passwordcontrollers,
                      labelText: "Password",
                      validatorCallback: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Your Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    Obx(
                      () => CustomElevatedButton(
                        onPressed: userApiController.isLoadingLogin.value
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  userApiController.loginPageApi(
                                    loginScreenControllers
                                        .emailcontrollers.text,
                                    loginScreenControllers
                                        .passwordcontrollers.text,
                                  );
                                }
                              },
                        buttonText: 'Log In -->',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
