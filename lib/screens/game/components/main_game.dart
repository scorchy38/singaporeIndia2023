// import 'dart:html';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:dicecash/services/gold_change_notifier.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/constants.dart';
import '../../../models/User.dart';
import '../../../services/data_streams/user_stream.dart';
import '../../../services/database/user_database_helper.dart';
import 'cell.dart';
import 'cell_widget.dart';

class FoodSuggestions extends StatefulWidget {
  const FoodSuggestions({
    Key? key,
  }) : super(key: key);

  @override
  State<FoodSuggestions> createState() => _FoodSuggestionsState();
}

class _FoodSuggestionsState extends State<FoodSuggestions>
    with SingleTickerProviderStateMixin {
  var size = 3;
  var cells = [];
  var totalCellsRevealed = 0;
  int leftDiceNumber = 1;
  int firstDice = 1;
  int secondDice = 1;
  AnimationController? _controller;
  CurvedAnimation? animation;
  int rolls = 0;
  int count = 0;
  CellModel cell1 = CellModel(0, 0);
  final UserStream userStream = UserStream();
  String widgetToShow = 'Still';
  GlobalKey centerKey = GlobalKey(); // declare a global key


  void generateGrid() {
    cells = [];
    totalCellsRevealed = 0;

    for (int i = 0; i < size; i++) {
      var row = [];
      for (int j = 0; j < size; j++) {
        final cell = CellModel(i, j);
        row.add(cell);
      }
      cells.add(row);
    }

    for (int i = 0; i < cells.length; ++i) {
      for (int j = 0; j < cells[i].length; ++j) {
        cells[i][j].value = Random().nextInt(20);
      }
    }
  }

  Widget buildButton(CellModel cell) {
    return (cell.x == 1 && cell.y == 1)
        ? GestureDetector(
            onTap: () {
              AssetsAudioPlayer.newPlayer().open(
                Audio("assets/audios/diceSound.mp3"),
                autoStart: true,
                showNotification: false,
              );
              roll;
            },
            child: CellWidget(
              size: size,
              cell: cell,
              key: centerKey,
            ),
          )
        : GestureDetector(
            onTap: () {
              roll;
            },
            child: CellWidget(
              size: size,
              cell: cell,
              key: const Key('key'),
            ),
          );
  }

  Widget buildDice2Button(CellModel cell, int tickets) {
    return Center(
      child: GestureDetector(
        onDoubleTap: () => roll(tickets),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Image(
              height: 150 - (animation?.value)! * 50,
              image: AssetImage('assets/dice/dice-png-$leftDiceNumber.png'),
            ),
          ),
        ),
      ),
    );
  }

  Row buildButtonRow(int column) {
    List<Widget> list = [];
    for (int i = 0; i < size; i++) {
      list.add(
        Expanded(
          child: buildButton(cells[i][column]),
        ),
      );
    }

    return Row(
      children: list,
    );
  }

  late AnimationController lottieController;

  Widget buildButtonColumn(int tickets, BuildContext context, UserData user) {
    List<Widget> rows = [];
    double y = 0;
    double x = 0;
    bool loading = false;
    for (int i = 0; i < size; i++) {
      rows.add(
        buildButtonRow(i),
      );
    }
    print(MediaQuery.of(context).size.width);

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(user.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    DocumentSnapshot<Map<String, dynamic>>? item =
                        snapshot.data;

                    return Card(
                      elevation: 3,
                      color: AppColors.primary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Container(
                          height: 30,
                          // width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("${item!.get('tickets')} 🎟",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.039,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                // width: 70,
                                child: AnimatedBuilder(
                                  animation: goldChangeNotifier,
                                  builder: (context, child) {
                                    return Center(
                                      child: Text("${item!.get('coins')} 🥇",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                    );
                                  },
                                ),
                                // child: StreamBuilder<
                                //         DocumentSnapshot<Map<String, dynamic>>>(
                                //     stream: UserDatabaseHelper().currentUserDataStream,
                                //     builder: (context, snapshot) {
                                //       if (!snapshot.hasData) return Container();
                                //       UserData userData = UserData.fromMap(
                                //           snapshot.data!.data(),
                                //           id: snapshot.data!.id);
                                //       return Center(
                                //         child: Text("${userData.gold} 🪙",
                                //             style: Theme.of(context)
                                //                 .textTheme
                                //                 .headline6
                                //                 ?.copyWith(
                                //                     color: Colors.white,
                                //                     fontWeight: FontWeight.bold)),
                                //       );
                                //     }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
            // Card(
            //   elevation: 3,
            //   color: Colors.deepPurple,
            //   child: Container(
            //     height: 55,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20.0),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Column(
            //             children: [
            //               Text("First Roll Number",
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .headline6
            //                       ?.copyWith(
            //                           fontSize: 16, color: Colors.white)),
            //               Text(firstDice.toString(),
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .headline6
            //                       ?.copyWith(
            //                           fontSize: 16, color: Colors.white)),
            //             ],
            //           ),
            //           Column(
            //             children: [
            //               Text("Second Roll Number",
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .headline6
            //                       ?.copyWith(
            //                           fontSize: 16, color: Colors.white)),
            //               Text(secondDice.toString(),
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .headline6
            //                       ?.copyWith(
            //                           fontSize: 16, color: Colors.white)),
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Column(
              children: rows,
            ),
            // Expanded(
            //   child: buildDice2Button(cell1, tickets),
            // ),
            Spacer(),
            const SizedBox(
              height: 0,
            ),
          ],
        ),
        AnimatedPositioned(
          left: x + MediaQuery.of(context).size.width * 0.085,
          top: y + MediaQuery.of(context).size.height * 0.45,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: GestureDetector(
            onTap: () async {
              if (user.tickets > 0) {
                // print(widgetToShow);
                if (widgetToShow == 'Collect') {
                  print(cell1.value);
                  await UserDatabaseHelper().cloudGoldSurge(cell1.value);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return FutureProgressDialog(
                        Future.delayed(const Duration(milliseconds: 2000)),
                        message: const Text("Request Processing..."),
                      );
                    },
                  );

// Here you can write your code
                  Future.delayed(const Duration(milliseconds: 2000), () async {
// Here you can write your code
                    goldChangeNotifier.setMethod();
                    goldChangeNotifier.notifyListeners();
                    setState(() {});
                    setState(() {
                      print(';;');
                      // UserDatabaseHelper().updateGold(cell1.value);

                      Fluttertoast.showToast(
                          msg: "Reward Collected!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 16.0);
                    });
                    setState(() {});
                    setState(() {
                      loading = false;
                    });
                    setState(() {
                      widgetToShow = 'Stable';
                    });
                    setState(() {
                      firstDice = 1;
                      secondDice = 1;
                    });

                    restart();
                  });

//                   Future.delayed(const Duration(milliseconds: 2000),
//                           () async {
// // Here you can write your code
//                         goldChangeNotifier.setMethod();
//                         goldChangeNotifier.notifyListeners();
//                         setState(() {
//                           print(';;');
//                           // UserDatabaseHelper().updateGold(cell1.value);
//
//                           Fluttertoast.showToast(
//                               msg: "Reward Collected!",
//                               toastLength: Toast.LENGTH_SHORT,
//                               gravity: ToastGravity.BOTTOM,
//                               fontSize: 16.0);
//                         });
//                         setState(() {});
//                         setState(() {
//                           loading = false;
//                         });
//                         setState(() {
//                           widgetToShow = 'Stable';
//                         });
//                         setState(() {
//                           firstDice = 1;
//                           secondDice = 1;
//                         });
//
//                         restart();
//                       });

                  // setState(() {
                  //   print(';;');
                  //   // UserDatabaseHelper().updateGold(cell1.value);
                  //
                  //   Fluttertoast.showToast(
                  //       msg: "Reward Collected!",
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.BOTTOM,
                  //       fontSize: 16.0);
                  // });
                  // setState(() {});
                  //
                  // setState(() {
                  //   widgetToShow = 'Stable';
                  // });
                  // setState(() {
                  //   firstDice = 0;
                  //   secondDice = 0;
                  // });
                  //
                  // restart();
                } else if (widgetToShow == 'Stable' ||
                    widgetToShow == 'Still') {
                  print(1);
                  AssetsAudioPlayer.newPlayer().open(
                    Audio("assets/audios/diceSound.mp3"),
                    autoStart: true,
                    showNotification: true,
                  );
                  setState(() {
                    widgetToShow = 'Rolling';
                  });
                  RenderBox box =
                      centerKey.currentContext?.findRenderObject() as RenderBox;
                  Offset position = await box
                      .localToGlobal(Offset.zero); //this is global position
                  y = position.dy;
                  x = position.dx;
                  print(y.toString());

                  // lottieController.forward();

                  Future.delayed(const Duration(milliseconds: 1500), () {
                    _controller?.forward();
                    roll(tickets);
                  });

                  Future.delayed(const Duration(milliseconds: 3500), () {
                    _controller?.forward();
                    roll(tickets);
                  });
                }
              } else {
                if (widgetToShow == 'Collect') {
                  await UserDatabaseHelper().cloudGoldSurge(cell1.value);

                  FutureProgressDialog(
                    Future.delayed(const Duration(milliseconds: 2000)),
                    message: const Text("Request Processing..."),
                  );
                  Future.delayed(const Duration(milliseconds: 2000), () {
                    setState(() {
                      widgetToShow = 'Stable';
                    });
                    setState(() {
                      firstDice = 1;
                      secondDice = 1;
                    });

                    restart();
                  });

                  print(cell1.value);
                } else {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Damnnnn!"),
                      content: const Text(
                          "You have 0 tickets left. Watch an Ad to get 3 new tickets!"),
                      actions: [
                        MaterialButton(
                          color: Colors.deepPurple,
                          onPressed: () async {
                            print(1);
                            isRewardedVideoAvailable =
                                false;

                            if (isRewardedVideoAvailable!) {

                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Reward video not available!');
                            }
                          },
                          child: const Text(
                            "Start",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
            child: widgetToShow == 'None'
                ? Container()
                : widgetToShow == 'Collect'
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.12,
                            left: 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    // color: Colors.red,
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SvgPicture.asset(
                                        'assets/dice/Dice$firstDice.svg',
                                        fit: BoxFit.contain,
                                      ),
                                    ))),
                                Container(
                                    // color: Colors.red,
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: SvgPicture.asset(
                                        'assets/dice/Dice$secondDice.svg',
                                        fit: BoxFit.contain,
                                      ),
                                    ))),
                              ],
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.725,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: AppColors.primary),
                              child: Center(
                                child: loading
                                    ? CircularProgressIndicator()
                                    : Text('Collect Your Reward',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      )
                    : widgetToShow == 'Number'
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                                top: MediaQuery.of(context).size.height * 0.17),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    // color: Colors.red,
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SvgPicture.asset(
                                        'assets/dice/Dice$firstDice.svg',
                                        fit: BoxFit.contain,
                                      ),
                                    ))),
                                Container(
                                    // color: Colors.red,
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: SvgPicture.asset(
                                        'assets/dice/Dice$secondDice.svg',
                                        fit: BoxFit.contain,
                                      ),
                                    ))),
                              ],
                            ),
                          )
                        : widgetToShow == 'Rolling'
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.023),
                                child: Container(
                                    // color: Colors.red,
                                    height: MediaQuery.of(context).size.height *
                                        0.36,
                                    width: MediaQuery.of(context).size.width *
                                        0.63,
                                    child: Center(
                                        child: Lottie.asset(
                                      'assets/dice/diceFinal.json',
                                      fit: BoxFit.cover,
                                    ))),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.15,
                                    left: 0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.125,
                                  width:
                                      MediaQuery.of(context).size.width * 0.725,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: AppColors.primary),
                                  child: Center(
                                    child: Text('Tap to Roll the Dice',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
          ),
        ),
      ],
    );
  }

  void restart() {
    setState(() {
      generateGrid();
    });
  }

  int firstNumber = 0;
  void unrevealRecursively(int number) {
    if (rolls <= 2) {
      rolls++;

      count += number;
      if (rolls == 2) {
        double temp1 = firstNumber / 3;
        int row = temp1.floor();
        int temp3 = firstNumber % 3 - 1;
        if (firstNumber % 3 == 0) {
          row--;
          temp3 += 3;
        }

        setState(() {
          cell1 = cells[temp3][row];
        });
        cells[temp3][row].isFinal = false;
      }
      if (rolls == 2) {
        if (count > 9) {
          count = count % 10 + 1;
        }

        double temp1 = count / 3;
        int row = temp1.floor();
        int temp3 = count % 3 - 1;
        if (count % 3 == 0) {
          row--;
          temp3 += 3;
        }

        setState(() {
          cell1 = cells[temp3][row];
        });
        cells[temp3][row].isFinal = true;
        for (int i = 0; i < 3; i++)
          for (int j = 0; j < 3; j++) cells[i][j].isRevealed = true;

        totalCellsRevealed++;
        count = 0;
      } else {
        double temp1 = count / 3;
        int row = temp1.floor();
        int temp3 = count % 3 - 1;
        if (count % 3 == 0) {
          row--;
          temp3 += 3;
        }

        setState(() {
          cell1 = cells[temp3][row];
        });
        // cells[temp3][row].isFinal = true;
        firstNumber = count;
      }
    }
  }

  animate() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = CurvedAnimation(parent: _controller!, curve: Curves.bounceOut);
    animation?.addListener(() {
      setState(() {});
    });
    animation?.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftDiceNumber = Random().nextInt(6) + 1;
          if (rolls == 0) firstDice = leftDiceNumber;
          if (rolls == 1) secondDice = leftDiceNumber;
        });
        if (rolls == 1) {
          setState(() {
            widgetToShow = 'Number';
          });
        }

        if (rolls == 1) {
          AssetsAudioPlayer.newPlayer().open(
            Audio("assets/audios/winning.mp3"),
            autoStart: true,
            showNotification: false,
          );
          await Future.delayed(const Duration(milliseconds: 1000), () {
            _controller?.stop();

            widgetToShow = 'Stable';
          });
        }

        unrevealRecursively(leftDiceNumber);
        if (totalCellsRevealed == 1) {
          rolls = 0;

          setState(() {
            widgetToShow = 'None';
          });
          UserDatabaseHelper().cloudTicket(-1);
          if (cell1.value == 0)
            widgetToShow = 'Stable';
          else
            widgetToShow = 'Collect';
          final response = await Fluttertoast.showToast(
              msg:
                  "Congratulations! You have won ${cell1.value}  ${(cell1.y + cell1.x) % 2 == 0 ? 'gold 🥇' : 'gold 🥇'}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              fontSize: 16.0);
          // await showDialog(
          //   context: context,
          //   // barrierDismissible: false,
          //   builder: (ctx) => AlertDialog(
          //     title: Text(
          //       "Congratulations!!!",
          //       style: Theme.of(context).textTheme.headline5?.copyWith(
          //           color: Colors.black,
          //           fontSize: MediaQuery.of(context).size.height * 0.03,
          //           fontWeight: FontWeight.bold),
          //     ),
          //     content: Text(
          //         "You have won ${cell1.value}  ${(cell1.y + cell1.x) % 2 == 0 ? 'gold 🪙' : 'gold 🪙'}"),
          //     alignment: Alignment.center,
          //     actions: [
          //       // Container(
          //       //   decoration: BoxDecoration(
          //       //       borderRadius: BorderRadius.all(Radius.circular(10))),
          //       //   child: MaterialButton(
          //       //     color: AppColors.orange,
          //       //     onPressed: () {
          //       //       Navigator.of(context).pop(true);
          //       //       widgetToShow = 'Stable';
          //       //     },
          //       //     child: Text(
          //       //       "Play Again",
          //       //       style: Theme.of(context).textTheme.headline5?.copyWith(
          //       //           color: Colors.white,
          //       //           fontSize: MediaQuery.of(context).size.height * 0.02,
          //       //           fontWeight: FontWeight.bold),
          //       //     ),
          //       //   ),
          //       // ),
          //     ],
          //   ),

          if (cell1.value == 0) {
            setState(() {
              firstDice = 1;
              secondDice = 1;
            });

            restart();
          }
        } else {
          setState(() {});
        }

        _controller?.reverse();
      }
    });
  }

  void roll(int tickets) {
    if (tickets > 0) {
      _controller?.forward();
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Damnnnn!"),
          content: const Text(
              "You have 0 tickets left. Participate in one of quick surveys to earn more!"),
          actions: [
            MaterialButton(
              color: Colors.deepPurple,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Close"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    goldChangeNotifier.setMethod();

    // lottieController =
    //     AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animate();
    generateGrid();
    userStream.init();
  }

  bool? isRewardedVideoAvailable = false;
  bool isInterstitialVideoAvailable = false;
  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    userStream.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // appBar: AppBar(
      //   elevation: 3,
      //   backgroundColor: Colors.white,
      //   title: const Text(
      //     "Dice Game🎲",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      //   automaticallyImplyLeading: true,
      // ),
      body: FutureBuilder<UserData>(
          future: UserDatabaseHelper().getUserDataFromId(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              final user = snapshot.data;
              return Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 45),
                child: Container(
                  child: buildButtonColumn(user!.tickets, context, user),
                ),
              );
            } else {
              return Center(child: Text('Loading'));
            }
          }),
    );
  }
}
