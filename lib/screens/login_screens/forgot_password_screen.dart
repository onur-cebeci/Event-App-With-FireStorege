import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/fonts.dart';
import 'package:kartek_demo/witgets/custom_form_field.dart';
import 'package:kartek_demo/witgets/custom_material_button.dart';
import 'package:kartek_demo/witgets/custom_show_dialog.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot-password';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController email;

  @override
  void initState() {
    super.initState();

    email = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomThemeData.whiteColor,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: CustomThemeData.whiteColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'reset.password',
          style: customFont18SemiBold,
        ).tr(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            // introduce
            const Text(
              're.password.text',
              style: customFont18SemiBold,
              textAlign: TextAlign.center,
            ).tr(),
            const SizedBox(height: AppConstant.defaultPadding),
            //input widget
            InputTextWithBorder(
              size: size,
              textEditingController: email,
              label: 'email',
              validation: (v) {
                return null;
              },
            ),
            //button
            const SizedBox(height: AppConstant.defaultPadding),

            CustomMaterialButton(
                tap: () {
                  CustomShowDialog.showMessageToLogin(context,
                      iconData: Icons.close,
                      title: 'unavailable',
                      subtitle: 'unavailable.text');
                },
                text: 'reset.password'),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
