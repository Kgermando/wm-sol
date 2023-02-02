import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/comptabilites/components/journals/table_journal.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_controller.dart';
import 'package:wm_solution/src/utils/comptes_dropdown.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class JournalLivreComptabilite extends StatefulWidget {
  const JournalLivreComptabilite({super.key});

  @override
  State<JournalLivreComptabilite> createState() =>
      _JournalLivreComptabiliteState();
}

class _JournalLivreComptabiliteState extends State<JournalLivreComptabilite> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final JournalController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilités";
  String subTitle = "Journal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenu(),
        floatingActionButton: Responsive.isMobile(context) ? FloatingActionButton( 
          tooltip: "Nouveau Journal",
          child: const Icon(Icons.add),
          onPressed: () => newEcritureDialog()) 
        : FloatingActionButton.extended(
            label: const Text("Feuille journal"),
            tooltip: "Nouveau Journal",
            icon: const Icon(Icons.add),
            onPressed: () => newEcritureDialog()),
        body: controller.obx(
            onLoading: loadingPage(context),
            onEmpty: const Text('Aucune donnée'),
            onError: (error) => loadingError(context, error!),
            (state) => Row(
              children: [
                Visibility(
                    visible: !Responsive.isMobile(context),
                    child: const Expanded(flex: 1, child: DrawerMenu())),
                Expanded(
                    flex: 5,
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: p20, right: p20, left: p20, bottom: p8),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TableJournal(
                            controller: controller, journalList: state!))),
                  ],
                )) 
    );
  }

  newEcritureDialog() {
    var headlineSmall = Theme.of(context).textTheme.headlineSmall;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.2),
        builder: (dialogContext) {
          List<String> comptesDebitList = [];
          List<String> comptesCreditList = [];
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
            return Padding(
                padding: const EdgeInsets.all(p20),
                child: Form(
                    key: controller.formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const TitleWidget(title: "Nouvel écriture"),
                        const SizedBox(height: p20),
                        libeleWidget(),
                        ResponsiveChildWidget(
                          child1: Column(
                            children: [
                              Text("Compte Debit", style: headlineSmall),
                              Container(
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
                                  value: controller.comptesAllSelectDebit,
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
                                      controller.comptesAllSelectDebit = value;
                                      comptesDebitList.clear();
                                      switch (
                                          controller.comptesAllSelectDebit) {
                                        case "Classe_1_Comptes_de_ressources_durables":
                                          comptesDebitList
                                              .addAll(class1Dropdown);
                                          controller.compteDebit =
                                              comptesDebitList.first;
                                          break;
                                        case "Classe_2_Comptes_Actif_immobilise":
                                          comptesDebitList
                                              .addAll(class2Dropdown);
                                          controller.compteDebit =
                                              comptesDebitList.first;
                                          break;
                                        case "Classe_3_Comptes_de_stocks":
                                          comptesDebitList
                                              .addAll(class3Dropdown);
                                          controller.compteDebit =
                                              comptesDebitList.first;
                                          break;
                                        case "Classe_4_Comptes_de_tiers":
                                          comptesDebitList
                                              .addAll(class4Dropdown);
                                          controller.compteDebit =
                                              comptesDebitList.first;
                                          break;
                                        case "Classe_5_Comptes_de_tresorerie":
                                          comptesDebitList
                                              .addAll(class5Dropdown);
                                          controller.compteDebit =
                                              comptesDebitList.first;
                                          break;
                                        case "Classe_6_Comptes_de_charges_des_activites_ordinaires":
                                          comptesDebitList
                                              .addAll(class6Dropdown);
                                          controller.compteDebit =
                                              comptesDebitList.first;
                                          break;
                                        case "Classe_7_Comptes_de_produits_des_activites_ordinaires":
                                          comptesDebitList
                                              .addAll(class7Dropdown);
                                          controller.compteDebit =
                                              comptesDebitList.first;
                                          break;
                                        case "Classe_8_Comptes_des_autres_charges_et_des_autres_produits":
                                          comptesDebitList
                                              .addAll(class8Dropdown);
                                          controller.compteDebit =
                                              comptesDebitList.first;
                                          break;
                                        case "Classe_9_Comptes_des_engagements_hors_bilan_et_comptes_de_la_comptabilite_analytique_de_gestion":
                                          comptesDebitList
                                              .addAll(class9Dropdown);
                                          controller.compteDebit =
                                              comptesDebitList.first;
                                          break;
                                        default:
                                          comptesDebitList
                                              .addAll(class9Dropdown);
                                      }
                                    });
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: p20),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Compte debit',
                                    labelStyle: const TextStyle(),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    contentPadding:
                                        const EdgeInsets.only(left: 5.0),
                                  ),
                                  value: controller.compteDebit,
                                  isExpanded: true,
                                  items: comptesDebitList.map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value!),
                                    );
                                  }).toList(),
                                  validator: (value) => value == null
                                      ? "Select compte debit"
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      controller.compteDebit = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          child2: Column(
                            children: [
                              Text("Compte Credit", style: headlineSmall),
                              Container(
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
                                  value: controller.comptesAllSelectCredit,
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
                                      controller.comptesAllSelectCredit = value;
                                      comptesCreditList.clear();
                                      switch (
                                          controller.comptesAllSelectCredit) {
                                        case "Classe_1_Comptes_de_ressources_durables":
                                          comptesCreditList
                                              .addAll(class1Dropdown);
                                          controller.compteCredit =
                                              comptesCreditList.first;
                                          break;
                                        case "Classe_2_Comptes_Actif_immobilise":
                                          comptesCreditList
                                              .addAll(class2Dropdown);
                                          controller.compteCredit =
                                              comptesCreditList.first;
                                          break;
                                        case "Classe_3_Comptes_de_stocks":
                                          comptesCreditList
                                              .addAll(class3Dropdown);
                                          controller.compteCredit =
                                              comptesCreditList.first;
                                          break;
                                        case "Classe_4_Comptes_de_tiers":
                                          comptesCreditList
                                              .addAll(class4Dropdown);
                                          controller.compteCredit =
                                              comptesCreditList.first;
                                          break;
                                        case "Classe_5_Comptes_de_tresorerie":
                                          comptesCreditList
                                              .addAll(class5Dropdown);
                                          controller.compteCredit =
                                              comptesCreditList.first;
                                          break;
                                        case "Classe_6_Comptes_de_charges_des_activites_ordinaires":
                                          comptesCreditList
                                              .addAll(class6Dropdown);
                                          controller.compteCredit =
                                              comptesCreditList.first;
                                          break;
                                        case "Classe_7_Comptes_de_produits_des_activites_ordinaires":
                                          comptesCreditList
                                              .addAll(class7Dropdown);
                                          controller.compteCredit =
                                              comptesCreditList.first;
                                          break;
                                        case "Classe_8_Comptes_des_autres_charges_et_des_autres_produits":
                                          comptesCreditList
                                              .addAll(class8Dropdown);
                                          controller.compteCredit =
                                              comptesCreditList.first;
                                          break;
                                        case "Classe_9_Comptes_des_engagements_hors_bilan_et_comptes_de_la_comptabilite_analytique_de_gestion":
                                          comptesCreditList
                                              .addAll(class9Dropdown);
                                          controller.compteCredit =
                                              comptesCreditList.first;
                                          break;
                                        default:
                                          comptesCreditList
                                              .addAll(class9Dropdown);
                                      }
                                    });
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: p20),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Compte credit',
                                    labelStyle: const TextStyle(),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    contentPadding:
                                        const EdgeInsets.only(left: 5.0),
                                  ),
                                  value: controller.compteCredit,
                                  isExpanded: true,
                                  items: comptesCreditList.map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value!),
                                    );
                                  }).toList(),
                                  validator: (value) => value == null
                                      ? "Select compte credit"
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      controller.compteCredit = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        montantWidget(),
                        Obx(() => BtnWidget(
                            title: 'Soumettre',
                            press: () {
                              final form = controller.formKey.currentState!;
                              if (form.validate()) {
                                controller.submit();
                                form.reset();
                                Navigator.pop(context, 'ok');
                              }
                            },
                            isLoading: controller.isLoading)) 
                      ],
                    )));
          });
        });
  }

  Widget libeleWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.libeleController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Libelé',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          ),
          keyboardType: TextInputType.text,
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

  Widget montantWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.montantController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Débit',
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(width: p8),
            Expanded(
                flex: 1,
                child: Text(monnaieStorage.monney,
                    style: Theme.of(context).textTheme.headline6))
          ],
        ));
  }
}
