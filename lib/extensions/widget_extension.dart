import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget horizontalPadding(double padding) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: this,
      );

  Widget verticalPadding(double padding) => Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: this,
      );

  Widget allPadding(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget symmetricPadding(
          {required double horizontal, required double vertical}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget onlyPadding({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          right: right,
          top: top,
          bottom: bottom,
        ),
        child: this,
      );

  Widget center() => Center(child: this);
}
