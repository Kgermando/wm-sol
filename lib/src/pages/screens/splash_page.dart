import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/pages/screens/controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
