import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/logistiques/material_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/components/materiels/approbation_materiel.dart';
import 'package:wm_solution/src/pages/logistique/components/materiels/table_trajet_roulant.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/trajets/trajet_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailMateriel extends StatefulWidget {
  const DetailMateriel({super.key, required this.materielModel});
  final MaterielModel materielModel;

  @override
  State<DetailMateriel> createState() => _DetailMaterielState();
}

class _DetailMaterielState extends State<DetailMateriel> {
  final MaterielController controller = Get.put(MaterielController());
  final ProfilController profilController = Get.find();
  final TrajetController trajetController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";

  Future<MaterielModel> refresh() async {
    final MaterielModel dataItem =
        await controller.detailView(widget.materielModel.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  widget.materielModel.identifiant),
              drawer: const DrawerMenu(),
              floatingActionButton: (widget.materielModel.typeMateriel == 'Materiel roulant') ? (profilController.user.fonctionOccupe !=
                      'Directeur de departement')
                  ? FloatingActionButton.extended(
                      label: const Text("Ajouter un trajet"),
                      tooltip: "Ajouter un nouveau trajet",
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Get.toNamed(LogistiqueRoutes.logAddTrajetAuto,
                            arguments: widget.materielModel);
                      },
                    )
                  : Container()
                : Container(),
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                      visible: !Responsive.isMobile(context),
                      child: const Expanded(flex: 1, child: DrawerMenu())),
                  Expanded(
                      flex: 5,
                      child: controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) =>  SingleChildScrollView(
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
                                            if(!Responsive.isMobile(context))
                                            TitleWidget(title: widget.materielModel.typeMateriel),
                                            Column(
                                              children: [
                                               
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          tooltip: 'Actualiser',
                                                          onPressed: () async {
                                                            refresh().then((value) =>
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    LogistiqueRoutes
                                                                        .logMaterielDetail,
                                                                    arguments:
                                                                        value));
                                                          },
                                                          icon: const Icon(
                                                              Icons.refresh,
                                                              color: Colors
                                                                  .green)),
                                                      if (widget.materielModel
                                                        .approbationDD !=
                                                    "Approved")     IconButton(
                                                          tooltip: 'Modifier',
                                                          onPressed: () {
                                                            Get.toNamed(
                                                                LogistiqueRoutes
                                                                    .logMaterielUpdate,
                                                                arguments: widget
                                                                    .materielModel);
                                                          },
                                                          icon: const Icon(
                                                              Icons.edit)),
                                                      if (widget.materielModel
                                                        .approbationDD !=
                                                    "Approved")
                                                  IconButton(
                                                          tooltip: 'Supprimer',
                                                          onPressed: () async {
                                                            alertDeleteDialog();
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors
                                                              .red.shade700),
                                                    ],
                                                  ),
                                                SelectableText(
                                                    DateFormat(
                                                            "dd-MM-yyyy HH:mm")
                                                        .format(widget
                                                            .materielModel
                                                            .created),
                                                    textAlign: TextAlign.start),
                                              ],
                                            )
                                          ],
                                        ),
                                        dataWidget()
                                      ],
                                    ),
                                  ),
                                ),
                                if (widget.materielModel.typeMateriel ==
                                    'Materiel roulant')
                                const SizedBox(height: p20),
                                if (widget.materielModel.typeMateriel ==
                                    'Materiel roulant')
                                TableTrajetRoulant(controller: trajetController, materielModel: widget.materielModel),
                                const SizedBox(height: p20),
                                ApprobationMateriel(
                                    data: widget.materielModel,
                                    controller: controller,
                                    profilController: profilController)
                              ],
                            ),
                          ))))
                ],
              ),
            )
    
    
    
    ;
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
                    controller.materielsApi
                        .deleteData(widget.materielModel.id!);
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
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Type materiel :',
                    textAlign: TextAlign.start,
                    style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(widget.materielModel.typeMateriel,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Identifiant :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(widget.materielModel.identifiant,
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(color: Colors.blueGrey)),
              )
            ],
          ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Marque :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(widget.materielModel.marque,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Modèle :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(widget.materielModel.modele,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Numéro Reference :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(widget.materielModel.numeroRef,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Couleur :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(widget.materielModel.couleur,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Genre :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(widget.materielModel.genre,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Quantité max du reservoir :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(
                    "${widget.materielModel.qtyMaxReservoir} L",
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Date de fabrication :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(
                    DateFormat("dd-MM-yyyy")
                        .format(widget.materielModel.dateFabrication),
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          if (widget.materielModel.typeMateriel == "Materiel roulant")
            Divider(
              color: mainColor,
            ),
          if (widget.materielModel.typeMateriel == "Materiel roulant")
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('Numéro plaque :',
                      textAlign: TextAlign.start,
                      style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  flex: 3,
                  child: SelectableText(widget.materielModel.numeroPLaque,
                      textAlign: TextAlign.start, style: bodyMedium),
                )
              ],
            ),
          if (widget.materielModel.typeMateriel == "Materiel roulant")
            Divider(
              color: mainColor,
            ),
          if (widget.materielModel.typeMateriel == "Materiel roulant")
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('kilometrage Initiale :',
                      textAlign: TextAlign.start,
                      style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  flex: 3,
                  child: SelectableText(
                      "${widget.materielModel.kilometrageInitiale} KM",
                      textAlign: TextAlign.start,
                      style: bodyMedium),
                )
              ],
            ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Fournisseur :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(widget.materielModel.fournisseur,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Signature :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(widget.materielModel.signature,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
        ],
      ),
    );
  }
}
