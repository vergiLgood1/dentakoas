import 'package:tugas_akhir/env.dart';

class ApiUrls {
  // Base URL
  static const String baseUrl = Env.baseUrl;
  static const String baseAuthUrl = '$baseUrl/auth';
  static const String baseAuthSignin = '$baseAuthUrl/signin';

  // Authentication Endpoints
  static const String signinCredentials = '$baseAuthSignin/credentials';
  static const String signinGoogle = '$baseAuthSignin/google';
  static const String signinFacebook = '$baseAuthSignin/facebook';
  static const String signinApple = '$baseAuthSignin/apple';
  static const String signinGithub = '$baseAuthSignin/github';

  static const String signup = '$baseAuthUrl/signup';

  static const String session = '$baseAuthUrl/session';
  static const String csrf = '$baseAuthUrl/csrf';

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
