import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PostTimeslotController extends GetxController {
  static PostTimeslotController get instance =>
      Get.find<PostTimeslotController>();

  var tooltipShown = false;

  var requiredParticipants = 0.obs;

  // Observables
  var sessionDuration = const Duration(hours: 1).obs;
  var timeSlots = <String, List<String>>{
    'Pagi': [],
    'Siang': [],
    'Malam': [],
  }.obs;

  var maxParticipants = <String, Map<String, int>>{
    'Pagi': {},
    'Siang': {},
    'Malam': {},
  }.obs;

  void setRequiredParticipants(int requiredParticipant) {
    requiredParticipants.value = requiredParticipant;
  }

// Tambahkan timeslot baru
  void addTimeSlot(String section, TimeOfDay startTime) {
    Logger()
        .d('Adding timeslot to section: $section at start time: $startTime');

    if (!timeSlots.containsKey(section)) {
      Logger().e('Section $section not found');
      return;
    }

    final DateTime now = DateTime.now();
    final DateTime startDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      startTime.hour,
      startTime.minute,
    );
    final DateTime endDateTime = startDateTime.add(sessionDuration.value);

    final String timeSlot =
        "${startDateTime.hour.toString().padLeft(2, '0')}:${startDateTime.minute.toString().padLeft(2, '0')} - "
        "${endDateTime.hour.toString().padLeft(2, '0')}:${endDateTime.minute.toString().padLeft(2, '0')}";

    Logger().d('Generated timeslot: $timeSlot');

    // Validasi untuk menghindari duplikasi timeslot
    for (var slot in timeSlots[section]!) {
      final existingStartTime = _parseTime(slot.split(' - ')[0]);
      final existingEndTime = _parseTime(slot.split(' - ')[1]);

      if ((startTime.hour == existingStartTime.hour &&
              startTime.minute == existingStartTime.minute) ||
          (startTime.hour >= existingStartTime.hour &&
              startTime.hour < existingEndTime.hour) ||
          (endDateTime.hour > existingStartTime.hour &&
              endDateTime.hour <= existingEndTime.hour)) {
        TLoaders.warningSnackBar(
            title: 'Warning',
            message:
                'Timeslot $timeSlot overlaps with existing timeslot $slot');
        Logger().e(
            'Timeslot $timeSlot overlaps with existing timeslot $slot in section $section');
        return;
      }
    }

    // Menambahkan timeslot baru
    timeSlots[section]?.add(timeSlot);
    maxParticipants[section] ??= {};

    // Cek apakah semua section kosong atau tidak
    bool allSectionsEmpty =
        maxParticipants.values.every((slots) => slots.isEmpty);
    maxParticipants[section]![timeSlot] = 1;

    Logger().d('All sections empty: $allSectionsEmpty');
    Logger().d(
        'Max participants for new timeslot: ${maxParticipants[section]![timeSlot]}');

    // Mengurangi peserta dari slot sebelumnya dengan maxParticipants tertinggi di section yang sama
    if (timeSlots[section]?.isNotEmpty ?? false) {
      // Menemukan timeslot dengan maxParticipants tertinggi
      final sortedSlots = maxParticipants[section]!.entries.toList()
        ..sort((a, b) => b.value
            .compareTo(a.value)); // Mengurutkan berdasarkan maxParticipants
      final previousSlot =
          sortedSlots.isNotEmpty ? sortedSlots.first.key : null;

      if (previousSlot != null && previousSlot != timeSlot) {
        Logger().d(
            'Decrementing max participants for previous slot: $previousSlot');
        decrementMaxParticipantsForSlot(section,
            previousSlot); // Mengurangi peserta dari timeslot dengan maxParticipants tertinggi
      }
    }

    timeSlots.refresh(); // Update UI
    update(); // Update UI
  }

// Ubah durasi sesi
  void updateSessionDuration(int hours) {
    sessionDuration.value = Duration(hours: hours);
    _updateAllTimeSlots(); // Perbarui semua slot waktu
  }

