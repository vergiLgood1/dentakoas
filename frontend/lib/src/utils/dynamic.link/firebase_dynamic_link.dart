import 'package:denta_koas/src/features/authentication/screen/password_configurations/verification_email_reset_password.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

class DynamicLinkProvider {
  Future<String> createLink(String refCode) async {
    String url = 'https://com.example.denta_koas?ref=$refCode';

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse(url),
      uriPrefix: "https://dentakoas.page.link",
      androidParameters:
          const AndroidParameters(packageName: 'com.example.denta_koas'),
      iosParameters: const IOSParameters(bundleId: 'com.example.denta_koas'),
    );

    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;

    final refLink = await link.buildShortLink(parameters);

    return refLink.shortUrl.toString();
  }

  void initDynamicLinks() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if (instanceLink != null) {
      final Uri refLink = instanceLink.link;

      String email = refLink.queryParameters['email'] ?? '';

      if (email.isNotEmpty) {
        // Panggil halaman reset password dan berikan email yang diambil dari Dynamic Link

        // Get.to(() => EmailResetPasswordScreen(email: email, isFromDynamicLink: true, obbCode: obbCode));
      }
    }
  }
}
