import 'package:dio/dio.dart';
import 'package:expenses/services/api_services/dio.dart';
import 'package:expenses/widgets/general_widgets/app_theme_base.dart';
import 'package:expenses/services/user_services.dart';
import 'package:expenses/widgets/login/login_service.dart';
import 'package:expenses/widgets/login/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then(
    (_) => runApp(
      MainWidget(),
    ),
  );*/
  await dotenv.load(fileName: ".env");
  return runApp(MultiProvider(
    providers: [
      Provider<Dio>(
        create: (_) => createDio(),
      ),
      ProxyProvider<Dio, ApiClient>(
        update: (_, dio, __) => ApiClient(dio),
      ),
      ProxyProvider<ApiClient, UserServices>(
        update: (_, client, __) => UserServices(client: client),
      ),
      ChangeNotifierProvider<LoginService>(
        create: (context) => LoginService(
          userServices: context.read(),
        ),
      ),
    ],
    child: MainWidget(),
  ));
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
          title: 'Expenses',
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
          home: LoginWidget(),
        );
      },
    );
  }
}
