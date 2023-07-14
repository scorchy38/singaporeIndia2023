import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class SurveyTile extends StatefulWidget {
  VoidCallback onTap;
  String title, reward, image;
  double scale;
   SurveyTile(this.title, this.reward, this.image, this.onTap, {Key? key, this.scale = 1.0}) : super(key: key);

  @override
  _SurveyTileState createState() => _SurveyTileState();
}

class _SurveyTileState extends State<SurveyTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Card(
          elevation: 2,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all( 10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius:28,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(widget.image, scale: widget.scale,),
                      ),
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.reward,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                              color: Colors.black, fontSize: 14)),
                    ],
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 3,
                    color: AppColors.primary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Container(
                        height: 15,
                        child: Center(
                          child: Text("Continue",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                  color: AppColors.text,
                                  fontSize: 14)),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
