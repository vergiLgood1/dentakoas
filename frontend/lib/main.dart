import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugas_akhir/src/features/authentication/application/auth_bloc.dart';
import 'package:tugas_akhir/src/features/authentication/application/auth_state.dart';
import 'package:tugas_akhir/src/core/routing/generator.dart';
import 'package:tugas_akhir/src/core/routing/routes.dart';
import 'package:tugas_akhir/src/features/authentication/domain/auth_provider.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      ...authProviders,
    ],
    child: const DentaKoas(),
  ));
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
      initialRoute: AppRoutes.login,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSessionFetched) {
            return Center(
              child: Text('Session: ${state.sessionData}'),
            );
          } else if (state is AuthError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else {
            return const Center(child: Text('Welcome Home!'));
          }
        },
      ),
    );
  }
}
