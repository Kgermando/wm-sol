import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class LigneBudgetaire extends StatefulWidget {
  const LigneBudgetaire(
      {super.key,
      required this.departementBudgetModel,
      required this.lignBudgetaireController,
      required this.ligneBudgetaireList});
  final DepartementBudgetModel departementBudgetModel;
  final LignBudgetaireController lignBudgetaireController;
  final List<LigneBudgetaireModel> ligneBudgetaireList;

  @override
  State<LigneBudgetaire> createState() => _LigneBudgetaireState();
}

class _LigneBudgetaireState extends State<LigneBudgetaire> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  PlutoGridSelectingMode gridSelectingMode = PlutoGridSelectingMode.row;

  @override
  initState() {
    agentsColumn();
    agentsRow().then((value) => stateManager!.setShowLoading(false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent tapEvent) async {
          final dataId = tapEvent.row.cells.values;
          final idPlutoRow = dataId.last;

          final LigneBudgetaireModel ligneBudgetaireModel = await widget
              .lignBudgetaireController
              .detailView(idPlutoRow.value);

          Get.toNamed(BudgetRoutes.budgetLignebudgetaireDetail,
              arguments: ligneBudgetaireModel);
        },
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          stateManager!.setShowColumnFilter(true);
          stateManager!.setShowLoading(true);
        },
        createHeader: (PlutoGridStateManager header) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TitleWidget(title: 'Lignes budgetaires'),
              IconButton(
                  tooltip: 'Rafraichir',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, BudgetRoutes.budgetBudgetPrevisionelDetail,
                        arguments: widget.departementBudgetModel);
                  },
                  icon: Icon(Icons.refresh, color: Colors.green.shade700)),
            ],
          );
        },
        configuration: PlutoGridConfiguration(
          columnFilter: PlutoGridColumnFilterConfig(
            filters: const [
              ...FilterHelper.defaultFilters,
            ],
            resolveDefaultColumnFilter: (column, resolver) {
              if (column.field == 'numero') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'nomLigneBudgetaire') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'periodeBudget') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'uniteChoisie') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'nombreUnite') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'coutUnitaire') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'coutTotal') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'caisse') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'banque') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'finExterieur') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'created') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'id') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              }
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            },
          ),
        ),
        rowColorCallback: (rowColorContext) {
          double sortieTotal = 0.0;
          for (var element in widget.ligneBudgetaireList.where((element) =>
              element.nomLigneBudgetaire ==
              rowColorContext.row.cells.entries.elementAt(1).value.value)) {
            sortieTotal = element.caisseSortie +
                element.banqueSortie +
                element.finExterieurSortie;
          }

          String value =
              rowColorContext.row.cells.entries.elementAt(6).value.value;

          bool isValid = double.parse(value) <= sortieTotal;

          if (isValid) {
            return Colors.orange.shade200;
          }

          return Colors.transparent;
        },
        createFooter: (stateManager) {
          stateManager.setPageSize(20, notify: true); // default 40
          return PlutoPagination(stateManager);
        },
      ),
    );
  }

  Future<List<PlutoRow>> agentsRow() async {
    var dataList = widget.ligneBudgetaireList
        .where((p0) => p0.reference == widget.departementBudgetModel.id)
        .toList();
    var i = dataList.length;
    for (var item in dataList) {
      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'nomLigneBudgetaire': PlutoCell(value: item.nomLigneBudgetaire),
          'periodeBudget': PlutoCell(
              value: DateFormat("dd-MM-yyyy").format(item.periodeBudgetDebut)),
          'uniteChoisie': PlutoCell(value: item.uniteChoisie),
          'nombreUnite': PlutoCell(value: item.nombreUnite),
          'coutUnitaire': PlutoCell(
              value:
                  "${NumberFormat.decimalPattern('fr').format(double.parse(item.coutUnitaire))} ${monnaieStorage.monney}"),
          'coutTotal': PlutoCell(value: item.coutTotal),
          'caisse': PlutoCell(
              value:
                  "${NumberFormat.decimalPattern('fr').format(double.parse(item.caisse))} ${monnaieStorage.monney}"),
          'banque': PlutoCell(
              value:
                  "${NumberFormat.decimalPattern('fr').format(double.parse(item.banque))} ${monnaieStorage.monney}"),
          'finExterieur': PlutoCell(
              value:
                  "${NumberFormat.decimalPattern('fr').format(double.parse(item.finExterieur))} ${monnaieStorage.monney}"),
          'created': PlutoCell(
              value: DateFormat("dd-MM-yyyy HH:mm").format(item.created)),
          'id': PlutoCell(value: item.id)
        }));
      });
    }
    return rows;
  }

  void agentsColumn() {
    columns = [
      PlutoColumn(
        readOnly: true,
        title: 'N°',
        field: 'numero',
        type: PlutoColumnType.number(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 100,
        minWidth: 80,
        renderer: (rendererContext) {
          return Text(
            rendererContext.cell.value.toString(),
            textAlign: TextAlign.center,
          );
        },
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Ligne Budgetaire',
        field: 'nomLigneBudgetaire',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 300,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Date de cloture',
        field: 'periodeBudget',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 250,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Unité',
        field: 'uniteChoisie',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 200,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Nombre d\'Unité',
        field: 'nombreUnite',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 200,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Coût Unitaire',
        field: 'coutUnitaire',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 200,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Coût Total ${monnaieStorage.monney}',
        field: 'coutTotal',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 200,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Caisse',
        field: 'caisse',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 200,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Banque',
        field: 'banque',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 200,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Reste à trouver',
        field: 'finExterieur',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 200,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Date',
        field: 'created',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 200,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Id',
        field: 'id',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 80,
        minWidth: 80,
        renderer: (rendererContext) {
          return Text(
            rendererContext.cell.value.toString(),
            textAlign: TextAlign.center,
          );
        },
      ),
    ];
  }
}
