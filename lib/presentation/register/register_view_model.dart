import 'dart:async';
import 'dart:io';

import 'package:tut_app/app/functions.dart';
import 'package:tut_app/domain/usecase/register_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
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

  final RegisterUseCase _registerUseCase;

  var registerViewObject = RegisterObject("", "", "", "", "", "");

  RegisterViewModel(this._registerUseCase);

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

  // -- Inputs

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  // -- outputs

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserNameValid) => isUserNameValid ? null : "Invalid username");

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : "Invalid Email");

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : "Invalid Mobile Number");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : "Invalid Password");

  @override
  Stream<File> get outputIsProfilePictureValid =>
      _profilePictureStreamController.stream.map((file) => file);

  @override
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  // -- private methods
  bool _isUserNameValid(String userName) {
    return userName.length >= 4;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
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

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;

  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;

  Stream<String?> get outputErrorPassword;

  Stream<File> get outputIsProfilePictureValid;
}
