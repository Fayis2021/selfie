import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> onBackPressed(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Exit App?'),
      content: const Text('Are you sure you want to exit the app?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          child: const Text('Sure'),
        ),
      ],
    ),
  ).then((value) => value ?? false);
}
