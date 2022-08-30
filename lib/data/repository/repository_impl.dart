import 'package:dartz/dartz.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/request/request.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/domain/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // its safe to call the API
      final response = await _remoteDataSource.login(loginRequest);

      if (response.status == 0) // success
      {
        // return data (success)
        // return right
        return Right(response.toDomain());
      } else {
        // return biz logic error
        // return left
        return Left(Failure(409,
            response.message ?? "We have business error logic from API side"));
      }
    } else {
      // return connection error
      return Left(Failure(501, "Please check your internet connection"));
    }
  }
}
