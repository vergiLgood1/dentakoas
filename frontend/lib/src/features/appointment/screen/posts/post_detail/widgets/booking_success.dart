import 'package:denta_koas/navigation_menu.dart';
import 'package:denta_koas/src/commons/widgets/success_screen/success_screen.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SuccessScreen(
        image: TImages.successfulPaymentIcon,
        title: 'Booking successful',
        subtitle: 'Your booking has been successfully created',
        onPressed: () => Get.off(() => const NavigationMenu()),
        child: SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Get.off(() => const NavigationMenu()),
            child: const Text('View appointment'),
          ),
        ),
      ),
    );
  }
}
