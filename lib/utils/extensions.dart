// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicHeight(double value) => MediaQuery.of(this).size.height * value;

  double dynamicWidth(double value) => MediaQuery.of(this).size.width * value;

  ScaffoldMessengerState get scaffold => ScaffoldMessenger.of(this);

  TextStyle? get headline4 => Theme.of(this).textTheme.headline4;

  TextStyle? get headline5 => Theme.of(this).textTheme.headline5;

  TextStyle? get headline6 => Theme.of(this).textTheme.headline6;

  TextStyle? get subtitle1 => Theme.of(this).textTheme.subtitle1;

  TextStyle? get subtitle2 => Theme.of(this).textTheme.subtitle2;

  TextStyle? get bodyText1 => Theme.of(this).textTheme.bodyText1;

  TextStyle? get bodyText2 => Theme.of(this).textTheme.bodyText2;

  TextStyle? get button => Theme.of(this).textTheme.button;

  TextStyle? get caption => Theme.of(this).textTheme.caption;

  TextStyle? get overLine => Theme.of(this).textTheme.overline;

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get cardColor => Theme.of(this).cardColor;

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  Color get dialogBackgroundColor => Theme.of(this).dialogBackgroundColor;

  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get hintColor => Theme.of(this).hintColor;

  Color get disabledColor => Theme.of(this).disabledColor;

  Color get secondaryHeaderColor => Theme.of(this).secondaryHeaderColor;

  Color get primaryColorLight => Theme.of(this).primaryColorLight;

  Color get errorColor => Theme.of(this).errorColor;
}

extension PaddingValues on BuildContext {
  /// Width
  double get paddingUltraSmallWidth => dynamicWidth(0.01);
  double get paddingUltraSmallV2Width => dynamicWidth(0.013);

  double get paddingExtraSmallWidth => dynamicWidth(0.02);

  double get paddingSmallWidth => dynamicWidth(0.04);

  double get paddingDefaultWidth => dynamicWidth(0.06);

  double get paddingLargeWidth => dynamicWidth(0.08);

  double get paddingExtraLargeWidth => dynamicWidth(0.1);

  /// Height
  double get paddingSmallest => dynamicHeight(0.002);
  double get paddingUltraSmallHeight => dynamicHeight(0.005);

  double get paddingExtraSmallHeight => dynamicHeight(0.01);

  double get paddingSmallHeight => dynamicHeight(0.02);

  double get paddingDefaultHeight => dynamicHeight(0.04);

  double get paddingLargeHeight => dynamicHeight(0.08);

  double get paddingExtraLargeHeight => dynamicHeight(0.08);
}

extension EmptyWidget on BuildContext {
  Widget get sizedBoxHeightMicro => SizedBox(
        height: dynamicHeight(0.005),
      );

  Widget get sizedBoxHeightUltraSmall => SizedBox(
        height: dynamicHeight(0.01),
      );

  Widget get sizedBoxHeightExtraSmall => SizedBox(
        height: dynamicHeight(0.02),
      );

  Widget get sizedBoxHeightSmall => SizedBox(
        height: dynamicHeight(0.04),
      );

  Widget get sizedBoxHeightDefault => SizedBox(
        height: dynamicHeight(0.06),
      );

  Widget get sizedBoxHeightLarge => SizedBox(
        height: dynamicHeight(0.08),
      );

  Widget get sizedBoxHeightExtraLarge => SizedBox(
        height: dynamicHeight(0.1),
      );

  Widget get sizedBoxWidthMicroSmall => SizedBox(
        width: dynamicWidth(0.008),
      );

  Widget get sizedBoxWidthExtraSmall => SizedBox(
        width: dynamicWidth(0.02),
      );

  Widget get sizedBoxWidthSmall => SizedBox(
        width: dynamicWidth(0.04),
      );

  Widget get sizedBoxWidthDefault => SizedBox(
        width: dynamicWidth(0.06),
      );

  Widget get sizedBoxWidthLarge => SizedBox(
        width: dynamicWidth(0.08),
      );

  Widget get sizedBoxWidthExtraLarge => SizedBox(
        width: dynamicWidth(0.1),
      );
}
