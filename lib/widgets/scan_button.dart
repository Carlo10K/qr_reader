import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_sqlite/providers/scan_list_provider.dart';
import 'package:qr_scanner_sqlite/utils/utils.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 0,
        child: const Icon(
          Icons.filter_center_focus,
          color: Colors.white,
        ),
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#3D8BEF', 'Cancelar', false, ScanMode.QR);

          if (barcodeScanRes == '-1') {
            return;
          }

          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);
          final newScan = await scanListProvider.newScan(barcodeScanRes);

          launchInBrowser(context, newScan);
        });
  }
}
