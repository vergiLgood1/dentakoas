import 'package:denta_koas/app.dart';
import 'package:denta_koas/firebase_options.dart';
import 'package:denta_koas/src/cores/data/repositories/authentication.repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Ensure that the Flutter binding is initialized before calling any Flutter
  final WidgetsBinding widgetBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // -- GetX Local Storage
  await GetStorage.init();

  // -- Await splash until other item load
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  // Initialize the authentication repository with Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  // Initialize Supabase Storage
  // await Supabase.initialize(
  //   url: 'https://qeavskuijpqoroxggpzz.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFlYXZza3VpanBxb3JveGdncHp6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYxMzAyNTIsImV4cCI6MjA1MTcwNjI1Mn0.FuMBVuGNfcfAA77IE0vbJyFuOWVMx6e3JXC3mXDQoV8',
  // );

  runApp(const App());
}
