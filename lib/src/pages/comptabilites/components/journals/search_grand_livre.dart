import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comptabilites/journal_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart'; 
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class SearchGrandLivre extends StatefulWidget {
  const SearchGrandLivre({super.key, required this.search});
  final List<JournalModel> search;

  @override
  State<SearchGrandLivre> createState() => _SearchGrandLivreState();
}

class _SearchGrandLivreState extends State<SearchGrandLivre> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilités";

  EasyTableModel<JournalModel>? _model;

  @override
  void initState() {
    List<JournalModel> rows =
        List.generate(widget.search.length, (index) => widget.search[index]);
    _model = EasyTableModel<JournalModel>(rows: rows, columns: [
      EasyTableColumn(
        name: 'Date',
        width: 200,
        stringValue: (row) =>
            DateFormat("dd-MM-yyyy HH:mm").format(row.created),
      ),
      EasyTableColumn(
          name: 'N° Operation',
          width: 150,
          stringValue: (row) => row.numeroOperation),
      EasyTableColumn(
          name: 'Libele', width: 300, stringValue: (row) => row.libele),
      EasyTableColumn(
          name: 'Compte',
          width: 100,
          stringValue: (row) {
            var compteSplit = row.compte.split('_');
            var compte = compteSplit.first;
            return compte;
          }),
      EasyTableColumn(
          name: 'Debit',
          width: 100,
          stringValue: (row) => (row.montantDebit == "0")
              ? "-"
              : "${NumberFormat.decimalPattern('fr').format(double.parse(row.montantDebit))} \$"),
      EasyTableColumn(
          name: 'Credit',
          width: 100,
          stringValue: (row) => (row.montantCredit == "0")
              ? "-"
              : "${NumberFormat.decimalPattern('fr').format(double.parse(row.montantCredit))} \$"),
      EasyTableColumn(
          name: 'TVA', width: 100, stringValue: (row) => "${row.tva} %"),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var journal = widget.search.map((e) => e.compte).first;
    var compteSplit = journal.split('_');
    var compte = compteSplit.first;
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, compte),
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
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        AutoSizeText(
                            "Résultats pour le compte <<$compte>>",
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: mainColor)),
                        const SizedBox(height: p20),
                        SizedBox(
                          height: 500,
                          child: EasyTable<JournalModel>(_model,
                              multiSort: true),
                        ),
                        totalWidget()
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  Widget totalWidget() {
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    double totalDebit = 0.0;
    double totalCredit = 0.0; 
    for (var element in widget.search) {
      totalDebit += double.parse(element.montantDebit);
    }
    for (var element in widget.search) {
      totalCredit += double.parse(element.montantCredit);
    }
    return Padding(
      padding: const EdgeInsets.all(p20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ResponsiveChildWidget(
              child1: Text("Total débit :",
                style: headlineMedium!.copyWith(
                    color: Colors.yellow, fontWeight: FontWeight.bold)), 
              child2: Text(
                "${NumberFormat.decimalPattern('fr').format(totalDebit)} \$",
                style: headlineMedium.copyWith(color: Colors.yellow))
            )
          ),
          Expanded(
            child: ResponsiveChildWidget(
              child1: Text("Total crédit :",
                style: headlineMedium.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold)),
              child2: Text(
                "${NumberFormat.decimalPattern('fr').format(totalCredit)} \$",
                style: headlineMedium.copyWith(color: Colors.green))
            ) 
          ),
          Expanded(
              child: ResponsiveChildWidget(
                  child1: Text("Solde :",
                      style: headlineMedium.copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                  child2: Text(
                      "${NumberFormat.decimalPattern('fr').format(totalDebit - totalCredit)} \$",
                      style: headlineMedium.copyWith(color: Colors.red)))),
        ],
      ),
    );
  }
}
