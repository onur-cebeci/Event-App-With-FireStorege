import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/extensions.dart';
import 'package:kartek_demo/witgets/custom_form_field.dart';
import 'package:kartek_demo/witgets/custom_material_button.dart';
import 'package:kartek_demo/witgets/custom_show_dialog.dart';

class AdminAddEventScreen extends StatefulWidget {
  static const String routeName = '/admin-add-event';
  const AdminAddEventScreen({super.key});

  @override
  State<AdminAddEventScreen> createState() => _AdminAddEventScreenState();
}

class _AdminAddEventScreenState extends State<AdminAddEventScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController eventType;
  late TextEditingController date;
  late TextEditingController place;
  late TextEditingController price;
  late TextEditingController phone;
  late TextEditingController address;
  late TextEditingController desc;
  late TextEditingController img;

  @override
  void initState() {
    super.initState();

    name = TextEditingController();
    eventType = TextEditingController();
    date = TextEditingController();
    place = TextEditingController();
    price = TextEditingController();
    phone = TextEditingController();
    address = TextEditingController();
    desc = TextEditingController();
    img = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    eventType.dispose();
    date.dispose();
    place.dispose();
    price.dispose();
    phone.dispose();
    address.dispose();
    desc.dispose();
    img.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomThemeData.primaryColor,
        centerTitle: true,
        title: const Text('Etkinlik Oluştur'),
      ),
      floatingActionButton: SizedBox(
        width: context.dynamicWidth(0.4),
        child: CustomMaterialButton(
            color: CustomThemeData.primaryColor,
            text: 'Paylaş',
            tap: () async {
              if (_key.currentState!.validate()) {
                await FirebaseFirestore.instance
                    .collection('event')
                    .add({
                      'name': name.text,
                      'eventType': eventType.text,
                      'date': date.text,
                      'place': place.text,
                      'price': price.text,
                      'phone': phone.text,
                      'desc': desc.text,
                      'address': address.text,
                      'img': img.text,
                    })
                    .then((value) => CustomShowDialog.showSuccesMessage(context,
                        title: 'success',
                        subtitle: 'success.text',
                        onPressed: () => Navigator.pop(context)))
                    .then((value) {
                      name.text = "";
                      eventType.text = "";
                      date.text = "";
                      place.text = "";
                      price.text = "";
                      phone.text = "";
                      desc.text = "";
                      address.text = "";
                      img.text = "";
                    });
              }
            }),
      ),
      body: SafeArea(
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: AppConstant.defaultPadding),
                Center(
                  child: Column(
                    children: [
                      InputTextWithBorder(
                        size: size,
                        textEditingController: name,
                        keyboardType: TextInputType.text,
                        label: 'Başlık',
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
                        textEditingController: eventType,
                        keyboardType: TextInputType.text,
                        label: 'Etkinlik türü',
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
                        textEditingController: date,
                        keyboardType: TextInputType.datetime,
                        label: 'Tarih',
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
                        textEditingController: place,
                        keyboardType: TextInputType.text,
                        label: 'Konum',
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
                        textEditingController: price,
                        keyboardType: TextInputType.number,
                        label: 'Bilet tutarı',
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
                        textEditingController: phone,
                        keyboardType: TextInputType.number,
                        label: 'Telefon numarası',
                        validation: (v) {
                          return null;
                        },
                      ),
                      const SizedBox(height: AppConstant.defaultPadding),
                      InputTextWithBorder(
                        size: size,
                        textEditingController: address,
                        keyboardType: TextInputType.streetAddress,
                        label: 'Etkinliğin adresi',
                        validation: (v) {
                          if (v!.isEmpty) {
                            return 'required.text'.tr();
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: AppConstant.defaultPadding),
                      InputTextWithBorderLarge(
                        size: size,
                        textEditingController: desc,
                        keyboardType: TextInputType.text,
                        label: 'Açıklama',
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
                        textEditingController: img,
                        keyboardType: TextInputType.text,
                        label: 'Resim Url',
                        validation: (v) {
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.dynamicHeight(0.08)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
