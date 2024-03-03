import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:humancattranslate/core/services/injection_container.dart';
import 'package:humancattranslate/core/skeleton/skeleton.dart';
import 'package:humancattranslate/src/on_boarding/data/datasource/on_boarding_local_datasource.dart';
import 'package:humancattranslate/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:humancattranslate/src/on_boarding/presentation/views/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Route<dynamic> ongenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (prefs.getBool(kFirstTimerKey) ?? true) {
            return BlocProvider(
              create: (_) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          }
          return const Skeleton();

        },
        settings: settings,
      );

    // case SignUpScreen.routeName:
    //   return _pageBuilder(
    //     (_) => BlocProvider(
    //       create: (_) => sl<AuthBloc>(),
    //       child: const SignUpScreen(),
    //     ),
    //     settings: settings,
    //   );
    // case Dashboard.routeName:
    //   return _pageBuilder((_) => const Dashboard(), settings: settings);
    // case '/forgot-password':
    //   return _pageBuilder(
    //     (_) => const ForgotPasswordScreen(),
    //     settings: settings,
    //   );
    default:
      return _pageBuilder(
        (_) => Container(
          height: 200,
          width: 200,
          color: Colors.yellow,
          child: const Text('Page Under Construction'),
        ),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
