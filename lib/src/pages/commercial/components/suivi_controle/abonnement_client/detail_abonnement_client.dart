import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/suivi_controle/abonnement_client_model.dart'; 
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/abonnement_client_controller.dart'; 
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailAbonnementClient extends StatefulWidget {
  const DetailAbonnementClient({super.key, required this.abonnementClientModel});
  final AbonnementClientModel abonnementClientModel;

  @override
  State<DetailAbonnementClient> createState() => _DetailAbonnementClientState();
}

class _DetailAbonnementClientState extends State<DetailAbonnementClient> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
 final AbonnementClientController controller =
      Get.put(AbonnementClientController());
  final ProfilController profilController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";

  Future<AbonnementClientModel> refresh() async {
    final AbonnementClientModel dataItem =
        await controller.detailView(widget.abonnementClientModel.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
    int roleUser = int.parse(profilController.user.role);
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(
          context, scaffoldKey, title, widget.abonnementClientModel.typeContrat),
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
                          elevation: 3,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: p20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TitleWidget(title: "Abonnement Client"),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  refresh().then((value) =>
                                                      Navigator.pushNamed(
                                                          context,
                                                          ComRoutes
                                                              .comProduitModelDetail,
                                                          arguments: value));
                                                },
                                                icon: const Icon(Icons.refresh,
                                                    color: Colors.green)),
                                            // Dans le cas d'une erreur il est permet de supprimer le document
                                            // if (roleUser <= 2) editButton(),
                                            if (roleUser <= 2) deleteButton(),
                                          ],
                                        ),
                                        SelectableText(
                                            DateFormat("dd-MM-yyyy HH:mm")
                                                .format(widget
                                                    .abonnementClientModel
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
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  Widget editButton() {
    return IconButton(
      icon: Icon(Icons.edit, color: Colors.purple.shade700),
      tooltip: "Modification",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Etes-vous sûr de modifier ceci?',
              style: TextStyle(color: mainColor)),
          content:
              const Text('Cette action permet de supprimer définitivement.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text('Annuler', style: TextStyle(color: Colors.purple.shade700),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Get.toNamed(ComRoutes.comAbonnementUpdate,
                    arguments: widget.abonnementClientModel);
              },
              child: Text('OK',
                  style: TextStyle(color: Colors.purple.shade700)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteButton() {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.red.shade700),
      tooltip: "Supprimer",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Etes-vous sûr de modifier ceci?',
              style: TextStyle(color: mainColor)),
          content:
              const Text('Cette action permet de supprimer définitivement.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text('Annuler',
                  style: TextStyle(color: Colors.red.shade700)),
            ),
            TextButton(
              onPressed: () {
                controller.deleteData(widget.abonnementClientModel.id!);
                Navigator.pop(context, 'ok');
              },
              child: Text('OK',
                  style: TextStyle(color: Colors.red.shade700)),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [ 
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Nom Social :',
                    textAlign: TextAlign.start,
                    style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.abonnementClientModel.nomSocial,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Date de d"but et Fin du Contrat :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                  widget.abonnementClientModel.dateDebutEtFinContrat,
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Type de Contrat :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.abonnementClientModel.typeContrat,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Montant :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                  "${NumberFormat.decimalPattern('fr').format(double.parse(widget.abonnementClientModel.montant))} ${monnaieStorage.monney}",
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Signataire Contrat:',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.abonnementClientModel.signataireContrat,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),  
          Row(
            children: [
              Expanded(
                child: Text('Signature :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.abonnementClientModel.signature,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          const SizedBox(height: p20),
        ],
      ),
    );
  }
}
