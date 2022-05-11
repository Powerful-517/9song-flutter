import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(const GetMaterialApp(
    home: NineSongApp(),
  ));
}
