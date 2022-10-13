import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comptabilites/bilan_model.dart';
import 'package:wm_solution/src/models/comptabilites/compte_bilan_ref_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/components/bilan/bilan_pdf.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/bilan_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/compte_bilan_ref_controller.dart';
import 'package:wm_solution/src/utils/comptes_dropdown.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailBilan extends StatefulWidget {
  const DetailBilan({super.key, required this.bilanModel});
  final BilanModel bilanModel;

  @override
  State<DetailBilan> createState() => _DetailBilanState();
}

class _DetailBilanState extends State<DetailBilan> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabiliés";

  @override
  Widget build(BuildContext context) {
    final CompteBilanRefController controller =
        Get.put(CompteBilanRefController());
    final BilanController bilanController = Get.put(BilanController());
    final ProfilController profilController = Get.put(ProfilController());

    return controller.obx(
        onLoading: loading(),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => Text(
            "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(
                  context, scaffoldKey, title, widget.bilanModel.titleBilan),
              drawer: const DrawerMenu(),
              floatingActionButton: (widget.bilanModel.isSubmit == 'false' &&
                      widget.bilanModel.approbationDD == '-' &&
                      widget.bilanModel.approbationDG == '-')
                  ? FloatingActionButton.extended(
                      label: const Text("Ajouter une écriture"),
                      tooltip: "Ecriture sur la feuille bilan",
                      icon: const Icon(Icons.person_add),
                      onPressed: () {
                        newEcritureDialog(controller);
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
                                        horizontal: p20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const TitleWidget(title: "Bilan"),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    if (widget.bilanModel
                                                            .signature ==
                                                        profilController.user
                                                            .matricule) // Uniqyement celui a remplit le document
                                                      sendButton(
                                                          bilanController),
                                                    if (widget.bilanModel
                                                                .approbationDG ==
                                                            "Unapproved" ||
                                                        widget.bilanModel
                                                                .approbationDD ==
                                                            "Unapproved")
                                                      deleteButton(
                                                          bilanController),
                                                    PrintWidget(
                                                        tooltip:
                                                            'Imprimer le document',
                                                        onPressed: () async {
                                                          await BilanPdf.generate(
                                                              widget.bilanModel,
                                                              controller
                                                                  .compteActifList,
                                                              controller
                                                                  .comptePassifList);
                                                        }),
                                                  ],
                                                ),
                                                Text(
                                                    DateFormat(
                                                            "dd-MM-yyyy HH:mm")
                                                        .format(widget
                                                            .bilanModel
                                                            .created),
                                                    textAlign: TextAlign.start),
                                              ],
                                            )
                                          ],
                                        ),
                                        dataWidget(controller),
                                        totalMontant(controller)
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

  Widget dataWidget(CompteBilanRefController controller) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text("Titre:",
                      style:
                          bodyMedium!.copyWith(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 3,
                  child: Text(widget.bilanModel.titleBilan, style: bodyMedium))
            ],
          ),
          const SizedBox(height: p20),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('ACTIF',
                        textAlign: TextAlign.start,
                        style: Responsive.isMobile(context)
                            ? bodyLarge!.copyWith(fontWeight: FontWeight.bold)
                            : headline6!.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: p20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: Responsive.isMobile(context) ? 2 : 3,
                          child: Text("Comptes",
                              textAlign: TextAlign.start,
                              style: Responsive.isMobile(context)
                                  ? bodySmall!
                                      .copyWith(fontWeight: FontWeight.bold)
                                  : bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          flex: Responsive.isMobile(context) ? 2 : 1,
                          child: Text("Montant",
                              textAlign: TextAlign.center,
                              style: Responsive.isMobile(context)
                                  ? bodySmall!
                                      .copyWith(fontWeight: FontWeight.bold)
                                  : bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: p30),
                    compteActifWidget(controller)
                  ],
                ),
              ),
              Container(
                  color: mainColor,
                  width: 2,
                  height: MediaQuery.of(context).size.height / 1.5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(p8),
                  child: Column(
                    children: [
                      Text('PASSIF',
                          textAlign: TextAlign.start,
                          style: Responsive.isMobile(context)
                              ? bodyLarge!.copyWith(fontWeight: FontWeight.bold)
                              : headline6!
                                  .copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: p20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: Responsive.isMobile(context) ? 2 : 3,
                            child: Text("Comptes",
                                textAlign: TextAlign.start,
                                style: Responsive.isMobile(context)
                                    ? bodySmall!
                                        .copyWith(fontWeight: FontWeight.bold)
                                    : bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: Responsive.isMobile(context) ? 2 : 1,
                            child: Text("Montant",
                                textAlign: TextAlign.center,
                                style: Responsive.isMobile(context)
                                    ? bodySmall!
                                        .copyWith(fontWeight: FontWeight.bold)
                                    : bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: p30),
                      comptePassifWidget(controller)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget compteActifWidget(CompteBilanRefController controller) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    List<CompteBilanRefModel>? dataList = controller.compteBilanRefList
        .where((element) =>
            element.reference == widget.bilanModel.id &&
            element.type == "Actif")
        .toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        final actif = dataList[index];
        var codeCompte = actif.comptes.split('_');
        var code = codeCompte.first;
        return Column(
          children: [
            Slidable(
              enabled: (widget.bilanModel.isSubmit == "true" ||
                      widget.bilanModel.approbationDD == "Unapproved" ||
                      widget.bilanModel.approbationDG == "Unapproved")
                  ? false
                  : true,
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                      flex: 2,
                      onPressed: (context) {
                        editLigneButton(controller, actif);
                      },
                      backgroundColor: Colors.purple.shade700,
                      foregroundColor: Colors.white,
                      icon: Icons.edit),
                  SlidableAction(
                    onPressed: (context) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Etes-vous sûr de faire ceci ?'),
                          content: const Text(
                              'Cette action permet de supprimer cette ligne.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Annuler'),
                            ),
                            TextButton(
                                onPressed: () {
                                  controller.deleteData(actif.id);
                                  Navigator.pop(context);
                                },
                                child: const Text('OK')),
                          ],
                        ),
                      );
                    },
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: p10),
                child: Row(
                  children: [
                    Expanded(
                      flex: Responsive.isMobile(context) ? 2 : 3,
                      child: Text(
                          Responsive.isMobile(context) ? code : actif.comptes,
                          textAlign: TextAlign.start,
                          style: bodyMedium),
                    ),
                    Expanded(
                      flex: Responsive.isMobile(context) ? 2 : 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(
                            color: mainColor,
                            width: 2,
                          ),
                        )),
                        child: Text(
                            "${NumberFormat.decimalPattern('fr').format(double.parse(actif.montant))} \$",
                            textAlign: TextAlign.center,
                            style: bodyMedium),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: mainColor),
          ],
        );
      },
    );
  }

  Widget comptePassifWidget(CompteBilanRefController controller) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    List<CompteBilanRefModel>? dataList = controller.compteBilanRefList
        .where((element) =>
            element.reference == widget.bilanModel.id &&
            element.type == "Passif")
        .toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        final passif = dataList[index];
        var codeCompte = passif.comptes.split('_');
        var code = codeCompte.first;

        return Column(
          children: [
            Slidable(
              enabled: (widget.bilanModel.isSubmit == "true" ||
                      widget.bilanModel.approbationDD == "Unapproved" ||
                      widget.bilanModel.approbationDG == "Unapproved")
                  ? false
                  : true,
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    flex: 2,
                    onPressed: (context) {
                      editLigneButton(controller, passif);
                    },
                    backgroundColor: Colors.purple.shade700,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    // label: 'Editer',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Etes-vous sûr de faire ceci ?'),
                          content: const Text(
                              'Cette action permet de supprimer cette ligne.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Annuler'),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.deleteData(passif.id);
                                Navigator.pop(context, 'ok');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    // label: 'Delete',
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: p10),
                child: Row(
                  children: [
                    Expanded(
                      flex: Responsive.isMobile(context) ? 2 : 3,
                      child: Text(
                          Responsive.isMobile(context) ? code : passif.comptes,
                          textAlign: TextAlign.start,
                          style: bodyMedium),
                    ),
                    Expanded(
                      flex: Responsive.isMobile(context) ? 2 : 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(
                            color: mainColor,
                            width: 2,
                          ),
                        )),
                        child: Text(
                            "${NumberFormat.decimalPattern('fr').format(double.parse(passif.montant))} \$",
                            textAlign: TextAlign.center,
                            style: bodyMedium),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: mainColor,
            ),
          ],
        );
      },
    );
  }

  editLigneButton(
      CompteBilanRefController controller, CompteBilanRefModel data) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (dialogContext) {
          final formEditKey = GlobalKey<FormState>();
          bool isLoading = false;
          String? comptesAllSelect;

          List<String> comptesList = [];
          final comptesDropdown = ComptesDropdown().classCompte;
          final class1Dropdown = ComptesDropdown().classe1compte;
          final class2Dropdown = ComptesDropdown().classe2compte;
          final class3Dropdown = ComptesDropdown().classe3compte;
          final class4Dropdown = ComptesDropdown().classe4compte;
          final class5Dropdown = ComptesDropdown().classe5compte;
          final class6Dropdown = ComptesDropdown().classe6compte;
          final class7Dropdown = ComptesDropdown().classe7compte;
          final class8Dropdown = ComptesDropdown().classe8compte;
          final class9Dropdown = ComptesDropdown().classe9compte;

          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text(data.comptes, style: TextStyle(color: mainColor)),
              content: SizedBox(
                  height: Responsive.isMobile(context) ? 350 : 300,
                  width: Responsive.isMobile(context) ? 300 : 400,
                  child: isLoading
                      ? loading()
                      : Form(
                          key: formEditKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              ResponsiveChildWidget(
                                  child1: Container(
                                    margin: const EdgeInsets.only(bottom: p20),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Classe des comptes',
                                        labelStyle: const TextStyle(),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        contentPadding:
                                            const EdgeInsets.only(left: 5.0),
                                      ),
                                      value: comptesAllSelect,
                                      isExpanded: true,
                                      items: comptesDropdown
                                          .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          })
                                          .toSet()
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          comptesAllSelect = value;
                                          comptesList.clear();
                                          switch (comptesAllSelect) {
                                            case "Classe_1_Comptes_de_ressources_durables":
                                              comptesList
                                                  .addAll(class1Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_2_Comptes_Actif_immobilise":
                                              comptesList
                                                  .addAll(class2Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_3_Comptes_de_stocks":
                                              comptesList
                                                  .addAll(class3Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_4_Comptes_de_tiers":
                                              comptesList
                                                  .addAll(class4Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_5_Comptes_de_tresorerie":
                                              comptesList
                                                  .addAll(class5Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_6_Comptes_de_charges_des_activites_ordinaires":
                                              comptesList
                                                  .addAll(class6Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_7_Comptes_de_produits_des_activites_ordinaires":
                                              comptesList
                                                  .addAll(class7Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_8_Comptes_des_autres_charges_et_des_autres_produits":
                                              comptesList
                                                  .addAll(class8Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_9_Comptes_des_engagements_hors_bilan_et_comptes_de_la_comptabilite_analytique_de_gestion":
                                              comptesList
                                                  .addAll(class9Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            default:
                                              comptesList
                                                  .addAll(class9Dropdown);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  child2: Container(
                                    margin: const EdgeInsets.only(bottom: p20),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Comptes',
                                        labelStyle: const TextStyle(),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        contentPadding:
                                            const EdgeInsets.only(left: 5.0),
                                      ),
                                      value: controller.comptes,
                                      isExpanded: true,
                                      items: comptesList.map((String? value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value!),
                                        );
                                      }).toList(),
                                      validator: (value) => value == null
                                          ? "Select compte"
                                          : null,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.comptes = value!;
                                        });
                                      },
                                    ),
                                  )),
                              typeWidget(controller),
                              montant(controller),
                            ],
                          ))),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    isLoading = true;
                    final form = formEditKey.currentState!;
                    if (form.validate()) {
                      controller.submitEdit(data);
                      form.reset();
                    }
                    Navigator.pop(context, 'ok');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget totalMontant(CompteBilanRefController controller) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;

    List<CompteBilanRefModel> dataListActif = controller.compteBilanRefList
        .where((element) =>
            element.reference == widget.bilanModel.id &&
            element.type == "Actif")
        .toList();
    List<CompteBilanRefModel> dataListPassif = controller.compteBilanRefList
        .where((element) =>
            element.reference == widget.bilanModel.id &&
            element.type == "Passif")
        .toList();

    double totalActif = 0.0;
    for (var item in dataListActif) {
      totalActif += double.parse(item.montant);
    }

    double totalPassif = 0.0;
    for (var item in dataListPassif) {
      totalPassif += double.parse(item.montant);
    }

    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: Responsive.isMobile(context) ? 2 : 1,
                  child: Text('TOTAL :',
                      textAlign: TextAlign.start,
                      style: Responsive.isMobile(context)
                          ? bodyLarge!.copyWith(fontWeight: FontWeight.bold)
                          : headline6!.copyWith(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  flex: Responsive.isMobile(context) ? 2 : 3,
                  child: Text(
                      "${NumberFormat.decimalPattern('fr').format(totalActif)} \$",
                      textAlign: TextAlign.start,
                      style: headline6!.copyWith(color: Colors.red.shade700)),
                )
              ],
            ),
          ),
          const SizedBox(width: p20),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: Responsive.isMobile(context) ? 2 : 1,
                  child: Text('TOTAL :',
                      textAlign: TextAlign.start,
                      style: Responsive.isMobile(context)
                          ? bodyLarge!.copyWith(fontWeight: FontWeight.bold)
                          : headline6.copyWith(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  flex: Responsive.isMobile(context) ? 2 : 3,
                  child: Text(
                      "${NumberFormat.decimalPattern('fr').format(totalPassif)} \$",
                      textAlign: TextAlign.start,
                      style: headline6.copyWith(color: Colors.red.shade700)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget deleteButton(BilanController bilanController) {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.blue.shade700),
      tooltip: "Supprimer",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Etes-vous sûr de faire cette action ?',
              style: TextStyle(color: mainColor)),
          content: const Text('Cette action permet de supprimer ce document.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                bilanController.deleteData(widget.bilanModel.id!);
                Navigator.pop(context, 'ok');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  Widget sendButton(BilanController bilanController) {
    return IconButton(
      icon: Icon(Icons.send, color: Colors.green.shade700),
      tooltip: "Soumettre chez le directeur de departement",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Etes-vous pour soumettre ce document ?',
              style: TextStyle(color: mainColor)),
          content: const Text(
              'Cette action permet de soumettre ce document chez le directeur de departement.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                bilanController.sendDD(widget.bilanModel);
                Navigator.pop(context, 'ok');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  newEcritureDialog(CompteBilanRefController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (dialogContext) {
          final formKey = GlobalKey<FormState>();
          bool isLoading = false;
          String? comptesAllSelect;

          List<String> comptesList = [];
          final comptesDropdown = ComptesDropdown().classCompte;
          final class1Dropdown = ComptesDropdown().classe1compte;
          final class2Dropdown = ComptesDropdown().classe2compte;
          final class3Dropdown = ComptesDropdown().classe3compte;
          final class4Dropdown = ComptesDropdown().classe4compte;
          final class5Dropdown = ComptesDropdown().classe5compte;
          final class6Dropdown = ComptesDropdown().classe6compte;
          final class7Dropdown = ComptesDropdown().classe7compte;
          final class8Dropdown = ComptesDropdown().classe8compte;
          final class9Dropdown = ComptesDropdown().classe9compte;

          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text('New document', style: TextStyle(color: mainColor)),
              content: SizedBox(
                  height: Responsive.isMobile(context) ? 350 : 300,
                  width: Responsive.isMobile(context) ? 300 : 400,
                  child: isLoading
                      ? loading()
                      : Form(
                          key: formKey,
                          child: Column(
                            children: [
                              ResponsiveChildWidget(
                                  child1: Container(
                                    margin: const EdgeInsets.only(bottom: p20),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Classe des comptes',
                                        labelStyle: const TextStyle(),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        contentPadding:
                                            const EdgeInsets.only(left: 5.0),
                                      ),
                                      value: comptesAllSelect,
                                      isExpanded: true,
                                      items: comptesDropdown
                                          .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          })
                                          .toSet()
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          comptesAllSelect = value;
                                          comptesList.clear();
                                          switch (comptesAllSelect) {
                                            case "Classe_1_Comptes_de_ressources_durables":
                                              comptesList
                                                  .addAll(class1Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_2_Comptes_Actif_immobilise":
                                              comptesList
                                                  .addAll(class2Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_3_Comptes_de_stocks":
                                              comptesList
                                                  .addAll(class3Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_4_Comptes_de_tiers":
                                              comptesList
                                                  .addAll(class4Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_5_Comptes_de_tresorerie":
                                              comptesList
                                                  .addAll(class5Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_6_Comptes_de_charges_des_activites_ordinaires":
                                              comptesList
                                                  .addAll(class6Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_7_Comptes_de_produits_des_activites_ordinaires":
                                              comptesList
                                                  .addAll(class7Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_8_Comptes_des_autres_charges_et_des_autres_produits":
                                              comptesList
                                                  .addAll(class8Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_9_Comptes_des_engagements_hors_bilan_et_comptes_de_la_comptabilite_analytique_de_gestion":
                                              comptesList
                                                  .addAll(class9Dropdown);
                                              controller.comptes =
                                                  comptesList.first;
                                              break;
                                            default:
                                              comptesList
                                                  .addAll(class9Dropdown);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  child2: Container(
                                    margin: const EdgeInsets.only(bottom: p20),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Comptes',
                                        labelStyle: const TextStyle(),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        contentPadding:
                                            const EdgeInsets.only(left: 5.0),
                                      ),
                                      value: controller.comptes,
                                      isExpanded: true,
                                      items: comptesList.map((String? value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value!),
                                        );
                                      }).toList(),
                                      validator: (value) => value == null
                                          ? "Select compte"
                                          : null,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.comptes = value!;
                                        });
                                      },
                                    ),
                                  )),
                              typeWidget(controller),
                              montant(controller),
                            ],
                          ))),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    isLoading = true;
                    final form = controller.formKey.currentState!;
                    if (form.validate()) {
                      controller.submit(widget.bilanModel);
                      form.reset();
                    }
                    Navigator.pop(context, 'Ok');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget typeWidget(CompteBilanRefController controller) {
    List<String> typeList = ["Actif", "Passif"];
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Type',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.type,
        isExpanded: true,
        items: typeList.map((String? value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value!),
          );
        }).toList(),
        validator: (value) => value == null ? "Select type" : null,
        onChanged: (value) {
          setState(() {
            controller.type = value!;
          });
        },
      ),
    );
  }

  Widget montant(CompteBilanRefController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.montantController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Montant \$',
          ),
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
