import 'package:flutter/material.dart';
import 'package:tut_app/app/app.dart';

import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
