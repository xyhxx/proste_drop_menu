import 'package:flutter/cupertino.dart';

class ProsteDropMenuItem {
  ProsteDropMenuItem({
    this.builder,
    this.tigger,
    this.backgroundColor,
    this.radius,
    this.height,
    this.child,
  });

  final void Function(BuildContext context)? tigger;
  final Widget Function(BuildContext context, Widget? child)? builder;
  final Color? backgroundColor;
  final BorderRadius? radius;
  final double? height;
  final Widget? child;
}
