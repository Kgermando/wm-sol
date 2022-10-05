import 'package:flutter/material.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';

class ResponsiveChild5Widget extends StatelessWidget {
  const ResponsiveChild5Widget(
      {super.key,
      required this.child1,
      required this.child2,
      required this.child3,
      required this.child4,
      required this.child5,
      this.flex1,
      this.flex2,
      this.flex3,
      this.flex4,
      this.flex5,
      this.mainAxisAlignment});

  final Widget child1;
  final Widget child2;
  final Widget child3;
  final Widget child4;
  final Widget child5;
  final int? flex1;
  final int? flex2;
  final int? flex3;
  final int? flex4;
  final int? flex5;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return Row(
        mainAxisAlignment: (mainAxisAlignment == null) ? MainAxisAlignment.start : mainAxisAlignment!,
        children: [
          Expanded(flex: (flex1 == null) ? 1 : flex1!, child: child1), 
          Expanded(flex: (flex2 == null) ? 1 : flex2!, child: child2),
          Expanded(flex: (flex3 == null) ? 1 : flex3!, child: child3),
          Expanded(flex: (flex4 == null) ? 1 : flex4!, child: child4),
          Expanded(flex: (flex5 == null) ? 1 : flex5!, child: child5),
        ],
      );
    } else if (Responsive.isTablet(context)) {
      return Row(
        mainAxisAlignment: (mainAxisAlignment == null)
            ? MainAxisAlignment.start
            : mainAxisAlignment!,
        children: [
          Expanded(flex: (flex1 == null) ? 1 : flex1!, child: child1), 
          Expanded(flex: (flex2 == null) ? 1 : flex2!, child: child2),
          Expanded(flex: (flex4 == null) ? 1 : flex4!, child: child4),
          Expanded(flex: (flex5 == null) ? 1 : flex5!, child: child5),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              child1,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              child2,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              child3,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              child4,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              child5,
            ],
          ),
        ],
      );
    }
  }
}
