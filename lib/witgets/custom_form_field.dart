// ignore_for_file: type_init_formals, must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/controllers/login_screen_controllers/auth_controller.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/fonts.dart';

import 'package:provider/provider.dart';

class InputTextWithBorder extends StatelessWidget {
  InputTextWithBorder({
    super.key,
    required this.size,
    required this.textEditingController,
    required this.label,
    required this.validation,
    TextInputType? this.keyboardType = TextInputType.text,
    this.isSecond = false,
  });

  final Size size;
  final TextEditingController textEditingController;
  final String? Function(String?)? validation;
  final String label;
  final bool isSecond;
  late TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, p, child) {
        return SizedBox(
            width: size.width / 1.1,
            child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: textEditingController,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  label: Text(label).tr(),
                  hintStyle: customFont11SemiBold,
                  hintMaxLines: 1,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppConstant.smallPadding))),
                ),
                validator: validation));
      },
    );
  }
}

class InputTextWithBorderRow extends StatelessWidget {
  InputTextWithBorderRow({
    super.key,
    required this.size,
    required this.textEditingController,
    required this.label,
    required this.validation,
    TextInputType? this.keyboardType = TextInputType.text,
    this.isSecond = false,
    required this.width,
  });

  final Size size;
  final TextEditingController textEditingController;
  final String? Function(String?)? validation;
  final String label;
  final double width;
  final bool isSecond;
  late TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, p, child) {
        return SizedBox(
            width: width,
            child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: textEditingController,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  label: Text(label).tr(),
                  hintStyle: customFont11SemiBold,
                  hintMaxLines: 1,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppConstant.smallPadding))),
                ),
                validator: validation));
      },
    );
  }
}

//
class InputTextWithBorderAndHintText extends StatelessWidget {
  InputTextWithBorderAndHintText({
    super.key,
    required this.size,
    required this.textEditingController,
    required this.hintText,
    required this.validation,
    TextInputType? this.keyboardType = TextInputType.text,
    this.isSecond = false,
    required this.label,
  });

  final Size size;
  final TextEditingController textEditingController;
  final String? Function(String?)? validation;
  final String hintText;
  final String label;
  final bool isSecond;
  late TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, p, child) {
        return SizedBox(
            width: size.width / 1.1,
            child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: textEditingController,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  hintText: hintText,
                  label: Text(label).tr(),
                  hintStyle: customFont11SemiBold,
                  hintMaxLines: 1,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppConstant.smallPadding))),
                ),
                validator: validation));
      },
    );
  }
}

//
class InputTextWithBorderLarge extends StatelessWidget {
  InputTextWithBorderLarge({
    super.key,
    required this.size,
    required this.textEditingController,
    required this.label,
    required this.validation,
    TextInputType? this.keyboardType = TextInputType.text,
    this.isSecond = false,
  });

  final Size size;
  final TextEditingController textEditingController;
  final String? Function(String?)? validation;
  final String label;
  final bool isSecond;
  late TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, p, child) {
        return Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstant.defaultPadding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), border: Border.all()),
          height: 80,
          child: TextFormField(
            controller: textEditingController,
            style: customFont16,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            validator: validation,
            enabled: true,
            maxLines: 3,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              hintText: label,
              errorMaxLines: 2,
            ),
          ),
        );
      },
    );
  }
}

//
class InputPasswordWithBorder extends StatelessWidget {
  const InputPasswordWithBorder({
    super.key,
    required this.size,
    required this.textEditingController,
    required this.label,
    required this.validation,
  });

  final Size size;
  final TextEditingController textEditingController;
  final String? Function(String?)? validation;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, p, child) {
        return SizedBox(
            width: size.width / 1.1,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: textEditingController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: p.isVisible,
              decoration: InputDecoration(
                label: Text(label).tr(),
                suffixIcon: p.isVisible
                    ? InkWell(
                        onTap: () {
                          p.setVisiblity();
                        },
                        child: const Icon(Icons.visibility_off))
                    : InkWell(
                        onTap: () {
                          p.setVisiblity();
                        },
                        child: const Icon(Icons.visibility)),
                hintStyle: customFont11SemiBold,
                hintMaxLines: 1,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppConstant.smallPadding))),
              ),
              validator: validation,
            ));
      },
    );
  }
}
