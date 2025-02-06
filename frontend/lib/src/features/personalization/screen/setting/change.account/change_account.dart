import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/features/appointment/controller/appointment.controller/appointments_controller.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class ChangeAccountScreen extends StatelessWidget {
  const ChangeAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppointmentsController.instance;
    return const Scaffold(
      appBar: DAppBar(
        title: Text('Privacy Account'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(0),
          child: StateScreen(
            image: TImages.comingSoon2,
            title: 'This feature is under development',
            subtitle:
                "We're working on it, please check back later and will be available soon",
            isLottie: true,
          )),
    );
  }
}
