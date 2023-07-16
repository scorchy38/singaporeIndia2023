import 'package:flutter/material.dart';

class Bannner extends StatefulWidget {
  const Bannner({Key? key}) : super(key: key);

  @override
  State<Bannner> createState() => _BannnerState();
}

class _BannnerState extends State<Bannner> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: SingleChildScrollView(child: Image(image: AssetImage('assets/images/bannner.png')))),
    );
  }
}
