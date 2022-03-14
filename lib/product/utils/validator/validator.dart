import 'package:school_project_ibdb/core/constants/string_constants.dart';

class Validator {
  String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return StringConstants().validatorCanNotEmpty;
    }
    return null;
  }

  String? validateEmail({required String? email}) {
    if (email == null) return null;
    RegExp emailReq = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (email.isEmpty) {
      return StringConstants().validatorCanNotEmpty;
    } else if (!emailReq.hasMatch(email)) {
      return StringConstants().enterProperMail;
    }
    return null;
  }

  String? validatePassword({required String? password}) {
    if (password == null) return null;
    if (password.isEmpty) {
      return StringConstants().validatorCanNotEmpty;
    }
    return null;
  }
}
