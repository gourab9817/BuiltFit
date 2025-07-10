import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/controllers/weekly_plan/weekly_plan_bloc.dart';
import 'package:notoro/controllers/weekly_plan/weekly_plan_event.dart';
import 'package:notoro/core/utils/theme/app_theme.dart';
import 'package:notoro/models/dashboard/weekly_plan.dart';
import 'package:notoro/models/history/history_model.dart';
import 'package:notoro/models/settings/app_settings_model.dart';
import 'package:notoro/models/workout/body_part.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:notoro/l10n/l10n.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'controllers/navbar/navbar_cubit.dart';
import 'models/history/duration_adapter.dart';
import 'models/workout/exercise_model.dart';
import 'models/workout/workout_model.dart';
import 'views/navbar_view.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutModelAdapter());
  Hive.registerAdapter(ExerciseTrainingModelAdapter());
  Hive.registerAdapter(BodyPartAdapter());
  Hive.registerAdapter(ExerciseModelAdapter());
  Hive.registerAdapter(WeeklyPlanAdapter());
  Hive.registerAdapter(DayOfWeekAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  Hive.registerAdapter(DurationAdapter());
  Hive.registerAdapter(AppSettingsModelAdapter());
  await Hive.openBox<WeeklyPlan>('user_plan');
  await Hive.openBox<WorkoutModel>('workouts');
  await Hive.openBox<HistoryModel>('workout_history');
  final settingsBox = await Hive.openBox<AppSettingsModel>('app_settings');

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initializeDateFormatting();

  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsNotifier(settingsBox),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (context, settings, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notoro',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: settings.themeMode,
        locale: Locale(settings.currentLocale),
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: MultiBlocProvider(
          providers: [
            BlocProvider<WeeklyPlanBloc>(
              create: (context) => WeeklyPlanBloc(
                planBox: Hive.box<WeeklyPlan>('user_plan'),
                workoutBox: Hive.box<WorkoutModel>('workouts'),
              )..add(LoadWeeklyPlan()),
            ),
            BlocProvider<NavbarCubit>(
              create: (_) => NavbarCubit(),
            ),
          ],
          child: const NavbarView(),
        ),
      ),
    );
  }
}
