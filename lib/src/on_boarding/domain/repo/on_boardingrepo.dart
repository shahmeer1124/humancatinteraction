import 'package:humancattranslate/core/utils/typedef.dart';

abstract class OnBoardingRepo{
  const OnBoardingRepo();
  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
