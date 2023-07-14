import 'dart:math';
import 'package:dicecash/screens/game/components/main_game.dart';
import 'package:dicecash/screens/modules/modules_screen.dart';
import 'package:dicecash/screens/surveys/components/item_tile.dart';
import 'package:dicecash/services/ModulesData.dart';
import 'package:dicecash/services/current_user_change_notifier.dart';
import 'package:dicecash/services/data_streams/user_stream.dart';
import 'package:dicecash/services/database/user_database_helper.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import '../../../core/constants/constants.dart';
import '../../../models/User.dart';
import '../../../services/authentication/authentication_service.dart';
import '../../profile/components/leaderboard.dart';
import '../../profile/components/refer_earn.dart';
import '../../surveys/surveys.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:dicecash/services/ModulesData.dart';

class HomeOptions extends StatefulWidget {
  const HomeOptions({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeOptions> createState() => _HomeOptionsState();
}

class _HomeOptionsState extends State<HomeOptions> {
  final UserStream userStream = UserStream();

  @override
  void initState() {
    generateFourNumbers();
    getRatedStatusNow();
    modulesDataChangeNotifier.setModules([
      {
        'name': 'Unit 1',
        'topic': 'The Money Mindset. Money 101',
        'coursesUnlocked': 1,
        'theoryLink': 'https://www.google.com'
      },
      {
        'name': 'Unit 2',
        'topic': 'Wealth Building, Independence',
        'coursesUnlocked': 1,
        'theoryLink': 'https://www.google.com'
      }
    ]);
    modulesDataChangeNotifier.setChapters({
      'The Money Mindset. Money 101': [
        {
          'name': 'Chapter 1',
          'index': 0,
          'unlocked': true,
        },
        {
          'name': 'Chapter 2',
          'index': 1,
          'unlocked': false,
        },
        {
          'name': 'Chapter 3',
          'index': 2,
          'unlocked': false,
        },
        {
          'name': 'Chapter 4',
          'index': 3,
          'unlocked': false,
        },
        {
          'name': 'Chapter 5',
          'index': 4,
          'unlocked': false,
        },
      ],
      'Wealth Building, Independence': [
        {
          'name': 'Chapter 1',
          'index': 0,
          'unlocked': true,
        },
        {
          'name': 'Chapter 2',
          'index': 1,
          'unlocked': false,
        },
        {
          'name': 'Chapter 3',
          'index': 2,
          'unlocked': false,
        },
      ]
    });
    modulesDataChangeNotifier.setQuestions({
      'The Money Mindset. Money 101 Chapter 1': [
        {
          'name': 'Su shi',
          'index': 0,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Trophy',
          'index': 1,
          'unlocked': false,
          'option1': 'Trophy',
          'option1Image': 'assets/images/board.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Trophy',
          'answerImage': 'assets/images/board.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 2,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 3,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'index': 4,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        }
      ],
      'The Money Mindset. Money 101 Chapter 2': [
        {
          'name': 'Su shi',
          'index': 0,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'index': 1,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 2,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 3,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'index': 4,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        }
      ],
      'The Money Mindset. Money 101 Chapter 3': [
        {
          'name': 'Su shi',
          'index': 0,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'index': 1,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 2,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 3,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'index': 4,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        }
      ],
      'The Money Mindset. Money 101 Chapter 4': [
        {
          'name': 'Su shi',
          'index': 0,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'index': 1,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 2,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 3,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'index': 4,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        }
      ],
      'The Money Mindset. Money 101 Chapter 5': [
        {
          'name': 'Su shi',
          'index': 0,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'index': 1,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 2,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 3,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'index': 4,
          'unlocked': false,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        }
      ],
      'Wealth Building, Independence Chapter 1': [
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 0,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 1,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 2,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        }
      ],
      'Wealth Building, Independence Chapter 2': [
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 0,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 1,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 2,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        }
      ],
      'Wealth Building, Independence Chapter 3': [
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 0,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 1,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        },
        {
          'name': 'Su shi',
          'unlocked': false,
          'index': 2,
          'option1': 'Water',
          'option1Image': 'assets/water.png',
          'option2': 'Sushi',
          'option2Image': 'assets/sushi.png',
          'option3': 'Rice',
          'option3Image': 'assets/rice.png',
          'option4': 'Tea',
          'option4Image': 'assets/tea.png',
          'answer': 'Sushi',
          'answerImage': 'assets/water.png'
        }
      ]
    });
    initPollfish();

    currentUserChangeNotifier.setCurrentUser(true);
    super.initState();
    userStream.init();
  }

