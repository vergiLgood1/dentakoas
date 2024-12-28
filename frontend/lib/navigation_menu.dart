import 'package:denta_koas/src/features/appointment/screen/explore/explore.dart';
import 'package:denta_koas/src/features/appointment/screen/home/home.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/create_post.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/schedule.dart';
import 'package:denta_koas/src/features/personalization/screen/setting/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () {
          // final index = controller.selectedIndex.value;
          // // Sembunyikan bottom navigation bar pada CreatePostScreen
          // if (controller.displayedScreens[index] is CreatePostScreen) {
          //   return const SizedBox
          //       .shrink(); // Tidak menampilkan bottomNavigationBar
          // }
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(0.3 * 255 ~/ 100),
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  controller.displayedScreens.asMap().entries.map((entry) {
                final index = entry.key;
                final isActive = controller.selectedIndex.value == index;

                return GestureDetector(
                  onTap: () {
                    controller.selectedIndex.value = index;
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.blue.shade50 : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          controller.displayedIcons[index],
                          color: isActive ? Colors.blue : Colors.grey,
                          size: 24,
                        ),
                        if (isActive)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              controller.displayedLabels[index],
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
      body: Obx(() {
        final index = controller.selectedIndex.value;
        return controller.displayedScreens[index];
      }),
    );
  }
}



class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const ScheduleScreen(),
    const SettingsScreen(),
    const CreatePostScreen()
  ];

  final List<IconData> icons = [
    Icons.home,
    Icons.explore_rounded,
    Icons.calendar_month,
    Icons.person,
    Iconsax.add_square,
  ];

  final List<String> labels = [
    'Home',
    'Explore',
    'Bookings',
    'Profile',
    '',
  ];

  // Layar, ikon, dan label yang ditampilkan
  final RxList<Widget> displayedScreens = <Widget>[].obs;
  final RxList<IconData> displayedIcons = <IconData>[].obs;
  final RxList<String> displayedLabels = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeUserSession();
  }

  void initializeUserSession() {
    // Data sesi pengguna manual
    final userSession = {
      'id': 1,
      'name': 'John Doe',
      'role': 'koas', // Ubah menjadi 'user' untuk pengujian role lainnya
    };

    // Tentukan apakah user adalah "koas"
    final isKoas = userSession['role'] == 'koas';

    // Tampilkan menu dasar (4 menu pertama)
    displayedScreens.addAll(screens.sublist(0, 4));
    displayedIcons.addAll(icons.sublist(0, 4));
    displayedLabels.addAll(labels.sublist(0, 4));

    // Sisipkan menu "Koas" di indeks 2 jika peran adalah "koas"
    if (isKoas) {
      displayedScreens.insert(2, screens[4]); // Menambahkan "Koas Screen"
      displayedIcons.insert(2, icons[4]); // Menambahkan ikon "Koas"
      displayedLabels.insert(2, labels[4]); // Menambahkan label "Koas"
    }
  }

}
