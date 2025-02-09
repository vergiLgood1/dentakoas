import 'package:cloudinary/cloudinary.dart';
import 'package:denta_koas/app.dart';
import 'package:denta_koas/firebase_options.dart';
import 'package:denta_koas/src/cores/data/repositories/authentication.repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
  // final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  // final supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';

  // await Supabase.initialize(
  //   url: supabaseUrl,
  //   anonKey: supabaseKey,
  // );
  

  runApp(const App());
}
