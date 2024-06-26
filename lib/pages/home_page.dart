import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_sqlite/pages/adresses_page.dart';
import 'package:qr_scanner_sqlite/pages/maps_page.dart';
import 'package:qr_scanner_sqlite/providers/scan_list_provider.dart';
import 'package:qr_scanner_sqlite/providers/ui_provider.dart';
import 'package:qr_scanner_sqlite/widgets/custom_navigator_bar.dart';
import 'package:qr_scanner_sqlite/widgets/scan_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Historial'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteAll();
              },
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              ))
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    //get ScanlistProvider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScanByType('geo');
        return const MapsPage();
      case 1:
        scanListProvider.loadScanByType('http');
        return const AddressesWidget();
      default:
        return const MapsPage();
    }
  }
}
