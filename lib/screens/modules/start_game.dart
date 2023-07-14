import 'package:dicecash/main.dart';
import 'package:dicecash/provider/select_correct_image_game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../games/select_correct_image.dart';
import 'modules_screen.dart';

class StartGameScreen extends StatefulWidget {
  const StartGameScreen(this.questionsDetails, this.moduleAndChapterName,
      this.chapterIndex, this.moduleName,
      {key});
  final List<Map> questionsDetails;
  final String moduleAndChapterName;
  final String moduleName;
  final int chapterIndex;

  @override
  State<StartGameScreen> createState() => _StartGameScreenState();
}

class _StartGameScreenState extends State<StartGameScreen> {
  // String? selected;
  String answer = "Sushi";
  List<String> values = ["water", "sushi", "rice", "tea"];
  TextEditingController textcontroller = TextEditingController();
  bool selected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ImageSelect>().initializeEverything();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child: SizedBox(
            //     height: 40,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         InkWell(
            //           onTap: () {
            //             Navigator.pop(context);
            //           },
            //           child: const Icon(
            //             Icons.arrow_back_rounded,
            //             size: 40,
            //             color: Colors.grey,
            //           ),
            //         ),
            //         // Linear Progress Indicator
            //         Stack(
            //           alignment: AlignmentDirectional.centerStart,
            //           children: [
            //             FancyButton(
            //               child: Container(
            //                 height: 12,
            //                 width: MediaQuery.of(context).size.width * 0.8,
            //                 decoration: BoxDecoration(
            //                     color: Colors.grey,
            //                     borderRadius: BorderRadius.circular(12)),
            //               ),
            //               size: 6,
            //               circle: true,
            //               color: Colors.grey,
            //             ),
            //             FancyButton(
            //               child: Container(
            //                 height: 14,
            //                 width:
            //                     MediaQuery.of(context).size.width * 0.7 * (0.5),
            //                 decoration: BoxDecoration(
            //                     color: const Color.fromARGB(255, 70, 222, 75),
            //                     borderRadius: BorderRadius.circular(12)),
            //               ),
            //               size: 10,
            //               circle: true,
            //               color: const Color.fromARGB(255, 70, 222, 75),
            //             )
            //             // Container(
            //             //   height: 12,
            //             //   width: MediaQuery.of(context).size.width * 0.8,
            //             //   decoration: BoxDecoration(
            //             //       color: Colors.grey,
            //             //       borderRadius: BorderRadius.circular(12)),
            //             // ),
            //             // Container(
            //             //   height: 14,
            //             //   width:
            //             //       MediaQuery.of(context).size.width * 0.7 * (0.5),
            //             //   decoration: BoxDecoration(
            //             //     color: Colors.blue,
            //             //     borderRadius: BorderRadius.circular(12),
            //             //     gradient: LinearGradient(
            //             //       begin: Alignment.topCenter,
            //             //       end: Alignment.bottomCenter,
            //             //       colors: [
            //             //         Color.fromARGB(255, 70, 222, 75),
            //             //         // Colors.green.shade400,
            //             //         Colors.green.shade300,
            //             //         // Colors.green.shade100,
            //             //       ],
            //             //     ),
            //             //   ),
            //             // )
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectCorrectImageGame(
                moduleAndChapterName: widget.moduleAndChapterName,
                moduleName: widget.moduleName,
                chapterIndex: widget.chapterIndex,
                values: values,
                answer: answer,
                questionsDetails: widget.questionsDetails,
              ),
              // child: ImageToTextGame(values: values, textcontroller: textcontroller, answer: answer),
              // child: Column(children: [
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: const Text(
              //       "Tap the matching pair",
              //       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              //   MatchPairsCards(),
              //   MatchPairsCards(),
              //   MatchPairsCards(),
              //   MatchPairsCards(),
              // ]),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> showAnswer(BuildContext context) {
    bool correct = context.watch<ImageSelect>().selected == answer;
    // bool correct = true;
    return showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      backgroundColor: const Color(0xFF263238),
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
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 30,
                          )
                        : const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 30,
                          ),
                  ),
                  Text(
                    correct ? 'Great Job' : "Incorrect",
                    style: TextStyle(
                        color: correct ? Colors.green : Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Correct Answer:\n $answer",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                      color: correct ? Colors.green : Colors.red,
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
                      style: const TextStyle(
                        fontSize: 18,
                        // fontFamily: 'Gameplay',
                      ),
                    ),
                    size: 35,
                    color: correct
                        ? const Color.fromARGB(255, 70, 222, 75)
                        : Colors.red,
                    onPressed: () {
                      if (correct) {
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
  }
}

class MatchPairsCards extends StatefulWidget {
  const MatchPairsCards({
    Key? key,
  }) : super(key: key);

  @override
  State<MatchPairsCards> createState() => _MatchPairsCardsState();
}

class _MatchPairsCardsState extends State<MatchPairsCards> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: BorderedContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Text("Sushi"),
        ),
        margin: 0,
        color: selected ? Colors.blue : null,
        containerColor: selected ? Colors.blue.withOpacity(0.2) : null,
      ),
    );
  }
}

class ImageToTextGame extends StatelessWidget {
  const ImageToTextGame({
    Key? key,
    required this.values,
    required this.textcontroller,
    required this.answer,
    required this.chapterDetails,
  }) : super(key: key);

