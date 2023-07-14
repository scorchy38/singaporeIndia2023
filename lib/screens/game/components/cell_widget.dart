import 'package:dicecash/core/constants/app_colors.dart';
import 'package:dicecash/core/constants/app_colors.dart';
import 'package:dicecash/core/constants/app_colors.dart';
import 'package:dicecash/core/constants/app_colors.dart';
import 'package:dicecash/core/constants/app_colors.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cell.dart';

class CellWidget extends StatefulWidget {
  const CellWidget({
    required Key key,
    required this.size,
    required this.cell,
  }) : super(key: key);

  final int size;
  final CellModel cell;

  @override
  _CellWidgetState createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  List<Color> colors = [
    AppColors.primary,
    AppColors.complimentary,
    AppColors.primary,
    AppColors.complimentary,
    AppColors.primary,
    AppColors.complimentary,
    AppColors.primary,
    AppColors.complimentary,
    AppColors.primary,
    AppColors.complimentary,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 1, bottom: 1),
      height: MediaQuery.of(context).size.width / widget.size - 10,
      decoration: BoxDecoration(
        border: widget.cell.isFinal == true
            ? Border.all(color: AppColors.complimentary, width: 5)
            : Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF434bf3),
            offset: const Offset(0, 10),
            blurRadius: 30,
            spreadRadius: -5,
          ),
        ],
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF723cfa),
              Color(0xFF6741f9),
              Color(0xFF5c45f7),
              Color(0xFF5048f5),
            ],
            stops: const [
              0.1,
              0.3,
              0.9,
              1.0
            ]),
        color: widget.cell.isRevealed
            ? (widget.cell.x % 2 == 0)
                ? (widget.cell.y % 2 == 1)
                    ? colors[2]
                    : colors[1]
                : colors[2]
            : Color(0xFFF1DEDE),
      ),
      child: (widget.cell.isMine && widget.cell.isRevealed)
          ? const Center(
              child: Icon(
                Icons.clear,
                color: Colors.red,
              ),
            )
          : widget.cell.isFlagged
              ? Center(
                  child: Icon(
                    Icons.flag,
                    color: Colors.red[400],
                  ),
                )
              : widget.cell.isRevealed
                  ? Center(
                      child: Text(
                        (widget.cell.y + widget.cell.x) % 2 == 0
                            ? '${widget.cell.value.toString()}  🥇'
                            : '${widget.cell.value.toString()}  🥇',
                        style: GoogleFonts.orbitron(
                          textStyle: TextStyle(
                              color: AppColors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(),
    );
  }
}
