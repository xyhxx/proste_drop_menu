import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProsteDropMenuHeaderItem {
  ProsteDropMenuHeaderItem({
    required this.label,
    this.icon,
    this.color,
    this.selectColor,
    this.size,
    this.selectStyle,
    this.style,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.border = const BorderSide(
      width: 1,
      color: Colors.black26,
    ),
  });

  final String label;
  final IconData? icon;
  final Color? color;
  final Color? selectColor;
  final double? size;
  final TextStyle? style;
  final TextStyle? selectStyle;
  final EdgeInsets? padding;
  final BorderSide? border;
}
