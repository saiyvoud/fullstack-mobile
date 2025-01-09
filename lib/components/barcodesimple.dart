import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nav_service/nav_service.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/messageHepler.dart';
import 'package:restaurant_app/components/qr_code_overlay.dart';
import 'package:restaurant_app/provider/product_provider.dart';
import 'package:restaurant_app/router/router.dart';

class BarcodeScannerSimple extends StatefulWidget {
  const BarcodeScannerSimple({super.key});

  @override
  State<BarcodeScannerSimple> createState() => _BarcodeScannerSimpleState();
}

class _BarcodeScannerSimpleState extends State<BarcodeScannerSimple> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Scanner QR"),
      ),
      body: Consumer<ProductProvider>(builder: (context, product, child) {
        return Stack(
          children: [
            MobileScanner(
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.noDuplicates,
                  returnImage: true,
                  torchEnabled: true,
                  useNewCameraSelector: true,
                ),
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  final Uint8List? image = capture.image;
                  var tableID;
                  for (var barcode in barcodes) {
                    final data = jsonDecode(barcode.rawValue.toString());
                    setState(() {
                      tableID = data['tableID'];
                    });
                  }
                  if (image != null) {
                    // qrcode ໂຄດຕໍ່ນີ້ມີໃນຖານຂໍ້ມູນບໍ່ ຖ້າຜ່ານແມ່ນຈະໄປຫນ້າສັ່ງອາຫານ ຖ້າບໍ່ຜ່ານຈະສະແດງຂໍ້ມູນວ່າ ໂຕະບໍ່ວ່າງ
                    product.CheckQRCode(tableID: tableID);
                  } else {
                    NavService.pop();
                    MessageHepler.showMessage(false, "Faild Scan QR code");
                  }
                }),
            QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
          ],
        );
      }),
    );
  }
}
