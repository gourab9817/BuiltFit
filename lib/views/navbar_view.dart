import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:notoro/core/utils/constants/app_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controllers/navbar/navbar_cubit.dart';

class NavbarView extends StatelessWidget {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return BlocBuilder<NavbarCubit, NavbarItem>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.index,
            children: AppConst.screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.index,
            onTap: (index) {
              context.read<NavbarCubit>().selectItem(
                    NavbarItem.values[index],
                  );
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center_outlined),
                label: AppLocalizations.of(context)!.workout,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined),
                label: AppLocalizations.of(context)!.history,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: AppLocalizations.of(context)!.settings,
              ),
            ],
          ),
        );
      },
    );
  }
}
