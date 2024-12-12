import 'package:flutter/material.dart';
import 'package:tugas_akhir/service_locator.dart';
import 'package:tugas_akhir/src/core/routing/generator.dart';
import 'package:tugas_akhir/src/core/routing/routes.dart';


void main() {
  setupServiceLocator();
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
      initialRoute: AppRoutes.signin,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
