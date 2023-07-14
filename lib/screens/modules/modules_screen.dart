import 'package:dicecash/main.dart';
import 'package:dicecash/screens/modules/start_game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ModulesScreen extends StatefulWidget {
  const ModulesScreen({key});

  @override
  State<ModulesScreen> createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen> {
  int completedChaps = 2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          title: const Text("Money Basics💸", style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
              fontWeight: FontWeight.w700
          ),),
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

            Expanded(
              child: PageView.builder(
                itemCount: 2,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return pageViewCard(context, index);
                },
              ),
            )
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
                        "Unit ${index+1}",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 22,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          index == 0 ? "The Money Mindset, Money 101 " : "Wealth Building, Independence",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                BorderedContainer(
                  color: Colors.blue,
                  radius: 16,
                  child: Icon(
                    Icons.book,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
                  width: double.maxFinite,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        chapterCard(index: 0),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: chapterCard(
                            alignment: Alignment.topLeft,
                            index: 1,
                          ),
                        ),
                        chapterCard(index: 2),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: chapterCard(
                              alignment: Alignment.topRight, index: 3),
                        ),
                        chapterCard(index: 4),
                      ],
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
      {AlignmentGeometry alignment = Alignment.center, int index = 0}) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Visibility(
              visible: index <= completedChaps,
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
              child: index <= completedChaps
                  ? FancyButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const StartGameScreen(),
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
