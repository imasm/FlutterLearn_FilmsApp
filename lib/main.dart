import 'dart:io';

import 'package:cinemapedia/config/device_setttings/windows_scroll_behavoir.dart';
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool needsMouse = Platform.isWindows || Platform.isMacOS || Platform.isLinux || kIsWeb;
    return MaterialApp.router(
        theme: AppTheme().current,
        scrollBehavior:  needsMouse ? WindowsScrollBehavior(): null,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter);
  }
}
