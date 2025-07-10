import 'package:flutter/material.dart';
import 'package:notoro/views/history/history_view.dart';
import 'package:notoro/views/home/home_view.dart';
import 'package:notoro/views/settings/settings_view.dart';
import 'package:notoro/views/workout/workout_view.dart';

class AppConst {
  static const List<Widget> screens = [
    HomeView(),
    WorkoutView(),
    HistoryView(),
    SettingsView(),
  ];
}