  @override
  void dispose() {
    userStream.dispose();
    super.dispose();
  }

  String _logText = '';

  bool _showButton = false;
  bool _completedSurvey = false;
  int _currentIndex = 0;
  int _cpa = 0;
  Future<void> initPollfish() async {
    String logText = 'Initializing Pollfish...';

    _showButton = false;
    _completedSurvey = false;

    final offerwallMode = _currentIndex == 2;

    setState(() {
      _logText = logText;
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    initPollfish();
  }

  Text findCurrentTitle(int currentIndex) {
    if (_currentIndex == 0) {
      return const Text('Pollfish Rewarded Integration');
    } else {
      return const Text('Pollfish Offerwall Integration');
    }
  }

  void _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        url,
        customTabsOption: const CustomTabsOption(
          toolbarColor: AppColors.primary,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          // animation: CustomTabsAnimation.slideIn(),
          // // or user defined animation.
          // animation: const CustomTabsAnimation(
          //   startEnter: 'slide_up',
          //   startExit: 'android:anim/fade_out',
          //   endEnter: 'android:anim/fade_in',
          //   endExit: 'slide_down',
          // ),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: Theme.of(context).primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

  bool? isRewardedVideoAvailable = false;
  bool isInterstitialVideoAvailable = false;

  bool? rated;
  void getRatedStatusNow() async {
    rated = await getRatingStatus();
    print('=============$rated');
  }

  int? n1;
  int? n2;
  int? n3;
  int? n4;
  generateFourNumbers() {
    var random = Random();
    n1 = random.nextInt(2);
    n2 = random.nextInt(3);
    n3 = random.nextInt(4);
    n4 = random.nextInt(5);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserData>(
        future: UserDatabaseHelper().getUserDataFromId(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            String? url = AuthenticationService().currentUser?.photoURL;
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ongoing Courses",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                        Container(
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              color: AppColors.primary),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderPage()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              child: Center(
                                child: Text('See All',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.29,
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                      ),
                      children: [
                        n1 == 1
                            ? SurveyTile(
                                'Money Basics',
                                'Mindset, Wealth Building',
                                'assets/images/money.png', () {
                                null;
                              })
                            : SurveyTile(
                                'Money Basics',
                                'Mindset, Wealth Building',
                                'assets/images/money.png', () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ModulesScreen()));
                              }),
                        n2 == 2
                            ? SurveyTile(
                                'Plan Retirement',
                                'Insurance, Children',
                                'assets/images/retire.png', () {
                                _launchURL(context,
                                    'https://surveywall.wannads.com?apiKey=62977e52beb71489487945&userId=vkumarsaraswat@gmail.com');
                              })
                            : SurveyTile(
                                'Plan Retirement',
                                'Insurance, Children',
                                'assets/images/retire.png', () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ModulesScreen()));
                              }),
                        // n3 == 3
                        //     ? SurveyTile('Admantum ', 'Get Upto 15000 Gold',
                        //         'assets/images/admantum.png', () {
                        //         _launchURL(context,
                        //             'https://www.admantum.com/offers?appid=24086&uid=vkumarsaraswat@gmail.com');
                        //       })
                        //     : SurveyTile(
                        //         'BitLabs Surveys',
                        //         'Get Upto 14000 Gold',
                        //         'assets/images/bitlabs.png', () {
                        //         _launchURL(context,
                        //             'https://web.bitlabs.ai/?uid=vkumarsarasawat@gmail.com&token=10650874-099c-4ee6-bb3a-9b05f7f100db');
                        //       }),
                        // n4 == 4
                        //     ? SurveyTile('KiwiWall ', 'Get Upto 16000 Gold',
                        //         'assets/images/kiwiWall.png', () {
                        //         _launchURL(context,
                        //             'https://www.kiwiwall.com/wall/7WKwukJEqYSNf69RjV3qfyc3MlMyMRl9/vkumarsarswat@gmail.com');
                        //       })
                        //     : SurveyTile(
                        //         'WannAds Offers ',
                        //         'Get Upto 25000 Gold',
                        //         'assets/images/wannads.png', () {
                        //         _launchURL(context,
                        //             'https://wall.wannads.com/wall?apiKey=62977e52beb71489487945&userId=vkumarsaraswat@gmail.com');
                        //       }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDefaults.padding - 2),
                    child: Row(
                      // scrollDirection: Axis.horizontal,
                      children: [
                        optionCard(
                            AppColors.primary,
                            ' Play Now',
                            'WIN UP TO',
                            'Play now',
                            'assets/images/diceLogo.png',
                            '100 🥇', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodSuggestions()));
                        }),
                        optionCard(
                          AppColors.primary,
                          'Watch Ads',
                          'WIN UP TO',
                          'Watch Now',
                          'assets/images/coin.png',
                          '3 🎟',
                          () async {
                            print(1);
                            isRewardedVideoAvailable = false;

                            if (isRewardedVideoAvailable!) {
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Reward video not available!');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  user!.activated == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDefaults.padding - 2),
                          child: Row(
                            children: [
                              optionCardHorizontal(
                                  AppColors.primary,
                                  'Rate Us⭐',
                                  'ON PLAYSTORE',
                                  'WIN UP TO',
                                  'assets/images/exchange.png',
                                  '50 🥇', () async {
                                launcher.launchUrl(
                                    Uri.parse(
                                        'https://play.google.com/store/apps/details?id=com.rayole.lucky.dice'),
                                    mode: launcher
                                        .LaunchMode.externalApplication);
                                setRatedStatus();
                                getRatedStatusNow();
                                setState(() {});
                              }),
                              optionCardHorizontal(
                                  AppColors.primary,
                                  'Refer & Earn️',
                                  'UP TO',
                                  'Go Now',
                                  'assets/images/playstore.png',
                                  '\$0.01 ', () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReferEarn()));
                              })
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          }
          return const Text('');
        });
  }

  Widget optionCard(Color color, String text, String line1, String btnText,
      String anim, String reward, void Function() onTap) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.46,
            child: Card(
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(text,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22)),
                        SizedBox(
                          height: 30,
                        ),
                        Text(line1,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                              color: AppColors.primary.withOpacity(0.4)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 12),
                            child: Text('$reward',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        color: AppColors.primary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.primary),
                          child: InkWell(
                            onTap: onTap,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 12),
                              child: Text(btnText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
        anim != ''
            ? Padding(
                padding: const EdgeInsets.only(bottom: 90.0),
                child: SizedBox(
                    height: 70,
                    child: CircleAvatar(
                      backgroundColor: AppColors.white,
                      child: Image.asset(
                        anim,
                        height: 50,
                      ),
                      radius: 50,
                    )),
              )
            : Container(),
      ],
    );
  }

  Widget optionCardHorizontal(Color color, String text, String line1,
      String btnText, String anim, String reward, void Function() onTap) {
    return InkWell(
      onTap: rated! && text == 'Rate Us⭐'
          ? () {
              Fluttertoast.showToast(msg: 'Already Redeemed!');
            }
          : onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.46,
        child: Card(
          elevation: 4,
          color: rated! && text == 'Rate Us⭐' ? Colors.grey[350] : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(line1,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: rated! && text == 'Rate Us⭐'
                                ? Colors.white
                                : AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(35)),
                          color: AppColors.primary.withOpacity(0.4)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 12),
                        child: Text('$reward',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                  ],
                ),
                // anim != ''
                //     ? SizedBox(
                //         height: 70, child: CircleAvatar(backgroundColor: Colors.white, backgroundImage:AssetImage(anim), radius: 50,))
                //     : Container(),

                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(10)),
                //     color: AppColors.orange
                //   ),
                //
                //   child:InkWell(
                //     onTap: onTap,
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
                //       child: Text(btnText,
                //           style: Theme.of(context).textTheme.headline6?.copyWith(
                //               color: Colors.white,
                //               fontSize: 16,
                //               fontWeight: FontWeight.bold)),
                //     ),
                //   ),
                //
                // )
              ],
            )),
          ),
        ),
      ),
    );
  }

  Future<bool?> getRatingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? status = prefs.getBool('rated');
    if (status == null) return false;

    return status;
  }

  void setRatedStatus() async {
    UserDatabaseHelper().cloudRateUs();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rated', true);
  }
}
