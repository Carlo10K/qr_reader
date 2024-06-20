import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;
  const ScanTiles({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, index) => Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction) {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteScanById(scans[index].id!);
              },
              child: ListTile(
                leading: Icon(
                  tipo == 'http' ? Icons.http : Icons.map,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(scans[index].valor),
                subtitle: Text(scans[index].id.toString()),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
                onTap: () => print('abrir algo ...'),
              ),
            ));
  }
}
