import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/succursale/succursale_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailUser extends StatefulWidget {
  const DetailUser({super.key, required this.user});
  final UserModel user;

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  final UsersController controller = Get.find();
  final SuccursaleController succursaleController =
      Get.put(SuccursaleController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";

  Future<UserModel> refresh() async {
    final UserModel dataItem = await controller.detailView(widget.user.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    List<dynamic> depList = jsonDecode(widget.user.departement);
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  "${widget.user.prenom} ${widget.user.nom}"),
              drawer: const DrawerMenu(),
              floatingActionButton: depList.contains("Commercial")
                  ? FloatingActionButton.extended(
                      label: const Text("Affecter une succursale"),
                      tooltip: "Affecter une succursale à cet utilisateur",
                      icon: const Icon(Icons.home_work),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: Colors.amber.shade100,
                              padding: const EdgeInsets.all(p20),
                              child: Form(
                                key: controller.formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Expanded(
                                            child: (widget.user.succursale ==
                                                    "-")
                                                ? Text(
                                                    "Affecter une succursale à cet utilisateur",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall)
                                                : Text(
                                                    "Modifier la succursale pour cet utilisateur",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: p20,
                                    ),
                                    succursaleWidget(),
                                    const SizedBox(
                                      height: p20,
                                    ),
                                    Obx(() => BtnWidget(
                                        title: 'Soumettre',
                                        press: () {
                                          final form =
                                              controller.formKey.currentState!;
                                          if (form.validate()) {
                                            controller
                                                .succursaleUser(widget.user);
                                            form.reset();
                                          }
                                        },
                                        isLoading: controller.isLoading))
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : Container(),
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
                                        horizontal: p20, vertical: p20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const TitleWidget(title: "Utitlisateur actif"),
                                            IconButton(
                                                tooltip: 'Actualiser',
                                                onPressed: () {
                                                  refresh().then((value) =>
                                                      Navigator.pushNamed(
                                                          context,
                                                          RhRoutes.rhdetailUser,
                                                          arguments: value));
                                                },
                                                icon: Icon(Icons.refresh,
                                                    color:
                                                        Colors.green.shade700)),
                                          ],
                                        ),
                                        const SizedBox(height: p20),
                                        ResponsiveChildWidget(
                                            child1: Text('Nom :',
                                                textAlign: TextAlign.start,
                                                style: bodyMedium!.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child2: SelectableText(
                                                widget.user.nom,
                                                textAlign: TextAlign.start,
                                                style: bodyMedium)),
                                        Divider(color: mainColor),
                                        ResponsiveChildWidget(
                                            child1: Text('Prénom :',
                                                textAlign: TextAlign.start,
                                                style: bodyMedium.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child2: SelectableText(
                                                widget.user.prenom,
                                                textAlign: TextAlign.start,
                                                style: bodyMedium)),
                                        Divider(color: mainColor),
                                        ResponsiveChildWidget(
                                            child1: Text('Email :',
                                                textAlign: TextAlign.start,
                                                style: bodyMedium.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child2: SelectableText(
                                                widget.user.email,
                                                textAlign: TextAlign.start,
                                                style: bodyMedium)),
                                        Divider(color: mainColor),
                                        ResponsiveChildWidget(
                                            child1: Text('Téléphone :',
                                                textAlign: TextAlign.start,
                                                style: bodyMedium.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child2: SelectableText(
                                                widget.user.telephone,
                                                textAlign: TextAlign.start,
                                                style: bodyMedium)),
                                        Divider(color: mainColor),
                                        ResponsiveChildWidget(
                                            child1: Text(
                                                'Niveau d\'accréditation :',
                                                textAlign: TextAlign.start,
                                                style: bodyMedium.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child2: SelectableText(
                                                widget.user.role,
                                                textAlign: TextAlign.start,
                                                style: bodyMedium)),
                                        Divider(color: mainColor),
                                        ResponsiveChildWidget(
                                            child1: Text('Matricule :',
                                                textAlign: TextAlign.start,
                                                style: bodyMedium.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child2: SelectableText(
                                                widget.user.matricule,
                                                textAlign: TextAlign.start,
                                                style: bodyMedium)),
                                        Divider(color: mainColor),
                                        ResponsiveChildWidget(
                                            child1: Text('Date de création :',
                                                textAlign: TextAlign.start,
                                                style: bodyMedium.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child2: Text(
                                                DateFormat("dd-MM-yyyy").format(
                                                    widget.user.createdAt),
                                                textAlign: TextAlign.start,
                                                style: bodyMedium)),
                                        Divider(color: mainColor),
                                        ResponsiveChildWidget(
                                            child1: Text('Département :',
                                                textAlign: TextAlign.start,
                                                style: bodyMedium.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child2: SelectableText(
                                                widget.user.departement,
                                                textAlign: TextAlign.start,
                                                style: bodyMedium)),
                                        Divider(color: mainColor),
                                        ResponsiveChildWidget(
                                            child1: Text(
                                                'Services d\'affectation :',
                                                textAlign: TextAlign.start,
                                                style: bodyMedium.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child2: SelectableText(
                                                widget.user.servicesAffectation,
                                                textAlign: TextAlign.start,
                                                style: bodyMedium)),
                                        Divider(color: mainColor),
                                        const SizedBox(height: p20),
                                        ResponsiveChildWidget(
                                            child1: Text('Succursale :',
                                                textAlign: TextAlign.start,
                                                style: bodyMedium.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child2: SelectableText(
                                                widget.user.succursale,
                                                textAlign: TextAlign.start,
                                                style: bodyMedium.copyWith(color: mainColor, fontWeight: FontWeight.bold))),
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

  Widget succursaleWidget() {
    var succList =
        succursaleController.succursaleList.map((e) => e.name).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Succursale',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.succursale,
        isExpanded: true,
        items: succList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select Succursale" : null,
        onChanged: (value) {
          setState(() {
            controller.succursale = value!;
          });
        },
      ),
    );
  }
}
