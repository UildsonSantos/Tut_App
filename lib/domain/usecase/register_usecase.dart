import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/request/request.dart';
import 'package:tut_app/domain/models/models.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(
      RegisterRequest(
        input.countryMobileCode,
        input.userName,
        input.email,
        input.password,
        input.mobileNumber,
        input.profilePicture,
      ),
    );
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;

  RegisterUseCaseInput(
    this.countryMobileCode,
    this.userName,
    this.email,
    this.password,
    this.mobileNumber,
    this.profilePicture,
  );
}
