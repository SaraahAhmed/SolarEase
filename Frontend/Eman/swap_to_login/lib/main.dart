import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_app/Pages/StartPage.dart';

double scw = 0; // 60% of screen width
double sch = 0;
double t = 0;
double width(double w){return scw * (w /783);}
double height(double h){return (h / 393) * sch;}
void main() {
  runApp(const SwapPaget());
}

class SwapPaget extends StatelessWidget {
  const SwapPaget({super.key});

  @override
  Widget build(BuildContext context) {
    scw = MediaQuery.of(context).size.width; // 60% of screen width
    sch = MediaQuery.of(context).size.height;
    t = MediaQuery.of(context).textScaleFactor;
    // print("the height is:");
    // print(scw);
    // print("the width is:");
    // print(sch);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SwapToLoginPage(),
    );
  }
}
//   -----------------------------------------------------