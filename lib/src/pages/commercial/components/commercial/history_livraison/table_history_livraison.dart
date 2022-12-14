import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/commercial/livraiason_history_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/history_livraison/history_livraison_xlsx.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableHistoryLivraison extends StatefulWidget {
  const TableHistoryLivraison(
      {super.key,
      required this.livraisonHistoryList,
      required this.profilController});
  final List<LivraisonHistoryModel> livraisonHistoryList;
  final ProfilController profilController;

  @override
  State<TableHistoryLivraison> createState() => _TableHistoryLivraisonState();
}

class _TableHistoryLivraisonState extends State<TableHistoryLivraison> {
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
    return PlutoGrid(
      columns: columns,
      rows: rows,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager!.setShowColumnFilter(true);
        stateManager!.setShowLoading(true);
      },
      createHeader: (PlutoGridStateManager header) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleWidget(title: "Historique de Livraisons"),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ComRoutes.comBonLivraison);
                    },
                    icon: Icon(Icons.refresh, color: Colors.green.shade700)),
                PrintWidget(onPressed: () {
                  HistoriqueLivraisonXlsx()
                      .exportToExcel(widget.livraisonHistoryList);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Exportation effectu??!"),
                    backgroundColor: Colors.green[700],
                  ));
                })
              ],
            ),
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
            } else if (column.field == 'idProduct') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'quantity') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'quantityAchat') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'priceAchatUnit') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'prixVenteUnit') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'margeBen') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'tva') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'remise') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'qtyRemise') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'margeBenRemise') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'qtyLivre') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'succursale') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'signature') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'created') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            }
            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
          },
        ),
      ),
      createFooter: (stateManager) {
        stateManager.setPageSize(20, notify: true); // default 40
        return PlutoPagination(stateManager);
      },
    );
  }

  Future<List<PlutoRow>> agentsRow() async {
    var dataList = widget.livraisonHistoryList
        .where((element) =>
            element.succursale == widget.profilController.user.succursale ||
            int.parse(widget.profilController.user.role) <= 2)
        .toSet()
        .toList();
    var i = dataList.length;
    for (var item in dataList) {
      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'idProduct': PlutoCell(value: item.idProduct),
          'quantity': PlutoCell(value: '${item.quantity} ${item.unite}'),
          'quantityAchat': PlutoCell(value: item.quantityAchat),
          'priceAchatUnit': PlutoCell(value: item.priceAchatUnit),
          'prixVenteUnit': PlutoCell(value: item.prixVenteUnit),
          'margeBen': PlutoCell(value: item.margeBen),
          'tva': PlutoCell(value: item.tva),
          'remise': PlutoCell(value: item.remise),
          'qtyRemise': PlutoCell(value: item.qtyRemise),
          'margeBenRemise': PlutoCell(value: item.margeBenRemise),
          'qtyLivre': PlutoCell(value: item.qtyLivre),
          'created': PlutoCell(
              value: DateFormat("dd-MM-yy H:mm").format(item.created)),
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
        title: 'N??',
        field: 'numero',
        type: PlutoColumnType.number(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 100,
        minWidth: 80,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Id Produit',
        field: 'idProduct',
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
        title: 'Quantit??',
        field: 'quantity',
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
        title: 'Quantit?? d\'Achat',
        field: 'quantityAchat',
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
        title: 'Prix d\'Achat Unitaire ${monnaieStorage.monney}',
        field: 'priceAchatUnit',
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
        title: 'Prix de vente Unitaire ${monnaieStorage.monney}',
        field: 'prixVenteUnit',
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
        title: 'marge Benefiaire',
        field: 'margeBen',
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
        title: 'TVA %',
        field: 'tva',
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
        title: 'Remise',
        field: 'remise',
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
        title: 'Qt??s avec Remise',
        field: 'qtyRemise',
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
        title: 'Marge Benefiaire avec Remise',
        field: 'margeBenRemise',
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
        title: 'Qt??s Livr??',
        field: 'qtyLivre',
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
      ),
    ];
  }
}
