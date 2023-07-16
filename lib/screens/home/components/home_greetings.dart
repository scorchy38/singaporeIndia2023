import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dicecash/main.dart';
import 'package:dicecash/screens/game/game.dart';
import 'package:dicecash/screens/home/components/home_options.dart';
import 'package:dicecash/screens/profile/profile_page.dart';
import 'package:dicecash/services/current_user_change_notifier.dart';
import 'package:dicecash/services/data_streams/user_stream.dart';
import 'package:dicecash/services/database/user_database_helper.dart';
import 'package:dicecash/services/gpt_service.dart';
import 'package:emojis/emoji.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../../core/constants/constants.dart';
import '../../../languages/languages.dart';
import '../../../languages/local_constants.dart';
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
  String part1 = "Loading"; // trim again to remove possible spaces
  String part2 = ""; //
  initialize() async {
    String status = await AuthenticationService().getLocalAuthStatus();
    if (status == 'LoggedIn') currentUserChangeNotifier.setCurrentUser(true);
    var userData = await UserDatabaseHelper().getUserDataFromId();
    print(userData?.wyd);
    var locale = await getLocale();
    var gptRes = await GPTService().fetchAnswer('This user describes themselves as "${userData?.wyd}", I want to show a couple of lines curated according to their persona, to provide them a personalised onboarding experience on the app\'s homescreen. The first should be of a format a heading and the other a one liner description not more than 6 words strictly. The title and description should be separated by -. The content should be in language $locale. For more context we are an app who deliver financial literacy at scale. Don\'t use phrases like welcome to our app, give the answer in a millennial manner. Strictly just give me the lines directly no extra text, dots or new lines');
    print(gptRes.statusCode);
    if (gptRes.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(gptRes.body);
      String fullText = jsonResponse['choices'][0]['text'].trim();
      String fullText2 = fullText.replaceAll('.', ' ');
      List<String> splitText = fullText2.split('-');
      setState(() {
        part1 = splitText[0].trim();
        for(int i=1; i<splitText.length; i++){
          part2 += splitText[i].trim();
        }
      });

    } else {
      throw Exception('Failed to load answer from API');
    }
    print(gptRes.body);
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
                                                          const ProfilePage()));
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
                                                        "View Profile 👩‍🦰",
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
                                '$part1💹',
                                true ? '$part2💸' : '',
                                '  View  ',
                                'assets/images/board.png',
                                '100 🥇', () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Leaderboard())
                              // );
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
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const Leaderboard()));
                                    },
                                    child: Container(
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
                                                  Text((Languages.of(context)?.place)!,
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
                                                Text((Languages.of(context)?.streak)!,
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
                    Padding(
                      padding: const EdgeInsets.only(top:4.0),
                      child: RotatedBox(quarterTurns: 1,
                      child: Icon(FontAwesomeIcons.moneyBillTransfer, color: Colors.white, size: 50,)),
                    ),

                    SizedBox(
                      width: 20,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 250,
                          child: Text(text,
                              style: Theme.of(context).textTheme.headline6?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                        line1 != ''
                            ? SizedBox(
                          height: 10,
                        )
                            : SizedBox(),
                        line1 != ''
                            ? Container(
                          width: 250,
                              child: Text(line1,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                  color: AppColors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold), maxLines: 4, softWrap: true,),
                            )
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
