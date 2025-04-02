import 'dart:developer';


class Validation {
  RegExp digitRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  RegExp regex = RegExp("^([0-9]{4}|[0-9]{6})");


  // phone validation
  phoneValidation(phone) {

    if (phone.isEmpty) {
      return "Pleas Enter Phone Number";
    }
    return null;
  }

  // Otp Validation
  otpValidation (value) {
    log("dd : $value");
    if (value!.isEmpty) {
      return ("Enter otp");
    }else
    if (!regex.hasMatch(value)) {
      return ("Enter valid otp");
    }else {
      return null;
    }

  }

  // Email Validation
  emailValidation(email) {
    if (email.isEmpty) {
      return "Please Enter Email";
    } else if (!digitRegex.hasMatch(email)) {
      return "Please Enter Valid";
    }
    return null;
  }

  // name validation
  nameValidation(name) {
    if (name.isEmpty) {
      return "Please Enter Value";
    }

    return null;
  }

}
