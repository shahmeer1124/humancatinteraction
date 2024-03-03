import 'package:get_it/get_it.dart';
import 'package:humancattranslate/src/on_boarding/data/datasource/on_boarding_local_datasource.dart';
import 'package:humancattranslate/src/on_boarding/data/repos/on_boardingrepo_impl.dart';
import 'package:humancattranslate/src/on_boarding/domain/repo/on_boardingrepo.dart';
import 'package:humancattranslate/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:humancattranslate/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:humancattranslate/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'injection_container_main.dart';