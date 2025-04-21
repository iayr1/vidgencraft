import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidgencraft/core/themes/app_theme.dart';
import 'config/di/dependency_injection.dart';
import 'config/routes/app_router.dart';
import 'config/routes/navigation_service.dart';
import 'core/themes/bloc/theme_bloc.dart';
import 'core/utils/windows.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator(); // Initialize dependency injection
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          NavigationService navigationService = sl<NavigationService>();
          Window().adaptDeviceScreenSize(view: View.of(context));
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeData.brightness == Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
            navigatorKey: navigationService.navigatorKey,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRoutes.generate,
          );
        },
      ),
    );
  }
}