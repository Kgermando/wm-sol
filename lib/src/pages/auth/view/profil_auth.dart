import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart'; 
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/button_standard_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class ProfileAuth extends StatefulWidget {
  const ProfileAuth({Key? key}) : super(key: key);

  @override
  State<ProfileAuth> createState() => _ProfileAuthState();
}

class _ProfileAuthState extends State<ProfileAuth> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Mon profil";
  String subTitle = "Dashboard";
  
  @override
  Widget build(BuildContext context) {
    final ProfilController controller = Get.find();
    final headline5 = Theme.of(context).textTheme.headline5;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;

    final String firstLettter2 = controller.user.prenom[0];
    final String firstLettter = controller.user.nom[0];

    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, controller.user.prenom),
      drawer: const DrawerMenu(),
      body: Row(
        children: [
          Visibility(
            visible: !Responsive.isMobile(context),
            child: const Expanded(child: DrawerMenu())),
        Expanded(
          flex: 5,
          child: controller.isLoadingProfil
        ? loading()
        : Container(
          padding: const EdgeInsets.all(p10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(p20),
          ),
          child: ListView(
              shrinkWrap: true, 
              controller: ScrollController(),
              physics: const ScrollPhysics(),
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      color: mainColor,
                      height: 200,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 130,
                      left: (Responsive.isDesktop(context)) ? 50 : 10,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            shape: BoxShape.circle,
                            border: Border.all(width: 2.0, color: mainColor)),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: AutoSizeText(
                            '$firstLettter2$firstLettter'.toUpperCase(),
                            maxLines: 2,
                            style: headline5!.copyWith(color: mainColor),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 150,
                        left: (Responsive.isDesktop(context)) ? 180 : 120,
                        child: (Responsive.isDesktop(context))
                            ? AutoSizeText(
                                "${controller.user.prenom} ${controller.user.nom}",
                                style: headline5.copyWith(color: Colors.white))
                            : Column(
                                children: [
                                  AutoSizeText(controller.user.prenom,
                                      textAlign: TextAlign.left,
                                      style: bodyLarge!
                                          .copyWith(color: Colors.white)),
                                  AutoSizeText(controller.user.nom,
                                      textAlign: TextAlign.left,
                                      style:
                                          bodyLarge.copyWith(color: Colors.white))
                                ],
                              )),
                    Positioned(
                        top: 155,
                        right: 20,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            shape: BoxShape.circle,
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: p50),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(p20),
                    child: Row(
                      children: [
                        Expanded(
                            child: AutoSizeText('Nom',
                                maxLines: 2,
                                style: bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold))),
                        const SizedBox(width: p20),
                        Expanded(
                            child: AutoSizeText(controller.user.nom,
                                maxLines: 2, style: bodyLarge))
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(p20),
                    child: Row(
                      children: [
                        Expanded(
                            child: AutoSizeText('Prénom',
                                maxLines: 2,
                                style: bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(width: p20),
                        Expanded(
                            child: AutoSizeText(controller.user.prenom,
                                maxLines: 2, style: bodyLarge))
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(p20),
                    child: Row(
                      children: [
                        Expanded(
                            child: AutoSizeText('Matricule',
                                maxLines: 2,
                                style: bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(width: p20),
                        Expanded(
                            child: AutoSizeText(controller.user.matricule,
                                maxLines: 2, style: bodyLarge))
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(p20),
                    child: Row(
                      children: [
                        Expanded(
                            child: AutoSizeText('Email',
                                maxLines: 2,
                                style: bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(width: p20),
                        Expanded(
                            child: AutoSizeText(controller.user.email,
                                maxLines: 2, style: bodyLarge))
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(p20),
                    child: Row(
                      children: [
                        Expanded(
                            child: AutoSizeText('Département',
                                maxLines: 2,
                                style: bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(width: p20),
                        Expanded(
                            child: AutoSizeText(controller.user.departement,
                                maxLines: 2, style: bodyLarge))
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(p20),
                    child: Row(
                      children: [
                        Expanded(
                            child: AutoSizeText('Services d\'Affectation',
                                maxLines: 2,
                                style: bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(width: p20),
                        Expanded(
                            child: AutoSizeText(
                                controller.user.servicesAffectation,
                                maxLines: 2,
                                style: bodyLarge))
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(p20),
                    child: Row(
                      children: [
                        Expanded(
                            child: AutoSizeText('Fonction Occupée',
                                maxLines: 2,
                                style: bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(width: p20),
                        Expanded(
                            child: AutoSizeText(controller.user.fonctionOccupe,
                                maxLines: 2, style: bodyLarge))
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(p20),
                    child: Row(
                      children: [
                        Expanded(
                            child: AutoSizeText('Accréditation',
                                maxLines: 2,
                                style: bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(width: p20),
                        Expanded(
                            child: AutoSizeText("Niveau ${controller.user.role}",
                                maxLines: 2, style: bodyLarge))
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(p20),
                    child: Row(
                      children: [
                        Expanded(
                            child: AutoSizeText('Succursale',
                                maxLines: 2,
                                style: bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(width: p20),
                        Expanded(
                            child: AutoSizeText(controller.user.succursale,
                                maxLines: 2, style: bodyLarge))
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(p20),
                    child: Row(
                      children: [
                        Expanded(
                            child: AutoSizeText('Date de création',
                                maxLines: 2,
                                style: bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(width: p20),
                        Expanded(
                            child: AutoSizeText(
                                DateFormat("dd.MM.yy HH:mm")
                                    .format(controller.user.createdAt),
                                maxLines: 2,
                                style: bodyLarge))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: p20), 
                ButtonStandarWidget(
                  text: "Modifiez votre mot de passe", 
                  onClicked: () {
                      Get.toNamed(UserRoutes.changePassword);
                    }, icon: Icons.password, color: Colors.white),
                const SizedBox(height: p30),
              ],
            ),
        )
              ),
            ],
          ) 
    );
  }
}


