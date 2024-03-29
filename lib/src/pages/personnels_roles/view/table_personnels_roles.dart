import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/pages/personnels_roles/components/personnels_roles_xlsx.dart';
import 'package:wm_solution/src/pages/personnels_roles/controller/personnels_roles_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TablePersonnelsRoles extends StatefulWidget {
  const TablePersonnelsRoles(
      {super.key,
      required this.personnelsRolesController,
      required this.personnelsController,
      required this.approuvedDD,
      required this.id,
      required this.departement,
      required this.route,
      required this.routeArgument});
  final PersonnelsRolesController personnelsRolesController;
  final PersonnelsController personnelsController;
  final String approuvedDD; // Verrouiller after approbation DD
  final int id;
  final String departement;
  final String route;
  final String routeArgument;

  @override
  State<TablePersonnelsRoles> createState() => _TablePersonnelsRolesState();
}

class _TablePersonnelsRolesState extends State<TablePersonnelsRoles> {
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
      height: 300,
      child: PlutoGrid(
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
              const TitleWidget(title: "Liste agents & rôle"),
              Row(
                children: [
                  if (widget.approuvedDD == "-")
                    IconButton(
                        tooltip: 'Ajouter les personnels ici.',
                        onPressed: () {
                          addAgentDialog();
                        },
                        icon: Icon(Icons.add, color: Colors.red.shade700)),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, widget.route, arguments: widget.routeArgument);
                      },
                      icon: Icon(Icons.refresh, color: Colors.green.shade700)),
                  PrintWidget(onPressed: () {
                    PersonnelsRolesXlsx().exportToExcel(
                        widget.personnelsRolesController.personnelsRoleList);
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text("Exportation effectué!"),
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
              } else if (column.field == 'agent') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'role') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'id') {
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
      ),
    );
  }

  Future<List<PlutoRow>> agentsRow() async {
   var dataList = widget.personnelsRolesController.personnelsRoleList
        .where((element) => element.reference == widget.id)
        .toList();
    var i = dataList.length;
    List.generate(dataList.length, (index) {
      var item = dataList[index];
      return rows.add(PlutoRow(cells: {
        'numero': PlutoCell(value: i--),
        'agent': PlutoCell(value: item.agent),
        'role': PlutoCell(value: item.role),
        'id': PlutoCell(value: item.id)
      }));
    });
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
        title: 'Personnels',
        field: 'agent',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 400,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Rôles',
        field: 'role',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 400,
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

  addAgentDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Ajout agent'),
              content: SizedBox(
                  height: 200,
                  width: 300,
                  child: Form(
                    key: widget.personnelsRolesController.formKey,
                    child: Column(
                      children: [
                        agentWidget(),
                        roleWidget(),
                      ],
                    ),
                  )),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    final form =
                        widget.personnelsRolesController.formKey.currentState!;
                    if (form.validate()) {
                      widget.personnelsRolesController
                          .submit(widget.id, widget.departement);
                      form.reset();
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget agentWidget() {
    List<String> suggestionList = widget.personnelsController.personnelsList
        .map((e) => e.matricule)
        .toList();
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: EasyAutocomplete(
          // controller: widget.personnelsRolesController.agentController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: "Matricule ou identifiant de l'agent",
          ),
          keyboardType: TextInputType.text,
          suggestions: suggestionList,
          validator: (value) => value == null ? "Select Service" : null,
          onChanged: (value) {
            widget.personnelsRolesController.agentController = value;
          },
        ));
  }

  Widget roleWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: widget.personnelsRolesController.roleController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Rôle',
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
}
