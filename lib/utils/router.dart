import 'package:flutter/material.dart';
import 'package:kartek_demo/models/event_models/event_model.dart';
import 'package:kartek_demo/screens/admin_screens/admin_add_event.dart';
import 'package:kartek_demo/screens/admin_screens/admin_edit_screen.dart';
import 'package:kartek_demo/screens/admin_screens/admin_screen.dart';
import 'package:kartek_demo/screens/event_screens/event_detail_screen.dart';
import 'package:kartek_demo/screens/event_screens/event_screen.dart';
import 'package:kartek_demo/screens/home_screens/home_screen.dart';
import 'package:kartek_demo/screens/login_screens/forgot_password_screen.dart';
import 'package:kartek_demo/screens/login_screens/login_screen.dart';
import 'package:kartek_demo/screens/login_screens/register_screen.dart';
import 'package:kartek_demo/screens/profile_screens/profile_edit_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case RegisterScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RegisterScreen(),
      );
    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ForgotPasswordScreen(),
      );
    case EventScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EventScreen(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    case EventDetailScreen.routeName:
      final model = routeSettings.arguments as EventModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EventDetailScreen(model: model),
      );
    case ProfileEditScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProfileEditScreen(),
      );
    case AdminEditEventScreen.routeName:
      final list = routeSettings.arguments as List;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AdminEditEventScreen(
          model: list[0],
          docs: list[1],
          index: list[2],
        ),
      );
    case AdminAddEventScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminAddEventScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
  }
}
