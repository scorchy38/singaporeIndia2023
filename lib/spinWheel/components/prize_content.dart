import 'package:flutter/material.dart';
import 'package:dicecash/const.dart';

class PrizeContent extends StatelessWidget {
  final Widget content;
  final String option;
  const PrizeContent({key, required this.content, required this.option});

  String getOption() {
    return option;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(tag: option, child: content);
  }
}
