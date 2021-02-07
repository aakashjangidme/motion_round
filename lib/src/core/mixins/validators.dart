/// Class of validation functions that the app will use
class Validators {
  final phoneNumberRegExp = RegExp(
      r'^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$');
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final zipCodeRegExp = RegExp(r'^[0-9]{5}(?:-[0-9]{4})?$');

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'This field can not be empty.';
    }
    if (!emailRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  String emptyValidaton(String value) {
    if (value.isEmpty) {
      return 'This field can not be empty.';
    }

    return null;
  }

  String validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'This field can not be empty.';
    }
    if (!phoneNumberRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid phone number.';
    }
    return null;
  }

  String validateZip(String value) {
    if (!zipCodeRegExp.hasMatch(value.trim())) {
      return 'invalid-zip';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'Password can not be empty.';
    } else if (value.length <= 6) {
      return 'The password is too short.';
    }
    return null;
  }
}
