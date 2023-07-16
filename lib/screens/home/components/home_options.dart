import 'dart:math';
import 'package:dicecash/screens/game/components/main_game.dart';
import 'package:dicecash/screens/modules/modules_screen.dart';
import 'package:dicecash/screens/surveys/components/item_tile.dart';
import 'package:dicecash/services/ModulesData.dart';
import 'package:dicecash/services/current_user_change_notifier.dart';
import 'package:dicecash/services/data_streams/user_stream.dart';
import 'package:dicecash/services/database/user_database_helper.dart';
import 'package:dicecash/spinWheel/spin_wheel.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/constants/constants.dart';
import '../../../models/User.dart';
import '../../../services/authentication/authentication_service.dart';
import '../../../webview.dart';
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
        "name": "Unit 1",
        "topic": "Financial Planning for Life Milestones",
        "coursesUnlocked": 1,
        "theoryLink": "https://foil-part-a58.notion.site/Course-Financial-Planning-for-Life-Milestones-c4d75f8fae004c38b89d854911eda1c3?pvs=4",
      },
      {
        "name": "Unit 2",
        "topic": "Fundamentals of Personal Finance",
        "coursesUnlocked": 0,
        "theoryLink": "https://foil-part-a58.notion.site/Course-Financial-Planning-for-Life-Milestones-c4d75f8fae004c38b89d854911eda1c3?pvs=4",
      },
    ]);
    modulesDataChangeNotifier.setChapters({
      "Financial Planning for Life Milestones": [
        {
          "name": "Introduction to Financial Planning",
          "index": 0,
          "unlocked": true,
        },
        {
          "name": "Managing Personal Finances",
          "index": 1,
          "unlocked": false,
        },
        {
          "name": "Saving and Investing",
          "index": 2,
          "unlocked": false,
        },
        {
          "name": "Insurance and Risk Management",
          "index": 3,
          "unlocked": false,
        },
        {
          "name": "Financial Planning for Education",
          "index": 4,
          "unlocked": false,
        },
        {
          "name": "Financial Planning for Career Development",
          "index": 5,
          "unlocked": false,
        },
        {
          "name": "Planning for Major Purchases",
          "index": 6,
          "unlocked": false,
        },
        {
          "name": "Retirement Planning",
          "index": 7,
          "unlocked": false,
        },
        {
          "name": "Estate Planning",
          "index": 8,
          "unlocked": false,
        },
        {
          "name": "Financial Planning for Life Transitions",
          "index": 9,
          "unlocked": false,
        },
        {
          "name": "Behavioral Finance and Psychology of Money",
          "index": 10,
          "unlocked": false,
        },
        {
          "name": "Putting It All Together",
          "index": 11,
          "unlocked": false,
        },
      ],
      "Fundamentals of Personal Finance": [
        {
          "name": "Chapter 1",
          "index": 0,
          "unlocked": true,
        },
        {
          "name": "Chapter 2",
          "index": 1,
          "unlocked": false,
        },
        {
          "name": "Chapter 3",
          "index": 2,
          "unlocked": false,
        },
      ],
    });
    modulesDataChangeNotifier.setQuestions({
      "Financial Planning for Life Milestones Introduction to Financial Planning": [
        {
          "name": "What is the purpose of financial planning?",
          "index": 0,
          "unlocked": false,
          "option1": "Control",
          "option1Image": "assets/water.png",
          "option2": "Flexibility",
          "option2Image": "assets/sushi.png",
          "option3": "Security",
          "option3Image": "assets/rice.png",
          "option4": "Entertainment",
          "option4Image": "assets/tea.png",
          "answer": "Security",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Why is it important to set specific financial goals?",
          "index": 1,
          "unlocked": false,
          "option1": "To limit progress",
          "option1Image": "assets/images/board.png",
          "option2": "To enhance decision-making",
          "option2Image": "assets/sushi.png",
          "option3": "To discourage savings",
          "option3Image": "assets/rice.png",
          "option4": "To increase debt",
          "option4Image": "assets/tea.png",
          "answer": "To enhance decision-making",
          "answerImage": "assets/images/board.png",
        },
        {
          "name": "What is the first step in assessing your financial situation?",
          "unlocked": false,
          "index": 2,
          "option1": "Tracking income",
          "option1Image": "assets/water.png",
          "option2": "Analyzing expenses",
          "option2Image": "assets/sushi.png",
          "option3": "Evaluating assets",
          "option3Image": "assets/rice.png",
          "option4": "Listing liabilities",
          "option4Image": "assets/tea.png",
          "answer": "Tracking income",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Budgeting helps individuals:",
          "unlocked": false,
          "index": 3,
          "option1": "Spend recklessly",
          "option1Image": "assets/water.png",
          "option2": "Increase debt",
          "option2Image": "assets/sushi.png",
          "option3": "Monitor income and expenses",
          "option3Image": "assets/rice.png",
          "option4": "Decrease savings",
          "option4Image": "assets/tea.png",
          "answer": "Monitor income and expenses",
          "answerImage": "assets/water.png",
        },
        {
          "name": "What does a financial planning mindset entail?",
          "index": 4,
          "unlocked": false,
          "option1": "Short-term thinking",
          "option1Image": "assets/water.png",
          "option2": "Impulsive decisions",
          "option2Image": "assets/sushi.png",
          "option3": "Long-term thinking",
          "option3Image": "assets/rice.png",
          "option4": "Indifference towards finances",
          "option4Image": "assets/tea.png",
          "answer": "Long-term thinking",
          "answerImage": "assets/water.png",
        },
      ],
      "Financial Planning for Life Milestones Managing Personal Finances": [
        {
          "name": "Cash flow management involves:",
          "index": 0,
          "unlocked": false,
          "option1": "Maximizing expenses",
          "option1Image": "assets/water.png",
          "option2": "Controlling income",
          "option2Image": "assets/sushi.png",
          "option3": "Balancing income and expenses",
          "option3Image": "assets/rice.png",
          "option4": "Ignoring financial statements",
          "option4Image": "assets/tea.png",
          "answer": "Balancing income and expenses",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Which is NOT a characteristic of effective financial planning?",
          "index": 1,
          "unlocked": false,
          "option1": "Procrastination",
          "option1Image": "assets/water.png",
          "option2": "Organization",
          "option2Image": "assets/sushi.png",
          "option3": "Setting goals",
          "option3Image": "assets/rice.png",
          "option4": "Regular monitoring",
          "option4Image": "assets/tea.png",
          "answer": "Procrastination",
          "answerImage": "assets/water.png",
        },
        {
          "name": "How does financial planning contribute to reducing financial stress?",
          "unlocked": false,
          "index": 2,
          "option1": "Providing a sense of control",
          "option1Image": "assets/water.png",
          "option2": "Encouraging impulsive spending",
          "option2Image": "assets/sushi.png",
          "option3": "Increasing debt burden",
          "option3Image": "assets/rice.png",
          "option4": "Generating uncertainty",
          "option4Image": "assets/tea.png",
          "answer": "Providing a sense of control",
          "answerImage": "assets/water.png",
        },
        {
          "name": "What does debt management involve?",
          "unlocked": false,
          "index": 3,
          "option1": "Accumulating debt",
          "option1Image": "assets/water.png",
          "option2": "Managing and reducing debt",
          "option2Image": "assets/sushi.png",
          "option3": "Ignoring debt obligations",
          "option3Image": "assets/rice.png",
          "option4": "Increasing credit utilization",
          "option4Image": "assets/tea.png",
          "answer": "Managing and reducing debt",
          "answerImage": "assets/water.png",
        },
        {
          "name": "What is the purpose of a budget?",
          "index": 4,
          "unlocked": false,
          "option1": "Tracking savings only",
          "option1Image": "assets/water.png",
          "option2": "Limiting financial growth",
          "option2Image": "assets/sushi.png",
          "option3": "Planning and tracking income and expenses",
          "option3Image": "assets/rice.png",
          "option4": "Increasing expenses",
          "option4Image": "assets/tea.png",
          "answer": "Planning and tracking income and expenses",
          "answerImage": "assets/water.png",
        },
      ],
      "Financial Planning for Life Milestones Saving and Investing": [
        {
          "name": "Su shi",
          "index": 0,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 1,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 3,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 4,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
      "Financial Planning for Life Milestones Insurance and Risk Management": [
        {
          "name": "Su shi",
          "index": 0,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 1,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 3,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 4,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
      "Financial Planning for Life Milestones Financial Planning for Education": [
        {
          "name": "Su shi",
          "index": 0,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 1,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 3,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 4,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
      "Financial Planning for Life Milestones Financial Planning for Career Development": [
        {
          "name": "Su shi",
          "index": 0,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 1,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 3,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 4,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
      "Financial Planning for Life Milestones Planning for Major Purchases": [
        {
          "name": "Su shi",
          "index": 0,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 1,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 3,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 4,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
      "Financial Planning for Life Milestones Retirement Planning": [
        {
          "name": "Su shi",
          "index": 0,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 1,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 3,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 4,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
      "Financial Planning for Life Milestones Estate Planning": [
        {
          "name": "Su shi",
          "index": 0,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 1,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 3,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 4,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
      "Financial Planning for Life Milestones Financial Planning for Life Transitions": [
        {
          "name": "Su shi",
          "index": 0,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 1,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 3,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 4,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
      "Financial Planning for Life Milestones Behavioral Finance and Psychology of Money": [
        {
          "name": "Su shi",
          "index": 0,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 1,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 3,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 4,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
      "Financial Planning for Life Milestones Putting It All Together": [
        {
          "name": "Su shi",
          "index": 0,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 1,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 3,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "index": 4,
          "unlocked": false,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
      "Fundamentals of Personal Finance Chapter 1": [
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 0,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 1,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
      "Fundamentals of Personal Finance Chapter 2": [
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 0,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 1,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
      "Fundamentals of Personal Finance Chapter 3": [
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 0,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 1,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
        {
          "name": "Su shi",
          "unlocked": false,
          "index": 2,
          "option1": "Water",
          "option1Image": "assets/water.png",
          "option2": "Sushi",
          "option2Image": "assets/sushi.png",
          "option3": "Rice",
          "option3Image": "assets/rice.png",
          "option4": "Tea",
          "option4Image": "assets/tea.png",
          "answer": "Sushi",
          "answerImage": "assets/water.png",
        },
      ],
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
    Map<String, List<SurveyTile>> courseRecomm = {
      'Just a kid' : [SurveyTile(
          'Profit & Loss', 'FinSavvy Kids 101', 'assets/images/nav.png',
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ModulesScreen()));
          }),
        SurveyTile(
            'Spending and Saving', 'One less candy a day', 'assets/images/ind.png',
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ModulesScreen()));
            }),],
      'I go to school/college' : [SurveyTile(
          'Financial Independence', 'Achieve & Maintain', 'assets/images/ind.png',
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ModulesScreen()));
          }),
        SurveyTile(
            'Savings & Microinvestments', 'Savings, Investing 101', 'assets/images/nav.png',
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ModulesScreen()));
            }),],
      'I am a professional' : [SurveyTile(
          'Insurance & Investing', 'Investing 101, Retirement', 'assets/images/retire.png',
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ModulesScreen()));
          }),
        SurveyTile(
            'Finance Goal Planning', 'Rainy Day, Materials', 'assets/images/retire.png',
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ModulesScreen()));
            }),],
      'I am a home maker/house wife' : [SurveyTile(
          'Small Businesses', 'Earning, Growth', 'assets/images/retire.png',
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ModulesScreen()));
          }),
        SurveyTile(
            'Grow Your Gold', 'Gold Investing, Commodities', 'assets/images/retire.png',
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ModulesScreen()));
            }),],
      'I am retired' : [SurveyTile(
          'Retirement Planning', 'Healthcare, Retirement', 'assets/images/retire.png',
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ModulesScreen()));
          }),
        SurveyTile(
            'Wealth & Children', 'Wills, Charities', 'assets/images/retire.png',
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ModulesScreen()));
            }),],
      'Other' : [SurveyTile(
          'Insurance & Investing', 'Investing 101, Retirement', 'assets/images/retire.png',
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ModulesScreen()));
          }), SurveyTile(
          'Insurance & Investing', 'Investing 101, Retirement', 'assets/images/retire.png',
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ModulesScreen()));
          }),],

    };

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
                        Text("Suggested For You",
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
                       courseRecomm[snapshot.data?.wyd]![0],
                       courseRecomm[snapshot.data?.wyd]![1],
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
                            'Find The Right ',
                            'SERVICE',
                            'Go now',
                            'assets/images/diceLogo.png',
                            '📒', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                   WebViewExample(url: 'https://foil-part-a58.notion.site/Yellow-Pages-Ideas-eb1d2be4a7d14e7d876eb359fe8096b8?pvs=4', moduleName: 'Third Party Services',)));
                        }),
                        optionCard(
                          AppColors.primary,
                          'SheFi Product',
                          'OF THE DAY',
                          'Watch Now',
                          'assets/images/coin.png',
                          '🤑',
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
                                  '⭐⭐⭐⭐', () async {
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
                                  'INCENTIVES OF',
                                  'Go Now',
                                  'assets/images/playstore.png',
                                  'Upto \$ 2 ', () {
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
