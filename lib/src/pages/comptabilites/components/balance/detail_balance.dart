import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comptabilites/balance_comptes_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/components/balance/balance_pdf.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_ref_controller.dart';
import 'package:wm_solution/src/utils/comptes_dropdown.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child4_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailBalance extends StatefulWidget {
  const DetailBalance({super.key, required this.balanceCompteModel});
  final BalanceCompteModel balanceCompteModel;

  @override
  State<DetailBalance> createState() => _DetailBalanceState();
}

class _DetailBalanceState extends State<DetailBalance> {
  final BalanceController controller = Get.put(BalanceController());
  final ProfilController profilController = Get.put(ProfilController());
  final BalanceRefController balanceRefController =
      Get.put(BalanceRefController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabiliés";

  @override
  Widget build(BuildContext context) {
    return balanceRefController.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(
                  context, scaffoldKey, title, widget.balanceCompteModel.title),
              drawer: const DrawerMenu(),
              floatingActionButton:
                  (widget.balanceCompteModel.isSubmit == 'false' &&
                          widget.balanceCompteModel.approbationDD == '-')
                      ? FloatingActionButton.extended(
                          label: const Text("Ajouter une écriture"),
                          tooltip: "Ecriture sur la feuille balance",
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            newEcritureDialog(balanceRefController);
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
                                            TitleWidget(
                                                title:
                                                    Responsive.isMobile(context)
                                                        ? "Balance"
                                                        : "Comptes Balance"),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    if (widget.balanceCompteModel
                                                                .signature ==
                                                            profilController
                                                                .user
                                                                .matricule &&
                                                        widget.balanceCompteModel
                                                                .isSubmit ==
                                                            "false") // Uniqyement celui a remplit le document
                                                      sendButton(controller),
                                                    if (widget
                                                            .balanceCompteModel
                                                            .approbationDD ==
                                                        "-")
                                                      deleteButton(controller),
                                                    PrintWidget(
                                                        tooltip:
                                                            'Imprimer le document',
                                                        onPressed: () async {
                                                          var compteBalanceRefPdf =
                                                              balanceRefController
                                                                  .compteBalanceRefList
                                                                  .where((element) =>
                                                                      element
                                                                          .reference ==
                                                                      widget
                                                                          .balanceCompteModel
                                                                          .id)
                                                                  .toList();
                                                          await BalancePdf.generate(
                                                              widget
                                                                  .balanceCompteModel,
                                                              compteBalanceRefPdf);
                                                        }),
                                                  ],
                                                ),
                                                Text(
                                                    DateFormat(
                                                            "dd-MM-yyyy HH:mm")
                                                        .format(widget
                                                            .balanceCompteModel
                                                            .created),
                                                    textAlign: TextAlign.start),
                                              ],
                                            )
                                          ],
                                        ),
                                        dataWidget(balanceRefController),
                                        totalMontant(balanceRefController)
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

  Widget totalMontant(BalanceRefController balanceRefController) {
    final headline6 = Theme.of(context).textTheme.headline6;
    List<CompteBalanceRefModel>? dataList = balanceRefController
        .compteBalanceRefList
        .where((element) => element.reference == widget.balanceCompteModel.id)
        .toList();
    double totalDebit = 0.0;
    double totalCredit = 0.0;
    double totalSolde = 0.0;

    for (var item in dataList) {
      totalDebit += double.parse(item.debit);
      totalCredit += double.parse(item.credit);
      totalSolde += double.parse(item.solde);

      // print("item.debit ${item.debit} ");
    }

    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChild4Widget(
              flex1: 3,
              flex2: 1,
              flex3: 1,
              flex4: 1,
              child1: Text("TOTAL :",
                  textAlign: TextAlign.start,
                  style: headline6!.copyWith(fontWeight: FontWeight.bold)),
              child2: Container(
                decoration: const BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                )),
                child: Text(
                    "${NumberFormat.decimalPattern('fr').format(totalDebit)} \$",
                    textAlign: TextAlign.center,
                    style: headline6.copyWith(fontWeight: FontWeight.bold)),
              ),
              child3: Container(
                decoration: const BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                )),
                child: Text(
                    "${NumberFormat.decimalPattern('fr').format(totalCredit)} \$",
                    textAlign: TextAlign.center,
                    style: headline6.copyWith(fontWeight: FontWeight.bold)),
              ),
              child4: Container(
                decoration: const BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                )),
                child: Text(
                    "${NumberFormat.decimalPattern('fr').format(totalSolde)} \$",
                    textAlign: TextAlign.center,
                    style: headline6.copyWith(fontWeight: FontWeight.bold)),
              ))
        ],
      ),
    );
  }

  Widget dataWidget(BalanceRefController balanceRefController) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(widget.balanceCompteModel.title, style: bodyLarge)],
          ),
          const SizedBox(height: p20),
          Divider(color: mainColor),
          ResponsiveChild4Widget(
            mainAxisAlignment: MainAxisAlignment.start,
            flex1: 3,
            flex2: 1,
            flex3: 1,
            flex4: 1,
            child1: Container(
              decoration: const BoxDecoration(),
              child: Text("Comptes",
                  textAlign: TextAlign.start,
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
            ),
            child2: Container(
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
              )),
              child: Text("Débit",
                  textAlign: TextAlign.center,
                  style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            ),
            child3: Container(
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
              )),
              child: Text("Crédit",
                  textAlign: TextAlign.center,
                  style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            ),
            child4: Container(
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
              )),
              child: Text("Solde",
                  textAlign: TextAlign.center,
                  style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          Divider(color: mainColor),
          const SizedBox(height: p30),
          compteWidget()
        ],
      ),
    );
  }

  Widget compteWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    var dataList = balanceRefController.compteBalanceRefList
        .where((element) => element.reference == widget.balanceCompteModel.id)
        .toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        final compte = dataList[index];
        return Column(
          children: [
            Slidable(
              enabled: (widget.balanceCompteModel.isSubmit == "true" ||
                      widget.balanceCompteModel.approbationDD == "Unapproved")
                  ? false
                  : true,
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                      onPressed: (context) {
                        editLigneButton(balanceRefController, compte);
                      },
                      backgroundColor: Colors.purple.shade700,
                      foregroundColor: Colors.white,
                      icon: Icons.edit),
                  SlidableAction(
                    onPressed: (context) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Etes-vous sûr de faire ceci ?',
                              style: TextStyle(color: mainColor)),
                          content: const Text(
                              'Cette action permet de supprimer cette ligne.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Annuler'),
                            ),
                            TextButton(
                                onPressed: () async {
                                  balanceRefController.deleteData(compte.id!);
                                  Navigator.pop(context, 'ok');
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
                padding: const EdgeInsets.only(bottom: p20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(compte.comptes,
                          textAlign: TextAlign.start, style: bodyMedium),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(
                            color: mainColor,
                            width: 2,
                          ),
                        )),
                        child: Text(
                            (compte.debit == "0")
                                ? "-"
                                : "${NumberFormat.decimalPattern('fr').format(double.parse(compte.debit))} \$",
                            textAlign: TextAlign.center,
                            style: bodyMedium),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(
                            color: mainColor,
                            width: 2,
                          ),
                        )),
                        child: Text(
                            (compte.credit == "0")
                                ? "-"
                                : "${NumberFormat.decimalPattern('fr').format(double.parse(compte.credit))} \$",
                            textAlign: TextAlign.center,
                            style: bodyMedium),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(
                            color: mainColor,
                            width: 2,
                          ),
                        )),
                        child: Text(
                            "${NumberFormat.decimalPattern('fr').format(double.parse(compte.solde))} \$",
                            textAlign: TextAlign.center,
                            style: bodyMedium),
                      ),
                    )
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

  Widget deleteButton(BalanceController controller) {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.red.shade700),
      tooltip: "Supprimer",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Etes-vous sûr de faire cette action ?'),
          content: const Text(
              'Cette action permet de permet de mettre ce fichier en corbeille.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                controller.deleteData(widget.balanceCompteModel.id!);
                Navigator.pop(context, 'ok');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  Widget sendButton(BalanceController controller) {
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
                controller.sendDD(widget.balanceCompteModel);
                Navigator.pop(context, 'ok');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  newEcritureDialog(BalanceRefController balanceRefController) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (dialogContext) {
          bool isLoading = false;

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
              title: Text("New document", style: TextStyle(color: mainColor)),
              content: SizedBox(
                  height: Responsive.isMobile(context) ? 350 : 300,
                  width: Responsive.isMobile(context) ? 300 : 400,
                  child: isLoading
                      ? loading()
                      : Form(
                          key: balanceRefController.formKey,
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
                                      value:
                                          balanceRefController.comptesAllSelect,
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
                                          balanceRefController
                                              .comptesAllSelect = value;
                                          comptesList.clear();
                                          switch (balanceRefController
                                              .comptesAllSelect) {
                                            case "Classe_1_Comptes_de_ressources_durables":
                                              comptesList
                                                  .addAll(class1Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_2_Comptes_Actif_immobilise":
                                              comptesList
                                                  .addAll(class2Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_3_Comptes_de_stocks":
                                              comptesList
                                                  .addAll(class3Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_4_Comptes_de_tiers":
                                              comptesList
                                                  .addAll(class4Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_5_Comptes_de_tresorerie":
                                              comptesList
                                                  .addAll(class5Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_6_Comptes_de_charges_des_activites_ordinaires":
                                              comptesList
                                                  .addAll(class6Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_7_Comptes_de_produits_des_activites_ordinaires":
                                              comptesList
                                                  .addAll(class7Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_8_Comptes_des_autres_charges_et_des_autres_produits":
                                              comptesList
                                                  .addAll(class8Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_9_Comptes_des_engagements_hors_bilan_et_comptes_de_la_comptabilite_analytique_de_gestion":
                                              comptesList
                                                  .addAll(class9Dropdown);
                                              balanceRefController.comptes =
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
                                      value: balanceRefController.comptes,
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
                                          balanceRefController.comptes = value!;
                                        });
                                      },
                                    ),
                                  )),
                              debit(balanceRefController),
                              credit(balanceRefController),
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
                    final form = balanceRefController.formKey.currentState!;
                    if (form.validate()) {
                      balanceRefController.submit(widget.balanceCompteModel);
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

  editLigneButton(
      BalanceRefController balanceRefController, CompteBalanceRefModel compte) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (dialogContext) {
          bool isLoading = false;

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
              title: Text(compte.comptes, style: TextStyle(color: mainColor)),
              content: SizedBox(
                  height: Responsive.isMobile(context) ? 350 : 300,
                  width: Responsive.isMobile(context) ? 300 : 400,
                  child: isLoading
                      ? loading()
                      : Form(
                          key: balanceRefController.formKey,
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
                                      value:
                                          balanceRefController.comptesAllSelect,
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
                                          balanceRefController
                                              .comptesAllSelect = value;
                                          comptesList.clear();
                                          switch (balanceRefController
                                              .comptesAllSelect) {
                                            case "Classe_1_Comptes_de_ressources_durables":
                                              comptesList
                                                  .addAll(class1Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_2_Comptes_Actif_immobilise":
                                              comptesList
                                                  .addAll(class2Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_3_Comptes_de_stocks":
                                              comptesList
                                                  .addAll(class3Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_4_Comptes_de_tiers":
                                              comptesList
                                                  .addAll(class4Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_5_Comptes_de_tresorerie":
                                              comptesList
                                                  .addAll(class5Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_6_Comptes_de_charges_des_activites_ordinaires":
                                              comptesList
                                                  .addAll(class6Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_7_Comptes_de_produits_des_activites_ordinaires":
                                              comptesList
                                                  .addAll(class7Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_8_Comptes_des_autres_charges_et_des_autres_produits":
                                              comptesList
                                                  .addAll(class8Dropdown);
                                              balanceRefController.comptes =
                                                  comptesList.first;
                                              break;
                                            case "Classe_9_Comptes_des_engagements_hors_bilan_et_comptes_de_la_comptabilite_analytique_de_gestion":
                                              comptesList
                                                  .addAll(class9Dropdown);
                                              balanceRefController.comptes =
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
                                      value: balanceRefController.comptes,
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
                                          balanceRefController.comptes = value!;
                                        });
                                      },
                                    ),
                                  )),
                              debit(balanceRefController),
                              credit(balanceRefController),
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
                    final form = balanceRefController.formKey.currentState!;
                    if (form.validate()) {
                      balanceRefController.submitEdit(compte);
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

  Widget debit(BalanceRefController balanceRefController) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: balanceRefController.montantDebitController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Débit \$',
          ),
        ));
  }

  Widget credit(BalanceRefController balanceRefController) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: balanceRefController.montantCreditController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: ' Crédit \$',
          ),
        ));
  }
}
