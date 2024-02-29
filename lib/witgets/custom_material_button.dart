// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/fonts.dart';

class CustomMaterialButton extends StatelessWidget {
  final String text;
  final void Function()? tap;
  late Color color;
  CustomMaterialButton(
      {super.key,
      required this.text,
      required this.tap,
      this.color = CustomThemeData.blackColorLight});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstant.smallPadding),
      height: 50,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: CustomThemeData.blueColor.withOpacity(0.4),
              blurRadius: 5,
              spreadRadius: .6,
              offset: const Offset(0, 3)),
        ], borderRadius: BorderRadius.circular(AppConstant.extraSmallPadding)),
        child: MaterialButton(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppConstant.extraSmallPadding),
            ),
            onPressed: tap,
            child: Text(
              text,
              style: customFont18SemiBoldSecondary,
            ).tr()),
      ),
    );
  }
}

class CustomMaterialButtonType2 extends StatelessWidget {
  final String text;
  final void Function()? tap;
  late Color color;
  CustomMaterialButtonType2(
      {super.key,
      required this.text,
      required this.tap,
      this.color = CustomThemeData.blackColorLight});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstant.smallPadding),
      height: 50,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: CustomThemeData.blueColor.withOpacity(0.4),
              blurRadius: 5,
              spreadRadius: .6,
              offset: const Offset(0, 3)),
        ], borderRadius: BorderRadius.circular(AppConstant.defaultPadding)),
        child: MaterialButton(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstant.defaultPadding),
            ),
            onPressed: tap,
            child: Text(
              text,
              style: customFont18SemiBoldSecondary,
            ).tr()),
      ),
    );
  }
}
