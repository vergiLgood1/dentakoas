import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownCategory extends StatelessWidget {
  const DropdownCategory({
    super.key,
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
          prefixIcon: const Icon(Icons.medical_services),
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
          hintText: 'Select Category...',
          hintStyle: const TextStyle(
            color: TColors.textPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      items: (f, cs) => [
        "Item 1",
        'Item 2',
        'Item 3',
        'Item 4',
        'Item 5',
        'Item 6',
        'Item 7',
        'Item 8',
      ],
      popupProps: PopupProps.menu(
        disabledItemFn: (item) => item == 'Item 3',
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
