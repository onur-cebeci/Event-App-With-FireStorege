import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color color;
  final double height;
  final String title;
  final TextStyle style;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    Key? key,
    required this.title,
    this.color = CustomThemeData.blackColorLight,
    required this.onPressed,
    this.height = kTextTabBarHeight,
    this.style = customFont14SemiBoldSecondary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: height),
      height: height,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 2,
            spreadRadius: 0.5,
            blurStyle: BlurStyle.normal,
            color: CustomThemeData.blackColorLight)
      ]),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            color,
          ),
        ),
        onPressed: onPressed,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(title, style: style).tr(),
        ]),
      ),
    );
  }
}
