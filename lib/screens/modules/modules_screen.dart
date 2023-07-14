import 'package:dicecash/main.dart';
import 'package:dicecash/screens/modules/start_game.dart';
import 'package:dicecash/services/ModulesData.dart';
import 'package:dicecash/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ModulesScreen extends StatefulWidget {
  const ModulesScreen({key});

  @override
  State<ModulesScreen> createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen> {
  int completedChaps = 2;
  List chapterData = [
    {
      'name': 'Unit 1',
      'topic': 'The Money Mindset. Money 101',
      'coursesUnlocked': 1,
      'theoryLink': 'www.google.com'
    },
    {
      'name': 'Unit 2',
      'topic': 'Wealth Building, Independence',
      'coursesUnlocked': 1,
      'theoryLink': 'www.google.com'
    },
    {
      'name': 'Unit 1',
      'topic': 'The Money Mindset. Money 101',
      'coursesUnlocked': 1,
      'theoryLink': 'www.google.com'
    }
  ];

  @override
  void initState() {
    print(modulesDataChangeNotifier.questions);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Map> moduleDetails=modulesDataChangeNotifier.modulesData;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          title: const Text(
            "Money Basics💸",
            style: TextStyle(
                color: Colors.blue, fontSize: 22, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          // leading: const Text(''),
          automaticallyImplyLeading: true,
        ),

        // floatingActionButton: Visibility(
        //   child: FloatingActionButton(
        //     onPressed: () {},
        //   ),
        // ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            AnimatedBuilder(
                animation: modulesDataChangeNotifier,
                builder: (context, child) {
                  return Expanded(
                    child: PageView.builder(
                      itemCount: modulesDataChangeNotifier.modulesData?.length,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return pageViewCard(context, index);
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Container pageViewCard(BuildContext context, int index) {
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            // color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        modulesDataChangeNotifier.modulesData?[index]['name'],
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          modulesDataChangeNotifier.modulesData?[index]
                              ['topic'],
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => WebViewExample(
                            url: modulesDataChangeNotifier.modulesData?[index]
                                ['theoryLink'],
                            moduleName: modulesDataChangeNotifier
                                .modulesData?[index]['topic'],
                          ),
                        ));
                  },
                  child: BorderedContainer(
                    color: Colors.blue,
                    radius: 16,
                    child: Icon(
                      Icons.book,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
                  width: double.maxFinite,
                  color: Colors.white,
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: modulesDataChangeNotifier.chaptersData![
                                modulesDataChangeNotifier.modulesData?[index]
                                    ['topic']]
                            .map<Widget>((widgetMap) {
                          print(modulesDataChangeNotifier.modulesData?[index]
                                  ['topic'] +
                              ' ' +
                              widgetMap['name']);
                          return widgetMap['index'] % 2 == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: chapterCard(
                                      modulesDataChangeNotifier.questions![
                                          modulesDataChangeNotifier
                                                      .modulesData?[index]
                                                  ['topic'] +
                                              ' ' +
                                              widgetMap['name']],
                                      modulesDataChangeNotifier
                                              .modulesData?[index]['topic'] +
                                          ' ' +
                                          widgetMap['name'],
                                      modulesDataChangeNotifier
                                          .modulesData?[index]['topic'],
                                      widgetMap['index'],
                                      alignment: Alignment.topRight,
                                      index: widgetMap['index'],
                                      unlocked: widgetMap['unlocked']),
                                )
                              : chapterCard(
                                  modulesDataChangeNotifier.questions![
                                      modulesDataChangeNotifier
                                              .modulesData?[index]['topic'] +
                                          ' ' +
                                          widgetMap['name']],
                                  modulesDataChangeNotifier.modulesData?[index]
                                          ['topic'] +
                                      ' ' +
                                      widgetMap['name'],
                                  modulesDataChangeNotifier.modulesData?[index]
                                      ['topic'],
                                  widgetMap['index'],
                                  index: widgetMap['index'],
                                  unlocked: widgetMap['unlocked']);
                        }).toList(),
                        // [
                        //   SizedBox(
                        //     height: 10,
                        //   ),
                        //
                        //   Padding(
                        //     padding: const EdgeInsets.only(left: 40),
                        //     child: chapterCard(
                        //       alignment: Alignment.topLeft,
                        //       index: 1,
                        //     ),
                        //   ),
                        //   chapterCard(index: 2),
                        //   Padding(
                        //     padding: const EdgeInsets.only(right: 40),
                        //     child: chapterCard(
                        //         alignment: Alignment.topRight, index: 3),
                        //   ),
                        //   chapterCard(index: 4),
                        // ],
                      ),
                    ),
                  ))),
          Container(
            height: MediaQuery.of(context).size.height * 0.02,
            // color: Colors.grey,
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  Align chapterCard(
    List<Map> questionsDetails,
    String moduleAndChapterName,
    String moduleName,
    int chapterIndex, {
    AlignmentGeometry alignment = Alignment.center,
    int index = 0,
    bool unlocked = false,
  }) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Visibility(
              visible: unlocked,
              child: const SizedBox(
                height: 75,
                width: 75,
                child: CircularProgressIndicator(
                  value: 0.4,
                  strokeWidth: 8,
                  color: Colors.blue,
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: unlocked
                  ? FancyButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => StartGameScreen(
                                  questionsDetails,
                                  moduleAndChapterName,
                                  chapterIndex,
                                  moduleName),
                            ));
                      },
                      child: Icon(
                        Icons.star_rate_rounded,
                        color: Colors.white,
                        size: 35,
                      ),
                      size: 35,
                      circle: true,
                      color: Colors.blueAccent)
                  : FancyButton(
                      // onPressed: () {
                      //   print("Tapped on the button");
                      // },
                      child: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 35,
                      ),
                      size: 75,
                      circle: true,
                      color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class BorderedContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double radius;
  final double margin;
  final Color? containerColor;
  BorderedContainer({
    Key? key,
    required this.child,
    this.color,
    this.radius = 8,
    this.margin = 15,
    this.containerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: color ?? Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(radius),
        color: containerColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
