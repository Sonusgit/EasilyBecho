import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final String? hint;
  final String? label;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CommonDropdown({
    super.key,
    required this.items,
    this.value,
    this.hint,
    this.label,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value ,

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),

      borderRadius: BorderRadius.circular(12),

      dropdownColor:
          Get.isDarkMode ? Colors.black : Colors.white,

      elevation: 2,

      iconEnabledColor: Colors.blue,
      iconDisabledColor: Colors.grey,
      iconSize: 24,

      validator: validator,

      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(fontFamily: 'Roboto'),
          ),
        );
      }).toList(),

      onChanged: onChanged,
    );
  }
}
