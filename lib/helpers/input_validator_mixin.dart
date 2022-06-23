mixin TextFieldValidator {
  String? isEmailValid(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "email can't be empty";
    }
    if (!regExp.hasMatch(value)) {
      return "please enter a valid email";
    } else {
      return null;
    }
  }

  String? isPasswordValid(String? value) {
    if (value!.length < 8) {
      return "password must contain 8 characters";
    } else {
      return null;
    }
  }
}
