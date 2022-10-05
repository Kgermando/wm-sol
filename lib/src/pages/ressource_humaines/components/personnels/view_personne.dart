import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/agent_pdf.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class ViewPersonne extends StatefulWidget {
  const ViewPersonne({super.key, required this.personne});
  final AgentModel personne;

  @override
  State<ViewPersonne> createState() => _ViewPersonneState();
}

class _ViewPersonneState extends State<ViewPersonne> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: p20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TitleWidget(title: 'Curriculum vitæ'),
              Row(
                children: [
                  // if (int.parse(
                  //       profilController.user.role) == 0 &&
                  //     actionnaire.isEmpty)
                  //   IconButton(
                  //       color: Colors.red.shade700,
                  //       tooltip: 'Ajout Actionnaire',
                  //       onPressed: () {
                  //         actionnaireDialog(agentModel);
                  //       },
                  //       icon: const Icon(
                  //           Icons.admin_panel_settings)),
                  PrintWidget(
                      tooltip: "Imprimer le CV",
                      onPressed: () async {
                        await AgentPdf.generate(widget.personne);
                      }),
                ],
              )
            ],
          ),
          identiteWidget(),
          serviceWidget(),
          competenceExperienceWidget(),
          infosEditeurWidget(),
        ]),
      ),
    );
  }

  Widget identiteWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          Responsive.isMobile(context)
              ? Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: SfBarcodeGenerator(
                                value: widget.personne.matricule,
                                symbology: QRCode(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Statut agent : ',
                                textAlign: TextAlign.start,
                                style: bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            (widget.personne.statutAgent == 'true')
                                ? Text('Actif',
                                    textAlign: TextAlign.start,
                                    style: bodyMedium.copyWith(
                                        color: Colors.green.shade700))
                                : Text('Inactif',
                                    textAlign: TextAlign.start,
                                    style: bodyMedium.copyWith(
                                        color: Colors.orange.shade700))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                "Créé le. ${DateFormat("dd-MM-yyyy HH:mm").format(widget.personne.createdAt)}",
                                textAlign: TextAlign.start,
                                style: bodyMedium),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                "Mise à jour le. ${DateFormat("dd-MM-yyyy HH:mm").format(widget.personne.created)}",
                                textAlign: TextAlign.start,
                                style: bodyMedium),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: p20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: mainColor,
                          child: ClipOval(
                              child: (widget.personne.photo == null)
                                  ? Image.asset(
                                      'assets/images/avatar.jpg',
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    )
                                  : Image.network(
                                      width: 150,
                                      height: 150,
                                      widget.personne.photo!,
                                      fit: BoxFit.cover, loadingBuilder:
                                          (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(child: loadingMini());
                                    }, errorBuilder:
                                          (context, error, stackTrace) {
                                      if (kDebugMode) {
                                        print("error $error");
                                      }
                                      return Image.asset(
                                        'assets/images/avatar.jpg',
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      );
                                    })),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: mainColor,
                      child: ClipOval(
                          child: (widget.personne.photo == null)
                              ? Image.asset(
                                  'assets/images/avatar.jpg',
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                )
                              : Image.network(
                                  width: 150,
                                  height: 150,
                                  widget.personne.photo!,
                                  fit: BoxFit.cover, loadingBuilder:
                                      (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(child: loadingMini());
                                }, errorBuilder: (context, error, stackTrace) {
                                  if (kDebugMode) {
                                    print("error $error");
                                  }
                                  return Image.asset(
                                    'assets/images/avatar.jpg',
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  );
                                })),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: SfBarcodeGenerator(
                                value: widget.personne.matricule,
                                symbology: QRCode(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Statut agent : ',
                                textAlign: TextAlign.start,
                                style: bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            (widget.personne.statutAgent == 'true')
                                ? Text('Actif',
                                    textAlign: TextAlign.start,
                                    style: bodyMedium.copyWith(
                                        color: Colors.green.shade700))
                                : Text('Inactif',
                                    textAlign: TextAlign.start,
                                    style: bodyMedium.copyWith(
                                        color: Colors.orange.shade700))
                          ],
                        ),
                        Text(
                            "Créé le. ${DateFormat("dd-MM-yyyy HH:mm").format(widget.personne.createdAt)}",
                            textAlign: TextAlign.start,
                            style: bodyMedium),
                        Text(
                            "Mise à jour le. ${DateFormat("dd-MM-yyyy HH:mm").format(widget.personne.created)}",
                            textAlign: TextAlign.start,
                            style: bodyMedium),
                      ],
                    )
                  ],
                ),
          const SizedBox(
            height: p20,
          ),
          ResponsiveChildWidget(
              child1: Text('Nom :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.nom,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Post-Nom :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.postNom,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Prénom :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.prenom,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Email :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.email,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Téléphone :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.telephone,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Sexe :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.sexe,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Niveau d\'accréditation :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.role,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Matricule :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.matricule,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Numéro de sécurité sociale :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.numeroSecuriteSociale,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Lieu de naissance :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.lieuNaissance,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Date de naissance :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: Text(
                  DateFormat("dd-MM-yyyy")
                      .format(widget.personne.dateNaissance),
                  textAlign: TextAlign.start,
                  style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Nationalité :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.nationalite,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Adresse :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.adresse,
                  textAlign: TextAlign.start, style: bodyMedium)),
        ],
      ),
    );
  }

  Widget serviceWidget() {
    final ProfilController profilController = Get.find();
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final role = int.parse(profilController.user.role);
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
              child1: Text('Type de Contrat :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.typeContrat,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Fonction occupée :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.fonctionOccupe,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Département :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.departement,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Services d\'affectation :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.personne.servicesAffectation,
                  textAlign: TextAlign.start, style: bodyMedium)),
          ResponsiveChildWidget(
              child1: Text('Date de début du contrat :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(
                  DateFormat("dd-MM-yyyy")
                      .format(widget.personne.dateDebutContrat),
                  textAlign: TextAlign.start,
                  style: bodyMedium)),
          if (widget.personne.typeContrat == 'CDD')
            ResponsiveChildWidget(
                child1: Text('Date de fin du contrat :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                child2: SelectableText(
                    DateFormat("dd-MM-yyyy")
                        .format(widget.personne.dateFinContrat),
                    textAlign: TextAlign.start,
                    style: bodyMedium)),
          if (role <= 3)
            ResponsiveChildWidget(
                child1: Text('Salaire :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                child2: SelectableText("${widget.personne.salaire} USD",
                    textAlign: TextAlign.start, style: bodyMedium)),
        ],
      ),
    );
  }

  Widget competenceExperienceWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Formation :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              SelectableText(widget.personne.competance!,
                  textAlign: TextAlign.justify, style: bodyMedium)
            ],
          ),
          const SizedBox(height: p30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Experience :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              SelectableText(widget.personne.experience!,
                  textAlign: TextAlign.justify, style: bodyMedium)
            ],
          ),
        ],
      ),
    );
  }

  Widget infosEditeurWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Signature :',
              style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
          SelectableText(widget.personne.signature,
              textAlign: TextAlign.justify, style: bodyMedium)
        ],
      ),
    );
  }
}