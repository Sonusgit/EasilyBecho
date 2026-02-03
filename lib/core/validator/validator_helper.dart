class ValidatorHelper {
  /// Checks if the field is empty
  static String? isEmpty(String? value, {String fieldName = "This field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName cannot be empty";
    }
    return null;
  }

  /// Checks if field is required (more generic)
  static String? isRequired(String? value, {String fieldName = "This field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  /// Checks if email is valid
  static String? validEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email";
    }
    return null;
  }

  /// Checks if password is strong (with special characters, numbers, etc.)
  static String? validPassword(String? value, {int minLength = 8}) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }
    if (value.length < minLength) {
      return "Password must be at least $minLength characters long";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least one uppercase letter";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Password must contain at least one lowercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least one number";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Password must contain at least one special character";
    }
    return null;
  }

  /// Checks if phone number is valid (Indian format - 10 digits)
  static String? validPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    // Remove spaces, hyphens, and country code
    final cleanPhone = value.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');

    // Check for 10 digit Indian phone number
    final phoneRegex = RegExp(r'^[6-9]\d{9}$');
    if (!phoneRegex.hasMatch(cleanPhone)) {
      return "Enter a valid 10-digit phone number";
    }
    return null;
  }

  /// Checks if phone number is valid with country code
  static String? validPhoneWithCountryCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    final cleanPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Matches: +91XXXXXXXXXX or 91XXXXXXXXXX or XXXXXXXXXX
    final phoneRegex = RegExp(r'^(\+?91)?[6-9]\d{9}$');
    if (!phoneRegex.hasMatch(cleanPhone)) {
      return "Enter a valid phone number";
    }
    return null;
  }

  /// Checks if PIN code is valid (Indian PIN code - 6 digits)
  static String? validPincode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "PIN code is required";
    }
    final pinCodeRegex = RegExp(r'^\d{6}$');
    if (!pinCodeRegex.hasMatch(value.trim())) {
      return "Enter a valid 6-digit PIN code";
    }
    return null;
  }

  /// Checks if PIC code is valid (format: ABC12345)
  static String? validPicCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "PIC code is required";
    }
    final picCodeRegex = RegExp(r'^[A-Z]{3}\d{5}$');
    if (!picCodeRegex.hasMatch(value.trim())) {
      return "Enter a valid PIC code (e.g., ABC12345)";
    }
    return null;
  }

  /// Checks if address is valid
  static String? validAddress(String? value, {int minLength = 10}) {
    if (value == null || value.trim().isEmpty) {
      return "Address is required";
    }
    if (value.trim().length < minLength) {
      return "Address must be at least $minLength characters long";
    }
    return null;
  }

  /// Checks if Aadhaar number is valid (12 digits)
  static String? validAadhaar(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Aadhaar number is required";
    }

    // Remove spaces and hyphens
    final cleanAadhaar = value.replaceAll(RegExp(r'[\s\-]'), '');

    // Check for 12 digits
    final aadhaarRegex = RegExp(r'^\d{12}$');
    if (!aadhaarRegex.hasMatch(cleanAadhaar)) {
      return "Enter a valid 12-digit Aadhaar number";
    }

    // Aadhaar cannot start with 0 or 1
    if (cleanAadhaar.startsWith('0') || cleanAadhaar.startsWith('1')) {
      return "Invalid Aadhaar number";
    }

    return null;
  }

  /// Checks if GST number is valid (15 characters)
  static String? validGst(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "GST number is required";
    }

    final cleanGst = value.trim().toUpperCase();

    // GST format: 22AAAAA0000A1Z5
    // 2 digits (state code) + 10 chars (PAN) + 1 digit (entity number)
    // + 1 letter (Z by default) + 1 check digit
    final gstRegex = RegExp(
      r'^\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}$',
    );

    if (!gstRegex.hasMatch(cleanGst)) {
      return "Enter a valid 15-character GST number";
    }

    return null;
  }

  /// Checks if PAN number is valid (10 characters)
  static String? validPan(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "PAN number is required";
    }

    final cleanPan = value.trim().toUpperCase();

    // PAN format: AAAAA9999A
    // 5 letters + 4 digits + 1 letter
    final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

    if (!panRegex.hasMatch(cleanPan)) {
      return "Enter a valid PAN number (e.g., ABCDE1234F)";
    }

    return null;
  }

  /// Checks if name is valid
  static String? validName(String? value, {int minLength = 2}) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    if (value.trim().length < minLength) {
      return "Name must be at least $minLength characters long";
    }
    // Only letters and spaces
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return "Name can only contain letters";
    }
    return null;
  }

  /// Checks if username is valid
  static String? validUsername(String? value, {int minLength = 3}) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    }
    if (value.trim().length < minLength) {
      return "Username must be at least $minLength characters long";
    }
    // Alphanumeric and underscore only
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value.trim())) {
      return "Username can only contain letters, numbers, and underscores";
    }
    return null;
  }

  /// Checks if URL is valid
  static String? validUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "URL is required";
    }
    final urlRegex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );
    if (!urlRegex.hasMatch(value.trim())) {
      return "Enter a valid URL";
    }
    return null;
  }

  /// Checks if number is valid
  static String? validNumber(String? value, {String fieldName = "Number"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    if (double.tryParse(value.trim()) == null) {
      return "Enter a valid number";
    }
    return null;
  }

  /// Checks if number is within range
  static String? isInRange(
    String? value, {
    required double min,
    required double max,
    String fieldName = "Value",
  }) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    final number = double.tryParse(value.trim());
    if (number == null) {
      return "Enter a valid number";
    }
    if (number < min || number > max) {
      return "$fieldName must be between $min and $max";
    }
    return null;
  }

  /// Checks if date is valid
  static String? validDate(String? value, {String format = 'dd/MM/yyyy'}) {
    if (value == null || value.trim().isEmpty) {
      return "Date is required";
    }
    try {
      // Basic date validation for dd/MM/yyyy format
      final parts = value.split('/');
      if (parts.length != 3) return "Enter date in $format format";

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final date = DateTime(year, month, day);
      if (date.day != day || date.month != month || date.year != year) {
        return "Enter a valid date";
      }
      return null;
    } catch (e) {
      return "Enter a valid date";
    }
  }

  /// Checks if age is valid (based on date of birth)
  static String? validAge(
    String? dateOfBirth, {
    required int minAge,
    required int maxAge,
    String format = 'dd/MM/yyyy',
  }) {
    if (dateOfBirth == null || dateOfBirth.trim().isEmpty) {
      return "Date of birth is required";
    }

    try {
      final parts = dateOfBirth.split('/');
      if (parts.length != 3) return "Enter date in $format format";

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final dob = DateTime(year, month, day);
      final today = DateTime.now();
      final age = today.year - dob.year;

      if (age < minAge) {
        return "Age must be at least $minAge years";
      }
      if (age > maxAge) {
        return "Age must not exceed $maxAge years";
      }
      return null;
    } catch (e) {
      return "Enter a valid date of birth";
    }
  }

  /// Confirms if two passwords match
  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.trim().isEmpty) {
      return "Please confirm your password";
    }
    if (password != confirmPassword) {
      return "Passwords do not match";
    }
    return null;
  }

  /// Checks minimum length
  static String? minLength(
    String? value,
    int length, {
    String fieldName = "This field",
  }) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    if (value.trim().length < length) {
      return "$fieldName must be at least $length characters long";
    }
    return null;
  }

  /// Checks maximum length
  static String? maxLength(
    String? value,
    int length, {
    String fieldName = "This field",
  }) {
    if (value == null) return null;
    if (value.trim().length > length) {
      return "$fieldName must not exceed $length characters";
    }
    return null;
  }

  /// Checks if IFSC code is valid
  static String? validIfsc(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "IFSC code is required";
    }

    final cleanIfsc = value.trim().toUpperCase();

    // IFSC format: 4 letters (bank code) + 0 + 6 characters (branch code)
    final ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');

    if (!ifscRegex.hasMatch(cleanIfsc)) {
      return "Enter a valid IFSC code (e.g., SBIN0001234)";
    }

    return null;
  }

  /// Checks if vehicle number is valid (Indian format)
  static String? validVehicleNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Vehicle number is required";
    }

    final cleanNumber = value.replaceAll(RegExp(r'[\s\-]'), '').toUpperCase();

    // Format: MH12AB1234 (2 letters + 2 digits + 1-2 letters + 1-4 digits)
    final vehicleRegex = RegExp(r'^[A-Z]{2}\d{2}[A-Z]{1,2}\d{1,4}$');

    if (!vehicleRegex.hasMatch(cleanNumber)) {
      return "Enter a valid vehicle number (e.g., MH12AB1234)";
    }

    return null;
  }

  /// Custom validator with regex pattern
  static String? customPattern(
    String? value,
    RegExp pattern, {
    required String errorMessage,
    String fieldName = "This field",
  }) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    if (!pattern.hasMatch(value.trim())) {
      return errorMessage;
    }
    return null;
  }

  /// Combine multiple validators
  static String? combine(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (var validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  }
}