// Perbarui semua slot waktu berdasarkan durasi terbaru
  void _updateAllTimeSlots() {
    final updatedSlots = <String, List<String>>{};

    timeSlots.forEach((section, slots) {
      final updatedSectionSlots = <String>[];

      for (var slot in slots) {
        final startTime = _parseTime(slot.split(' - ')[0]);
        final startDateTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          startTime.hour,
          startTime.minute,
        );
        final endDateTime = startDateTime.add(sessionDuration.value);

        final updatedSlot =
            "${startDateTime.hour.toString().padLeft(2, '0')}:${startDateTime.minute.toString().padLeft(2, '0')} - "
            "${endDateTime.hour.toString().padLeft(2, '0')}:${endDateTime.minute.toString().padLeft(2, '0')}";
        updatedSectionSlots.add(updatedSlot);
      }

      updatedSlots[section] = updatedSectionSlots;
    });

    timeSlots.value = updatedSlots;
    timeSlots.refresh(); // Update UI
    update(); // Update UI
  }

  // Update jumlah peserta maksimal untuk sesi tertentu
  // void setMaxParticipants(String section, int max) {
  //   if(timeSlots[section] != null) {
  //   maxParticipants[section] = max;
  //   maxParticipants.refresh(); // Update UI
  //   update(); // Update UI
  //   }
  // }

// Helper untuk parsing waktu dari string
  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

// Hapus timeslot
  void removeTimeSlot(String section, String slot) {
    timeSlots[section]?.remove(slot);
    maxParticipants[section]?.remove(slot);
    timeSlots.refresh(); // Update UI
    maxParticipants.refresh(); // Update UI
    update(); // Update UI
  }

// Get total jumlah peserta maksimal dari semua section
  int get totalMaxParticipants {
    int total = 0;
    maxParticipants.forEach((section, slots) {
      slots.forEach((slot, max) {
        total += max;
      });
    });
    return total;
  }

// Get total jumlah timeslot yang tersedia dari semua section
  int get totalAvailableTimeSlots {
    int total = 0;
    maxParticipants.forEach((section, slots) {
      total += slots.length;
    });
    return total;
  }

// Increment jumlah peserta maksimal untuk slot waktu tertentu
  void incrementMaxParticipantsForSlot(String section, String slot) {
    if (timeSlots[section] != null) {
      maxParticipants[section] ??= {};
      maxParticipants[section]![slot] =
          (maxParticipants[section]![slot] ?? 1) + 1;
      maxParticipants.refresh(); // Update UI
      update(); // Update UI
    }
  }

// Decrement jumlah peserta maksimal untuk slot waktu tertentu
  void decrementMaxParticipantsForSlot(String section, String slot) {
    if (timeSlots[section] != null) {
      maxParticipants[section] ??= {};
      final currentMax = maxParticipants[section]![slot] ?? 1;
      if (currentMax > 1) {
        maxParticipants[section]![slot] = currentMax - 1;
        maxParticipants.refresh(); // Update UI
        update(); // Update UI
      }
    }
  }

// Get jumlah peserta maksimal untuk slot waktu tertentu
  int maxParticipantsForSlot(String section, String slot) {
    return maxParticipants[section]?[slot] ?? 1; // Default value is 1
  }

  Map<String, int> calculateSectionLengths() {
    final sectionLengths = <String, int>{};

    // Hitung jumlah slot per section
    timeSlots.forEach((section, slots) {
      sectionLengths[section] = slots.length;
    });

    return sectionLengths;
  }

  int calculateTotalSlots() {
    int totalSlots = 0;

    // Hitung total semua slot
    timeSlots.forEach((_, slots) {
      totalSlots += slots.length;
    });

    return totalSlots;
  }

  final selectedTimeStamp = (-1).obs;

  void updateSelectedTimeStamp(int index) {
    selectedTimeStamp.value = index;
  }
}
