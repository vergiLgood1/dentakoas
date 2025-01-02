class Endpoints {
  // Base URL
  static const String baseUrl = 'http://192.168.1.5:3000/api';

  static const String baseAuthUrl = '$baseUrl/auth';
  static const String baseAuthSignin = '$baseAuthUrl/signin';

  // Authentication Endpoints
  static const String signinWithCredentials = '$baseAuthSignin/credentials';
  static const String signinWithGoogle = '$baseAuthSignin/google';
  static const String signinWithFacebook = '$baseAuthSignin/facebook';
  static const String signinWithApple = '$baseAuthSignin/apple';
  static const String signinWithGithub = '$baseAuthSignin/github';

  static const String signup = '$baseAuthUrl/signup';
  static const String sendVerificationEmail =
      '$baseAuthUrl/send-verification-email';
  static const String createNewVerificationToken =
      '$baseAuthUrl/new-verification';
  static const String verifyEmail = '$baseAuthUrl/email-verify';
  static const String resetPassword = '$baseAuthUrl/reset-password';
  static const String compareOtpResetPassword = '$baseAuthUrl/verification-otp';

  static const String session = '$baseAuthUrl/session';
  static const String csrf = '$baseAuthUrl/csrf';

  static const String signout = '$baseAuthUrl/signout';

  // User Endpoints
  static const String users = '$baseUrl/users';
  static const String user = '$baseUrl/users/';
  static const String userProfile = '$baseUrl/users/:id/profile';

  // Post Endpoints
  static const String posts = '$baseUrl/posts/';
  static const String post = '$baseUrl/posts/:id';
  static const String likes = '$baseUrl/posts/:id/likes';

  // Schedule Endpoints
  static const String schedules = '$baseUrl/schedules/';
  static const String schedule = '$baseUrl/schedules/:id';
  static const String scheduleAvailability =
      '$baseUrl/schedules/:id/availability';

  // Timeslot Endpoints
  static const String timeslots = '$baseUrl/timeslots/';
  static const String timeslot = '$baseUrl/timeslots/:id';

  // Appointment Endpoints
  static const String appointments = '$baseUrl/appointments/';
  static const String appointment = '$baseUrl/appointments/:id';
}
