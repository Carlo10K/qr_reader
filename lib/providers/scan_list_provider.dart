import 'package:flutter/material.dart';
import 'package:qr_scanner_sqlite/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  newScan(String valor) async {
    final newScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.newScan(newScan);

    //asignacion del id al modelo nuevo
    newScan.id = id;

    if (selectedType == newScan.tipo) {
      scans.add(newScan);
      notifyListeners();
    }
  }

  loadScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...?scans];
    notifyListeners();
  }

  loadScanByType(String tipo) async {
    final scans = await DBProvider.db.getScansByType(tipo);
    this.scans = [...?scans];
    selectedType = tipo;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    loadScanByType(selectedType);
  }
}
