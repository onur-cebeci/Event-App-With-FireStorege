import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/models/event_models/event_model.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/extensions.dart';
import 'package:kartek_demo/utils/fonts.dart';
import 'package:kartek_demo/witgets/custom_material_button.dart';
import 'package:kartek_demo/witgets/custom_show_dialog.dart';

class EventDetailScreen extends StatelessWidget {
  static const String routeName = '/event-detail';
  const EventDetailScreen({super.key, required this.model});

  final EventModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomThemeData.whiteColor,
      body: ListView(
        children: [
          //appbar
          EvetDetailAppBar(
            model: model,
          ),
          const SizedBox(height: AppConstant.defaultPadding),
          //informations
          EventDetailInformationCard(model: model),
          //description
          Padding(
            padding: const EdgeInsets.only(
                left: AppConstant.smallPadding,
                top: AppConstant.smallPadding,
                right: AppConstant.smallPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'desc',
                      style: customFont18SemiBold,
                    ).tr(),
                  ],
                ),
                Text(model.desc)
              ],
            ),
          ),
          const SizedBox(height: AppConstant.defaultPadding),
          //botton
          CustomMaterialButtonType2(
            text: 'calendar.add',
            tap: () {
              CustomShowDialog.showSuccesMessage(context,
                  title: 'success', subtitle: 'success.text', onPressed: () {
                Navigator.pop(context);
              });
            },
            color: CustomThemeData.primaryColor,
          ),
          const SizedBox(height: AppConstant.defaultPadding),
        ],
      ),
    );
  }
}

class EventDetailInformationCard extends StatelessWidget {
  const EventDetailInformationCard({
    super.key,
    required this.model,
  });

  final EventModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EventDetailInformationLine(
          icon: Icons.payments_outlined,
          text: "${model.price}₺",
        ),
        EventDetailInformationLine(
          icon: Icons.screenshot_monitor_rounded,
          text: model.event,
        ),
        EventDetailInformationLine(
          icon: Icons.calendar_month,
          text: model.date,
        ),
        model.phone.isNotEmpty
            ? EventDetailInformationLine(
                icon: Icons.phone,
                text: model.phone,
              )
            : const SizedBox.shrink(),
        EventDetailInformationLine(
          icon: Icons.location_pin,
          text: model.place,
        ),
        EventDetailInformationLine(
          icon: Icons.map_outlined,
          text: model.address,
        ),
      ],
    );
  }
}

class EventDetailInformationLine extends StatelessWidget {
  final String text;
  final IconData icon;
  const EventDetailInformationLine({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppConstant.smallPadding, bottom: AppConstant.smallPadding),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
          ),
          Text(
            ' $text',
            style: customFont15SemiBold,
          )
        ],
      ),
    );
  }
}

class EvetDetailAppBar extends StatelessWidget {
  const EvetDetailAppBar({
    super.key,
    required this.model,
  });
  final EventModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.35),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppConstant.defaultPadding),
              bottomRight: Radius.circular(AppConstant.defaultPadding)),
          image: DecorationImage(
              image: NetworkImage(model.img), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EventDetailNavigationLine(
            model: model,
          ),
          EventDetailTitleLine(model: model),
        ],
      ),
    );
  }
}

class EventDetailTitleLine extends StatelessWidget {
  const EventDetailTitleLine({
    super.key,
    required this.model,
  });
  final EventModel model;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: AppConstant.extraSmallPadding,
              right: AppConstant.defaultPadding),
          child: Text(
            model.name,
            style: customFont28BoldSecondary,
          ),
        )
      ],
    );
  }
}

class EventDetailNavigationLine extends StatelessWidget {
  const EventDetailNavigationLine({
    super.key,
    required this.model,
  });
  final EventModel model;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(
                top: AppConstant.extraSmallPadding,
                left: AppConstant.extraSmallPadding),
            child: Icon(
              Icons.arrow_back_ios,
              color: CustomThemeData.whiteColor,
              size: 35,
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await FirebaseFirestore.instance.collection('likes-list').add({
              'name': model.name,
              'eventType': model.event,
              'date': model.date,
              'place': model.place,
              'price': model.price,
              'phone': model.phone,
              'desc': model.desc,
              'address': model.address,
              'img': model.img,
            });
          },
          child: const Padding(
            padding: EdgeInsets.only(
                top: AppConstant.extraSmallPadding,
                right: AppConstant.extraSmallPadding),
            child: Icon(
              Icons.favorite_border,
              color: CustomThemeData.whiteColor,
              size: 40,
            ),
          ),
        )
      ],
    );
  }
}
