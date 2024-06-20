import 'package:flutter/material.dart';
import 'package:qr_scanner_sqlite/widgets/scan_tiles.dart';

class AddressesWidget extends StatelessWidget {
  const AddressesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'http');
  }
}
