// ignore_for_file: prefer_is_empty

mixin InputValidationMixin {
  bool emailValid(String val) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(val);
  }

  bool passwordValid(String password) {
    RegExp regExp = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&-._+;:#,])[A-Za-z\d@$!%*?&-._@$!%*?&-._+;:#,]{8,}$');
    if (password.length < 8) {
      return false;
    } else if (!regExp.hasMatch(password)) {
      return false;
    } else {
      return true;
    }
  }
}
