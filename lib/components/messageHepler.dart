import 'package:flutter/material.dart';

class MessageHepler {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showMessage(bool isSuccess, String message) {
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar( 
        duration: Duration(seconds: 5),
        backgroundColor: isSuccess == true ? Colors.green : Colors.red,
        content: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
