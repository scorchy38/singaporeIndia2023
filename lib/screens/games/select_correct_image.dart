import 'package:dicecash/services/ModulesData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../provider/select_correct_image_game.dart';
import '../modules/start_game.dart';

class SelectCorrectImageGame extends StatefulWidget {
  const SelectCorrectImageGame({
    Key? key,
    required this.questionsDetails,
    required this.moduleAndChapterName,
    required this.chapterIndex,
    required this.moduleName,
    required this.values,
    required this.answer,
  }) : super(key: key);

  final List<Map> questionsDetails;
  final String moduleAndChapterName;
  final int chapterIndex;
  final String moduleName;
  final List<String> values;
  final String answer;

  @override
  State<SelectCorrectImageGame> createState() => _SelectCorrectImageGameState();
}

class _SelectCorrectImageGameState extends State<SelectCorrectImageGame> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                    // Linear Progress Indicator
                    Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: [
                        FancyButton(
                          child: Container(
                            height: 12,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          size: 6,
                          circle: true,
                          color: Colors.grey,
                        ),
                        FancyButton(
                          child: Container(
                            height: 14,
                            width: MediaQuery.of(context).size.width *
                                0.8 *
                                (currentIndex) /
                                widget.questionsDetails.length,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 70, 222, 75),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          size: 10,
                          circle: true,
                          color: const Color.fromARGB(255, 70, 222, 75),
                        )
                        // Container(
                        //   height: 12,
                        //   width: MediaQuery.of(context).size.width * 0.8,
                        //   decoration: BoxDecoration(
                        //       color: Colors.grey,
                        //       borderRadius: BorderRadius.circular(12)),
                        // ),
                        // Container(
                        //   height: 14,
                        //   width:
                        //       MediaQuery.of(context).size.width * 0.7 * (0.5),
                        //   decoration: BoxDecoration(
                        //     color: Colors.blue,
                        //     borderRadius: BorderRadius.circular(12),
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topCenter,
                        //       end: Alignment.bottomCenter,
                        //       colors: [
                        //         Color.fromARGB(255, 70, 222, 75),
                        //         // Colors.green.shade400,
                        //         Colors.green.shade300,
                        //         // Colors.green.shade100,
                        //       ],
                        //     ),
                        //   ),
                        // )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Select the correct image",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FancyButton(
                      child: Icon(Icons.volume_up_rounded, size: 30),
                      size: 25,
                      onPressed: () async {
                        FlutterTts flutterTts = FlutterTts();
                        await flutterTts.setLanguage("en");
                        await flutterTts.speak(widget.questionsDetails[currentIndex]['name']);
                      },
                      color: Colors.blue.shade300),
                ),
                SizedBox(
                  width: 12,
                ),
                Tooltip(
                  message: widget.questionsDetails[currentIndex]['name'],
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 290,
                        child: Text(
                          widget.questionsDetails[currentIndex]['name'],
                          style: TextStyle(
                              color: Color.fromARGB(255, 214, 119, 231)),
                          maxLines: 2,
                          softWrap: true,

                        ),
                      ),
                      // Text(
                      //   "はい ",
                      //   style: TextStyle(
                      //       color: Color.fromARGB(255, 214, 119, 231)),
                      // )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: GridView.count(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    crossAxisCount: 2,
                    children: <Widget>[
                      CustomBorderedButton(
                          selected: context.watch<ImageSelect>().selected,
                          onpressed: () {
                            context.read<ImageSelect>().changeSelected(widget
                                .questionsDetails[currentIndex]['option1']);
                          },
                          name: widget.questionsDetails[currentIndex]
                              ['option1'],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                widget.questionsDetails[currentIndex]
                                    ['option1'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.blue
                                ),
                                // height: 100,
                                // width: 100,
                              ),
                            ),
                          )),
                      CustomBorderedButton(
                          selected: context.watch<ImageSelect>().selected,
                          onpressed: () {
                            context.read<ImageSelect>().changeSelected(widget
                                .questionsDetails[currentIndex]['option2']);
                          },
                          name: widget.questionsDetails[currentIndex]
                              ['option2'],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                widget.questionsDetails[currentIndex]
                                    ['option2'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.blue
                                ),
                                // height: 100,
                                // width: 100,
                              ),
                            ),
                          )),
                      CustomBorderedButton(
                          selected: context.watch<ImageSelect>().selected,
                          onpressed: () {
                            context.read<ImageSelect>().changeSelected(widget
                                .questionsDetails[currentIndex]['option3']);
                          },
                          name: widget.questionsDetails[currentIndex]
                              ['option3'],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                widget.questionsDetails[currentIndex]
                                    ['option3'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.blue
                                ),
                                // height: 100,
                                // width: 100,
                              ),
                            ),
                          )),
                      CustomBorderedButton(
                          selected: context.watch<ImageSelect>().selected,
                          onpressed: () {
                            context.read<ImageSelect>().changeSelected(widget
                                .questionsDetails[currentIndex]['option4']);
                          },
                          name: widget.questionsDetails[currentIndex]
                              ['option4'],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:Center(
                              child: Text(
                                widget.questionsDetails[currentIndex]
                                    ['option4'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.blue
                                ),
                                // height: 100,
                                // width: 100,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: FancyButton(
              width: MediaQuery.of(context).size.width,
              center: true,
              child: Text(
                "Check",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  // fontFamily: 'Gameplay',
                ),
              ),
              size: 35,
              color: context.watch<ImageSelect>().selected == null
                  ? Colors.grey
                  : Color.fromARGB(255, 70, 222, 75),
              onPressed: context.watch<ImageSelect>().selected == null
                  ? null
                  : () {
                      // Navigator.push(
                      //     context,
                      //     CupertinoPageRoute(
                      //       builder: (context) =>
                      //           const WhatToLearnScreen(),
                      //     ));

                      // showAnswer(
                      //   context,
                      // );

                      bool correct = context
                              .read<ImageSelect>()
                              .selected!
                              .trim()
                              .toLowerCase() ==
                          widget.questionsDetails[currentIndex]['answer']
                              .trim()
                              .toLowerCase();
                      showModalBottomSheet<void>(
                        context: context,
                        isDismissible: false,
                        backgroundColor: Color(0xFF263238),
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: correct
                                          ? Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 30,
                                            )
                                          : Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                    ),
                                    Text(
                                      correct ? 'Great Job' : "Incorrect",
                                      style: TextStyle(
                                          color: correct
                                              ? Colors.green
                                              : Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "Correct Answer:\n ${widget.questionsDetails[currentIndex]['answer']}",
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            correct ? Colors.green : Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 22,
                                      left: 8,
                                      right: 8,
                                      top: 8,
                                    ),
                                    child: FancyButton(
                                      width: MediaQuery.of(context).size.width,
                                      center: true,
                                      child: Text(
                                        correct ? "Continue" : "Got it",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          // fontFamily: 'Gameplay',
                                        ),
                                      ),
                                      size: 35,
                                      color: correct
                                          ? Color.fromARGB(255, 70, 222, 75)
                                          : Colors.red,
                                      onPressed: () {
                                        if (correct) {
                                          setState(() {
                                            if (currentIndex ==
                                                widget.questionsDetails.length -
                                                    1) {
                                              modulesDataChangeNotifier
                                                  .unlockNextChapter(
                                                      widget.chapterIndex + 1,
                                                      widget.moduleName);
                                              print(modulesDataChangeNotifier
                                                  .chaptersData);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            } else {
                                              modulesDataChangeNotifier
                                                  .setQuestionToAnswered(
                                                      widget
                                                          .moduleAndChapterName,
                                                      currentIndex);
                                              print(modulesDataChangeNotifier
                                                      .questions![
                                                  widget.moduleAndChapterName]);
                                              currentIndex++;
                                              Navigator.pop(context);
                                            }
                                          });
                                        } else {
                                          Navigator.pop(context);
                                        }
                                        // Navigator.push(
                                        //     context,
                                        //     CupertinoPageRoute(
                                        //       builder: (context) =>
                                        //           const WhatToLearnScreen(),
                                        //     ));
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
            ),
          ),
        ),
      ],
    );
  }
}
