class InputValidators {

  static bool nameValid(String name) {
    return name.trim().length >= 2;
  }

  static bool emailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool hasMinLength(String password) {
    return password.length >= 8;
  }

  static bool hasNumber(String password) {
    return RegExp(r'[0-9]').hasMatch(password);
  }

  static bool hasSpecialChar(String password) {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  static bool hasUppercase(String password) {
    return RegExp(r'[A-Z]').hasMatch(password);
  }

  static bool passwordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  static bool hasLowercase(String password) {
    return RegExp(r'[a-z]').hasMatch(password);
  }

  static bool passwordValid(String password) {
    return hasMinLength(password) &&
          hasNumber(password) &&
          hasSpecialChar(password) &&
          hasUppercase(password) &&
          hasLowercase(password);
  }
}