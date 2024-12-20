import 'package:denta_koas/src/features/appointment/screen/home/home.dart';
import 'package:denta_koas/src/features/appointment/screen/profile/profile.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    const dark = THelperFunctions.isDarkMode;
    
    return Scaffold(
      bottomNavigationBar: Obx(
        () => Container(
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
            children: controller.screens.asMap().entries.map((entry) {
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
                    color: isActive
                        ? Colors.blue.shade50
                        : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        controller.icons[index],
                        color: isActive
                            ? Colors.blue
                            : Colors.grey,
                        size: 24,
                      ),
                      if (isActive)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            controller.labels[index],
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
        ),
      ),
      body: Obx(() {
        final index = controller.selectedIndex.value;
        return controller.screens[index];
      }),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    Container(color: Colors.red),
    Container(color: Colors.green),
    const ProfileScreen(),
  ];

  final List<IconData> icons = [
    Icons.home,
    Icons.explore_rounded,
    Icons.calendar_month,
    Icons.person,
  ];

  final List<String> labels = [
    'Home',
    'Explore',
    'Bookings',
    'Profile',
  ];
}
