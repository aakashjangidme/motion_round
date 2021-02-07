import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BasicUtils {
  BasicUtils._();

  /// shows Android Toast Message
  static void toast(String message) => Fluttertoast.showToast(
      msg: message,
      backgroundColor: Color(0xffFAFAFA),
      textColor: Color(0xff000000),
      gravity: ToastGravity.BOTTOM,
      fontSize: 13);

  /// Returns the age in numaric
  static String calculateAge(DateTime birthDate) {
    var currentDate = DateTime.now();
    var age = currentDate.year - birthDate.year;
    var month1 = currentDate.month;
    var month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      var day1 = currentDate.day;
      var day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }
}
