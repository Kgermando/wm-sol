import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comptabilites/journal_livre_model.dart';
import 'package:wm_solution/src/models/comptabilites/journal_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/components/journals/approbation_journal_livre.dart';
import 'package:wm_solution/src/pages/comptabilites/components/journals/table_journal.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_livre_controller.dart';
import 'package:wm_solution/src/utils/comptes_dropdown.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailJournalLivre extends StatefulWidget {
  const DetailJournalLivre({super.key, required this.journalLivreModel});
  final JournalLivreModel journalLivreModel;

  @override
  State<DetailJournalLivre> createState() => _DetailJournalLivreState();
}

class _DetailJournalLivreState extends State<DetailJournalLivre> {
  final JournalLivreController journalLivreController =
      Get.put(JournalLivreController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilités";

  @override
  Widget build(BuildContext context) {
    final JournalController controller = Get.put(JournalController());
    
    final ProfilController profilController = Get.put(ProfilController());
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return controller.obx(
        onLoading: loading(),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => Text(
            "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  widget.journalLivreModel.intitule),
              drawer: const DrawerMenu(),
              floatingActionButton: FloatingActionButton.extended(
                  tooltip: "Nouvel écriture",
                  label: const Text("Ajouter une écriture"),
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    newEcritureDialog(controller);
                  }),
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
                                                title: "Journals"),
                                            Row(
                                              children: [ 
                                                if (widget.journalLivreModel
                                                            .signature ==
                                                        profilController
                                                            .user.matricule &&
                                                    widget.journalLivreModel
                                                            .isSubmit ==
                                                        "false") // Uniqyement celui a remplit le document
                                                  sendButton(),
                                                SelectableText(
                                                  DateFormat(
                                                          "dd-MM-yyyy HH:mm")
                                                      .format(widget.journalLivreModel
                                                          .created),
                                                  textAlign: TextAlign.end,
                                                  style: bodyMedium)
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: p20),
                                ResponsiveChildWidget(
                                  flex1: 1,
                                  flex2: 3,
                                  child1: Text('Intitule :',
                                    textAlign: TextAlign
                                        .start,
                                    style: bodyMedium!
                                        .copyWith(
                                            fontWeight:
                                                FontWeight
                                                    .bold)), 
                                  child2: SelectableText(
                                      widget.journalLivreModel.intitule,
                                      textAlign: TextAlign.justify,
                                      style: bodyMedium)
                                ),
                                Divider(color: mainColor),
                                ResponsiveChildWidget(
                                          flex1: 1,
                                          flex2: 3,
                                  child1: Text('Date de début :',
                                  textAlign: TextAlign.start,
                                  style: bodyMedium.copyWith(
                                      fontWeight:
                                          FontWeight.bold)), 
                                child2: SelectableText(
                                    DateFormat("dd-MM-yyyy").format(
                                        widget
                                            .journalLivreModel.debut),
                                    textAlign: TextAlign.justify,
                                    style: bodyMedium),
                              ),
                                        Divider(color: mainColor),
                              ResponsiveChildWidget(
                                flex1: 1,
                                flex2: 3,
                                child1: Text('Date de fin :',
                                  textAlign: TextAlign.start,
                                  style: bodyMedium.copyWith(
                                      fontWeight:
                                          FontWeight.bold)),
                              child2: SelectableText(
                                  DateFormat("dd-MM-yyyy").format(
                                      widget
                                          .journalLivreModel.fin),
                                  textAlign: TextAlign.justify,
                                  style: bodyMedium)), 
                              Divider(color: mainColor),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('Signature :',
                                        textAlign: TextAlign.start,
                                        style: bodyMedium.copyWith(
                                            fontWeight:
                                                FontWeight.bold)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: SelectableText(
                                        widget.journalLivreModel.signature,
                                        textAlign: TextAlign.justify,
                                        style: bodyMedium),
                                  )
                                ],
                              ),
                              Divider(color: mainColor),
                              SizedBox(
                                height: MediaQuery.of(context)
                                        .size
                                        .height /
                                    1.5,
                                child: Expanded(
                                  child: TableJournal(itemList: controller.journalList)
                                ),
                              ),
                              totalWidget(controller.journalList),  
                              const SizedBox(height: p20),
                            ApprobationJournalLivre(
                              data: widget.journalLivreModel,
                              controller: journalLivreController,
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


  
  Widget sendButton() {
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
                journalLivreController.sendDD(widget.journalLivreModel);
                Navigator.pop(context, 'ok');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }


  Widget totalWidget(List<JournalModel> itemList) {
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    double totalDebit = 0.0;
    double totalCredit = 0.0;
    for (var element in itemList) {
      totalDebit += double.parse(element.montantDebit);
    }
    for (var element in itemList) {
      totalCredit += double.parse(element.montantCredit);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: ResponsiveChildWidget(
            child1: Text("Total débit :",
                style: headlineMedium!.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold)), 
            child2: Text(
              "${NumberFormat.decimalPattern('fr').format(totalDebit)} \$",
              style: headlineMedium.copyWith(color: Colors.red))) 
        ),
        Expanded(
          child: ResponsiveChildWidget(
            child1: Text("Total crédit :",
              style: headlineMedium.copyWith(
                  color: Colors.orange, fontWeight: FontWeight.bold)),
            child2: Text(
              "${NumberFormat.decimalPattern('fr').format(totalCredit)} \$",
              style: headlineMedium.copyWith(color: Colors.orange))
          )
        ),
      ],
    );
  }

  newEcritureDialog(JournalController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (dialogContext) {
          final formKey = GlobalKey<FormState>();
          bool isLoading = false;
          List<String> typaList = ["Debit", "Credit"];

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
                  height: Responsive.isMobile(context) ? 600 : 500,
                  width: Responsive.isMobile(context) ? 300 : 500,
                  child: isLoading
                      ? loading()
                      : Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: p20),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Type d\'entrer',
                                    labelStyle: const TextStyle(),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    contentPadding:
                                        const EdgeInsets.only(left: 5.0),
                                  ),
                                  value: controller.type,
                                  isExpanded: true,
                                  items: typaList.map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value!),
                                    );
                                  }).toList(),
                                  validator: (value) =>
                                      value == null ? "Select compte" : null,
                                  onChanged: (value) {
                                    setState(() {
                                      controller.type = value!;
                                    });
                                  },
                                ),
                              ),
                              ResponsiveChildWidget(
                                  child1: numeroOperationWidget(controller),
                                  child2: libeleWidget(controller)),
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
                                      value: controller.comptesAllSelect,
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
                                          controller.comptesAllSelect = value;
                                          comptesList.clear();
                                          switch (controller.comptesAllSelect) {
                                            case "Classe_1_Comptes_de_ressources_durables":
                                              comptesList
                                                  .addAll(class1Dropdown);
                                              controller.comptes = comptesList.first;
                                              break;
                                            case "Classe_2_Comptes_Actif_immobilise":
                                              comptesList
                                                  .addAll(class2Dropdown);
                                              controller.comptes = comptesList.first;
                                              break;
                                            case "Classe_3_Comptes_de_stocks":
                                              comptesList
                                                  .addAll(class3Dropdown);
                                              controller.comptes = comptesList.first;
                                              break;
                                            case "Classe_4_Comptes_de_tiers":
                                              comptesList
                                                  .addAll(class4Dropdown);
                                              controller.comptes = comptesList.first;
                                              break;
                                            case "Classe_5_Comptes_de_tresorerie":
                                              comptesList
                                                  .addAll(class5Dropdown);
                                              controller.comptes = comptesList.first;
                                              break;
                                            case "Classe_6_Comptes_de_charges_des_activites_ordinaires":
                                              comptesList
                                                  .addAll(class6Dropdown);
                                              controller.comptes = comptesList.first;
                                              break;
                                            case "Classe_7_Comptes_de_produits_des_activites_ordinaires":
                                              comptesList
                                                  .addAll(class7Dropdown);
                                              controller.comptes = comptesList.first;
                                              break;
                                            case "Classe_8_Comptes_des_autres_charges_et_des_autres_produits":
                                              comptesList
                                                  .addAll(class8Dropdown);
                                              controller.comptes = comptesList.first;
                                              break;
                                            case "Classe_9_Comptes_des_engagements_hors_bilan_et_comptes_de_la_comptabilite_analytique_de_gestion":
                                              comptesList
                                                  .addAll(class9Dropdown);
                                              controller.comptes = comptesList.first;
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
                              Column(
                                children: [
                                  if (controller.type == "Debit") debit(controller),
                                  if (controller.type == "Credit") credit(controller)
                                ],
                              ),
                              tvaWidget(controller)
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
                    final form = formKey.currentState!;
                    if (form.validate()) {
                      controller.submit(widget.journalLivreModel);
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

  Widget numeroOperationWidget(JournalController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.numeroOperationController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'N°',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          ),
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

  Widget libeleWidget(JournalController controller) {
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

  Widget debit(JournalController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.montantDebitController,
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
              ),
            ),
            const SizedBox(width: p8),
            Expanded(
                flex: 1,
                child: Text("\$", style: Theme.of(context).textTheme.headline6))
          ],
        ));
  }

  Widget credit(JournalController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.montantCreditController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Crédit',
                ),
              ),
            ),
            const SizedBox(width: p8),
            Expanded(
                flex: 1,
                child: Text("\$", style: Theme.of(context).textTheme.headline6))
          ],
        ));
  }

  Widget tvaWidget(JournalController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.tvaController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'TVA en %',
                ),
                style: const TextStyle(),
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
                child: Text("%", style: Theme.of(context).textTheme.headline6))
          ],
        ));
  }
}
