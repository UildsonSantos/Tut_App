import 'package:data_connection_checker/data_connection_checker.dart'; // with: flutter run --no-sound-null-safety
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/data_source/local_data_source.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/dio_factory.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/repository/repository_impl.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/forgot_password_usecase.dart';
import 'package:tut_app/domain/usecase/home_usecase.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/domain/usecase/register_usecase.dart';
import 'package:tut_app/domain/usecase/store_details_usecase.dart';
import 'package:tut_app/presentation/forgot_password/forgot_password_view_model.dart';
import 'package:tut_app/presentation/login/login_view_model.dart';
import 'package:tut_app/presentation/main/home/home_view_model.dart';
import 'package:tut_app/presentation/register/register_view_model.dart';
import 'package:tut_app/presentation/store_datails/store_details_view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(
    () => sharedPrefs,
  );

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance()),
  );

  // network info
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(DataConnectionChecker()),
  );

  // dio factory
  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(instance()),
  );

  // app  service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(
    () => AppServiceClient(dio),
  );

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(instance()),
  );

  // local data source
  instance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );

  // repository
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(instance(), instance(), instance()),
  );
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(instance()),
    );
    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(instance()),
    );
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(instance()),
    );
    instance.registerFactory<ForgotPasswordViewModel>(
      () => ForgotPasswordViewModel(instance()),
    );
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(
      () => RegisterUseCase(instance()),
    );
    instance.registerFactory<RegisterViewModel>(
      () => RegisterViewModel(instance()),
    );
    instance.registerFactory<ImagePicker>(
      () => ImagePicker(),
    );
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(
      () => HomeUseCase(instance()),
    );
    instance.registerFactory<HomeViewModel>(
      () => HomeViewModel(instance()),
    );
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
      () => StoreDetailsUseCase(instance()),
    );
    instance.registerFactory<StoreDetailsViewModel>(
      () => StoreDetailsViewModel(instance()),
    );
  }
}
