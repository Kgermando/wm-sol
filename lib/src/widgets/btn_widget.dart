import 'package:flutter/material.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class BtnWidget extends StatelessWidget {
  const BtnWidget(
      {Key? key,
      required this.title,
      required this.press,
      required this.isLoading})
      : super(key: key);
  final String title;
  final VoidCallback press;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: const EdgeInsets.only(bottom: 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 10),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: press,
            child: isLoading
              ? loading() 
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                    fontSize: MediaQuery.of(context).size.height / 50,
                  ),
                ))),
    ]);
  }
}
