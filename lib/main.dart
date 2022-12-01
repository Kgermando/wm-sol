import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/bindings/wm_binding.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/role_theme.dart';
import 'package:wm_solution/src/pages/404/error.dart';
import 'package:wm_solution/src/routes/router.dart';
import 'package:wm_solution/src/routes/routes.dart'; 
import 'package:wm_solution/src/utils/info_system.dart'; 
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  await GetStorage.init();
  // UserModel user = await AuthApi().getUserId();
  timeago.setLocaleMessages('fr', timeago.FrMessages()); // Add french messages
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // popGesture: true,
      title: InfoSystem().name(),
      initialBinding: WMBindings(),
      initialRoute: SettingsRoutes.splash, // redirectRoute(user),  
      unknownRoute: GetPage(
          name: '/not-found',
          page: () => const PageNotFound(),
          transition: Transition.fadeIn),
      getPages: getPages,
      theme: ThemeData(
        useMaterial3: true,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          },
        ),
        scaffoldBackgroundColor: Colors.blue.shade50,
        primaryColor: Colors.white,
        primarySwatch: roleThemeSwatch(1),
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.light(
          primary: mainColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(5.0),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0));
            }),
            textStyle: MaterialStateProperty.all(const TextStyle(
              color: Colors.white,
            )),
            backgroundColor: MaterialStateProperty.all(mainColor),
          ),
        ),
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      )
    ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key, required this.user}) : super(key: key);
//   final UserModel user;

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       // popGesture: true,
//       title: InfoSystem().name(),
//       initialBinding: WMBindings(),
//       initialRoute: SettingsRoutes.splash, // redirectRoute(user), 
//       unknownRoute: GetPage(
//           name: '/not-found',
//           page: () => const PageNotFound(),
//           transition: Transition.fadeIn),
//       getPages: getPages,
//       theme: ThemeData(
//         useMaterial3: true,
//         pageTransitionsTheme: const PageTransitionsTheme(
//           builders: {
//             TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
//             TargetPlatform.android: ZoomPageTransitionsBuilder(),
//             TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
//           },
//         ),
//         scaffoldBackgroundColor: Colors.blue.shade50,
//         primaryColor: Colors.white,
//         primarySwatch: roleThemeSwatch(1),
//         fontFamily: 'Poppins',
//         colorScheme: ColorScheme.light(
//           primary: mainColor,
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ButtonStyle(
//             elevation: MaterialStateProperty.all(5.0),
//             shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
//               return RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0));
//             }),
//             textStyle: MaterialStateProperty.all(const TextStyle(
//               color: Colors.white,
//             )),
//             backgroundColor: MaterialStateProperty.all(mainColor),
//           ),
//         ),
//         // visualDensity: VisualDensity.adaptivePlatformDensity,
//       )
//     );
//   }
// }
