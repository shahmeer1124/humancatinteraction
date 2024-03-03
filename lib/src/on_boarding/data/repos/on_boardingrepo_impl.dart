

import 'package:dartz/dartz.dart';
import 'package:humancattranslate/core/errors/exceptions.dart';
import 'package:humancattranslate/core/errors/failure.dart';
import 'package:humancattranslate/core/utils/typedef.dart';
import 'package:humancattranslate/src/on_boarding/data/datasource/on_boarding_local_datasource.dart';
import 'package:humancattranslate/src/on_boarding/domain/repo/on_boardingrepo.dart';

class OnBoardingRepoImpl implements OnBoardingRepo {
  const OnBoardingRepoImpl(this._localDataSource);
  final OnBoardingLocalDataSource _localDataSource;
  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
    final result =  await _localDataSource.checkIfUserIsFirstTimer();
      return  Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
