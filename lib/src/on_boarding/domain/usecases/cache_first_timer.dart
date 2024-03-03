import 'package:humancattranslate/core/usecases/usecases.dart';
import 'package:humancattranslate/core/utils/typedef.dart';
import 'package:humancattranslate/src/on_boarding/domain/repo/on_boardingrepo.dart';

class CacheFirstTimer extends UseCaseWithOutParams<void> {
  CacheFirstTimer(this._repo);
  final OnBoardingRepo _repo;
  @override
  ResultFuture<void> call() async => _repo.cacheFirstTimer();
}
