import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/exploitations/agent_role_model.dart';
import 'package:wm_solution/src/models/exploitations/projet_model.dart';
import 'package:wm_solution/src/models/marketing/campaign_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/personnels_roles/components/personnels_roles_xlsx.dart';
import 'package:wm_solution/src/pages/personnels_roles/controller/personnels_roles_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TablePersonnelsRolesFilter extends StatefulWidget {
  const TablePersonnelsRolesFilter(
      {super.key,
      required this.state,
      required this.personnelsController,
      required this.personnelsRolesController,
      required this.departement,
      required this.id,
      required this.route,
      this.argument1,
      this.argument2});
  final List<AgentRoleModel> state;
  final PersonnelsController personnelsController;
  final PersonnelsRolesController personnelsRolesController;
  final String departement;
  final int id; // Pour compatibilite avec d'autres modules
  final String route;
  final ProjetModel? argument1;
  final CampaignModel? argument2;

  @override
  State<TablePersonnelsRolesFilter> createState() =>
      _TablePersonnelsRolesFilterState();
}

class _TablePersonnelsRolesFilterState
    extends State<TablePersonnelsRolesFilter> {
  final ProfilController profilController = Get.find();
  EasyTableModel<AgentRoleModel>? _model;

  @override
  void initState() {
    super.initState();
    List<AgentRoleModel> rows =
        List.generate(widget.state.length, (index) => widget.state[index]);
    _model = EasyTableModel<AgentRoleModel>(rows: rows, columns: [
      EasyTableColumn(
          name: 'Agent', width: 300, stringValue: (row) => row.agent),
      EasyTableColumn(name: 'Rôle', width: 300, stringValue: (row) => row.role),
      EasyTableColumn(
          name: 'Date',
          width: 150,
          stringValue: (row) =>
              DateFormat("dd-MM-yy HH:mm").format(row.created)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    int roleUser = int.parse(profilController.user.role);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(p10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleWidget(title: 'Personnels et Rôles'),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            widget.personnelsRolesController.getList();
                            if (widget.departement == 'Exploitations') {
                              Navigator.pushNamed(context, widget.route,
                                  arguments: widget.argument1);
                            }
                            if (widget.departement == 'Marketing') {
                              Navigator.pushNamed(context, widget.route,
                                  arguments: widget.argument2);
                            }
                          });
                        },
                        icon: const Icon(Icons.refresh, color: Colors.green)),
                    if (roleUser <= 3)
                      IconButton(
                          tooltip: 'Ajouter du personnels ici.',
                          onPressed: () {
                            addAgentDialog();
                          },
                          icon: Icon(Icons.add, color: Colors.red.shade700)),
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
                )
              ],
            ),
            const SizedBox(height: p10),
            SizedBox(
                height: 300,
                child: EasyTable<AgentRoleModel>(
                  _model,
                  multiSort: true,
                  columnsFit: true,
                  onRowDoubleTap: (row) => deleteButton(row.id!),
                )),
          ],
        ),
      ),
    );
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
          validator: (value) => value == null ? "Select identifiant" : null,
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

  Widget deleteButton(int id) {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.red.shade700),
      tooltip: "Suppression",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            'Etes-vous sûr de supprimer ceci?',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text('Cette action permet de modifier le projet.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Annuler', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                widget.personnelsRolesController.deleteData(id);
                Navigator.pop(context, 'ok');
              },
              child: Obx(() => widget.personnelsRolesController.isLoading
                  ? loading()
                  : const Text('OK', style: TextStyle(color: Colors.red))),
            ),
          ],
        ),
      ),
    );
  }
}
