import 'package:flutter/material.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';

class ResponsiveChildWidget extends StatelessWidget {
  const ResponsiveChildWidget(
      {super.key, required this.child1, required this.child2, this.flex});

  final Widget child1;
  final Widget child2;
  final int? flex;

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return Row(
        children: [
          Expanded(flex: (flex == null) ? 1 : flex!, child: child1),
          const SizedBox(width: p20),
          Expanded(flex: (flex == null) ? 1 : flex!, child: child2),
        ],
      );
    } else if (Responsive.isTablet(context)) {
      return Row(
        children: [
          Expanded(flex: (flex == null) ? 1 : flex!, child: child1),
          const SizedBox(width: p20),
          Expanded(flex: (flex == null) ? 1 : flex!, child: child2),
        ],
      );
    } else {
      return Column(
        children: [child1, child2],
      );
    }
  }
}
