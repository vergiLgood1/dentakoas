import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final IconData prefixIcon;
  final String? disabledItem;

  const DDropdownMenu({
    super.key,
    required this.items,
    this.hintText = 'Select Category...',
    this.prefixIcon = Icons.medical_services,
    this.disabledItem,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      suffixProps: const DropdownSuffixProps(
        dropdownButtonProps: DropdownButtonProps(
          iconClosed: Icon(CupertinoIcons.chevron_down),
          iconOpened: Icon(CupertinoIcons.chevron_up),
        ),
      ),
      decoratorProps: DropDownDecoratorProps(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: TColors.textPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      items: (f, cs) => items,
      popupProps: PopupProps.menu(
        disabledItemFn: (item) => item == disabledItem,
        fit: FlexFit.loose,
        menuProps: MenuProps(
          backgroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
