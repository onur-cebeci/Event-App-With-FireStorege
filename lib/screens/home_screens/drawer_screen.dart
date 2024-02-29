// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:kartek_demo/controllers/home_screen_controllers/home_screen_contoller.dart';
import 'package:kartek_demo/controllers/login_screen_controllers/auth_controller.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/extensions.dart';
import 'package:kartek_demo/utils/fonts.dart';

import 'package:provider/provider.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthController, HomeScreenController>(
      builder: (context, p, homeScreenController, child) {
        return Scaffold(
          backgroundColor: CustomThemeData.blackColorLight,
          body: Container(
            width: context.dynamicWidth(0.6),
            padding: EdgeInsets.symmetric(
                horizontal: context.dynamicWidth(0.1),
                vertical: context.dynamicWidth(0.1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //photo

                const PhotoCard(),
                //menu
                const MenuCard(),
                //exit
                Column(
                  children: [
                    p.userModel.isAdmin
                        ? MenuButtom(
                            icon: Icons.person,
                            text: 'Admin',
                            onTap: () {
                              Navigator.pushNamed(context, '/admin-screen');
                              if (homeScreenController.isTap == false) {
                                homeScreenController.menuButtonTap(
                                    context: context, value: true);
                              }
                            },
                          )
                        : const SizedBox.shrink(),
                    MenuButtom(
                      icon: Icons.exit_to_app,
                      text: 'Çıkış Yap',
                      onTap: () {
                        p.firebaseSignOut(context: context);
                        if (homeScreenController.isTap == false) {
                          homeScreenController.menuButtonTap(
                              context: context, value: true);
                        }
                      },
                    ),
                    MenuButtomV2(
                      onTap: () {},
                      icon: Icons.delete,
                      text: 'Hesabı Sil',
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(
      builder: (context, p, child) {
        return Column(
          children: [
            MenuButtom(
              icon: Icons.search,
              text: 'Arama',
              onTap: () {},
            ),
            MenuButtom(
              icon: Icons.home,
              text: 'Ana Sayfa',
              onTap: () {
                if (p.isTap == false) {
                  p.menuButtonTap(context: context, value: true);
                }
              },
            ),
            MenuButtom(
              onTap: () {
                Navigator.pushNamed(context, '/profile-edit');
                if (p.isTap == false) {
                  p.menuButtonTap(context: context, value: true);
                }
              },
              icon: Icons.person,
              text: 'Profile',
            ),
            MenuButtom(
              onTap: () {},
              icon: Icons.calendar_month,
              text: 'Takvim',
            ),
            MenuButtom(
              onTap: () {},
              icon: Icons.favorite,
              text: 'Beğendiklerim',
            ),
            MenuButtom(
              onTap: () {},
              icon: Icons.settings,
              text: 'Ayarlar',
            ),
          ],
        );
      },
    );
  }
}

class MenuButtom extends StatelessWidget {
  final IconData icon;
  final String text;
  void Function()? onTap;
  MenuButtom({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: CustomThemeData.backgroudColor,
            ),
            Text(
              ' $text',
              style: customFont14Secondary,
            )
          ],
        ),
      ),
    );
  }
}

class MenuButtomV2 extends StatelessWidget {
  final IconData icon;
  final String text;
  void Function()? onTap;
  MenuButtomV2({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: CustomThemeData.primaryColor,
            ),
            Text(
              ' $text',
              style: customFont14Secondary.copyWith(
                  color: CustomThemeData.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, p, child) {
        return Column(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: p.userModel.img.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(p.userModel.img),
                          fit: BoxFit.cover)
                      : null),
            ),
            const SizedBox(height: 10),
            Text(
              '${p.userModel.name} ${p.userModel.surname}',
              style: customFont16Secondary,
            )
          ],
        );
      },
    );
  }
}
