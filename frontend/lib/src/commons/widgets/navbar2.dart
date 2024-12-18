import 'package:denta_koas/src/features/authentication/presentasion/signin/signin.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  final List<NavItem> _navItems = [
    NavItem(
        icon: FontAwesomeIcons.house,
        label: 'Home',
        onPressed: () => Get.to(const SigninScreen())),
    NavItem(
        icon: FontAwesomeIcons.calendarDays,
        label: 'Calendar',
        onPressed: () => Get.to(const SigninScreen())),
    NavItem(
        icon: FontAwesomeIcons.message, label: 'Messages', onPressed: () {}),
    NavItem(icon: FontAwesomeIcons.user, label: 'Profile', onPressed: () {}),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _navItems.asMap().entries.map((entry) {
          int idx = entry.key;
          NavItem item = entry.value;
          bool isActive = _selectedIndex == idx;

          return GestureDetector(
            onTap: () => _onItemTapped(idx),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: isActive ? Colors.blue.shade50 : Colors.transparent,
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
              ),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    color: isActive ? Colors.blue : Colors.grey,
                  ),
                  if (isActive)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        item.label,
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
  }
}

class NavItem {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const NavItem({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
}
