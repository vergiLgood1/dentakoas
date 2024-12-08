import 'package:tugas_akhir/env.dart';

class ApiEndpoints {
  // Base URL
  static const String baseUrl = Env.baseUrl;

  // Authentication Endpoints
  static const String login = '$baseUrl/auth/signin/credentials';
  static const String loginGoogle = '$baseUrl/auth/signin/google';
  static const String loginFacebook = '$baseUrl/auth/signin/facebook';
  static const String loginApple = '$baseUrl/auth/signin/apple';
  static const String loginGithub = '$baseUrl/auth/signin/github';

  static const String register = '$baseUrl/auth/signup';

  static const String session = '$baseUrl/auth/session';
  static const String csrf = '$baseUrl/auth/csrf';

  static const String logout = '$baseUrl/auth/signout';

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
