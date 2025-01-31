import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/extension/context_extension.dart';
import 'package:flutter_all_in_one/style/app_color.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColor.white,
        centerTitle: true,
        title: Text(
          context.loc.scan_qr,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
