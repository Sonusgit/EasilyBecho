import 'package:flutter/material.dart';

class Components {
  static Widget buildTextformField({
     required String label,
     required TextEditingController controller,
  }) {
    return TextFormField(
       controller: controller,
       decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder()
       ),
    );
  }
}
