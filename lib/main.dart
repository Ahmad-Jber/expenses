import 'package:expenses/widgets/general_widgets/app_theme_base.dart';
import 'package:expenses/widgets/my_expenses/expenses_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then(
    (_) => runApp(
      MainWidget(),
    ),
  );
}

class MainWidget extends StatelessWidget {
  MainWidget({super.key});

  final ColorScheme lightColorScheme =
      ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent);
  final ColorScheme darkColorScheme =
      ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent);
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (BuildContext context, ThemeMode currentMode, Widget? child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeData(
            lightColorScheme,
            Colors.white70,
          ),
          darkTheme: AppTheme.getThemeData(
            darkColorScheme,
            Colors.black26,
          ),
          themeMode: currentMode,
          home: const ExpensesWidget(),
        );
      },
    );
  }
}
