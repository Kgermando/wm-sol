import 'package:flutter/material.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';

class UpdatePersonnel extends StatefulWidget {
  const UpdatePersonnel({super.key, required this.personnelList});
  final List<AgentModel> personnelList;

  @override
  State<UpdatePersonnel> createState() => _UpdatePersonnelState();
}

class _UpdatePersonnelState extends State<UpdatePersonnel> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}