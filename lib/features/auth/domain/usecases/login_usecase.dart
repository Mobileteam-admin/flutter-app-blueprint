import 'package:dartz/dartz.dart';
import 'package:flutter_base_project/core/error/failures.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../entities/user.dart';

class LoginParams {
  final String email;
  final String password;
  LoginParams(this.email, this.password);
}

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(LoginParams params) {
    return repository.login(params.email, params.password);
  }
}
