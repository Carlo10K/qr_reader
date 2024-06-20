import 'package:flutter/material.dart';
import 'package:qr_scanner_sqlite/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchInBrowser(BuildContext context, ScanModel scan) async {
  final url = scan.valor;
  if (scan.tipo == 'http') {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  } else {
    Navigator.pushNamed(context, '/maps', arguments: scan);
  }
}
