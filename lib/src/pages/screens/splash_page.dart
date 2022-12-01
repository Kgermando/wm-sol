import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/pages/screens/controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Center(
        child: Column(
          children: [
            Expanded(child: Image.asset("assets/images/logo.png")), 
            const SizedBox(
              width: 50,
              child: LinearProgressIndicator()),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
