import 'dart:async';
import 'dart:io';


import 'package:dicecash/provider/select_correct_image_game.dart';
import 'package:dicecash/screens/auth/error_page.dart';
import 'package:dicecash/screens/shorts/service_locator.dart';
import 'package:dicecash/services/authentication/authentication_service.dart';
import 'package:dicecash/services/database/user_database_helper.dart';
import 'package:dicecash/wrappers/authentication_wrapper.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app/app.locator.dart';
import 'core/themes/app_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:overlay_support/overlay_support.dart';

import 'models/User.dart';

StreamingSharedPreferences? preferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  preferences = await StreamingSharedPreferences.instance;
  await Firebase.initializeApp();
  setup();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => ImageSelect(),
    ),
    ChangeNotifierProvider(
      create: (_) => OngoingGameStats(),
    ),
  ], child: MyApp()),);

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // AuthenticationService().signOut();

    return MaterialApp(
      title: 'SheFi',
      theme: AppThemes.light,
      home: const AuthenticationWrapper(),
    );
  }
}
