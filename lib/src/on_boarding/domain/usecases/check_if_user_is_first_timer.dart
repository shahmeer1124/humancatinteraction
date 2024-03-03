import 'package:humancattranslate/core/usecases/usecases.dart';
import 'package:humancattranslate/core/utils/typedef.dart';
import 'package:humancattranslate/src/on_boarding/domain/repo/on_boardingrepo.dart';


class CheckIfUserIsFirstTimer extends UseCaseWithOutParams<bool> {
  CheckIfUserIsFirstTimer(this._repo);
  final OnBoardingRepo _repo;
  @override
  ResultFuture<bool> call() => _repo.checkIfUserIsFirstTimer();
}





