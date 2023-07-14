import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dicecash/main.dart';
import 'package:dicecash/screens/game/game.dart';
import 'package:dicecash/screens/home/components/home_options.dart';
import 'package:dicecash/services/current_user_change_notifier.dart';
import 'package:dicecash/services/data_streams/user_stream.dart';
import 'package:dicecash/services/database/user_database_helper.dart';
import 'package:emojis/emoji.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../../core/constants/constants.dart';
import '../../../models/User.dart';
import '../../../services/authentication/authentication_service.dart';
import '../../entrypoint/entrypoint_ui.dart';
import '../../profile/components/leaderboard.dart';
import '../../profile/components/wallet.dart';

class HomeGreetings extends StatefulWidget {
  const HomeGreetings({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeGreetings> createState() => _HomeGreetingsState();
}

class _HomeGreetingsState extends State<HomeGreetings> {
  final UserStream userStream = UserStream();
  // StreamingSharedPreferences? preferences;
  initialize() async {
    String status = await AuthenticationService().getLocalAuthStatus();
    if (status == 'LoggedIn') currentUserChangeNotifier.setCurrentUser(true);
  }

  @override
  void initState() {
    super.initState();

    initialize();
    userStream.init();
  }

  @override
  void dispose() {
    userStream.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getSecurityStatus();

    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: PreferenceBuilder<bool>(
          preference: preferences!.getBool('securityCheck', defaultValue: true),
          builder: (BuildContext context, bool counter) {
            print('Sec Check ${counter}');
            return AnimatedBuilder(
              animation: currentUserChangeNotifier,
              builder: (context, child) {
                String? url = AuthenticationService().currentUser?.photoURL ??
                    "https://www.alchinlong.com/wp-content/uploads/2015/09/sample-profile.png";
                return currentUserChangeNotifier.currentUserData == null
                    ? Container(
                        child: Center(
                          child: Text('Loading...'),
                        ),
                      )
                    : Container(
                        child: Column(
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    preferences!
                                        .setBool('securityCheck', false);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.primary,
                                    radius: 43,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(url!),
                                      radius: 40,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Welcome, ${currentUserChangeNotifier.currentUserData!.name.split(" ")[0]}!",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                                color: AppColors.primary,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.025,
                                                fontWeight: FontWeight.bold)),
                                    currentUserChangeNotifier
                                                .currentUserData!.activated ==
                                            true
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Wallet()));
                                            },
                                            child: Card(
                                              elevation: 3,
                                              color: AppColors.primary,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 10),
                                                child: Container(
                                                  height: 15,
                                                  child: Center(
                                                    child: Text(
                                                        "View Wallet 💵",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            ?.copyWith(
                                                                color: AppColors
                                                                    .text,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: Text(
                                                  currentUserChangeNotifier
                                                      .currentUserData!.uid,
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Clipboard.setData(ClipboardData(
                                                      text:
                                                          "${currentUserChangeNotifier.currentUserData!.uid}"));
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'User Id Copied to Clipboard!');
                                                },
                                                child: Icon(
                                                  Icons.copy,
                                                  color: Colors.grey,
                                                  size: 15,
                                                ),
                                              ),
                                            ],
                                          )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            optionCardLong(
                                AppColors.primary,
                                'Weekly Leaderboard Rewards🎁️',
                                true ? 'Finish at #1 and Win Demat Account \nOpening at 0 fees' : '',
                                '  View  ',
                                'assets/images/board.png',
                                '100 🥇', () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Leaderboard()));
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 80,
                              width: double.infinity,
                              // (MediaQuery.of(context).size.width / 2) * 0.75
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 15),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                    "#2",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                Text("Place",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        ?.copyWith(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                // "🪙",
                                                "🏆",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    ?.copyWith(
                                                        fontSize: 30,
                                                        color:
                                                            AppColors.primary,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(color: Colors.blue),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.withOpacity(0.8),
                                          Colors.blue.withOpacity(0.8),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 15),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                    "12",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                Text("Day Streak",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        ?.copyWith(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("🔥",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    ?.copyWith(
                                                        fontSize: 30,
                                                        color:
                                                            AppColors.primary,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(color: Colors.blue),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.withOpacity(0.8),
                                          Colors.blue.withOpacity(0.8),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Text("${user.tickets} 🎟",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .headline6
                            //         ?.copyWith(
                            //         color: AppColors.primary,
                            //         fontWeight: FontWeight.bold)),
                            // Container(
                            //   child: Text("${userData.gold} 🪙",
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .headline6
                            //           ?.copyWith(
                            //           color:
                            //           AppColors.primary,
                            //           fontWeight:
                            //           FontWeight.bold)),
                            // ),

                            // Card(
                            //   elevation: 3,
                            //   color: AppColors.primary,
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //         horizontal: 10.0, vertical: 10),
                            //     child: Container(
                            //       height: 35,
                            //       width: double.infinity,
                            //       // (MediaQuery.of(context).size.width / 2) * 0.75
                            //       child: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceEvenly,
                            //         children: [
                            //           Text("${user?.tickets} 🎟",
                            //               style: Theme.of(context)
                            //                   .textTheme
                            //                   .headline6
                            //                   ?.copyWith(color: AppColors.text, fontWeight: FontWeight.bold)),
                            //           SizedBox(
                            //             width: 8,
                            //           ),
                            //           Text("${user?.gold} 🥇",
                            //               style: Theme.of(context)
                            //                   .textTheme
                            //                   .headline6
                            //                   ?.copyWith(color: AppColors.text, fontWeight: FontWeight.bold)),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // )
                            // Spacer(),
                            // InkWell(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => FoodStylePage()));
                            //   },
                            //   child: Card(
                            //     elevation: 3,
                            //     color: AppColors.primary,
                            //     child: Padding(
                            //       padding: const EdgeInsets.symmetric(
                            //           horizontal: 10.0, vertical: 10),
                            //       child: Container(
                            //         height: 35,
                            //         width:
                            //         (MediaQuery.of(context).size.width / 2) * 0.75,
                            //         child: Center(
                            //           child: Text("Play Now 🎲",
                            //               style: Theme.of(context)
                            //                   .textTheme
                            //                   .headline6
                            //                   ?.copyWith(
                            //                       color: AppColors.text,
                            //                       fontSize: 18, fontWeight: FontWeight.bold)),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
              },
            );
          }),
    );
  }
  Widget optionCardLong(Color color, String text, String line1, String btnText,
      String anim, String reward, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 4,
          color: AppColors.primary.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 70,
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary.withOpacity(0.4),
                          child: Image.asset(
                            anim,
                            height: 50,
                          ),
                          radius: 30,
                        )),

                    SizedBox(
                      width: 20,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(text,
                            style: Theme.of(context).textTheme.headline6?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        line1 != ''
                            ? SizedBox(
                          height: 10,
                        )
                            : SizedBox(),
                        line1 != ''
                            ? Text(line1,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold))
                            : SizedBox(),

                        // Container(
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.all(Radius.circular(35)),
                        //       color: AppColors.orange.withOpacity(0.4)
                        //   ),
                        //
                        //   child:Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
                        //     child: Text('$reward',
                        //         style: Theme.of(context).textTheme.headline6?.copyWith(
                        //             color: Colors.white,
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.bold)),
                        //   ),
                        //
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                      ],
                    ),

                    // Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(10)),
                    //       color: AppColors.primary),
                    //   child: InkWell(
                    //     onTap: onTap,
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 15.0, vertical: 12),
                    //       child: Text(btnText,
                    //           style: Theme.of(context).textTheme.headline6?.copyWith(
                    //               color: Colors.white,
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.bold)),
                    //     ),
                    //   ),
                    // )
                    // anim != ''
                    //     ? SizedBox(
                    //         height: 70, child: CircleAvatar(backgroundColor: Colors.white, backgroundImage:AssetImage(anim), radius: 50,))
                    //     : Container(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

}
