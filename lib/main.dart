import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:of_ramadan/application/routes/app_routes.dart';
import 'package:of_ramadan/application/state/content_settings_state.dart';
import 'package:of_ramadan/application/state/main_app_state.dart';
import 'package:of_ramadan/application/strings/app_constraints.dart';
import 'package:of_ramadan/application/strings/app_strings.dart';
import 'package:of_ramadan/application/themes/app_theme.dart';
import 'package:of_ramadan/presentation/pages/main_page.dart';
import 'package:of_ramadan/presentation/pages/tablet_page.dart';
import 'package:of_ramadan/presentation/widgets/default_scroll_behavior.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(AppConstraints.keyAppSettingsBox);
  await Hive.openBox(AppConstraints.keyFavoritesList);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainAppState(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContentSettingsState(),
        ),
      ],
      child: const RootPage(),
    ),
  );
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ContentSettingsState settings = context.watch<ContentSettingsState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: DefaultScrollBehavior(),
          child: child!,
        );
      },
      themeMode: settings.getAdaptiveTheme ? ThemeMode.system : settings.getDarkTheme ? ThemeMode.dark : ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      home: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => const MainPage(),
        tablet: (BuildContext context) => const TabletPage(),
      ),
    );
  }
}