  final List<String> values;
  final TextEditingController textcontroller;
  final String answer;
  final Map chapterDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Translate the word",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        CustomBorderedButton(
            selected: context.watch<ImageSelect>().selected,
            onpressed: () {
              // context.read<ImageSelect>().changeSelected(values[0]);
            },
            name: values[0],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/water.png",
                    height: 150,
                    width: 150,
                  ),
                ),
                const Text(
                  "Water",
                  // style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(14)),
            child: TextField(
              controller: textcontroller,
              decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  fillColor: const Color.fromARGB(255, 83, 110, 123),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    // borderSide: BorderSide(
                    //   color: Colors.white,
                    //   width: 4,
                    // ),
                    borderSide: BorderSide.none,
                  )),
            ),
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: FancyButton(
              width: MediaQuery.of(context).size.width,
              center: true,
              child: const Text(
                "Check",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  // fontFamily: 'Gameplay',
                ),
              ),
              size: 35,
              color: const Color.fromARGB(255, 70, 222, 75),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     CupertinoPageRoute(
                //       builder: (context) =>
                //           const WhatToLearnScreen(),
                //     ));

                // showAnswer(
                //   context,
                // );

                bool correct = textcontroller.text.trim().toLowerCase() ==
                    answer.toLowerCase();
                showModalBottomSheet<void>(
                  context: context,
                  isDismissible: false,
                  backgroundColor: const Color(0xFF263238),
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
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                              ),
                              Text(
                                correct ? 'Great Job' : "Incorrect",
                                style: TextStyle(
                                    color: correct ? Colors.green : Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Correct Answer:\n $answer",
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: correct ? Colors.green : Colors.red,
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
                                  style: const TextStyle(
                                    fontSize: 18,
                                    // fontFamily: 'Gameplay',
                                  ),
                                ),
                                size: 35,
                                color: correct
                                    ? const Color.fromARGB(255, 70, 222, 75)
                                    : Colors.red,
                                onPressed: () {
                                  if (correct) {
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

class CustomBorderedButton extends StatelessWidget {
  const CustomBorderedButton({
    Key? key,
    this.selected,
    this.name,
    required this.child,
    required this.onpressed,
  }) : super(key: key);
  final String? selected;
  final String? name;
  final Widget child;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onpressed,
        child: Container(
            // margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                color: selected == name
                    ? Colors.blue.withOpacity(0.2)
                    : Colors.transparent,
                border: Border.all(
                  color: selected == name ? Colors.blue : Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: child),
      ),
    );
  }
}

class FancyButton extends StatefulWidget {
  const FancyButton({
    Key? key,
    required this.child,
    required this.size,
    required this.color,
    this.duration = const Duration(milliseconds: 160),
    this.onPressed,
    this.height,
    this.width,
    this.center = false,
    this.circle,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final Duration duration;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final bool? center;

  final double size;
  final bool? circle;

  @override
  _FancyButtonState createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _pressedAnimation;

  late TickerFuture _downTicker;

  double get buttonDepth => widget.size * 0.2;

  void _setupAnimation() {
    _animationController?.stop();
    final oldControllerValue = _animationController!.value;
    _animationController!.dispose();
    _animationController = AnimationController(
      duration: Duration(microseconds: widget.duration.inMicroseconds ~/ 2),
      vsync: this,
      value: oldControllerValue,
    );
    _pressedAnimation = Tween<double>(begin: -buttonDepth, end: 0.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(FancyButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _setupAnimation();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setupAnimation();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(microseconds: widget.duration.inMicroseconds ~/ 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    if (widget.onPressed != null) {
      _downTicker = _animationController!.animateTo(1.0);
    }
  }

  void _onTapUp(_) {
    if (widget.onPressed != null) {
      _downTicker.whenComplete(() {
        _animationController!.animateTo(0.0);
        widget.onPressed?.call();
      });
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null) {
      _animationController!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    var vertPadding =
        widget.circle == true ? widget.size * 0.25 : widget.size * 0.25;
    var horzPadding =
        widget.circle == true ? widget.size * 0.25 : widget.size * 0.50;
    var radius = widget.circle == true
        ? BorderRadius.circular(1000)
        : BorderRadius.circular(horzPadding * 0.5);

    return Container(
      height: widget.height,
      width: widget.width,
      padding: widget.onPressed != null
          ? EdgeInsets.only(bottom: 2, left: 0.5, right: 0.5)
          : null,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: radius,
      ),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: IntrinsicWidth(
          child: IntrinsicHeight(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: _hslRelativeColor(s: -0.20, l: -0.20),
                    borderRadius: radius,
                  ),
                ),
                AnimatedBuilder(
                  animation: _pressedAnimation!,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(0.0, _pressedAnimation!.value),
                      child: child,
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: radius,
                        child: Stack(
                          children: <Widget>[
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: _hslRelativeColor(l: 0.06),
                                borderRadius: radius,
                              ),
                              child: SizedBox.expand(),
                            ),
                            Transform.translate(
                              offset: Offset(0.0, vertPadding * 2),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: _hslRelativeColor(),
                                  borderRadius: radius,
                                ),
                                child: SizedBox.expand(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: vertPadding,
                          horizontal: horzPadding,
                        ),
                        child: widget.center == true
                            ? Center(child: widget.child)
                            : widget.child,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _hslRelativeColor({double h = 0.0, s = 0.0, l = 0.0}) {
    final hslColor = HSLColor.fromColor(widget.color);
    h = (hslColor.hue + h).clamp(0.0, 360.0);
    s = (hslColor.saturation + s).clamp(0.0, 1.0);
    l = (hslColor.lightness + l).clamp(0.0, 1.0);
    return HSLColor.fromAHSL(hslColor.alpha, h, s, l).toColor();
  }
}
