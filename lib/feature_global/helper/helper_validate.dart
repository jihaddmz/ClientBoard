class HelperValidate {

  static bool validateEmail(String value) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static bool validatePassword(String value) {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#\$%^&*\(\)_\+\-=~`{}\[\]:;"\<>,.?/]).{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}
