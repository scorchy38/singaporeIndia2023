import 'package:dicecash/core/constants/app_colors.dart';
import 'package:dicecash/screens/surveys/components/webview.dart';
import 'package:dicecash/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';


import '../modules/modules_screen.dart';
import 'components/item_tile.dart';

// Pollfish basic configuration options
const String androidApiKey = '4c6e23e5-77d2-461d-95c7-6a0e20be6743';
const bool releaseMode = false;
class Course {
  final String title;
  final String description;

  Course(this.title, this.description);
}
class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Course> _courses = [
    Course('Women & Personal Finance', 'Understanding the basics of personal finance and investment.'),
    Course('Retirement Planning for Women', 'How to plan for a secure retirement, considering the specific challenges faced by women.'),
    Course('Investing for Women', 'Mastering the principles of investing, with a focus on strategies that fit women\'s unique needs.'),
    Course('Financial Independence for Women', 'Learn how to achieve and maintain financial independence.'),
    Course('Entrepreneurship for Women', 'Learn the finance fundamentals necessary to start and run a successful business.'),
    Course('Women & Real Estate Investment', 'Understand the basics of real estate investing and how to build a profitable portfolio.'),
    Course('Navigating the Gender Wage Gap', 'Strategies to negotiate for fair pay and work towards closing the gender wage gap.'),
    Course('Insurance for Women', 'Understanding the importance of different types of insurance and how they can protect you and your family.'),
    Course('Estate Planning for Women', 'How to plan for the future to ensure your assets are handled according to your wishes.'),
    Course('Financial Literacy for Young Women', 'A course designed to help young women understand and manage their finances early on.')
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: const Text("Courses📘️", style: TextStyle(
          color: Colors.blue,
          fontSize: 22,
          fontWeight: FontWeight.w700
        ),),
        centerTitle: true,
        // leading: const Text(''),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Recommended Tracks for You",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: AppColors.primary, fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                  ),
                  children: [
                    SurveyTile('Money Basics for Women', 'Mindset, Wealth Building',
                        'assets/images/money.png', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ModulesScreen()));
                    }),
                    SurveyTile(
                        'Insurance & Investing', 'Investing 101, Retirement', 'assets/images/retire.png',
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ModulesScreen()));
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("All Tracks",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: AppColors.primary, fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                  ),
                  children: [
                    SurveyTile('Financial Independence', 'Achieve and Maintain',
                        'assets/images/ind.png', () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ModulesScreen()));
                    }, scale: 1.0,),
                    SurveyTile(
                        'Navigating the Gender Wage Gap', 'Negotiate for a Fair Pay', 'assets/images/nav.png',
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ModulesScreen()));
                    },),
                    SurveyTile('Money Basics for Women', 'Mindset, Wealth Building',
                        'assets/images/money.png', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ModulesScreen()));
                        }),
                    SurveyTile(
                        'Insurance & Investing', 'Investing 101, Retirement', 'assets/images/retire.png',
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ModulesScreen()));
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }



  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Text findCurrentTitle(int currentIndex) {
    if (_currentIndex == 0) {
      return const Text('Pollfish Rewarded Integration');
    } else {
      return const Text('Pollfish Offerwall Integration');
    }
  }

  // Pollfish notification functions


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
}
