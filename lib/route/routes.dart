// lib/route/routes.dart

import 'package:flutter/material.dart';

// Existing imports
import 'package:medjoy/LogIn/SignIn.dart';
import 'package:medjoy/Home/Home.dart';
import 'package:medjoy/Doctors/doctors.dart';
import 'package:medjoy/Doctors/doctor_info.dart';
import 'package:medjoy/Doctors/favourite_doctor.dart';
import 'package:medjoy/Doctors/favourite_service.dart';
import 'package:medjoy/Doctors/favourite_male_doctor.dart';
import 'package:medjoy/Doctors/favourite_female_doctor.dart';

// NEW imports for the Profile screens:
import 'package:medjoy/ProfileScreen/profile.dart';
import 'package:medjoy/ProfileScreen/editprofile.dart';
import 'package:medjoy/ProfileScreen/seetings.dart';
import 'package:medjoy/ProfileScreen/notification_setting.dart';
import 'package:medjoy/ProfileScreen/changePass.dart';
import 'package:medjoy/ProfileScreen/logout.dart';

class Routes {
  // Existing
  static const String signIn = '/signIn';
  static const String home = '/home';
  static const String doctors = '/doctors';
  static const String doctorInfo = '/doctorInfo';
  static const String favouriteDoctor = '/favouriteDoctor';
  static const String favouriteService = '/favouriteService';
  static const String favouriteMaleDoctor = '/favouriteMaleDoctor';
  static const String favouriteFemaleDoctor = '/favouriteFemaleDoctor';

  // NEW: Profile-related routes
  static const String profile = '/profile';

  static const String editProfile = '/editProfile';
  static const String settings = '/settings';
  static const String notificationSetting = '/notificationSetting';
  static const String changePass = '/changePass';
  static const String logout = '/logout';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      // ---------- Existing ----------
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case doctors:
        return MaterialPageRoute(builder: (_) => const DoctorsScreen());
      case doctorInfo:
        // We expect a Doctor object in settings.arguments
        final doctorArg = settings.arguments as Doctor;
        return MaterialPageRoute(
          builder: (_) => DoctorInfoScreen(doctor: doctorArg),
        );
      case favouriteDoctor:
        return MaterialPageRoute(
          builder: (_) => const FavouriteDoctorScreen(),
        );
      case favouriteService:
        return MaterialPageRoute(
          builder: (_) => const FavouriteServiceScreen(),
        );
      case favouriteMaleDoctor:
        return MaterialPageRoute(
          builder: (_) => const FavouriteMaleDoctorScreen(),
        );
      case favouriteFemaleDoctor:
        return MaterialPageRoute(
          builder: (_) => const FavouriteFemaleDoctorScreen(),
        );

      // ---------- NEW Profile routes ----------
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case notificationSetting:
        return MaterialPageRoute(
            builder: (_) => const NotificationSettingScreen());
      case changePass:
        return MaterialPageRoute(
            builder: (_) => const ChangePasswordScreen());
      case logout:
        return MaterialPageRoute(builder: (_) => const LogoutScreen());

      // ---------- Fallback ----------
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
