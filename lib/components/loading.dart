import 'package:flutter/material.dart';

void Loading(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 40,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Loading..."),
                ),
                CircularProgressIndicator(strokeWidth: 2,color: Colors.black,),
              ],
            ),
          ),
        );
      });
}
