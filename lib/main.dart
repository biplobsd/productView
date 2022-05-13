import 'package:flutter/material.dart';
import 'package:productview/app/app.dart';
import 'package:productview/core/themes/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppTheme.setStatusBarAndNavigationBarColors();
  runApp(const App());
}
