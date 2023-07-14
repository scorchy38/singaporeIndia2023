import 'dart:async';

import 'package:dicecash/screens/auth/login_page.dart';

import 'package:flutter/material.dart';

import '../screens/entrypoint/entrypoint_ui.dart';
import '../services/authentication/authentication_service.dart';

//TODO: Commented Code
class AuthenticationWrapper extends StatefulWidget {
  static const String routeName = "/authentification_wrapper";

  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  String localStatus = '';

  @override
  void initState() {
    super.initState();

    getLocalAuthStatus();
  }




  Future<String> getLocalAuthStatus() async {

    localStatus = await AuthenticationService().getLocalAuthStatus();
    return localStatus;
  }

  @override
  Widget build(BuildContext context) {
    // log(_connectionStatus.name.toString());

    return StreamBuilder(
        stream: AuthenticationService().authStateChanges,
        builder: (context, snapshot) {


          if (snapshot.hasData) {
            return const EntryPointUI();
          } else {
            if (localStatus == 'LoggedIn') {
              return const EntryPointUI();
            } else {
              return const LoginPage();
            }
          }

        });
  }
}
