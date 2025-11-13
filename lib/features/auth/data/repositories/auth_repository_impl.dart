import 'package:dartz/dartz.dart';
import 'package:flutter_base_project/core/error/failures.dart';
import 'package:flutter_base_project/core/storage/shared_prefs.dart';
import '../../domain/entities/user.dart';
import '../datasources/auth_remote_data_source.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final SharedPrefManager prefs;

  AuthRepositoryImpl({
    required this.remote,
    required this.prefs,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await remote.login(email, password);
      // await prefs.saveToken(user.token); // if applicable
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
