import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/controllers/login_screen_controllers/auth_controller.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/extensions.dart';
import 'package:kartek_demo/utils/fonts.dart';
import 'package:kartek_demo/witgets/custom_form_field.dart';
import 'package:kartek_demo/witgets/custom_material_button.dart';
import 'package:kartek_demo/witgets/custom_show_dialog.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController email;
  late TextEditingController password;
  @override
  void initState() {
    super.initState();

    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthController>(
      builder: (context, p, child) {
        return Scaffold(
          backgroundColor: CustomThemeData.whiteColor,
          body: SafeArea(
              child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Title
                const LoginScreenTitleCard(),

                //Input Widgets
                LoginScreenInputPart(
                    size: size, email: email, password: password),

                //forgot password
                const ForgotPasswordLine(),

                //Button
                CustomMaterialButton(
                    tap: () {
                      if (email.text.isNotEmpty && password.text.isNotEmpty) {
                        p.userLogin(
                            email: email.text.trim(),
                            password: password.text,
                            context: context);
                      } else {
                        CustomShowDialog.showMessage(context,
                            iconData: Icons.close,
                            title: 'login.error.title',
                            subtitle: 'login.error');
                      }
                    },
                    text: 'login'),
                //Social

                const SocialLine(),
                //Register Line

                const RegisterLine(),
              ],
            ),
          )),
        );
      },
    );
  }
}

class ForgotPasswordLine extends StatelessWidget {
  const ForgotPasswordLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/forgot-password');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: context.dynamicHeight(0.035),
                bottom: context.dynamicHeight(0.035),
                right: AppConstant.smallPadding),
            child: const Text(
              're.password',
              style: customFont13SemiBold,
            ).tr(),
          )
        ],
      ),
    );
  }
}

class RegisterLine extends StatelessWidget {
  const RegisterLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.dynamicHeight(0.05)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'register.check',
            style: customFont15SemiBold,
          ).tr(),
          const SizedBox(width: 2),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/register');
            },
            child: Text(
              'register',
              style: customFont15Bold.copyWith(
                  color: CustomThemeData.primaryColor),
            ).tr(),
          ),
        ],
      ),
    );
  }
}

class SocialLine extends StatelessWidget {
  const SocialLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, p, child) {
        return Padding(
          padding: EdgeInsets.only(
            top: context.dynamicHeight(0.035),
            bottom: context.dynamicHeight(0.035),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    CustomShowDialog.showMessageToLogin(context,
                        iconData: Icons.close,
                        title: 'unavailable',
                        subtitle: 'unavailable.text');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: AppConstant.ultraSmallPadding),
                    child: Image.asset(
                      'assets/icons/apple-logo.png',
                      height: 50,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    p.signInWithGoogle(context: context);
                  },
                  child: Image.asset(
                    'assets/icons/google-glass-logo.png',
                    height: 42,
                  ),
                ),
              ]),
        );
      },
    );
  }
}

class LoginScreenInputPart extends StatelessWidget {
  const LoginScreenInputPart({
    super.key,
    required this.size,
    required this.email,
    required this.password,
  });

  final Size size;
  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputTextWithBorder(
          size: size,
          textEditingController: email,
          label: 'email',
          validation: (v) {
            return null;
          },
        ),
        const SizedBox(height: AppConstant.defaultPadding),
        InputPasswordWithBorder(
          size: size,
          textEditingController: password,
          label: 'password',
          validation: (v) {
            return null;
          },
        ),
      ],
    );
  }
}

class LoginScreenTitleCard extends StatelessWidget {
  const LoginScreenTitleCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: context.dynamicHeight(0.05),
          bottom: context.dynamicHeight(0.13)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: context.dynamicHeight(0.05)),
              const Text('hi', style: customFont28Bold).tr(),
              const SizedBox(height: AppConstant.smallPadding),
              Column(
                children: [
                  const Text('introduce', style: customFont15SemiBold).tr(),
                  const Text('welcome', style: customFont15SemiBold).tr()
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
