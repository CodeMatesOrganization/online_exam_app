
String? nulltyChecker(String? val) {
  if (val == null || val.isEmpty) {
    return 'this field is required';
  }
  return null;
}
String? emailValidator(String? val) {
  RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (val == null || val.trim().isEmpty) {
    return 'this field is required';
  }
  if (emailRegex.hasMatch(val) == false) {
    return 'enter valid email';
  }
  return null;
}

String? passwordValidator(String? val) {
  RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');
  if (val == null || val.isEmpty) {
    return 'this field is required';
  }
  if (val.length < 8 || !passwordRegex.hasMatch(val)) {
    return 'strong password please';
  }
  return null;
}
String? confirmPasswordValidator(String? val , String password) {
  if (val == null || val.isEmpty) {
    return "Confirm password can't be empty";
  }

  if (val != password) {
    return "Passwords do not match";
  }

  return null; // تمام
}

String?  phoneValidator(String? val) {
  RegExp phoneRegex = RegExp(r'^\+?[0-9]{11}$');

  if (val == null || val.isEmpty) {
    return 'this field is required';
  }
  if (!phoneRegex.hasMatch(val.trim())) {
    return 'enter valid phone number';
  } else {
    return null;
  }
}