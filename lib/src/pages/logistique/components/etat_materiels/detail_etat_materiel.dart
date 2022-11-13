import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/logistiques/etat_materiel_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/components/etat_materiels/approbation_etat_materiel.dart';
import 'package:wm_solution/src/pages/logistique/controller/etat_materiel/etat_materiel_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailEtatMateriel extends StatefulWidget {
  const DetailEtatMateriel({super.key, required this.etatMaterielModel});
  final EtatMaterielModel etatMaterielModel;

  @override
  State<DetailEtatMateriel> createState() => _DetailEtatMaterielState();
}

class _DetailEtatMaterielState extends State<DetailEtatMateriel> {
  final EtatMaterielController controller = Get.find();
  final ProfilController profilController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(
                  context, scaffoldKey, title, widget.etatMaterielModel.nom),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const TitleWidget(
                                                title: "Etat Materiel"),
                                            Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    if ( widget.etatMaterielModel
                                                            .approbationDD ==
                                                        "Unapproved")
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                              tooltip:
                                                                  'Modifier',
                                                              onPressed: () {
                                                                Get.toNamed(
                                                                    LogistiqueRoutes
                                                                        .logEtatMaterielUpdate,
                                                                    arguments:
                                                                        widget
                                                                            .etatMaterielModel);
                                                              },
                                                              icon: const Icon(
                                                                  Icons.edit)),
                                                          IconButton(
                                                              tooltip:
                                                                  'Supprimer',
                                                              onPressed:
                                                                  () async {
                                                                alertDeleteDialog();
                                                              },
                                                              icon: const Icon(
                                                                  Icons.delete),
                                                              color: Colors.red
                                                                  .shade700),
                                                        ],
                                                      ),
                                                    SelectableText(
                                                        DateFormat(
                                                                "dd-MM-yy HH:mm")
                                                            .format(widget
                                                                .etatMaterielModel
                                                                .created),
                                                        textAlign:
                                                            TextAlign.start),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        dataWidget(),
                                        const SizedBox(height: p20),
                                        ApprobationEtatMateriel(
                                            data: widget.etatMaterielModel,
                                            controller: controller,
                                            profilController: profilController)
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

  alertDeleteDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Etes-vous sûr de vouloir faire ceci ?',
                  style: TextStyle(color: Colors.red)),
              content: const SizedBox(
                  height: 100,
                  width: 100,
                  child: Text("Cette action permet de supprimer le document")),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler',
                      style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: () {
                    controller.etatMaterielApi
                        .deleteData(widget.etatMaterielModel.id!);
                  },
                  child: const Text('OK', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          });
        });
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
              child1: Text('Identifiant :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.etatMaterielModel.nom,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          // ResponsiveChildWidget(
          //     child1: Text('Modèle :',
          //         textAlign: TextAlign.start,
          //         style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
          //     child2: SelectableText(widget.etatMaterielModel.modele,
          //         textAlign: TextAlign.start, style: bodyMedium)),
          // Divider(
          //   color: mainColor,
          // ),
          // ResponsiveChildWidget(
          //     child1: Text('Marque :',
          //         textAlign: TextAlign.start,
          //         style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
          //     child2: SelectableText(widget.etatMaterielModel.marque,
          //         textAlign: TextAlign.start, style: bodyMedium)),
          // Divider(
          //   color: mainColor,
          // ),
          ResponsiveChildWidget(
              child1: Text('Type d\'Objet :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.etatMaterielModel.typeObjet,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          if (profilController.user.fonctionOccupe ==
              "Directeur de departement" && widget.etatMaterielModel.approbationDD == "Approved")
            ResponsiveChildWidget(
                child1: Text('Changez Statut :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                child2: statutWidget()),
          Row(
            children: [
              Expanded(
                child: Text('Statut :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              if (widget.etatMaterielModel.statut == 'Actif')
                Expanded(
                  child: SelectableText(widget.etatMaterielModel.statut,
                      textAlign: TextAlign.start,
                      style: bodyMedium.copyWith(color: Colors.green.shade700)),
                ),
              if (widget.etatMaterielModel.statut == 'Inactif')
                Expanded(
                  child: SelectableText(widget.etatMaterielModel.statut,
                      textAlign: TextAlign.start,
                      style:
                          bodyMedium.copyWith(color: Colors.orange.shade700)),
                ),
              if (widget.etatMaterielModel.statut == 'Déclasser')
                Expanded(
                  child: SelectableText(widget.etatMaterielModel.statut,
                      textAlign: TextAlign.start,
                      style: bodyMedium.copyWith(color: Colors.red.shade700)),
                )
            ],
          ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                child: Text('Signature :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.etatMaterielModel.signature,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget statutWidget() {
    List<String> statutObjetList = ["Actif", "Inactif", "Déclasser"];
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Statut',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.statutObjet,
        isExpanded: true,
        items: statutObjetList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.statutObjet = value!;
            controller.submitStatut(widget.etatMaterielModel);
          });
        },
      ),
    );
  }
}
