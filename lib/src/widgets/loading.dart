import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:wm_solution/src/constants/app_theme.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

Widget loadingPage(BuildContext context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            height: p20,
          ),
          Text('Patientez svp...',
              textAlign: TextAlign.center, style: TextStyle())
        ],
      ),
    );

Widget loadingError(BuildContext context, String error) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/error.png",
          width: 350,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Text("$error. Merçi.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6)),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Phoenix.rebirth(context);
            },
            child: Text("Revenir en arrière.",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white)))
      ],
    );

Widget loadingMega() => Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
                color: Colors.red.shade700, strokeWidth: 5.0),
            const SizedBox(
              width: 20.0,
            ),
            Text('Initialisation en cours...',
                style: TextStyle(color: Colors.red.shade700))
          ],
        ),
      ),
    );

Widget loading() => Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            width: 20.0,
          ),
          Text('Patientez svp...', style: TextStyle())
        ],
      ),
    );

Widget loadingWhite() => Center(
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
    );

Widget loadingMini() => const Center(
      child: SizedBox(
          width: 10,
          height: 10,
          child: CircularProgressIndicator(strokeWidth: 2.0)),
    );
