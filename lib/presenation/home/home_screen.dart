// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/presenation/home/account/account_view.dart';
import 'package:gypse/presenation/home/bloc/navigation_cubit.dart';
import 'package:gypse/presenation/home/bloc/navigation_state.dart';
import 'package:gypse/presenation/home/charts/charts_view.dart';
import 'package:gypse/presenation/home/components/home_app_bar.dart';
import 'package:gypse/presenation/home/components/home_bottom_bar.dart';
import 'package:gypse/presenation/home/home/home_view.dart';

/// Homepage
///
/// HomeScreen is the first view of the app
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget selectedView(int index) {
    switch (index) {
      case 1:
        return const ChartsView();
      case 2:
        return const AccountView();
      default:
        return const HomeView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => NavigationCubit(),
        child: BlocConsumer<NavigationCubit, NavigationState>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
            appBar: HomeAppBar(context),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home_bkg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: selectedView(state.index),
            ),
            bottomNavigationBar: HomeBottomBar(
                index: state.index,
                selectPage: context.read<NavigationCubit>().setIndex),
          ),
        ));
  }
}
