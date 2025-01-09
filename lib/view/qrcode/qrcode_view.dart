import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeView extends StatefulWidget {
  const QRCodeView({super.key});

  @override
  State<QRCodeView> createState() => _QRCodeViewState();
}

class _QRCodeViewState extends State<QRCodeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        centerTitle: true,
        title: Text(
          "QRCODE",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   margin: EdgeInsets.all(120),
            //   child: QrImageView(
            //     data: '1234567890',
            //     version: QrVersions.auto,
            //     size: 200.0,
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                Text("Save Qr code"),
                IconButton(
                  onPressed: () {
                    
                  },
                  icon: Icon(Icons.download_for_offline_rounded),
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.all(120),
              child: Image.network(
                  "http://res.cloudinary.com/docl6igdw/image/upload/v1733917981/images1/ktf00yh0ariti7pbv1up.png"),
            )
          ],
        ),
      ),
    );
  }
}
