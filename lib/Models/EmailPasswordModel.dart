import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailPasswordModel with ChangeNotifier{
  bool _isHidden=true;
  get isHidden=> _isHidden;
  void isHiddenP(value)
  {
    _isHidden=value;
    notifyListeners();
  }

  bool _isValid= false;
  get isValid=> _isValid;
  void setValid(value)
  {
    _isValid=value;
    notifyListeners();
  }
  void isValidEmail(String input)
  {
    _isValid=EmailValidator.validate(input);
    notifyListeners();
  }

}