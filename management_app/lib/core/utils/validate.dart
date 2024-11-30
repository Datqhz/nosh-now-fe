

bool validateEmail(String email){
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (regex.hasMatch(email)) {
      return true;
    }
    return false;
}

bool validatePhone(String phone){
    RegExp regex = RegExp(r'^\d{10}$');
    if (regex.hasMatch(phone)) {
      return true;
    }
    return false;
}

bool containsWhitespace(String s){
    return s.contains(' ');
}