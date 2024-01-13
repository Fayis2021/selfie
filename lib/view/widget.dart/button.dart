import 'package:flutter/material.dart';
import 'package:selfie/constants/app_color_constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;

  CustomElevatedButton({
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5.0,
            backgroundColor: AppColorsConstants.buttonbackgroundColor,
            shadowColor: AppColorsConstants.buttonshadowColor),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    );
  }
}
