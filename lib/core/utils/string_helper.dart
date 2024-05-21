class StringUtils {
  static String validateString(String text) {
    return text.trim().replaceAll(RegExp(r'\s+'), ' ');
  }
}
