import 'package:easilybecho/utility/const/app_colors.dart';
import 'package:flutter/material.dart';

class Components {
  static Widget buildTextformField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    Widget? suffix,
    Widget? prefix,
    Widget? prefixIcon,
    String? hintText,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Text(label, style: TextStyle(fontSize: 16.0)),
            TextFormField(
              validator: validator,
              controller: controller,
              decoration: InputDecoration(
                suffix: suffix,
                prefix: prefix,
                prefixIcon: prefixIcon,

                hintText: hintText ?? label,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: AppColors.borderColor,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildButton({
    required String label,
    required VoidCallback onPressed,
    bool isLoading = false,
    // double? width = double.infinity,
    // double? height = 20.0,
    Color? color,
    IconData? icon,
    Color? iconColor,
    // Color? textColor = Colors.white,
    double? iconSize = 25.0,
    // TextStyle? textStyle
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        // width: width,
        // height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            // foregroundColor: textColor,
          ),

          onPressed: onPressed,
          child: isLoading
              ? CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    if (icon != null) Icon(icon, color: iconColor),

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        label,
                        style: TextStyle(
                          // fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          // color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  static Widget buildElevatedButton({
    required String label,
    IconData? icon,
    Color ? color,
    Color ? textColor,
    required void Function()? onPressed,
    bool isLoading = false,
  }) {
    return ElevatedButton(
      style:ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
      ) ,
      onPressed: onPressed, child:  isLoading ? CircularProgressIndicator(): Wrap(
                
                  children: [
                    if (icon != null) Icon(icon,),

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        label,
                        style: TextStyle(
                          // fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          // color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),);
  }

  static Widget buildCard({
   Widget? child,
    double? height,
    double? width,
    Color? color,

    void Function()? onTap,
  }) {
    return Card(
      // color: color ?? Colors.white,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.blue.withOpacity(0.2), // Optional: ripple color
        borderRadius: BorderRadius.circular(8.0), // Match Card's shape
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0), // Match Card's shape
          ),
          height: height,
          width: width,
          padding: const EdgeInsets.all(12.0),
          child: child,
        ),
      ),
    );
  }

  static Widget buildOverviewCards({
    String? title,
    IconData? icon,
    Color? color,
    VoidCallback? onTap,
    String? value,
    double? height,
    double? width,
  }) {
    return Card.outlined(
      // color: Colors.red,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.blue.withOpacity(0.2), // Optional: ripple color
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          decoration: BoxDecoration(
            // color: color,
            borderRadius: BorderRadius.circular(8.0), // Match Card's shape
          ),
          height: height ?? 100.0,
          width: width ?? 200.0,
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              Positioned(
                child: Text(
                  "$title",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                right: 0,
                top: 30,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
              ),

              Positioned(
                // right: 0,
                top: 60,
                child: Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    // color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
