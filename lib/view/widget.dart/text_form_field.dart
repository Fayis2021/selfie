import 'package:flutter/material.dart';

typedef ValidatorCallback = String? Function(String? value);

TextFormField buildTextFormField({
  required TextEditingController controller,
  required String labelText,
  required ValidatorCallback? validatorCallback,
}) {
  return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      validator: validatorCallback
      );
}
