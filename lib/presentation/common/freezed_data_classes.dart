import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart'; // flutter pub run build_runner build --delete-conflicting-outputs

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
    String countryMobileCode,
    String userName,
    String email,
    String password,
    String mobileNumber,
    String profilePicture,
  ) = _RegisterObject;
}
