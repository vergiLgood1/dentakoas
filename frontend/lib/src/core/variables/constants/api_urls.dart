import 'package:tugas_akhir/env.dart';

class ApiUrls {
  // Base URL
  static const String baseUrl = Env.baseUrl;
  static const String baseAuthUrl = '$baseUrl/auth';
  static const String baseAuthSignin = '$baseAuthUrl/signin';

  // Authentication Endpoints
  static const String login = '$baseAuthSignin/credentials';
  static const String loginGoogle = '$baseAuthSignin/google';
  static const String loginFacebook = '$baseAuthSignin/facebook';
  static const String loginApple = '$baseAuthSignin/apple';
  static const String loginGithub = '$baseAuthSignin/github';

  static const String register = '$baseAuthUrl/signup';

  static const String session = '$baseAuthUrl/session';
  static const String token = '$baseAuthUrl/csrf';

  static const String logout = '$baseAuthUrl/signout';

  // User Endpoints
  static const String users = '$baseUrl/users';
  static const String user = '$baseUrl/users/:id';
  static const String userProfile = '$baseUrl/users/:id/profile';

  // Post Endpoints
  static const String posts = '$baseUrl/posts';
  static const String post = '$baseUrl/posts/:id';
  static const String likes = '$baseUrl/posts/:id/likes';

  // Schedule Endpoints
  static const String schedules = '$baseUrl/schedules';
  static const String schedule = '$baseUrl/schedules/:id';
  static const String scheduleAvailability =
      '$baseUrl/schedules/:id/availability';

  // Timeslot Endpoints
  static const String timeslots = '$baseUrl/timeslots';
  static const String timeslot = '$baseUrl/timeslots/:id';

  // Appointment Endpoints
  static const String appointments = '$baseUrl/appointments';
  static const String appointment = '$baseUrl/appointments/:id';
}
