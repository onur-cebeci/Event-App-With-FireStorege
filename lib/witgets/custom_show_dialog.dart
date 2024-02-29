import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/extensions.dart';
import 'package:kartek_demo/utils/fonts.dart';
import 'package:kartek_demo/witgets/custom_elevated_button.dart';

class CustomShowDialog {
  static const double _dialogHeight = 230;
  static const double _dialogHeightTablet = 280;
  static const double _radius = 35;
  static const double _iconSize = 40;
  static const double _buttonHeight = 40;

  CustomShowDialog.showMessage(
    BuildContext context, {
    required String title,
    required String subtitle,
    IconData iconData = Icons.done,
  }) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: AppConstant.tablet < size.width
                ? context.dynamicWidth(0.5)
                : context.dynamicWidth(0.80),
            height: AppConstant.tablet < size.height
                ? _dialogHeight
                : _dialogHeightTablet,
            child: Card(
              child: Padding(
                padding: customPaddingLarge,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: CustomThemeData.whiteColor,
                      radius: _radius,
                      child: Icon(
                        iconData,
                        size: _iconSize,
                        color: CustomThemeData.primaryColor,
                      ),
                    ),
                    context.sizedBoxHeightExtraSmall,
                    Text(
                      title,
                      style: customFont18Bold.copyWith(
                        color: CustomThemeData.primaryColor,
                      ),
                    ).tr(),
                    context.sizedBoxHeightUltraSmall,
                    Text(
                      subtitle,
                      style: customFont13SemiBold.copyWith(
                        color: context.disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ).tr(),
                    const Spacer(),
                    SizedBox(
                      width: size.width / 3,
                      child: CustomElevatedButton(
                        title: 'close',
                        onPressed: () => Navigator.of(context).pop(),
                        height: _buttonHeight,
                      ),
                    ),
                    context.sizedBoxHeightExtraSmall,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  CustomShowDialog.showSuccesMessage(
    BuildContext context, {
    required String title,
    required String subtitle,
    required void Function() onPressed,
  }) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: AppConstant.tablet < size.width
                ? context.dynamicWidth(0.5)
                : context.dynamicWidth(0.80),
            height: AppConstant.tablet < size.height
                ? _dialogHeight
                : _dialogHeightTablet,
            child: Card(
              child: Padding(
                padding: customPaddingLarge,
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundColor: CustomThemeData.whiteColor,
                      radius: _radius,
                      child: Icon(
                        Icons.done,
                        size: _iconSize,
                        color: CustomThemeData.primaryColor,
                      ),
                    ),
                    context.sizedBoxHeightExtraSmall,
                    Text(
                      title,
                      style: customFont18Bold.copyWith(
                        color: CustomThemeData.primaryColor,
                      ),
                    ).tr(),
                    context.sizedBoxHeightUltraSmall,
                    Text(
                      subtitle,
                      style: customFont13SemiBold.copyWith(
                        color: context.disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ).tr(),
                    const Spacer(),
                    SizedBox(
                      width: size.width / 3,
                      child: CustomElevatedButton(
                        title: 'close',
                        onPressed: onPressed,
                        height: _buttonHeight,
                      ),
                    ),
                    context.sizedBoxHeightExtraSmall,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  CustomShowDialog.showMessageToLogin(
    BuildContext context, {
    required String title,
    required String subtitle,
    IconData iconData = Icons.done,
  }) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: AppConstant.tablet < size.width
                ? context.dynamicWidth(0.5)
                : context.dynamicWidth(0.80),
            height: AppConstant.tablet < size.height
                ? _dialogHeight
                : _dialogHeightTablet,
            child: Card(
              child: Padding(
                padding: customPaddingLarge,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: CustomThemeData.whiteColor,
                      radius: _radius,
                      child: Icon(
                        iconData,
                        size: _iconSize,
                        color: CustomThemeData.primaryColor,
                      ),
                    ),
                    context.sizedBoxHeightExtraSmall,
                    Text(
                      title,
                      style: customFont18Bold.copyWith(
                        color: CustomThemeData.primaryColor,
                      ),
                    ).tr(),
                    context.sizedBoxHeightUltraSmall,
                    Text(
                      subtitle,
                      style: customFont13SemiBold.copyWith(
                        color: context.disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ).tr(),
                    const Spacer(),
                    SizedBox(
                      width: size.width / 3,
                      child: CustomElevatedButton(
                        title: 'close',
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/login'),
                        height: _buttonHeight,
                      ),
                    ),
                    context.sizedBoxHeightExtraSmall,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
