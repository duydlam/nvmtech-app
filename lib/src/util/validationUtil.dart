import 'package:nvmtech/src/constants/validationUtil_constant.dart';

class Validation {
  static String _emailvalid =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String validateName(String name) {
    if (name == null) {
      return CONST_VALIDATION_NAME_IS_NULL;
    }

    if (name.isEmpty) {
      return CONST_VALIDATION_IS_EMPTY;
    }

    if (name.length < 30) {
      return CONST_VALIDATION_NAME_MIN_LENGTH;
    }

    return '';
  }

  static String 
  validateEmail(String email) {
    if (email == null) {
      return CONST_VALIDATION_EMAIL_IS_NULL;
    }

    if (email.isEmpty) {
      return CONST_VALIDATION_IS_EMPTY;
    }

    final bool emailValid = RegExp(_emailvalid).hasMatch(email);

    if (!emailValid) {
      return CONST_VALIDATION_EMAIL_IS_INVALID;
    }

    return '';
  }

  static String validatePassword(String password) {
    if (password == null) {
      return CONST_VALIDATION_PASS_IS_NULL;
    }

    if (password.isEmpty) {
      return CONST_VALIDATION_IS_EMPTY;
    }

    if (password.length < 7) {
      return CONST_VALIDATION_PASS_MIN_LENGTH;
    }

    return '';
  }
}
