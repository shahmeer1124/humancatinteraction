

import 'package:dartz/dartz.dart';
import 'package:humancattranslate/core/errors/failure.dart';

typedef ResultFuture<T>=Future<Either<Failure,T>>;
typedef DataMap=Map<String,dynamic>;
