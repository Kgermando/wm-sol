import 'package:flutter/material.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';

class InfosPersonne extends StatefulWidget {
  const InfosPersonne({super.key, required this.personne});
  final AgentModel personne;

  @override
  State<InfosPersonne> createState() => _InfosPersonneState();
}

class _InfosPersonneState extends State<InfosPersonne> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}