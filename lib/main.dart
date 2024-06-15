import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_sqlite/pages/home_page.dart';
import 'package:qr_scanner_sqlite/pages/map_page.dart';
import 'package:qr_scanner_sqlite/providers/ui_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qr Reader',
        initialRoute: '/home',
        routes: {
          '/home': (_) => const HomeScreen(),
          '/maps': (_) => const MapScreen()
        },
        theme: ThemeData(
            primaryColor: Colors.deepPurple,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepPurple)),
      ),
    );
  }
}
