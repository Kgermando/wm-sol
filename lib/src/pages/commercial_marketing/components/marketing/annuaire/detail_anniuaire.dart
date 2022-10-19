import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comm_maketing/annuaire_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/marketing/annuaire/annuaire_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class DetailAnnuaire extends StatefulWidget {
  const DetailAnnuaire({super.key, required this.annuaireColor});
  final AnnuaireColor annuaireColor;

  @override
  State<DetailAnnuaire> createState() => _DetailAnnuaireState();
}

class _DetailAnnuaireState extends State<DetailAnnuaire> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial & Marketing";

  @override
  Widget build(BuildContext context) {
    final AnnuaireController controller = Get.put(AnnuaireController());
    final ProfilController profilController = Get.put(ProfilController());

    int userRole = int.parse(profilController.user.role);
    final headline5 = Theme.of(context).textTheme.headline5;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).size.width >= 1100) {
      width = MediaQuery.of(context).size.width / 2;
    } else if (MediaQuery.of(context).size.width < 1100 &&
        MediaQuery.of(context).size.width >= 650) {
      width = MediaQuery.of(context).size.width / 1.3;
    } else if (MediaQuery.of(context).size.width < 650) {
      width = MediaQuery.of(context).size.width / 1.2;
    }
    return controller.obx(
        onLoading: loading(),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => Text(
            "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  widget.annuaireColor.annuaireModel.nomPostnomPrenom),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              children: [
                                Card(
                                  elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: p20),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Card(
                                    elevation: 10,
                                    child: Container(
                                      margin:
                                          const EdgeInsets.all(p16),
                                      width: width,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(
                                                p10),
                                        border: Border.all(
                                          color: Colors
                                              .blueGrey.shade700,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                color: widget
                                                    .annuaireColor
                                                    .color,
                                                height: 200,
                                                width:
                                                    double.infinity,
                                              ),
                                              Positioned(
                                                top: 130,
                                                left: (Responsive
                                                        .isDesktop(
                                                            context))
                                                    ? 50
                                                    : 10,
                                                child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors
                                                          .green
                                                          .shade700,
                                                      shape: BoxShape
                                                          .circle,
                                                      border: Border.all(
                                                          width: 2.0,
                                                          color:
                                                              mainColor)),
                                                  child:
                                                      CircleAvatar(
                                                          radius: 50,
                                                          backgroundColor:
                                                              Colors
                                                                  .white,
                                                          child: Image
                                                              .asset(
                                                            "assets/images/avatar.jpg",
                                                            width: 80,
                                                            height: 80)),
                                                            ),
                                                          ),
                                                          Positioned(
                                                              top: 150,
                                                              left: (Responsive
                                                                      .isDesktop(
                                                                          context))
                                                                  ? 180
                                                                  : 120,
                                                              child: (Responsive
                                                                      .isMobile(
                                                                          context))
                                                                  ? Container()
                                                                  : AutoSizeText(
                                                                      widget
                                                                          .annuaireColor
                                                                          .annuaireModel
                                                                          .nomPostnomPrenom,
                                                                      maxLines:
                                                                          2,
                                                                      style: headline5!.copyWith(
                                                                          color:
                                                                              Colors.white))),
                                                          Positioned(
                                                              top: 150,
                                                              right: 20,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  IconButton(
                                                                      onPressed: controller
                                                                              .hasCallSupport
                                                                          ? () =>
                                                                              setState(() {
                                                                                controller.launched = controller.makePhoneCall(widget.annuaireColor.annuaireModel.mobile1);
                                                                              })
                                                                          : null,
                                                                      icon: const Icon(
                                                                        Icons
                                                                            .call,
                                                                        size:
                                                                            40.0,
                                                                        color: Colors
                                                                            .green,
                                                                      )),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (Platform
                                                                            .isAndroid) {}
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .sms,
                                                                        size:
                                                                            40.0,
                                                                        color: Colors
                                                                            .green,
                                                                      )),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () =>
                                                                            {},
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .email_sharp,
                                                                      size:
                                                                          40.0,
                                                                      color: Colors
                                                                          .purple,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: p30),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          if (userRole <= 3)
                                                            editButton(widget
                                                                .annuaireColor),
                                                          if (userRole <= 2)
                                                            deleteButton(
                                                                controller)
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: p30),
                                                      if (Responsive.isMobile(
                                                          context))
                                                        Card(
                                                          elevation: 2,
                                                          child: ListTile(
                                                            leading: Icon(
                                                                Icons.person,
                                                                color: widget
                                                                    .annuaireColor
                                                                    .color),
                                                            title: Text(
                                                              widget
                                                                  .annuaireColor
                                                                  .annuaireModel
                                                                  .nomPostnomPrenom,
                                                              style: bodyMedium,
                                                            ),
                                                          ),
                                                        ),
                                                      if (!widget.annuaireColor
                                                          .annuaireModel.email
                                                          .contains('null'))
                                                        Card(
                                                          elevation: 2,
                                                          child: ListTile(
                                                            leading: Icon(
                                                                Icons
                                                                    .email_sharp,
                                                                color: widget
                                                                    .annuaireColor
                                                                    .color),
                                                            title: Text(
                                                              widget
                                                                  .annuaireColor
                                                                  .annuaireModel
                                                                  .email,
                                                              style: bodyMedium,
                                                            ),
                                                          ),
                                                        ),
                                                      Card(
                                                        elevation: 2,
                                                        child: ListTile(
                                                          leading: Icon(
                                                            Icons.call,
                                                            color: widget
                                                                .annuaireColor
                                                                .color,
                                                            size: 40,
                                                          ),
                                                          title: Text(
                                                            widget
                                                                .annuaireColor
                                                                .annuaireModel
                                                                .mobile1,
                                                            style: bodyMedium,
                                                          ),
                                                          subtitle: (!widget
                                                                  .annuaireColor
                                                                  .annuaireModel
                                                                  .mobile2
                                                                  .contains(
                                                                      'null'))
                                                              ? Text(
                                                                  widget
                                                                      .annuaireColor
                                                                      .annuaireModel
                                                                      .mobile2,
                                                                  style:
                                                                      bodyMedium,
                                                                )
                                                              : Container(),
                                                        ),
                                                      ),
                                                      if (!widget
                                                          .annuaireColor
                                                          .annuaireModel
                                                          .secteurActivite
                                                          .contains('null'))
                                                        Card(
                                                          elevation: 2,
                                                          child: ListTile(
                                                            leading: Icon(
                                                                Icons
                                                                    .local_activity,
                                                                color: widget
                                                                    .annuaireColor
                                                                    .color),
                                                            title: Text(
                                                              widget
                                                                  .annuaireColor
                                                                  .annuaireModel
                                                                  .secteurActivite,
                                                              style: bodyMedium,
                                                            ),
                                                          ),
                                                        ),
                                                      if (!widget
                                                          .annuaireColor
                                                          .annuaireModel
                                                          .nomEntreprise
                                                          .contains('null'))
                                                        Card(
                                                          elevation: 2,
                                                          child: ListTile(
                                                            leading: Icon(
                                                                Icons.business,
                                                                color: widget
                                                                    .annuaireColor
                                                                    .color),
                                                            title: Text(
                                                              widget
                                                                  .annuaireColor
                                                                  .annuaireModel
                                                                  .nomEntreprise,
                                                              style: bodyMedium,
                                                            ),
                                                          ),
                                                        ),
                                                      if (!widget.annuaireColor
                                                          .annuaireModel.grade
                                                          .contains('null'))
                                                        Card(
                                                          elevation: 2,
                                                          child: ListTile(
                                                            leading: Icon(
                                                                Icons.grade,
                                                                color: widget
                                                                    .annuaireColor
                                                                    .color),
                                                            title: Text(
                                                              widget
                                                                  .annuaireColor
                                                                  .annuaireModel
                                                                  .grade,
                                                              style: bodyMedium,
                                                            ),
                                                          ),
                                                        ),
                                                      if (!widget
                                                          .annuaireColor
                                                          .annuaireModel
                                                          .adresseEntreprise
                                                          .contains('null'))
                                                        Card(
                                                          elevation: 2,
                                                          child: ListTile(
                                                            leading: Icon(
                                                                Icons
                                                                    .place_sharp,
                                                                color: widget
                                                                    .annuaireColor
                                                                    .color),
                                                            title: Text(
                                                              widget
                                                                  .annuaireColor
                                                                  .annuaireModel
                                                                  .adresseEntreprise,
                                                              style: bodyMedium,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )))
                ],
              ),
            ));
  }

  Widget editButton(AnnuaireColor annuaireColor) => IconButton(
      icon: const Icon(Icons.edit_outlined),
      color: Colors.purple,
      tooltip: "Modifiaction",
      onPressed: () {
        Get.toNamed(ComMarketingRoutes.comMarketingAnnuaireEdit,
            arguments: annuaireColor.annuaireModel);
      });

  Widget deleteButton(AnnuaireController controller) {
    return IconButton(
      icon: const Icon(Icons.delete),
      color: Colors.red,
      tooltip: "Suppression",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Etes-vous sûr de supprimé ceci?'),
          content:
              const Text('Cette action permet de supprimer définitivement.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Annuler'),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                controller.deleteData(widget.annuaireColor.annuaireModel.id!);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
