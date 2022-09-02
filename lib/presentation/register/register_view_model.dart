import 'dart:async';
import 'dart:io';

import 'package:tut_app/presentation/base/base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();

  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();

  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _isAllInputsValidStreamController.close();
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    super.dispose();
  }
}

abstract class RegisterViewModelInput {
  register();

  Sink get inputUserName;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicture;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;

  Stream<String> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;

  Stream<String> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;

  Stream<String> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;

  Stream<String> get outputErrorPassword;

  Stream<File> get outputIsProfilePictureValid;
}
