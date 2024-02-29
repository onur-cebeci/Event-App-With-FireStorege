import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/models/event_models/event_model.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/extensions.dart';
import 'package:kartek_demo/witgets/custom_form_field.dart';
import 'package:kartek_demo/witgets/custom_material_button.dart';
import 'package:kartek_demo/witgets/show_snack_bar.dart';

class AdminEditEventScreen extends StatefulWidget {
  static const String routeName = '/admin-edit-event';
  const AdminEditEventScreen({
    super.key,
    required this.model,
    required this.docs,
    required this.index,
  });
  final EventModel model;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs;
  final int index;

  @override
  State<AdminEditEventScreen> createState() => _AdminEditEventScreenState();
}

class _AdminEditEventScreenState extends State<AdminEditEventScreen> {
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
    name.text = widget.model.name;
    eventType.text = widget.model.event;
    date.text = widget.model.date;
    place.text = widget.model.place;
    price.text = widget.model.price;
    phone.text = widget.model.phone;
    address.text = widget.model.address;
    desc.text = widget.model.desc;
    img.text = widget.model.img;
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
        title: const Text('Etkinlik Düzenle'),
      ),
      floatingActionButton: SizedBox(
        width: context.dynamicWidth(0.4),
        child: CustomMaterialButton(
            color: CustomThemeData.primaryColor,
            text: 'Paylaş',
            tap: () async {
              //  databaseReference.child("asda").set({'name:': name.text});
              FirebaseFirestore.instance
                  .collection('event')
                  .doc(widget.docs[widget.index].id)
                  .update({
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
                  .then((value) => Navigator.pop(context))
                  .then((value) => showSnackBar(context, 'update.text'));
              /* await FirebaseFirestore.instance
                          .collection('event')
                          .doc()
                          .delete(); */
            }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: AppConstant.defaultPadding),
              Center(
                child: Column(
                  children: [
                    InputTextWithBorderAndHintText(
                      label: 'title',
                      size: size,
                      textEditingController: name,
                      keyboardType: TextInputType.text,
                      hintText: name.text,
                      validation: (v) {
                        return null;
                      },
                    ),
                    const SizedBox(height: AppConstant.defaultPadding),
                    InputTextWithBorderAndHintText(
                      label: 'event',
                      size: size,
                      textEditingController: eventType,
                      keyboardType: TextInputType.text,
                      hintText: eventType.text,
                      validation: (v) {
                        return null;
                      },
                    ),
                    const SizedBox(height: AppConstant.defaultPadding),
                    InputTextWithBorderAndHintText(
                      label: 'date',
                      size: size,
                      textEditingController: date,
                      keyboardType: TextInputType.datetime,
                      hintText: date.text,
                      validation: (v) {
                        return null;
                      },
                    ),
                    const SizedBox(height: AppConstant.defaultPadding),
                    InputTextWithBorderAndHintText(
                      label: 'place',
                      size: size,
                      textEditingController: place,
                      keyboardType: TextInputType.text,
                      hintText: place.text,
                      validation: (v) {
                        return null;
                      },
                    ),
                    const SizedBox(height: AppConstant.defaultPadding),
                    InputTextWithBorderAndHintText(
                      size: size,
                      label: 'price',
                      textEditingController: price,
                      keyboardType: TextInputType.number,
                      hintText: price.text,
                      validation: (v) {
                        return null;
                      },
                    ),
                    const SizedBox(height: AppConstant.defaultPadding),
                    InputTextWithBorderAndHintText(
                      label: 'phone.number',
                      size: size,
                      textEditingController: phone,
                      keyboardType: TextInputType.number,
                      hintText: phone.text,
                      validation: (v) {
                        return null;
                      },
                    ),
                    const SizedBox(height: AppConstant.defaultPadding),
                    InputTextWithBorderAndHintText(
                      label: 'address',
                      size: size,
                      textEditingController: address,
                      keyboardType: TextInputType.streetAddress,
                      hintText: address.text,
                      validation: (v) {
                        return null;
                      },
                    ),
                    const SizedBox(height: AppConstant.defaultPadding),
                    InputTextWithBorderAndHintText(
                      label: 'desc',
                      size: size,
                      textEditingController: desc,
                      keyboardType: TextInputType.text,
                      hintText: desc.text,
                      validation: (v) {
                        return null;
                      },
                    ),
                    const SizedBox(height: AppConstant.defaultPadding),
                    InputTextWithBorderAndHintText(
                      label: 'img',
                      size: size,
                      textEditingController: img,
                      keyboardType: TextInputType.text,
                      hintText: img.text,
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
    );
  }
}
