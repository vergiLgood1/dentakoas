
class TValidator {

static String? validateUserInput(
      String? fieldName, String? value, int? maxLength) {
    String? emptyTextValidation = validateEmptyText(fieldName, value);
    if (emptyTextValidation != null) {
      return emptyTextValidation;
    }

    String? lengthValidation = validateLength(value, maxLength!);
    if (lengthValidation != null) {
      return lengthValidation;
    }

    return null;
  }

static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }

    return null;
  }

static String? validateLength(String? value, int maxLength) {
    if (value == null || value.isEmpty) {
      return 'Value is required.';
    }

    if (value.length > maxLength) {
      return 'Value must be no more than $maxLength characters long.';
    }

    return null;
  }

static String? validateEmail(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty || value == '') {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password must contain at least one special character.';
    // }

    return null;
  }

static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required.';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match.';
    }

    return null;
  }

static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon wajib diisi';
    }

    // Bersihkan nomor dari spasi dan karakter khusus
    value = value.replaceAll(RegExp(r'[\s\-()]'), '');

    // Regular expression untuk format nomor Indonesia:
    // - Bisa dimulai dengan +62, 62, atau 0
    // - Diikuti dengan 8
    // - Diikuti dengan 1-9 untuk digit ketiga (kode provider)
    // - Total panjang 10-13 digit setelah kode negara
    final phoneRegExp = RegExp(r'^(?:(?:\+62|62)|0)8[1-9][0-9]{8,10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Format nomor telepon tidak valid. Contoh: 081234567890';
    }

    // Validasi panjang nomor (10-13 digit)
    int length = value.startsWith('0')
        ? value.length
        : value.startsWith('62')
            ? value.length - 2
            : value.length - 3;

    if (length < 10 || length > 13) {
      return 'Nomor telepon harus terdiri dari 10-13 digit';
    }

    return null;
  }

static String? validateRating(double rating) {
    if (rating == 0) {
      return 'Rating is required.';
    }
    return null;
  }
}
