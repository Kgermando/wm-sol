import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comptabilites/balance_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class SearchGrandLivre extends StatefulWidget {
  const SearchGrandLivre({super.key, required this.search});
  final List<BalanceModel> search;

  @override
  State<SearchGrandLivre> createState() => _SearchGrandLivreState();
}

class _SearchGrandLivreState extends State<SearchGrandLivre> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilités";

  EasyTableModel<BalanceModel>? _model;

  @override
  void initState() {
    List<BalanceModel> rows =
        List.generate(widget.search.length, (index) => widget.search[index]);
    _model = EasyTableModel<BalanceModel>(rows: rows, columns: [
      EasyTableColumn(
        name: 'Date',
        width: 200,
        headerAlignment: Alignment.center,
        cellAlignment: Alignment.center,
        stringValue: (row) =>
            DateFormat("dd-MM-yyyy HH:mm").format(row.created),
      ),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'N° Operation',
          width: 150,
          stringValue: (row) => row.numeroOperation),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Libele', width: 200, stringValue: (row) => row.libele),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Compte',
          width: 100,
          stringValue: (row) {
            var compteSplit = row.comptes.split('_');
            var compte = compteSplit.first;
            return compte;
          }),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Debit',
          width: 100,
          stringValue: (row) => (row.debit == "0")
              ? "-"
              : "${NumberFormat.decimalPattern('fr').format(double.parse(row.debit))} \$"),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Credit',
          width: 100,
          stringValue: (row) => (row.credit == "0")
              ? "-"
              : "${NumberFormat.decimalPattern('fr').format(double.parse(row.credit))} \$"),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Solde',
          width: 100,
          stringValue: (row) {
            double solde = double.parse(row.debit) - double.parse(row.credit);
            return "${NumberFormat.decimalPattern('fr').format(solde)} \$";
          }),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var journal = widget.search.map((e) => e.comptes).first;
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
                  child: Card(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: p20, bottom: p8, right: p20, left: p20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Text.rich(TextSpan(
                            text: 'Résultats pour le compte <<', // default text style
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' $journal ',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: mainColor)),
                              const TextSpan(
                                  text: '>> '),
                               
                            ],
                          )),
                          const SizedBox(height: p20),
                          SizedBox(
                            height: 500,
                            child: EasyTable<BalanceModel>(
                              _model,
                              multiSort: true,
                              // onRowTap: (row) {},
                            ),
                          ),
                          totalWidget()
                        ],
                      ),
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
      totalDebit += double.parse(element.debit);
    }
    for (var element in widget.search) {
      totalCredit += double.parse(element.credit);
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
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                  child2: Text(
                      "${NumberFormat.decimalPattern('fr').format(totalDebit)} \$",
                      style: headlineMedium.copyWith(color: Colors.blue)))),
          Expanded(
              child: ResponsiveChildWidget(
                  child1: Text("Total crédit :",
                      style: headlineMedium.copyWith(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                  child2: Text(
                      "${NumberFormat.decimalPattern('fr').format(totalCredit)} \$",
                      style: headlineMedium.copyWith(color: Colors.green)))),
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
