class BValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Fill the above field.';
    }
    return null;
  }
}
