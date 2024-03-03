import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:humancattranslate/core/services/injection_container.dart';
import 'package:humancattranslate/core/services/router.dart';
import 'package:humancattranslate/core/skeleton/providers/selected_page_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SelectedPageProvider(showbottomwidget: false),
          ),
        ],
        child: MaterialApp(
          onGenerateRoute: ongenerateRoute,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(color: Colors.transparent),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
