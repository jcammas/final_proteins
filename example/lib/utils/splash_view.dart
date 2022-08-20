import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proteins_example/providers/auth_provider.dart';
import 'package:proteins_example/utils/palette.dart';
import 'package:proteins_example/views/auth/login_view.dart';
import 'package:proteins_example/views/home/home.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static String routeName = '/splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final bool? isLogggedin = Provider.of<AuthProvider>(context).isLoggedin;

    Future.delayed(
      const Duration(microseconds: 1),
      () {
        if (isLogggedin != null) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (isLogggedin == false) {
              Navigator.pushReplacementNamed(
                  context, LoginViewController.routename);
            } else if (isLogggedin == true) {
              Navigator.pushReplacementNamed(
                  context, HomeViewController.routename);
            }
          });
        }
      },
    );

    return Scaffold(
      backgroundColor: createMaterialColor(const Color(0xFF292D39)),
      body: const SizedBox(),
    );
  }
}
