import 'package:flutter/material.dart';

class CustomSnackbar {
  static SnackBar show({
    required BuildContext context,
    required String message,
  }) {
    return SnackBar(
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
