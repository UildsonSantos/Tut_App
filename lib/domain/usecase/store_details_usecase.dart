import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/models/models.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository repository;

  StoreDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) {
    return repository.getStoreDetails();
  }
}
