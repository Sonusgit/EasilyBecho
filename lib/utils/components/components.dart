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

  static Widget buildElevatedButton({
    required String label,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: isLoading ? CircularProgressIndicator() : Text(label),
    );
  }
}
