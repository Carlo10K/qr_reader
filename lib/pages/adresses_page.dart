import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class AddressesWidget extends StatelessWidget {
  const AddressesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, index) => ListTile(
              leading: Icon(
                Icons.http,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scans[index].valor),
              subtitle: Text(scans[index].id.toString()),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: () => print('abrir algo ...'),
            ));
  }
}
