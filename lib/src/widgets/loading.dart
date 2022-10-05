import 'package:flutter/material.dart';

Widget loadingMega() => Scaffold(
  body: Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: Colors.red.shade700, strokeWidth: 5.0),
        const SizedBox(
          width: 20.0,
        ),
        Text('Initialisation en cours...', style: TextStyle(color: Colors.red.shade700))
      ],
    ),
  ),
);

Widget loading() => Scaffold(
  body: Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        SizedBox(width: 20.0,),
        Text('Patientez svp...', style: TextStyle())
      ],
    ),
  ),
);

Widget loadingWhite() => Scaffold(
  body: Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(strokeWidth: 2.0, color: Colors.white),
        SizedBox(
          width: 10.0,
        ),
        Text('Patientez svp...', style: TextStyle(color: Colors.white))
      ],
    ),
  ),
);


Widget loadingMini() => const Scaffold(
  body: Center(
    child: SizedBox(
      width: 10,
      height: 10,
      child: CircularProgressIndicator(strokeWidth: 2.0)),
  ),
);
