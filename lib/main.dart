import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfie/view/Home_page.dart';
import 'package:selfie/view/Login_page.dart';
import 'package:selfie/view/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: '/Login', page: () => LoginPage()),
        GetPage(name: '/Home', page: () => HomePage()),
      ],
      home: SplashScreen(),
    );
  }
}
