import 'package:flutter/material.dart';
import 'package:tugas_akhir/views/auth/onboarding_page.dart';

import 'views/auth/register_page.dart';
import 'views/pages/home_page.dart';
import 'views/pages/profile_page.dart';
import 'views/pages/social_feed_page.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/social_feed': (context) => SocialFeedPage(),
      },
    );
  }
}
