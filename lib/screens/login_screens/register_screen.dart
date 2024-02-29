import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/controllers/login_screen_controllers/auth_controller.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/extensions.dart';
import 'package:kartek_demo/utils/fonts.dart';
import 'package:kartek_demo/utils/validation_check.dart';
import 'package:kartek_demo/witgets/custom_form_field.dart';
import 'package:kartek_demo/witgets/custom_material_button.dart';
import 'package:kartek_demo/witgets/custom_model_bottom_sheet.dart';
import 'package:kartek_demo/witgets/custom_show_dialog.dart';

import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController secondPassword;
  late GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    email = TextEditingController();
    password = TextEditingController();
    secondPassword = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    secondPassword.dispose();
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Title
                    const RegisterTitleCard(),

                    //Input Widgets
                    RegisterInputParts(
                        size: size,
                        email: email,
                        password: password,
                        secondPassword: secondPassword),

                    //agreement
                    const AgreementPart(),

                    //Button
                    CustomMaterialButton(
                        tap: () {
                          if (_formKey.currentState!.validate()) {
                            if (password.text == secondPassword.text) {
                              p.userRegister(
                                  email: email.text.trim(),
                                  password: password.text,
                                  context: context);
                            } else {
                              CustomShowDialog.showMessage(context,
                                  iconData: Icons.close,
                                  title: 'password.val.check.title',
                                  subtitle: 'password.val.check');
                            }
                          } else {
                            CustomShowDialog.showMessage(context,
                                iconData: Icons.close,
                                title: 'val.error.title',
                                subtitle: 'val.error');
                          }
                        },
                        text: 'register'),

                    //Login Line

                    const LoginLine(),
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

class RegisterTitleCard extends StatelessWidget {
  const RegisterTitleCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: context.dynamicHeight(0.03),
          bottom: context.dynamicHeight(0.10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: context.dynamicHeight(0.05)),
              const Text('register', style: customFont34Bold).tr(),
              const SizedBox(height: AppConstant.smallPadding),
            ],
          ),
        ],
      ),
    );
  }
}

class RegisterInputParts extends StatelessWidget with InputValidationMixin {
  const RegisterInputParts({
    super.key,
    required this.size,
    required this.email,
    required this.password,
    required this.secondPassword,
  });

  final Size size;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController secondPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.dynamicHeight(0.04)),
      child: Column(
        children: [
          InputTextWithBorder(
            size: size,
            textEditingController: email,
            label: 'email',
            validation: (val) {
              if (emailValid(val!)) {
                return null;
              } else {
                return 'Geçerli bir email adresi girin';
              }
            },
          ),
          const SizedBox(height: AppConstant.defaultPadding),
          InputPasswordWithBorder(
            size: size,
            textEditingController: password,
            label: 'password',
            validation: (val) {
              if (val!.length > 5) {
                return null;
              } else {
                return 'Şifreniz en az 6 haneli olmalıdır';
              }
            },
          ),
          const SizedBox(height: AppConstant.defaultPadding),
          InputPasswordWithBorder(
            size: size,
            textEditingController: secondPassword,
            label: 'password.again',
            validation: (val) {
              if (val!.length > 5) {
                return null;
              } else {
                return 'Şifreniz en az 6 haneli olmalıdır';
              }
            },
          ),
        ],
      ),
    );
  }
}

class LoginLine extends StatelessWidget {
  const LoginLine({
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
            'login.check',
            style: customFont16SemiBold,
          ).tr(),
          const SizedBox(width: 2),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text(
              'login.v2',
              style: customFont16Bold.copyWith(
                  color: CustomThemeData.primaryColor),
            ).tr(),
          ),
        ],
      ),
    );
  }
}

class AgreementPart extends StatelessWidget {
  const AgreementPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: AppConstant.smallPadding,
          left: AppConstant.smallPadding,
          bottom: context.dynamicHeight(0.02)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('agreement.1', style: customFont11).tr(),
                  GestureDetector(
                    onTap: () {
                      CustomModalButtomSheet().buildshowModalBottomSheet(
                          context: context,
                          widget: const Text(
                              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using,It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using,It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using '));
                    },
                    child: Text(
                      'agreement.2',
                      style: customFont11SemiBold.copyWith(
                          color: CustomThemeData.primaryColor),
                    ).tr(),
                  ),
                  const Text('agreement.3', style: customFont11).tr(),
                  const Text('agreement.4', style: customFont11).tr(),
                ],
              ),
              const SizedBox(height: AppConstant.ultraSmallPadding),
              Row(
                children: [
                  const Text('agreement.5', style: customFont11).tr(),
                  GestureDetector(
                    onTap: () {
                      CustomModalButtomSheet().buildshowModalBottomSheet(
                          context: context,
                          widget: const Text(
                              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using,It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using,It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using '));
                    },
                    child: Text(
                      'agreement.6',
                      style: customFont11SemiBold.copyWith(
                          color: CustomThemeData.primaryColor),
                    ).tr(),
                  ),
                  const Text('agreement.7', style: customFont11).tr(),
                ],
              ),
              const SizedBox(height: AppConstant.ultraSmallPadding),
              Row(
                children: [
                  const Text('agreement.8', style: customFont11).tr(),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
