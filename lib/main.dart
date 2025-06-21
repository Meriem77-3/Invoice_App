import 'package:flutter/material.dart';
import 'screens/invoice_screen.dart';

void main() {
  runApp(FactureApp());
}

class FactureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Générateur de Factures',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: InvoiceScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}