import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/change_password_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class ChangePasswordAuth extends StatefulWidget {
  const ChangePasswordAuth({super.key});

  @override
  State<ChangePasswordAuth> createState() => _ChangePasswordAuthState();
}

class _ChangePasswordAuthState extends State<ChangePasswordAuth> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Authentification";
  String subTitle = "Changer le mot de passe";

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController controller = Get.put(ChangePasswordController());
    final ProfilController profilController =
        Get.put(ProfilController());
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const DrawerMenu(), 
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: !Responsive.isMobile(context),
              child: const Expanded(flex: 1, child: DrawerMenu())),
          Expanded(
              flex: 5,
              child: SingleChildScrollView(
                  controller: ScrollController(),
                  physics: const ScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: p20, bottom: p8, right: p20, left: p20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Card( 
                          child: Padding(
                            padding: const EdgeInsets.all(p20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TitleWidget(
                                    title: 'Modifier votre mot de passe'),
                                const SizedBox(
                                  height: p20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AutoSizeText(
                                        "Bonjour ${profilController.user.prenom}, votre sécurité passe avant tout!",
                                        maxLines: 3,
                                        style: bodyLarge,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: p30),
                                newPasswordWidget(controller),
                                const SizedBox(
                                  height: p20,
                                ),
                                BtnWidget(
                                    title: 'Soumettre',
                                    isLoading:
                                        controller.isLoadingChangePassword,
                                    press: controller.submitChangePassword)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  Widget newPasswordWidget(ChangePasswordController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.changePasswordController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nouveau mot de passe',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }
}
 