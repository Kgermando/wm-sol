import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/widgets/custom_text.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

Widget loadingPage(BuildContext context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            height: p20,
          ),
          Text('Patientez svp...', style: TextStyle())
        ],
      ),
    );

// Widget loadingPage(BuildContext context) => Scaffold(
//     key: scaffoldKey,
//     appBar: headerBar(context, scaffoldKey, '', ''),
//     drawer: const DrawerMenu(),
//     body: Row(
//       children: [
//         Visibility(
//             visible: !Responsive.isMobile(context),
//             child: const Expanded(flex: 1, child: DrawerMenu())),
//         Expanded(
//           flex: 5,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 CircularProgressIndicator(),
//                 SizedBox(
//                   height: p20,
//                 ),
//                 Text('Patientez svp...', style: TextStyle())
//               ],
//             ),
//           )
//         ),
//       ],
//     )
//   );

Widget loadingError(BuildContext context, String error) => Column(
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
            Expanded(child: Text("Une erreur s'est produite $error. Merçi.")),

             ElevatedButton(onPressed: () => Get.back(), child: const Text("Revenir en arrière."))
          ],
        ),
      ],
    );
// Widget loadingError(BuildContext context, String error) => Scaffold(
//     key: scaffoldKey,
//     appBar: headerBar(context, scaffoldKey, '', ''),
//     drawer: const DrawerMenu(),
//     body: Row(
//       children: [
//         Visibility(
//             visible: !Responsive.isMobile(context),
//             child: const Expanded(flex: 1, child: DrawerMenu())),
//         Expanded(
//             flex: 5,
//             child: Column(
//               children: [
//                 Image.asset(
//                   "assets/images/error.png",
//                   width: 350,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CustomText(
//                       text:
//                           "Une erreur s'est produite $error veillez actualiser votre logiciel. Merçi.",
//                       size: 24,
//                       weight: FontWeight.bold,
//                     ),
//                   ],
//                 ),
//               ],
//             )),
//       ],
//     ));

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
