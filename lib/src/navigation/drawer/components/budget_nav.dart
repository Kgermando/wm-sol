import 'package:flutter/material.dart';

class BudgetNav extends StatefulWidget {
  const BudgetNav({super.key, required this.currentRoute});
  final String currentRoute;

  @override
  State<BudgetNav> createState() => _BudgetNavState();
}

class _BudgetNavState extends State<BudgetNav> {
  
  @override
  Widget build(BuildContext context) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;

    return Container();
  }
}