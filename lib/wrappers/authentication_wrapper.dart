import 'dart:async';

import 'package:dicecash/screens/auth/login_page.dart';
import 'package:dicecash/screens/profile/components/create_profile.dart';

import 'package:flutter/material.dart';

import '../screens/entrypoint/entrypoint_ui.dart';
import '../services/authentication/authentication_service.dart';
import '../services/database/user_database_helper.dart';

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
  var userData = false;
  @override
  Widget build(BuildContext context) {
    // log(_connectionStatus.name.toString());

    return StreamBuilder(
        stream: AuthenticationService().authStateChanges,
        builder: (context, snapshot) {


          if (snapshot.hasData) {
           UserDatabaseHelper().getUserDataFromId()?.then((value){
             if(value.wyd != ''){
               userData = true;
           }

            });

           return !userData ? CreateProfile() : EntryPointUI();


          } else {
            if (localStatus == 'LoggedIn') {
              return const CreateProfile();
            } else {
              return const LoginPage();
            }
          }

        });
  }
}
