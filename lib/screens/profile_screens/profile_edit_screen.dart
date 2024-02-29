import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/controllers/events_controllers/event_controller.dart';
import 'package:kartek_demo/controllers/login_screen_controllers/auth_controller.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/extensions.dart';
import 'package:kartek_demo/utils/fonts.dart';
import 'package:kartek_demo/witgets/custom_form_field.dart';
import 'package:kartek_demo/witgets/show_snack_bar.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatefulWidget {
  static const String routeName = "/profile-edit";

  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  String? _selectedItem;
  late TextEditingController name;
  late TextEditingController surname;
  late TextEditingController brithDay;
  late TextEditingController city;
  late TextEditingController phone;
  late TextEditingController address;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    surname = TextEditingController();
    brithDay = TextEditingController();
    city = TextEditingController();
    phone = TextEditingController();
    address = TextEditingController();

    setPlaceholder();
  }

  @override
  void dispose() {
    name.dispose();
    surname.dispose();
    brithDay.dispose();
    city.dispose();
    phone.dispose();
    address.dispose();

    super.dispose();
  }

  setPlaceholder() {
    final userModel =
        Provider.of<AuthController>(context, listen: false).userModel;

    name.text = userModel.name;
    surname.text = userModel.surname;
    brithDay.text = userModel.birthDay;
    city.text = userModel.city;
    phone.text = userModel.phone;
    address.text = userModel.address;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<EventController, AuthController>(
      builder: (context, p, authController, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('edit.profile.screen').tr(),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: AppConstant.defaultPadding),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          authController.uploudpicture(context: context);
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: authController.userModel.img.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(
                                          authController.userModel.img))
                                  : null),
                        ),
                      ),
                      const SizedBox(height: AppConstant.ultraSmallPadding),
                      Text(authController.userModel.mail),
                    ],
                  ),
                  const SizedBox(height: AppConstant.defaultPadding),
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppConstant.defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InputTextWithBorderRow(
                                width: context.dynamicWidth(0.4),
                                size: size,
                                textEditingController: name,
                                keyboardType: TextInputType.text,
                                label: 'name'.tr(),
                                validation: (v) {
                                  if (v!.isEmpty) {
                                    return 'required.text'.tr();
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              InputTextWithBorderRow(
                                width: context.dynamicWidth(0.4),
                                size: size,
                                textEditingController: surname,
                                keyboardType: TextInputType.text,
                                label: 'surname'.tr(),
                                validation: (v) {
                                  if (v!.isEmpty) {
                                    return 'required.text'.tr();
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppConstant.defaultPadding),
                        InputTextWithBorder(
                          size: size,
                          textEditingController: phone,
                          keyboardType: TextInputType.number,
                          label: 'phone.number'.tr(),
                          validation: (v) {
                            return null;
                          },
                        ),
                        const SizedBox(height: AppConstant.defaultPadding),
                        Container(
                          width: size.width / 1.1,
                          height: 60,
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppConstant.defaultPadding),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                          child: DropdownButton<String>(
                              hint: authController.userModel.city.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: AppConstant.extraSmallPadding,
                                          top: AppConstant.extraSmallPadding),
                                      child:
                                          Text(authController.userModel.city),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: AppConstant.extraSmallPadding,
                                          top: AppConstant.extraSmallPadding),
                                      child: Text(p.city.first.toString()),
                                    ),
                              underline: const SizedBox.shrink(),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              value: _selectedItem == ''
                                  ? p.city.first
                                  : _selectedItem,
                              onChanged: (v) {
                                _selectedItem = v;

                                p.getSelectedCity(v: v!);
                              },
                              items: p.city
                                  .map<DropdownMenuItem<String>>((e) =>
                                      DropdownMenuItem<String>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left:
                                                  AppConstant.ultraSmallPadding,
                                              top: AppConstant
                                                  .ultraSmallPadding),
                                          child: SizedBox(
                                              height: 60,
                                              width: size.width / 1.3,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(e),
                                                ],
                                              )),
                                        ),
                                      ))
                                  .toList()),
                        ),
                        const SizedBox(height: AppConstant.defaultPadding),
                        InputTextWithBorder(
                          size: size,
                          textEditingController: brithDay,
                          keyboardType: TextInputType.datetime,
                          label: 'birthDay'.tr(),
                          validation: (v) {
                            if (v!.isEmpty) {
                              return 'required.text'.tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: AppConstant.defaultPadding),
                        InputTextWithBorder(
                          size: size,
                          textEditingController: address,
                          keyboardType: TextInputType.streetAddress,
                          label: 'address.profile'.tr(),
                          validation: (v) {
                            if (v!.isEmpty) {
                              return 'required.text'.tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: AppConstant.extraLargePadding),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppConstant.smallPadding),
                          height: 50,
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: CustomThemeData.disabledColorDark
                                          .withOpacity(0.4),
                                      blurRadius: 5,
                                      spreadRadius: .6,
                                      offset: const Offset(0, 3)),
                                ],
                                borderRadius: BorderRadius.circular(
                                    AppConstant.defaultPadding)),
                            child: MaterialButton(
                                color: CustomThemeData.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppConstant.defaultPadding),
                                ),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(authController.userModel.mail)
                                      .set({
                                        "name": name.text,
                                        "surname": surname.text,
                                        "birthDay": brithDay.text,
                                        "mail": authController.userModel.mail,
                                        "city": p.selectedCity.isNotEmpty
                                            ? p.selectedCity
                                            : authController.userModel.city,
                                        "phone": phone.text,
                                        "img": authController.userModel.img,
                                        "address": address.text,
                                        "isAdmin":
                                            authController.userModel.isAdmin,
                                      })
                                      .then((value) => authController
                                          .getUserData(context: context))
                                      .then((value) => Navigator.pop(context))
                                      .then((value) => showSnackBar(
                                          context, 'success.text'));
                                },
                                child: const Text(
                                  'upgrade',
                                  style: customFont18SemiBoldSecondary,
                                ).tr()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.dynamicHeight(0.08)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
