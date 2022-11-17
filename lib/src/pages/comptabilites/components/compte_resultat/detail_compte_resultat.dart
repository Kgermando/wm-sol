import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comptabilites/compte_resultat_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/components/compte_resultat/approbation_compte_resultat.dart';
import 'package:wm_solution/src/pages/comptabilites/components/compte_resultat/compte_resultat_pdf.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/compte_resultat/compte_resultat_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailCompteResultat extends StatefulWidget {
  const DetailCompteResultat({super.key, required this.compteResulatsModel});
  final CompteResulatsModel compteResulatsModel;

  @override
  State<DetailCompteResultat> createState() => _DetailCompteResultatState();
}

class _DetailCompteResultatState extends State<DetailCompteResultat> {
  final CompteResultatController controller = Get.find();
  final ProfilController profilController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilités";

  double totalCharges1 = 0.0;
  double totalCharges123 = 0.0;
  double totalGeneralCharges = 0.0;

  double totalProduits1 = 0.0;
  double totalProduits123 = 0.0;
  double totalGeneralProduits = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(
          context, scaffoldKey, title, widget.compteResulatsModel.intitule),
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
                        pageDetail(),
                        const SizedBox(height: p20),
                        ApprobationCompteResultat(
                            data: widget.compteResulatsModel,
                            controller: controller,
                            profilController: profilController)
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
 
