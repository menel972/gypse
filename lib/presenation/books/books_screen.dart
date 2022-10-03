import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/presenation/books/bloc/filter_cubit.dart';
import 'package:gypse/presenation/books/bloc/filter_state.dart';
import 'package:gypse/presenation/books/books/books_view.dart';
import 'package:gypse/presenation/books/components/books_app_bar.dart';
import 'package:gypse/presenation/books/search_bar/search_bar_view.dart';

/// View of all bible books
///
/// BooksScreen allows users to filter questions by bible's book
class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FilterCubit(),
      child: BlocConsumer<FilterCubit, FilterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: BooksAppBar(context),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/game_bkg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    SearchBarView(context.read<FilterCubit>().setFilter),
                    Expanded(child: BooksView(state.filter))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
