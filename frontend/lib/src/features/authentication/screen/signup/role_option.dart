import 'package:denta_koas/src/features/authentication/controller/signup/role_controller.dart';
import 'package:denta_koas/src/features/authentication/screen/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseRolePage extends StatelessWidget {
  const ChooseRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RoleController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0, // Menghilangkan AppBar default
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              "How do you want to use the app?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Obx(() => RoleOption(
                  icon: Icons.health_and_safety,
                  title: "Fasilitator",
                  subtitle:
                      "Manage your koas and keep track of their progress.",
                  isSelected: controller.selectedIndexRole.value == 0,
                  onTap: () => controller.selectRole(0),
                )),
            const SizedBox(height: 16),
            Obx(() => RoleOption(
                  icon: Icons.school,
                  title: "Koas",
                  subtitle: "Make your post and meet with your pasien.",
                  isSelected: controller.selectedIndexRole.value == 1,
                  onTap: () => controller.selectRole(1),
                )),
            const SizedBox(height: 16),
            Obx(() => RoleOption(
                  icon: Icons.person,
                  title: "Pasien",
                  subtitle: "Find your koas and make an appointment with them.",
                  isSelected: controller.selectedIndexRole.value == 2,
                  onTap: () => controller.selectRole(2),
                )),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  
                  // Set the selected role to the storage
                  controller.setSelectedRole();

                  // Navigasi ke halaman berikutnya
                  Get.to(() => const SignupScreen());
                  
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class RoleOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleOption({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 36,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
