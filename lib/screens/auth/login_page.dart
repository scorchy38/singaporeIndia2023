import 'package:dicecash/core/constants/app_colors.dart';
import 'package:dicecash/screens/auth/components/login_referral.dart';
import 'package:dicecash/screens/profile/components/create_profile.dart';
import 'package:dicecash/services/current_user_change_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dicecash/screens/entrypoint/entrypoint_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import '../../exceptions/firebaseauth/messeged_firebaseauth_exception.dart';
import '../../exceptions/firebaseauth/signin_exceptions.dart';
import '../../languages/languages.dart';
import '../../languages/local_constants.dart';
import '../../main.dart';
import '../../services/authentication/authentication_service.dart';
import '../../services/database/user_database_helper.dart';
import 'components/sign_in_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    prints();
    super.initState();
  }

  String? token;
  prints() async {
    // token = await FirebaseMessaging.instance.getToken();

    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Spacer(),
              Image.asset(
                'assets/dice/logo.png',
                height: 150,
              ),
              const SizedBox(height: 8),
              // Text('Lucky Dice',
              //     style: Theme.of(context).textTheme.headline6?.copyWith(
              //         color: Colors.black,
              //         fontWeight: FontWeight.w900,
              //         fontSize: 24,
              //         letterSpacing: 2)),
              const SizedBox(height: 40),
              SignInButtons(
                onSignupWithGoogle: () => signInButtonCallback(),
                text: (Languages.of(context)?.login)!,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginReferralPage()));
                },
                child: Text((Languages.of(context)?.referral)!,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        )),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() async {
                    var locale = await getLocale();
                    print(locale.languageCode);
                    locale.languageCode == 'hi'
                        ? changeLanguage(context, 'en')
                        : changeLanguage(context, 'hi');
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text((Languages.of(context)?.labelSelectLanguage)!,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            )),
                    Icon(FontAwesomeIcons.language, color: Colors.blue,)
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInButtonCallback() async {
    final AuthenticationService authService = AuthenticationService();
    bool signInStatus = false;
    String snackMessage;

    try {
      print('Running done');

      final signInStatus =
          await authService.signInWithGoogle(false, 'rc', "token");
      print(signInStatus);

      // signInFuture.then((value) => signInStatus = value);
      // signInStatus = await showDialog(
      //   context: context,
      //   builder: (context) {
      //     return FutureProgressDialog(
      //       signInFuture,
      //       message: const Text("Signing in to account"),
      //     );
      //   },
      // );
      await Future.delayed(Duration(seconds: 10), () async {


        AuthenticationService().setLocalAuthStatus('LoggedIn');
        print('Running done');
      });
      if (signInStatus == true) {
        snackMessage = "Signed In Successfully";
        print("Signed In Successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const CreateProfile()));
      } else {
        print("Sign In Unsuccessfully");
        throw FirebaseSignInAuthUnknownReasonFailure();
      }
    } on MessagedFirebaseAuthException catch (e) {
      snackMessage = e.message;
      if (kDebugMode) {
        print(snackMessage);
      }

      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(snackMessage),
      //   ),
      // );
    } catch (e) {
      snackMessage = e.toString();
      if (kDebugMode) {
        print(snackMessage);
      }

      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(snackMessage),
      //   ),
      // );
    }
  }
}
