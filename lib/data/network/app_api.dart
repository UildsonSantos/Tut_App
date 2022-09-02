import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tut_app/app/constant.dart';
import 'package:tut_app/data/responses/responses.dart';

part 'app_api.g.dart'; // with flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("imei") String imei,
    @Field("device_type") String deviceType,
  );

  @POST("/customers/forgot-password")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
      @Field("country_mobile_code") String countryMobileCode,
      @Field("user_name") String userName,
      @Field("password") String password,
      @Field("mobile_number") String mobileNumber,
      @Field("profile_picture") String profilePicture,
      );
}