  Widget pageDetail() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Card(
          elevation: 10,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleWidget(title: "Compte Resultat"),
                  Column(
                    children: [
                      Row(
                        children: [
                          if (widget.compteResulatsModel.approbationDD == '-' ||
                              widget.compteResulatsModel.approbationDD ==
                                  "Unapproved")
                            editButton(),
                          if (int.parse(profilController.user.role) <= 3 ||
                              widget.compteResulatsModel.approbationDD == '-')
                            deleteButton(controller),
                          PrintWidget(
                              tooltip: 'Imprimer le document',
                              onPressed: () async {
                                await CompteResultatPdf.generate(
                                    widget.compteResulatsModel,
                                    totalCharges1,
                                    totalCharges123,
                                    totalGeneralCharges,
                                    totalProduits1,
                                    totalProduits123,
                                    totalGeneralProduits);
                              }),
                        ],
                      ),
                      SelectableText(
                          DateFormat("dd-MM-yyyy HH:mm")
                              .format(widget.compteResulatsModel.created),
                          textAlign: TextAlign.start),
                    ],
                  )
                ],
              ),
              dataWidget(),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget editButton() {
    return IconButton(
      icon: Icon(Icons.edit, color: Colors.purple.shade700),
      tooltip: "Modifier",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Etes-vous sûr de faire cette action ?',
              style: TextStyle(color: Colors.purple)),
          content: const Text('Cette action permet de modifier ce document.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'cancel'),
              child:
                  const Text('Annuler', style: TextStyle(color: Colors.purple)),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(ComptabiliteRoutes.comptabiliteCompteResultatUpdate,
                    arguments: widget.compteResulatsModel);
                Navigator.pop(context, 'ok');
              },
              child: const Text('OK', style: TextStyle(color: Colors.purple)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteButton(CompteResultatController controller) {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.red.shade700),
      tooltip: "Supprimer",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Etes-vous sûr de faire cette action ?',
              style: TextStyle(color: Colors.red)),
          content:
              const Text('Cette action va supprimer difinitivement le ficher.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'cancel'),
              child: const Text('Annuler', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                controller.compteResultatApi
                    .deleteData(widget.compteResulatsModel.id!)
                    .then((value) => Navigator.of(context).pop());
                Navigator.pop(context, 'ok');
              },
              child: const Text('OK', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataWidget() {
    TextStyle? headline6;
    TextStyle? bodyLarge;

    if (Responsive.isMobile(context)) {
      headline6 = Theme.of(context).textTheme.bodyLarge;
      bodyLarge = Theme.of(context).textTheme.bodyMedium;
    } else {
      headline6 = Theme.of(context).textTheme.headline6;
      bodyLarge = Theme.of(context).textTheme.bodyLarge;
    }
    return Padding(
      padding: const EdgeInsets.all(p8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('Charges (Hors taxes)',
                        textAlign: TextAlign.start,
                        style:
                            headline6!.copyWith(fontWeight: FontWeight.bold)),
                    Divider(color: mainColor),
                    const SizedBox(height: p20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SelectableText("Comptes",
                              textAlign: TextAlign.start,
                              style: bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          flex: Responsive.isMobile(context) ? 3 : 1,
                          child: SelectableText("Exercice",
                              textAlign: TextAlign.center,
                              style: bodyLarge.copyWith(
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    Divider(color: mainColor),
                    const SizedBox(height: p30),
                    chargeWidget()
                  ],
                ),
              ),
              Container(
                  color: mainColor,
                  width: 2,
                  height: MediaQuery.of(context).size.height / 1.3),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: p8),
                  child: Column(
                    children: [
                      Text('Produits (Hors taxes)',
                          textAlign: TextAlign.start,
                          style:
                              headline6.copyWith(fontWeight: FontWeight.bold)),
                      Divider(color: mainColor),
                      const SizedBox(height: p20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: SelectableText("Comptes",
                                textAlign: TextAlign.start,
                                style: bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: Responsive.isMobile(context) ? 3 : 1,
                            child: SelectableText("Exercice",
                                textAlign: TextAlign.center,
                                style: bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      Divider(color: mainColor),
                      const SizedBox(height: p30),
                      produitWidget()
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

  Widget chargeWidget() {
    TextStyle? headline6;
    TextStyle? bodyLarge;
    TextStyle? bodyMedium;

    if (Responsive.isMobile(context)) {
      headline6 = Theme.of(context).textTheme.bodyLarge;
      bodyLarge = Theme.of(context).textTheme.bodyMedium;
      bodyMedium = Theme.of(context).textTheme.bodySmall;
    } else {
      headline6 = Theme.of(context).textTheme.headline6;
      bodyLarge = Theme.of(context).textTheme.bodyLarge;
      bodyMedium = Theme.of(context).textTheme.bodyMedium;
    }


    totalCharges1 = double.parse(widget.compteResulatsModel.achatMarchandises) +
        double.parse(widget.compteResulatsModel.variationStockMarchandises) +
        double.parse(widget.compteResulatsModel.achatApprovionnements) +
        double.parse(widget.compteResulatsModel.variationApprovionnements) +
        double.parse(widget.compteResulatsModel.autresChargesExterne) +
        double.parse(
            widget.compteResulatsModel.impotsTaxesVersementsAssimiles) +
        double.parse(widget.compteResulatsModel.renumerationPersonnel) +
        double.parse(widget.compteResulatsModel.chargesSocialas) +
        double.parse(widget.compteResulatsModel.dotatiopnsProvisions) +
        double.parse(widget.compteResulatsModel.autresCharges) +
        double.parse(widget.compteResulatsModel.chargesfinancieres);

    totalCharges123 = totalCharges1 +
        double.parse(widget.compteResulatsModel.chargesExptionnelles) +
        double.parse(widget.compteResulatsModel.impotSurbenefices);
    totalGeneralCharges = totalCharges123 +
        double.parse(widget.compteResulatsModel.soldeCrediteur);
 

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Achats Marchandises",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.achatMarchandises))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Variation Stock Marchandises",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.variationStockMarchandises))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Achats Approvionnements",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.achatApprovionnements))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Variation Approvionnements",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.variationApprovionnements))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Autres Charges Externe",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.autresChargesExterne))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Impôts Taxes et Versements Assimilés",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.impotsTaxesVersementsAssimiles))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Renumeration du Personnel",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.renumerationPersonnel))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Charges Sociales",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.chargesSocialas))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Dotatiopns Provisions",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.dotatiopnsProvisions))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Autres Charges",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.autresCharges))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Charges financieres",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.chargesfinancieres))} \$",
                    textAlign: TextAlign.center,
                    style: bodyLarge),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        ResponsiveChildWidget(
            child1: Text('Total (I):',
                textAlign: TextAlign.start,
                style: headline6!.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                "${NumberFormat.decimalPattern('fr').format(totalCharges1)} \$",
                textAlign: TextAlign.start,
                style: headline6.copyWith(color: Colors.red.shade700))),
        Divider(
          color: Colors.red.shade700,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Charges exptionnelles (II)",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.chargesExptionnelles))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: Colors.red.shade700,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Impôt Sur les benefices (III)",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.impotSurbenefices))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: Colors.red.shade700,
        ),
        ResponsiveChildWidget(
            child1: AutoSizeText('Total des charges(I + II + III):',
                textAlign: TextAlign.start,
                maxLines: 1,
                style: headline6.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                "${NumberFormat.decimalPattern('fr').format(totalCharges123)} \$",
                textAlign: TextAlign.start,
                style: headline6.copyWith(color: Colors.red.shade700))),
        Divider(
          color: Colors.red.shade700,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Solde Crediteur (bénéfice) ",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.soldeCrediteur))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        const SizedBox(height: p20),
        Divider(
          color: Colors.red.shade700,
        ),
        Responsive.isMobile(context)
            ? Column(
                children: [
                  Text('TOTAL GENERAL :',
                      textAlign: TextAlign.start,
                      style: headline6.copyWith(fontWeight: FontWeight.bold)),
                  SelectableText(
                      "${NumberFormat.decimalPattern('fr').format(totalGeneralCharges)} \$",
                      textAlign: TextAlign.start,
                      style: headline6.copyWith(color: Colors.red.shade700)),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text('TOTAL GENERAL :',
                        textAlign: TextAlign.start,
                        style: headline6.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: Responsive.isMobile(context) ? 3 : 1,
                    child: SelectableText(
                        "${NumberFormat.decimalPattern('fr').format(totalGeneralCharges)} \$",
                        textAlign: TextAlign.start,
                        style: headline6.copyWith(color: Colors.red.shade700)),
                  )
                ],
              ),
        Divider(
          color: Colors.red.shade700,
        ),
      ],
    );
  }

  Widget produitWidget() {
    TextStyle? headline6;
    TextStyle? bodyMedium;

    if (Responsive.isMobile(context)) {
      headline6 = Theme.of(context).textTheme.bodyLarge;
      bodyMedium = Theme.of(context).textTheme.bodySmall;
    } else {
      headline6 = Theme.of(context).textTheme.headline6;
      bodyMedium = Theme.of(context).textTheme.bodyMedium;
    }

    totalProduits1 = double.parse(
            widget.compteResulatsModel.ventesMarchandises) +
        double.parse(widget.compteResulatsModel.productionVendueBienEtSerices) +
        double.parse(widget.compteResulatsModel.productionStockee) +
        double.parse(widget.compteResulatsModel.productionImmobilisee) +
        double.parse(widget.compteResulatsModel.subventionExploitation) +
        double.parse(widget.compteResulatsModel.autreProduits) +
        double.parse(widget.compteResulatsModel.produitfinancieres);

    totalProduits123 = totalProduits1 +
        double.parse(widget.compteResulatsModel.produitExceptionnels);
    totalGeneralProduits = totalProduits123 +
        double.parse(widget.compteResulatsModel.soldeDebiteur) +
        double.parse(widget.compteResulatsModel.montantExportation);

    
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Ventes Marchandises",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.ventesMarchandises))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Production Vendue des Biens Et Services",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.productionVendueBienEtSerices))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Production Stockée",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.productionStockee))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Production Immobilisée",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.productionImmobilisee))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Subvention d'exploitations",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.subventionExploitation))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Autres Produits",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.autreProduits))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Produit financieres",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.produitfinancieres))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: mainColor,
        ),
        ResponsiveChildWidget(
          child1: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total (I):',
                  textAlign: TextAlign.start,
                  style: headline6!.copyWith(fontWeight: FontWeight.bold)),
              SelectableText("Dont à l'exportation :",
                  textAlign: TextAlign.start, style: bodyMedium),
            ],
          ),
          child2: Column(
            children: [
              SelectableText(
                  "${NumberFormat.decimalPattern('fr').format(totalProduits1)} \$",
                  textAlign: TextAlign.start,
                  style: headline6.copyWith(color: Colors.red.shade700)),
              SelectableText(
                  "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.montantExportation))} \$",
                  textAlign: TextAlign.center,
                  style: bodyMedium),
            ],
          ),
        ),
        Divider(
          color: Colors.red.shade700,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Produit exceptionnels (II)",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.produitExceptionnels))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        Divider(
          color: Colors.red.shade700,
        ),
        ResponsiveChildWidget(
          child1: Text('Total des produits(I + II):',
              textAlign: TextAlign.start,
              style: headline6.copyWith(fontWeight: FontWeight.bold)),
          child2: SelectableText(
              "${NumberFormat.decimalPattern('fr').format(totalProduits123)} \$",
              textAlign: TextAlign.start,
              style: headline6.copyWith(color: Colors.red.shade700)),
        ),
        Divider(
          color: Colors.red.shade700,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SelectableText("Solde debiteur (pertes) :",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Expanded(
              flex: Responsive.isMobile(context) ? 3 : 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.compteResulatsModel.soldeDebiteur))} \$",
                    textAlign: TextAlign.center,
                    style: bodyMedium),
              ),
            )
          ],
        ),
        const SizedBox(height: p20),
        Divider(
          color: Colors.red.shade700,
        ),
        ResponsiveChildWidget(
          child1: Text('TOTAL GENERAL :',
              textAlign: TextAlign.start,
              style: headline6.copyWith(fontWeight: FontWeight.bold)),
          child2: SelectableText(
              "${NumberFormat.decimalPattern('fr').format(totalGeneralProduits)} \$",
              textAlign: TextAlign.start,
              style: headline6.copyWith(color: Colors.red.shade700)),
        ),
        Divider(
          color: Colors.red.shade700,
        ),
      ],
    );
  }
}
