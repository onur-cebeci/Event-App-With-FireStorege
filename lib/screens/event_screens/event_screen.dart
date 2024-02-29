import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:kartek_demo/controllers/login_screen_controllers/auth_controller.dart';
import 'package:kartek_demo/models/event_models/event_model.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/extensions.dart';
import 'package:kartek_demo/utils/fonts.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  static const String routeName = '/event-screen';
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final ref = FirebaseFirestore.instance.collection('event').snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: CustomThemeData.whiteColor,
        appBar: AppBar(
          backgroundColor: CustomThemeData.blackColorLight,
          elevation: 0,
          title: const Text(
            'event.title',
            style: customFont20BoldSecondary,
          ).tr(),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: ref,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return EventCard(
                    size: size,
                    name: docs[index]['name'],
                    date: docs[index]['date'],
                    event: docs[index]['eventType'],
                    place: docs[index]['place'],
                    img: docs[index]['img'],
                    price: docs[index]['price'],
                    address: docs[index]['address'],
                    desc: docs[index]['desc'],
                    phone: docs[index]['phone'],
                  );
                },
              );
            }
          },
        ));
  }
}

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.size,
    required this.name,
    required this.event,
    required this.date,
    required this.place,
    required this.img,
    required this.price,
    required this.desc,
    required this.address,
    required this.phone,
  });

  final Size size;
  final String name;
  final String event;
  final String date;
  final String place;
  final String img;
  final String price;
  final String desc;
  final String address;
  final String phone;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, authController, child) {
        return GestureDetector(
          onTap: () {
            authController.userModel.mail.isNotEmpty
                ? Navigator.pushNamed(context, '/event-detail',
                    arguments: EventModel(
                        name: name,
                        date: date,
                        place: place,
                        price: price,
                        img: img,
                        desc: desc,
                        address: address,
                        event: event,
                        phone: phone))
                : Navigator.pushNamed(context, '/login');
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: context.dynamicWidth(0.05),
                vertical: context.dynamicWidth(0.04)),
            decoration: BoxDecoration(
                color: CustomThemeData.blackColorLight,
                borderRadius: BorderRadius.circular(AppConstant.smallPadding),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 0.8,
                      color: CustomThemeData.disabledColorDark),
                ]),
            height: 120,
            width: double.infinity,
            child: Row(
              children: [
                EventImagePart(
                  size: size,
                  img: img,
                  price: price,
                ),
                EventDetailPart(
                  size: size,
                  name: name,
                  date: date,
                  event: event,
                  place: place,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EventDetailPart extends StatelessWidget {
  const EventDetailPart({
    super.key,
    required this.size,
    required this.name,
    required this.event,
    required this.date,
    required this.place,
  });

  final Size size;
  final String name;
  final String event;
  final String date;
  final String place;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (size.width / 2) - context.dynamicWidth(0.04),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          EventTitleLine(
            name: name,
          ),
          EventDetailLine(
            text: event,
            iconData: Icons.location_city_outlined,
          ),
          EventDetailLine(
            text: date,
            iconData: Icons.calendar_month,
          ),
          EventDetailLine(
            text: place,
            iconData: Icons.map_outlined,
          ),
        ],
      ),
    );
  }
}

class EventTitleLine extends StatelessWidget {
  const EventTitleLine({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Text(
        name,
        style: customFont14BoldSecondary,
      ),
    );
  }
}

class EventDetailLine extends StatelessWidget {
  final String text;
  final IconData iconData;
  const EventDetailLine({
    super.key,
    required this.text,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: customFont14Secondary,
        ),
        Icon(
          iconData,
          size: 18,
          color: CustomThemeData.whiteColor,
        )
      ],
    );
  }
}

class EventImagePart extends StatelessWidget {
  const EventImagePart({
    super.key,
    required this.size,
    required this.img,
    required this.price,
  });

  final Size size;
  final String img;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: (size.width / 2.2) - context.dynamicWidth(0.04),
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppConstant.smallPadding),
                topLeft: Radius.circular(
                  AppConstant.smallPadding,
                ),
              )),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: AppConstant.ultraSmallPadding,
              horizontal: AppConstant.smallPadding),
          decoration: const BoxDecoration(
              color: CustomThemeData.primaryColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10))),
          child: Row(
            children: [
              const Icon(
                Icons.payments_outlined,
                size: 19,
                color: CustomThemeData.backgroudColor,
              ),
              Text(
                ' $price₺',
                style: customFont12Secondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
