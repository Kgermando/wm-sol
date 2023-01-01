import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/logistiques/trajet_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/components/trajets/approbation_trajet.dart';
import 'package:wm_solution/src/pages/logistique/controller/trajets/trajet_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailTrajet extends StatefulWidget {
  const DetailTrajet({super.key, required this.trajetModel});
  final TrajetModel trajetModel;

  @override
  State<DetailTrajet> createState() => _DetailTrajetState();
}

class _DetailTrajetState extends State<DetailTrajet> {
  final TrajetController controller = Get.put(TrajetController());
  final ProfilController profilController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";

  Future<TrajetModel> refresh() async {
    final TrajetModel dataItem =
        await controller.detailView(widget.trajetModel.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(
          context, scaffoldKey, title, widget.trajetModel.conducteur),
      drawer: const DrawerMenu(),
      floatingActionButton: (widget.trajetModel.approbationDD == "Approved") ? addKMRetourButton() : Container(),
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
        (state) => SingleChildScrollView(
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
                                    const TitleWidget(title: "Trajet"),
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
                                                                .logTrajetAutoDetail,
                                                            arguments:
                                                                value));
                                                  },
                                                  icon: const Icon(
                                                      Icons.refresh,
                                                      color: Colors
                                                          .green)),
                                              if (widget.trajetModel
                                                .approbationDD !=
                                            "Approved") IconButton(
                                                  tooltip: 'Supprimer',
                                                  onPressed: () async {
                                                    alertDeleteDialog();
                                                  },
                                                  icon: const Icon(
                                                      Icons.delete),
                                                  color:
                                                      Colors.red.shade700),
                                            ],
                                          ),
                                        SelectableText(
                                            DateFormat("dd-MM-yy HH:mm")
                                                .format(widget
                                                    .trajetModel
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
                        const SizedBox(height: p20),
                        ApprobationTrajet(
                            data: widget.trajetModel,
                            controller: controller,
                            profilController: profilController)
                      ],
                    ),
                  ))) )
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
                  onPressed: () async {
                    controller.trajetApi.deleteData(widget.trajetModel.id!);
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
              child2: SelectableText(widget.trajetModel.nomeroEntreprise,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Conducteur :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.trajetModel.conducteur,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Trajet De... :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.trajetModel.trajetDe,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Trajet A... :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.trajetModel.trajetA,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Mission :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.trajetModel.mission,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Kilometrage de départ :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(
                  "${widget.trajetModel.kilometrageSorite} km/h",
                  textAlign: TextAlign.start,
                  style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Kilometrage de retour :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(
                  "${widget.trajetModel.kilometrageRetour} km/h",
                  textAlign: TextAlign.start,
                  style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Signature :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.trajetModel.signature,
                  textAlign: TextAlign.start, style: bodyMedium)),
        ],
      ),
    );
  }

  Widget kilometrageRetourWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.kilometrageRetourController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'kilometrage retour',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
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

  Widget addKMRetourButton() {
    return (widget.trajetModel.kilometrageRetour != '-')
        ? Container()
        : FloatingActionButton.extended(
            tooltip: "Indiquez le kilometrage de retour",
            label: const Text("kilometrage retour"),
            icon: const Icon(Icons.traffic_outlined),
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Indiquez le kilometrage de retour',
                    style: TextStyle(color: mainColor)),
                content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return SizedBox(
                    height: 100,
                    width: 500,
                    child: controller.isLoading
                        ? loading()
                        : Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                kilometrageRetourWidget(),
                              ],
                            ),
                          ),
                  );
                }),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () {
                      final form = controller.formKey.currentState!;
                      if (form.validate()) {
                        controller.submitUpdate(widget.trajetModel);
                        form.reset();
                      }
                    },
                    child:
                        controller.isLoading ? loadingMini() : const Text('OK'),
                  ),
                ],
              ),
            ),
          );
  }
}
