import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _time;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _time = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    _appPreferences.isUserLoggedIn().then(
          (isUserLoggedIn) => {
            if (isUserLoggedIn)
              {
                // navigate to main screen
                Navigator.pushReplacementNamed(context, Routes.mainRoute)
              }
            else
              {
                _appPreferences.isOnBoardingScreenViewed().then(
                      (isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.loginRoute,
                            )
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.onBoardingRoute,
                            )
                          }
                      },
                    )
              }
          },
        );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _time?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }
}
