import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartek_demo/controllers/home_screen_controllers/home_screen_contoller.dart';
import 'package:kartek_demo/controllers/login_screen_controllers/auth_controller.dart';
import 'package:kartek_demo/screens/home_screens/drawer_screen.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/extensions.dart';
import 'package:kartek_demo/utils/fonts.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: const CustomAppBar(),
      backgroundColor: Colors.white,
      body: Stack(
        children: const [
          DrawerScreen(),
          HomeScreenBody(),
        ],
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(
      builder: (context, p, child) {
        return Transform.scale(
          scale: p.scale,
          child: Container(
            transform: Matrix4.translationValues(p.xOffset, 0, 0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              onTap: () {
                if (!p.isTap) {
                  p.menuButtonTap(context: context, value: !p.isTap);
                }
              },
              child: SafeArea(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const HomeScreenAppBarCard(),
                    //slider

                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppConstant.smallPadding),
                      height: context.dynamicHeight(0.25),
                      child: CarouselSlider(
                          items: p.bannerList
                              .map(
                                (e) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal:
                                          AppConstant.extraSmallPadding),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: NetworkImage(e),
                                          fit: BoxFit.cover)),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                              autoPlay: false,
                              scrollDirection: Axis.horizontal)),
                    ),

                    SizedBox(height: context.dynamicHeight(0.01)),
                    //logo
                    Container(
                      padding: const EdgeInsets.only(
                          top: AppConstant.extraSmallPadding,
                          bottom: AppConstant.extraSmallPadding),
                      margin: EdgeInsets.symmetric(
                          horizontal: context.dynamicWidth(0.03)),
                      height: context.dynamicHeight(0.1),
                      child: CarouselSlider(
                          items: p.bannerList
                              .map(
                                (e) => Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(e),
                                          fit: BoxFit.cover)),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            autoPlay: false,
                            scrollDirection: Axis.horizontal,
                          )),
                    ),
                    SizedBox(height: context.dynamicHeight(0.01)),
                    //event part
                    Expanded(
                      child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            EventCard(
                              img:
                                  'https://sozcuo01.sozcucdn.com/wp-content/uploads/2023/10/20/tarkan-1-1.jpeg',
                              title: 'TARKAN Konseri',
                              onTap: () {
                                Navigator.pushNamed(context, '/event-screen');
                                if (p.isTap == false) {
                                  p.menuButtonTap(
                                      context: context, value: true);
                                }
                              },
                            ),
                            EventCard(
                              img:
                                  'https://www2.denizli.bel.tr/userfiles/image/r230530140800549.jpg',
                              title: 'Ahi Tiyatrosu',
                              onTap: () {
                                Navigator.pushNamed(context, '/event-screen');
                                if (p.isTap == false) {
                                  p.menuButtonTap(
                                      context: context, value: true);
                                }
                              },
                            ),
                            const EventCardLast(),
                          ]),
                    ),
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

class EventCardLast extends StatelessWidget {
  const EventCardLast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(
      builder: (context, p, child) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/event-screen');
            if (p.isTap == false) {
              p.menuButtonTap(context: context, value: true);
            }
          },
          child: Container(
            margin: EdgeInsets.only(
                right: context.dynamicWidth(0.03),
                left: context.dynamicWidth(0.03),
                bottom: context.dynamicWidth(0.02),
                top: context.dynamicWidth(0.03)),
            height: context.dynamicHeight(0.17),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: CachedNetworkImageProvider(
                        'https://blog.biletino.com/file/2022/03/Kapak-1.jpg'),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: AppConstant.smallPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'all.events',
                        style: customFont28SemiBoldSecondary,
                      ).tr(),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeScreenAppBarCard extends StatelessWidget {
  const HomeScreenAppBarCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeScreenController, AuthController>(
      builder: (context, p, authController, child) {
        return SizedBox(
          height: 80,
          width: double.infinity,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
                onPressed: () {
                  authController.userModel.mail.isNotEmpty
                      ? p.menuButtonTap(context: context, value: !p.isTap)
                      : Navigator.pushNamed(context, '/login');
                },
                icon: Icon(
                  authController.userModel.mail.isNotEmpty
                      ? Icons.menu
                      : Icons.person,
                  size: 32,
                  color: Colors.black,
                )),
            const Text(
              'appName',
              style: customFont20Bold,
            ).tr(),
            IconButton(
              onPressed: () {},
              icon: Transform.rotate(
                angle: 3.14 / 4,
                child: const Icon(
                  Icons.notifications,
                  size: 32,
                  color: Colors.black,
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.img,
  });
  final void Function()? onTap;
  final String title;
  final String img;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(children: [
        Container(
          margin: EdgeInsets.only(
              right: context.dynamicWidth(0.03),
              left: context.dynamicWidth(0.03),
              bottom: context.dynamicWidth(0.02),
              top: context.dynamicWidth(0.03)),
          height: context.dynamicHeight(0.17),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(img), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //
              const ReachLine(),
              //
              const LocationLine(),
              //
              const CalendarLine(),
              //
              PriceLine(title: title)
            ],
          ),
        ),
        Positioned(
          right: 30,
          top: 0,
          child: Container(
            height: 35,
            width: context.dynamicWidth(0.35),
            decoration: BoxDecoration(
                color: CustomThemeData.primaryColor,
                borderRadius: BorderRadius.circular(40)),
            child: Center(
              child: Text(
                'Sana en yakın',
                textAlign: TextAlign.center,
                style: customFont18.copyWith(
                    color: Colors.white.withOpacity(0.85)),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class PriceLine extends StatelessWidget {
  const PriceLine({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            decoration: const BoxDecoration(
                color: CustomThemeData.blackColorLight,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(10))),
            child: Row(
              children: const [
                Icon(
                  Icons.payments_outlined,
                  size: 19,
                  color: CustomThemeData.backgroudColor,
                ),
                Text(
                  ' 180₺',
                  style: customFont14Secondary,
                ),
              ],
            ),
          ),
          Text(
            title,
            style: customFont20SemiBoldSecondary,
          )
        ],
      ),
    );
  }
}

class CalendarLine extends StatelessWidget {
  const CalendarLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.dynamicHeight(0.005), right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '11.02.2024 21:00 ',
            style: customFont12.copyWith(color: Colors.white.withOpacity(0.85)),
          ),
          Icon(
            Icons.calendar_month,
            size: 19,
            color: Colors.white.withOpacity(0.85),
          )
        ],
      ),
    );
  }
}

class LocationLine extends StatelessWidget {
  const LocationLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.dynamicHeight(0.005), right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Adana ',
            style: customFont12.copyWith(color: Colors.white.withOpacity(0.85)),
          ),
          Icon(
            Icons.location_on_rounded,
            size: 19,
            color: Colors.white.withOpacity(0.85),
          )
        ],
      ),
    );
  }
}

class ReachLine extends StatelessWidget {
  const ReachLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.dynamicHeight(0.045), right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '7.66km ',
            style: customFont12.copyWith(color: Colors.white.withOpacity(0.85)),
          ),
          Icon(
            Icons.location_on_rounded,
            size: 12,
            color: Colors.white.withOpacity(0.85),
          )
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'appName',
        style: customFont20Bold,
      ).tr(),
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            size: 32,
            color: Colors.black,
          )),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Transform.rotate(
            angle: 3.14 / 4,
            child: const Icon(
              Icons.notifications,
              size: 32,
              color: Colors.black,
            ),
          ),
        ),
      ],
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
