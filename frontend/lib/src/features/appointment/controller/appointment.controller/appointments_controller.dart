import 'package:denta_koas/navigation_menu.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/cores/data/repositories/appointments.repository/appointments_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/user.repository/user_repository.dart';
import 'package:denta_koas/src/features/appointment/data/model/appointments_model.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/helpers/network_manager.dart';
import 'package:denta_koas/src/utils/popups/full_screen_loader.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AppointmentsController extends GetxController {
  static AppointmentsController get instance => Get.find();

  RxList<AppointmentsModel> appointments = <AppointmentsModel>[].obs;
  RxList<AppointmentsModel> appointmentsByUser = <AppointmentsModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchAppointments();
    super.onInit();
  }

  fetchAppointments() async {
    try {
      isLoading(true);
      final appointmentsData =
          await AppointmentsRepository.instance.getAppointments();
      appointments.assignAll(appointmentsData);

      final appointmentsByUserData =
          await AppointmentsRepository.instance.getAppointmentByUser();
    } catch (e) {
      Logger().e(['Failed to fetch appointments: $e']);
    } finally {
      isLoading(false);
    }
  }

  createAppointment(
    String koasId,
    String scheduleId,
    String timeslotId,
    String date,
  ) async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'Processing your action....', TImages.loadingHealth);

      // Check connection
      final isConected = await NetworkManager.instance.isConnected();
      if (!isConected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final pasienDetail = await UserRepository.instance.getUserDetailById();
      final pasienId = pasienDetail.pasienProfile!.id;

      // Initiate the request
      final newAppointment = AppointmentsModel(
        pasienId: pasienId!,
        koasId: koasId,
        scheduleId: scheduleId,
        timeslotId: timeslotId,
        date: date,
      );

      // Save the appointment
      final appointmentRepository = Get.put(AppointmentsRepository());
      await appointmentRepository.createAppointment(newAppointment);

      // Stop loading
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(title: 'Appointment created successfully');

      // Fetch appointments
      // fetchAppointments();

      // Close the dialog
      Get.offAll(
        () => StateScreen(
          key: UniqueKey(),
          image: TImages.successCreatePost,
          title: 'Your appointment has been created successfully!',
          subtitle:
              'You can view your appointment in the schedule menu. Thank you!',
          showButton: true,
          primaryButtonTitle: 'Go to Dashboard',
          onPressed: () => Get.off(() => const NavigationMenu()),
        ),
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      Logger().e(['Failed to create appointment: $e']);
      TLoaders.errorSnackBar(
          title: 'Failed to create appointment',
          message: 'Something went wrong. Please try again later.');
    }
  }
}
