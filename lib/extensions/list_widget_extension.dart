import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prosoft_task/extensions/list_extension.dart';

extension ListWidgetExtension on List<Widget> {
  static const double _defaultHorizontalSpace = 8;
  static const double _defaultVerticalSpace = 8;

  List<Widget> _spaced({
    required double horizontalSpace,
    required double verticalSpace,
  }) {
    return separated(SizedBox(width: horizontalSpace, height: verticalSpace));
  }

  List<Widget> horizontallySpaced({
    double horizontalSpace = _defaultHorizontalSpace,
  }) {
    return _spaced(
      horizontalSpace: horizontalSpace,
      verticalSpace: 0,
    );
  }

  List<Widget> verticallySpaced({
    double verticalSpace = _defaultVerticalSpace,
  }) {
    return _spaced(
      horizontalSpace: 0,
      verticalSpace: verticalSpace,
    );
  }
}
