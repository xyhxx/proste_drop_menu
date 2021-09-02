import 'package:flutter/cupertino.dart';

class ProsteDropMenuItem {
  ProsteDropMenuItem({
    this.builder,
    this.tigger,
  });

  final void Function(BuildContext context)? tigger;
  final Widget Function(BuildContext context)? builder;
}
