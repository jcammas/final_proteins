// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proteins/controller/scenekit_plugin_controller_interface.dart';
import 'package:proteins/proteins.dart';
import 'package:proteins_example/views/sceneKit/scene_kit_page.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:proteins_example/providers/auth_provider.dart';
import 'package:proteins_example/providers/user_provider.dart';
import 'package:proteins_example/utils/config_theme.dart';
import 'package:proteins_example/utils/not_found.dart';
import 'package:proteins_example/utils/palette.dart';
import 'package:proteins_example/utils/splash_view.dart';
import 'package:proteins_example/views/auth/login_view.dart';
import 'package:proteins_example/views/auth/signup_view.dart';
import 'package:proteins_example/views/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  box = await Hive.openBox('easyTheme');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthProvider authProvider = AuthProvider();
  String _platformVersion = 'Unknown';
  final _proteinsPlugin = Proteins();
  late ScenekitController scenekitController;

  @override
  void initState() {
    super.initState();
    initPlatformState;

    authProvider.initAuth();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentTheme.addListener(() {
        setState(() {});
      });
    });
  }

  Future<void> initPlatformState(ScenekitController scenekitController) async {
    String platformVersion;
    this.scenekitController = scenekitController;
    final version = await scenekitController.getPlatformVersion();

    // ignore: avoid_print
    print(version);

    try {
      platformVersion = await _proteinsPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (_) => UserProvider(),
          update: (_, authProvider, oldUserProvider) {
            oldUserProvider!.update(authProvider);
            return oldUserProvider;
          },
        ),
      ],
      child: GetMaterialApp(
        title: 'Fluttery Gelatine',
        theme: ThemeData(
          primarySwatch: createMaterialColor(const Color(0xFF292D39)),
          scaffoldBackgroundColor: Colors.white,
          //primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: currentTheme.currentTheme(),
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            splash: Image.asset(
              'assets/images/logoicon.png',
            ),
            nextScreen: const SplashView(),
            duration: 1000,
            backgroundColor: createMaterialColor(const Color(0xFF292D39)),
            splashTransition: SplashTransition.rotationTransition),
        onGenerateRoute: (settings) {
          if (settings.name == HomeViewController.routename) {
            return MaterialPageRoute(
                builder: (_) => const HomeViewController());
          } else if (settings.name == LoginViewController.routename) {
            return MaterialPageRoute(
                builder: (_) => const LoginViewController());
          } else if (settings.name == Register.routeName) {
            return MaterialPageRoute(builder: (_) => const Register());
          } else if (settings.name == ScenekitPage.routename) {
            return MaterialPageRoute(
                builder: (_) => const ScenekitPage(
                      name: "",
                    ));
          } else {
            return null;
          }
        },
        onUnknownRoute: (_) =>
            MaterialPageRoute(builder: (_) => const NotFoundView()),
      ),
    );
  }
}
