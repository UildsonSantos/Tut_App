import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tut_app/app/app.dart';
import 'package:tut_app/presentation/resources/language_manager.dart';

import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
      supportedLocales: const [englishLocal, arabicLocal],
      path: assetsPathLocalization,
      child: Phoenix(child: MyApp()),
    ),
  );
}
