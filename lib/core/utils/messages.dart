// lib/core/utils/messages.dart

import 'package:flutter/material.dart';

class MessageUtils {
  /// Displays a success message.
  static void showSuccessMessage(BuildContext context, String message) {
    _showSnackBar(context, message, const Color.fromARGB(255, 40, 129, 43));
  }

  /// Displays an error message.
  static void showErrorMessage(BuildContext context, String message) {
    _showSnackBar(context, message, const Color.fromARGB(255, 182, 42, 32));
  }

  /// Displays an information message.
  static void showInfoMessage(BuildContext context, String message) {
    _showSnackBar(context, message, const Color.fromARGB(255, 18, 106, 177));
  }

  static void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center, 
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(12.0),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
