import 'package:easy_localization/easy_localization.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartek_demo/controllers/events_controllers/event_controller.dart';
import 'package:kartek_demo/controllers/home_screen_controllers/home_screen_contoller.dart';
import 'package:kartek_demo/controllers/login_screen_controllers/auth_controller.dart';
import 'package:kartek_demo/screens/home_screens/home_screen.dart';

import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/router.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenController()),
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => EventController()),
      ],
      child: EasyLocalization(
          supportedLocales: const [Locale('tr', 'TR'), Locale('en', 'US')],
          path: 'assets/translations',
          fallbackLocale: const Locale('tr', 'TR'),
          child: const MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    isOnline();
    getUserData();
  }

  isOnline() {
    Provider.of<AuthController>(context, listen: false).isUserOnline();
  }

  Future<void> getUserData() async {
    await Provider.of<AuthController>(context, listen: false)
        .getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Event App',
        debugShowCheckedModeBanner: false,
        theme: CustomThemeData.customLightTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const HomeScreen());
  }
}
