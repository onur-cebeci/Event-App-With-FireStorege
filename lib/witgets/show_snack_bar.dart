import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/fonts.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: CustomThemeData.primaryColor,
      content: Text(text,
          style: customFont18Secondary.copyWith(
            color: CustomThemeData.whiteColor,
          )).tr(),
    ),
  );
}
