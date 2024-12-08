import 'package:flutter/material.dart';
import 'package:tugas_akhir/src/routing/generator.dart';
import 'package:tugas_akhir/src/routing/routes.dart';

void main() {
  runApp(const DentaKoas());
}

class DentaKoas extends StatelessWidget {
  const DentaKoas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koas App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
